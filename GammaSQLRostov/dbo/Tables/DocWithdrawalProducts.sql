CREATE TABLE [dbo].[DocWithdrawalProducts] (
    [DocID]              UNIQUEIDENTIFIER NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [Quantity]           DECIMAL (15, 5)  NULL,
    [CompleteWithdrawal] BIT              NULL,
    CONSTRAINT [PK_DocWithdrawalProducts] PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_DocWithdrawalProducts_DocWithdrawal] FOREIGN KEY ([DocID]) REFERENCES [dbo].[DocWithdrawal] ([DocID]),
    CONSTRAINT [FK_DocWithdrawalProducts_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO
CREATE NONCLUSTERED INDEX [IndexProductID]
    ON [dbo].[DocWithdrawalProducts]([ProductID] ASC)
    INCLUDE([DocID], [CompleteWithdrawal]);


GO
CREATE NONCLUSTERED INDEX [IndexDocID]
    ON [dbo].[DocWithdrawalProducts]([DocID] ASC)
    INCLUDE([ProductID], [CompleteWithdrawal]);


GO
CREATE TRIGGER [dbo].[zzdDocWithdrawalProducts] ON DocWithdrawalProducts
AFTER  DELETE AS 
INSERT INTO zzDocWithdrawalProducts
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED

GO
CREATE TRIGGER [dbo].[zziDocWithdrawalProducts] ON DocWithdrawalProducts
AFTER  INSERT AS 
INSERT INTO zzDocWithdrawalProducts
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[ConfirmProductionAfterWithdraw]
   ON  [dbo].[DocWithdrawalProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	UPDATE c SET c.IsConfirmed = 1
	FROM
	DocProductionProducts a
	JOIN
	inserted b ON a.ProductID = b.ProductID
	JOIN
	Docs c ON a.DocID = c.DocID
	
END
GO

-- =============================================
-- Author:		Matvey Polidanov
-- Change date: 02.02.2017
-- Description:	изменение текущего количества при удалении списания
-- =============================================

CREATE TRIGGER [dbo].[ChangeProductQuantityAfterDeleteWithdrawal]
   ON  [dbo].[DocWithdrawalProducts]
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	DECLARE @ProductKindID int, @ProductID uniqueidentifier, @Quantity decimal(15,5), @DocID UNIQUEIDENTIFIER, @CompleteWithdraw bit,
		@WeightCoefficient float, @CoreDiameter decimal(18,5)

	DECLARE products CURSOR
	FOR
	SELECT a.ProductID, a.DocID, a.Quantity, b.ProductKindID, a.CompleteWithdrawal
	FROM
	deleted a
	JOIN
	Products b ON a.ProductID = b.ProductID

	OPEN products

	FETCH NEXT FROM products INTO @ProductID, @DocID, @Quantity, @ProductKindID, @CompleteWithdraw

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@Quantity IS NOT NULL OR @CompleteWithdraw = 1) AND dbo.AllowEditDoc(@DocID) = 1
--		NOT EXISTS (SELECT * FROM Docs WHERE Date > (SELECT Date FROM Docs WHERE DocID = @DocID))
		BEGIN
			IF @ProductKindID = 0 -- тамбура
			BEGIN
				SELECT @WeightCoefficient = 
					CASE
						WHEN b.Quantity IS NULL OR b.Quantity = 0 THEN 1
						ELSE (DecimalWeight + ISNULL(@Quantity, b.Quantity))/b.Quantity
					END,
						@CoreDiameter = dbo.GetCharSpoolCoreDiameter(a.[1CCharacteristicID])
					FROM
					ProductSpools a
					JOIN
					DocProductionProducts b ON a.ProductID = b.ProductID
					WHERE a.ProductID = @ProductID 
				
				UPDATE a SET DecimalWeight = DecimalWeight + ISNULL(@Quantity, b.Quantity),
					CurrentDiameter = sqrt(@WeightCoefficient*a.Diameter*a.Diameter + (1-@WeightCoefficient)*@CoreDiameter*@CoreDiameter),
					CurrentLength = @WeightCoefficient*a.Length
				FROM
				ProductSpools a
				JOIN
				DocProductionProducts b ON a.ProductID = b.ProductID
				WHERE a.ProductID = @ProductID
				

				IF @CompleteWithdraw = 1 AND NOT EXISTS (SELECT * FROM Rests WHERE ProductID = @ProductID)
				BEGIN
					INSERT INTO Rests (ProductID, PlaceID, Quantity)
					SELECT pi.ProductID, pi.PlaceID, 1
					FROM
					vProductsInfo pi
					WHERE pi.ProductID = @ProductID
				END
			END
		END

		FETCH NEXT FROM products INTO @ProductID, @DocID, @Quantity, @ProductKindID, @CompleteWithdraw
	END

	CLOSE products

	DEALLOCATE products
	

END

GO
DISABLE TRIGGER [dbo].[ChangeProductQuantityAfterDeleteWithdrawal]
    ON [dbo].[DocWithdrawalProducts];


GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Изменение остатков при списании
-- =============================================

CREATE TRIGGER [dbo].[ChangeProductQuantityAfterWithdrawal]
   ON  [dbo].[DocWithdrawalProducts]
   AFTER INSERT, UPDATE, DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductKindID int, @ProductID uniqueidentifier, @Quantity decimal(15,5), @DocID uniqueidentifier, @Date DateTime,
		@CompleteWithdrawal bit, @WeightCoefficient float, @CoreDiameter decimal(18,5), @Weight decimal(15,5)
		,@ProductIDDel uniqueidentifier, @QuantityDel decimal(15,5), @CompleteWithdrawalDel bit, @DeltaQuantity decimal(15,5), @WeightProduction decimal(15,5)
		,@DecimalWeight decimal(15,5)

	DECLARE products CURSOR
	FOR
	SELECT a.ProductID, a.DocID, a.Quantity, b.ProductKindID, c.Date, a.CompleteWithdrawal, d.ProductID AS ProductIDDel, d.Quantity AS QuantityDel, d.CompleteWithdrawal AS CompleteWithdrawalDel
	FROM
	inserted a FULL OUTER JOIN deleted d ON a.DocID = d.DocID AND a.ProductID = d.ProductID
	LEFT JOIN
	Products b ON ISNULL(a.ProductID, d.ProductID) = b.ProductID
	LEFT JOIN
	Docs c ON ISNULL(a.DocID,d.DocID) = c.DocID

	--DECLARE @c int
	--SELECT @c = COUNT(*)
	--FROM
	--inserted a FULL OUTER JOIN deleted d ON a.DocID = d.DocID AND a.ProductID = d.ProductID
	--LEFT JOIN
	--Products b ON ISNULL(a.ProductID, d.ProductID) = b.ProductID
	--LEFT JOIN
	--Docs c ON ISNULL(a.DocID,d.DocID) = c.DocID

--PRINT '0-' + CAST(@c AS varchar(100))


	OPEN products

	FETCH NEXT FROM products INTO @ProductID, @DocID, @Quantity, @ProductKindID, @Date, @CompleteWithdrawal, @ProductIDDel, @QuantityDel, @CompleteWithdrawalDel

	WHILE @@FETCH_STATUS = 0
	BEGIN
	/*
		IF @CompleteWithdrawal = 1
		BEGIN
			UPDATE ProductSpools SET 
					DecimalWeight = 0, CurrentDiameter = 0, CurrentLength = 0
				WHERE ProductID = @ProductID 

			UPDATE Rests SET Quantity = 0
			WHERE ProductID = @ProductID 
				AND NOT EXISTS (SELECT * FROM DocUnpackProducts up WHERE up.ProductID = @ProductID)
/*
			IF NOT EXISTS (SELECT * FROM DocProducts WHERE DocID = @DocID AND ProductID = @ProductID)
			BEGIN
				INSERT INTO DocProducts (DocID, ProductID)
				VALUES (@DocID, @ProductID)
			END
*/
		END

		ELSE */	IF dbo.AllowEditDoc(@DocID) = 1
		BEGIN
			SET @DecimalWeight = NULL
			SET @Weight = NULL
			SET @WeightProduction = NULL
			SET @CoreDiameter = NULL


--PRINT '1-' + CAST(@Quantity AS varchar(100))
--PRINT '2-' + CAST(@QuantityDel AS varchar(100))

			--IF @CompleteWithdrawal = 1 AND ISNULL(@CompleteWithdrawalDel,0) = 0 AND @Quantity IS NULL
			--	SET @QuantityDel = @Quantity
			SET @DeltaQuantity = ISNULL(@Quantity,0) - ISNULL(@QuantityDel,0)
--PRINT '3-' + CAST(@DeltaQuantity AS varchar(100))

			IF @ProductKindID = 0 -- тамбура
			BEGIN
				SELECT  @WeightProduction = b.Quantity,
						@CoreDiameter = dbo.GetCharSpoolCoreDiameter(a.[1CCharacteristicID]),
						@Weight = CASE 
							WHEN @CompleteWithdrawal = 1 AND @Quantity IS NULL --добавлено полное списание без указаная веса
								THEN 0
							WHEN @CompleteWithdrawalDel = 1 AND @QuantityDel IS NULL AND @ProductID IS NULL --удалено полное списание без указаная веса
								THEN [dbo].[CalculateSpoolWeightBeforeDate] (a.ProductID, @Date)
							ELSE ISNULL(DecimalWeight,0) - @DeltaQuantity END,
						@DecimalWeight=DecimalWeight
					FROM
					ProductSpools a
					JOIN
					DocProductionProducts b ON a.ProductID = b.ProductID
					WHERE a.ProductID = ISNULL(@ProductID,@ProductIDDel)

--PRINT 'DecimalWeight-' + CAST(@Weight AS varchar(100))
--PRINT '4-' + CAST(@Weight AS varchar(100))
				IF ISNULL(@Weight,0) <= 0
				BEGIN
					UPDATE ProductSpools SET 
					DecimalWeight = @Weight, CurrentDiameter = 0, CurrentLength = 0
					WHERE ProductID = ISNULL(@ProductID,@ProductIDDel) 
				END
				ELSE
				BEGIN
					SET @WeightCoefficient = @Weight / @WeightProduction
--PRINT '5-' + CAST(@WeightCoefficient AS varchar(100))
					UPDATE ProductSpools SET 
						DecimalWeight = @Weight, 
						CurrentDiameter = sqrt(@WeightCoefficient*Diameter*Diameter + (1-@WeightCoefficient)*@CoreDiameter*@CoreDiameter), 
						CurrentLength = @WeightCoefficient * Length
					WHERE ProductID = ISNULL(@ProductID,@ProductIDDel) 
				END
			END
			IF @ProductKindID = 2 -- ГУ
			BEGIN 
				SELECT @Weight = CASE 
							WHEN @CompleteWithdrawal = 1 AND @Quantity IS NULL THEN 0
							WHEN @CompleteWithdrawalDel = 1 AND @QuantityDel IS NULL AND @ProductID IS NULL --удалено полное списание без указаная веса
								THEN [dbo].[CalculateSpoolWeightBeforeDate] (ProductID, @Date)
							ELSE Weight - @DeltaQuantity END
					FROM ProductGroupPacks
					WHERE ProductID = ISNULL(@ProductID,@ProductIDDel) 

				UPDATE ProductGroupPacks SET Weight = @Weight, GrossWeight = @Weight
					WHERE ProductID = ISNULL(@ProductID,@ProductIDDel) 
			END 
			IF @ProductKindID IN (1,3) -- паллета
			BEGIN 
				SELECT @Weight = CASE 
							WHEN @CompleteWithdrawal = 1 AND @Quantity IS NULL THEN 0
							WHEN @CompleteWithdrawalDel = 1 AND @QuantityDel IS NULL AND @ProductID IS NULL --удалено полное списание без указаная веса
								THEN [dbo].[CalculateSpoolWeightBeforeDate] (ProductID, @Date)
							ELSE Quantity - @DeltaQuantity END
					FROM ProductItems
					WHERE ProductID = ISNULL(@ProductID,@ProductIDDel) 

				UPDATE ProductItems SET Quantity = @Weight
					WHERE ProductID = ISNULL(@ProductID,@ProductIDDel) 
			END

			IF ISNULL(@Weight,0) <= 0
				BEGIN
					UPDATE Rests SET Quantity = 0
					WHERE ProductID = ISNULL(@ProductID,@ProductIDDel) 
						--непонятно почему кроме. разобраться впоследствии
						--AND NOT EXISTS (SELECT * FROM DocUnpackProducts up WHERE up.ProductID = @ProductID)
				END
				ELSE
				BEGIN
					INSERT INTO Rests(ProductID,Quantity,PlaceID)
					SELECT a.ProductID, 1, NULL 
						FROM Products a 
							LEFT JOIN Rests b ON a.ProductID = b.ProductID
						WHERE a.ProductID = ISNULL(@ProductID,@ProductIDDel) AND b.ProductID IS NULL
				END
		END
	

		FETCH NEXT FROM products INTO @ProductID, @DocID, @Quantity, @ProductKindID, @Date, @CompleteWithdrawal, @ProductIDDel, @QuantityDel, @CompleteWithdrawalDel
	END

	CLOSE products

	DEALLOCATE products
	

END

GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Изменение остатков при списании
-- =============================================

CREATE TRIGGER [dbo].[ChangeProductQuantityAfterInsertWithdrawal]
   ON  [dbo].[DocWithdrawalProducts]
   AFTER INSERT, UPDATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductKindID int, @ProductID uniqueidentifier, @Quantity decimal(15,5), @DocID uniqueidentifier, @Date DateTime,
		@CompleteWithdrawal bit, @WeightCoefficient float, @CoreDiameter decimal(18,5)

	DECLARE products CURSOR
	FOR
	SELECT a.ProductID, a.DocID, a.Quantity, b.ProductKindID, c.Date, a.CompleteWithdrawal
	FROM
	inserted a
	JOIN
	Products b ON a.ProductID = b.ProductID
	JOIN
	Docs c ON a.DocID = c.DocID

	OPEN products

	FETCH NEXT FROM products INTO @ProductID, @DocID, @Quantity, @ProductKindID, @Date, @CompleteWithdrawal

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @CompleteWithdrawal = 1
		BEGIN
			UPDATE ProductSpools SET 
					DecimalWeight = 0, CurrentDiameter = 0, CurrentLength = 0
				WHERE ProductID = @ProductID 

			UPDATE Rests SET Quantity = 0
			WHERE ProductID = @ProductID 
				AND NOT EXISTS (SELECT * FROM DocUnpackProducts up WHERE up.ProductID = @ProductID)
/*
			IF NOT EXISTS (SELECT * FROM DocProducts WHERE DocID = @DocID AND ProductID = @ProductID)
			BEGIN
				INSERT INTO DocProducts (DocID, ProductID)
				VALUES (@DocID, @ProductID)
			END
*/
		END

		ELSE IF @Quantity IS NOT NULL AND dbo.AllowEditDoc(@DocID) = 1
		BEGIN
			IF @ProductKindID = 0 -- тамбура
			BEGIN
				SELECT @WeightCoefficient = 
						CASE
							WHEN DecimalWeight IS NULL OR DecimalWeight = 0 THEN 0
							ELSE (DecimalWeight - @Quantity)/DecimalWeight
						END,
						@CoreDiameter = dbo.GetCharSpoolCoreDiameter([1CCharacteristicID])
					FROM
					ProductSpools
					WHERE ProductID = @ProductID 
				
				SET @Quantity = dbo.CalculateSpoolWeightBeforeDate(@ProductID, (SELECT Date FROM Docs WHERE DocID = @DocID)) - @Quantity
				UPDATE a SET a.DecimalWeight = @Quantity, 
					a.CurrentDiameter = sqrt(@WeightCoefficient*CurrentDiameter*CurrentDiameter + (1-@WeightCoefficient)*@CoreDiameter*@CoreDiameter),
					a.CurrentLength = @WeightCoefficient*a.CurrentLength
				FROM
				ProductSpools a
				JOIN
				DocProductionProducts b ON a.ProductID = b.ProductID
				WHERE a.ProductID = @ProductID 

				IF @Quantity <= 0
				BEGIN
					UPDATE Rests SET Quantity = 0
						WHERE ProductID = @ProductID
						AND NOT EXISTS (SELECT * FROM DocUnpackProducts up WHERE up.ProductID = @ProductID)
				END
			END
		END
	

		FETCH NEXT FROM products INTO @ProductID, @DocID, @Quantity, @ProductKindID, @Date, @CompleteWithdrawal
	END

	CLOSE products

	DEALLOCATE products
	

END

GO
DISABLE TRIGGER [dbo].[ChangeProductQuantityAfterInsertWithdrawal]
    ON [dbo].[DocWithdrawalProducts];


GO
CREATE TRIGGER [dbo].[zzuDocWithdrawalProducts] ON DocWithdrawalProducts
AFTER  UPDATE AS 
INSERT INTO zzDocWithdrawalProducts
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocWithdrawalProducts] TO [PalletRepacker]
    AS [dbo];

