CREATE TABLE [dbo].[DocUnpackProducts] (
    [DocID]     UNIQUEIDENTIFIER NOT NULL,
    [ProductID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_DocUnpackProducts] PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_DocUnpackProducts_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID]),
    CONSTRAINT [FK_DocUnpackProducts_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);




GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Восстановление параметров рулонов после распаковки
-- =============================================
CREATE TRIGGER [dbo].[UpdateSpoolParametersAfterUnpack]
   ON  [dbo].[DocUnpackProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @ProductID uniqueidentifier, @DocID uniqueidentifier, @Date DateTime,
		@WeightCoefficient float, @CoreDiameter decimal(18,5), @Quantity decimal(18,5)

	DECLARE products CURSOR
	FOR
	SELECT a.ProductID, dbo.CalculateSpoolWeightBeforeDate(a.ProductID, a.Date) AS Quantity
	FROM
	(
		SELECT b.ProductID, ROW_NUMBER() OVER (PARTITION BY a.ProductID ORDER BY c.Date DESC) AS rn, c.Date, c.DocID
		FROM
		inserted a
		JOIN
		DocWithdrawalProducts b ON a.ProductID = b.ProductID
		JOIN
		Docs c ON b.DocID = c.DocID
		JOIN
		ProductSpools d ON a.ProductID = d.ProductID
	) a
	WHERE a.rn = 1
	

	OPEN products

	FETCH NEXT FROM products INTO @ProductID, @Quantity

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @Quantity <> 0
		BEGIN
			SELECT @WeightCoefficient = @Quantity/ISNULL(b.Quantity,@Quantity),
				@CoreDiameter = dbo.GetCharSpoolCoreDiameter(a.[1CCharacteristicID])
				FROM
				ProductSpools a
				JOIN
				DocProductionProducts b ON a.ProductID = b.ProductID
				WHERE a.ProductID = @ProductID AND (b.Quantity IS NULL OR b.Quantity > 0)
			IF @WeightCoefficient IS NULL
				SET @WeightCoefficient = 0
		END
		ELSE SET @WeightCoefficient = 0

				UPDATE a SET a.DecimalWeight = @Quantity, 
						a.CurrentDiameter = sqrt(@WeightCoefficient*CurrentDiameter*CurrentDiameter + (1-@WeightCoefficient)*@CoreDiameter*@CoreDiameter),
						a.CurrentLength = @WeightCoefficient*a.CurrentLength
					FROM
					ProductSpools a
					WHERE a.ProductID = @ProductID 	
		
		FETCH NEXT FROM products INTO @ProductID, @Quantity
	END

	CLOSE products

	DEALLOCATE products
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestSpoolsAfterUnpack]
   ON  [dbo].[DocUnpackProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	UPDATE a SET a.Quantity = 1, a.PlaceID = c.PlaceID
	FROM
	Rests a
	JOIN
	inserted b ON a.ProductID = b.ProductID 
	JOIN
	Docs c ON b.DocID = c.DocID


	INSERT INTO Rests (ProductID, Quantity, PlaceID)
	SELECT a.ProductID, 1, b.PlaceID
	FROM
	inserted a
	JOIN
	Docs b ON a.DocID = b.DocID
	WHERE NOT EXISTS (SELECT * FROM Rests r WHERE r.ProductID = a.ProductID)
END
GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Baler]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackProducts] TO [Baler]
    AS [dbo];

