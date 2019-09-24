CREATE TABLE [dbo].[DocBrokeDecisionProducts] (
    [DocID]              UNIQUEIDENTIFIER NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [StateID]            TINYINT          NOT NULL,
    [Quantity]           DECIMAL (18, 5)  NULL,
    [Comment]            VARCHAR (1000)   NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [DecisionApplied]    BIT              DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_DocBrokeDecisionProducts] PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC, [StateID] ASC),
    CONSTRAINT [FK_DocBrokeDecisionProducts_DocBroke] FOREIGN KEY ([DocID]) REFERENCES [dbo].[DocBroke] ([DocID]),
    CONSTRAINT [FK_DocBrokeDecisionProducts_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID]),
    CONSTRAINT [FK_DocBrokeDecisionProducts_ProductStates] FOREIGN KEY ([StateID]) REFERENCES [dbo].[ProductStates] ([StateID])
);


GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Изменение веса при обновлении данных в решении Акта о браке
-- =============================================
CREATE TRIGGER [dbo].[ChangeProductAfterUpdateBrokeDecision]
   ON  [dbo].[DocBrokeDecisionProducts]
   AFTER UPDATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	DECLARE @DocID uniqueidentifier, @ProductID uniqueidentifier, @StateID int, @Quantity decimal(15,5), @ProductKindID INT,
		@NomenclatureID UNIQUEIDENTIFIER, @CharacteristicID UNIQUEIDENTIFIER, @WeightCoefficient float, @CoreDiameter decimal(18,5)
		, @ShiftID int, @PlaceID int, @DecisionApplied bit, @Date datetime

	DECLARE decisions CURSOR
	FOR
	SELECT a.ProductID, a.DocID, a.StateID, a.Quantity, b.ProductKindID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.[DecisionApplied]
	FROM
	inserted a
	JOIN
	vProductsInfo b ON a.ProductID = b.ProductID
	ORDER BY StateID desc

	OPEN decisions

	FETCH NEXT FROM decisions
	INTO @ProductID, @DocID, @StateID, @Quantity, @ProductKindID, @NomenclatureID, @CharacteristicID, @DecisionApplied

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS (SELECT b.ProductID FROM DocOutProducts b JOIN DocMovement c ON b.DocID = c.DocID AND c.DocOrderID IS NOT NULL WHERE b.ProductID = @ProductID)--dbo.AllowEditDoc(@DocID) = 1
		BEGIN
			SELECT @Date = Date
			FROM
			Docs WHERE DocID = @DocID

			IF @StateID = 2 -- Утилизация 
			BEGIN
				DECLARE @DecisionAppliedOld bit, @QuantityOld decimal (15,5)
				SET @DecisionAppliedOld = NULL
				SELECT @DecisionAppliedOld = [DecisionApplied], @QuantityOld = Quantity 
					FROM 
					deleted a 
					WHERE a.DocID = @DocID AND a.ProductID = @ProductID AND a.StateID = @StateID
				DECLARE @Result bit
				IF (@DecisionApplied = 0 AND ISNULL(@DecisionAppliedOld,0) = 1)
					EXEC [dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] @ProductID,@DocID,@StateID,@QuantityOld,NULL,NULL,@Result
				IF (@DecisionApplied = 1 AND ISNULL(@DecisionAppliedOld,0) = 0)
					EXEC [dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] @ProductID,@DocID,@StateID,@Quantity,NULL,NULL,@Result
				IF (@DecisionApplied = 1 AND ISNULL(@DecisionAppliedOld,0) = 1 AND ISNULL(@Quantity,0) <> ISNULL(@QuantityOld,0))
				BEGIN
					UPDATE a SET Quantity = @Quantity
						FROM DocWithdrawalProducts a
							JOIN DocBrokeDecisionProductWithdrawalProducts b ON a.DocID = b.DocWithdrawalID AND a.ProductID = b.ProductID 
						WHERE b.DocID = @DocID AND b.ProductID = @ProductID AND b.StateID = @StateID
				END
			END
			ELSE IF @StateID = 5 -- На переделку(Смена номенклатуры)
			BEGIN
				IF @ProductKindID = 0
				BEGIN
					UPDATE ProductSpools SET [1CNomenclatureID] = @NomenclatureID, [1CCharacteristicID] = @CharacteristicID
					WHERE ProductID = @ProductID

				END
				IF @ProductKindID = 2 -- ГУ
				BEGIN
					UPDATE ProductGroupPacks SET [1CNomenclatureID] = @NomenclatureID, [1CCharacteristicID] = @CharacteristicID
					WHERE ProductID = @ProductID

					UPDATE a SET a.[1CNomenclatureID] = @NomenclatureID, a.[1CCharacteristicID] = @CharacteristicID
					FROM
					ProductSpools a
					JOIN
					vGroupPackSpools b ON a.ProductID = b.ProductID
					WHERE b.ProductGroupPackID = @ProductID
				END
				IF @ProductKindID = 1 -- паллеты
				BEGIN
					UPDATE ProductItems SET [1CNomenclatureID] = @NomenclatureID, [1CCharacteristicID] = @CharacteristicID
					WHERE ProductID = @ProductID 
				END
			END
			ELSE
			BEGIN	
				SET @StateID = @StateID
			END

			/*SET @StateID = 0
			SELECT @StateID = [dbo].[GetProductState](@ProductID)
			
			UPDATE a SET StateID = @StateID
				FROM Products a 
				WHERE a.ProductID = @ProductID AND (a.StateID <> @StateID OR (a.StateID IS NULL AND @StateID IS NOT NULL))
			
			IF @ProductKindID = 2
				UPDATE a SET StateID = @StateID
					FROM Products a JOIN vGroupPackSpools b ON a.ProductID = b.ProductID
					WHERE b.ProductGroupPackID = @ProductID AND (a.StateID <> @StateID OR (a.StateID IS NULL AND @StateID IS NOT NULL))
			*/
			DECLARE @TableDel t_DocBrokeDecisionProducts
			INSERT INTO @TableDel(DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied])
			SELECT DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied]  FROM 
					deleted a 
					WHERE a.DocID = @DocID AND a.ProductID = @ProductID AND a.StateID = @StateID
			DECLARE @TableIns t_DocBrokeDecisionProducts
			INSERT INTO @TableIns(DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied])
			SELECT DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied]  FROM 
					inserted a 
					WHERE a.DocID = @DocID AND a.ProductID = @ProductID AND a.StateID = @StateID
			
			EXEC [dbo].[RefreshProductState] @ProductID, @TableIns, @TableDel
			
		END
		ELSE
		RAISERROR (N'Продукция уже отгружена. Изменение запрещено.', -- Message text.  
           10, -- Severity,  
           1 -- State,  
           ); 
	FETCH NEXT FROM decisions
	INTO @ProductID, @DocID, @StateID, @Quantity, @ProductKindID, @NomenclatureID, @CharacteristicID, @DecisionApplied

	END

	CLOSE decisions

	DEALLOCATE decisions
	
END

GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Изменение веса при вставке данных в решении Акта о браке
-- =============================================
CREATE TRIGGER [dbo].[ChangeProductAfterBrokeDecision]
   ON  [dbo].[DocBrokeDecisionProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	DECLARE @DocID uniqueidentifier, @ProductID uniqueidentifier, @StateID int, @Quantity decimal(15,5), @ProductKindID INT,
		@NomenclatureID UNIQUEIDENTIFIER, @CharacteristicID UNIQUEIDENTIFIER, @WeightCoefficient float, @CoreDiameter decimal(18,5)
		, @ShiftID int, @PlaceID int, @DecisionApplied bit
	
	DECLARE decisions CURSOR
	FOR
	SELECT a.ProductID, a.DocID, a.StateID, a.Quantity, b.ProductKindID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.[DecisionApplied]
	FROM
	inserted a
	JOIN
	vProductsInfo b ON a.ProductID = b.ProductID
	JOIN 
	Docs d ON a.DocID = d.DocID
	ORDER BY StateID desc

	OPEN decisions

	FETCH NEXT FROM decisions
	INTO @ProductID, @DocID, @StateID, @Quantity, @ProductKindID, @NomenclatureID, @CharacteristicID, @DecisionApplied

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS (SELECT b.ProductID FROM DocOutProducts b JOIN DocMovement c ON b.DocID = c.DocID AND c.DocOrderID IS NOT NULL WHERE b.ProductID = @ProductID)--dbo.AllowEditDoc(@DocID) = 1
		BEGIN
			IF @StateID = 2 -- Утилизация 
			BEGIN
				
				IF @DecisionApplied = 1
				BEGIN
					DECLARE @Result bit
					EXEC [dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] @ProductID,@DocID,@StateID,@Quantity,NULL,NULL,@Result
				END
			END
			ELSE IF @StateID = 5 -- На переделку(Смена номенклатуры)
			BEGIN
				IF @ProductKindID = 0
				BEGIN
					UPDATE ProductSpools SET [1CNomenclatureID] = @NomenclatureID, [1CCharacteristicID] = @CharacteristicID
					WHERE ProductID = @ProductID

				END
				IF @ProductKindID = 2 -- ГУ
				BEGIN
					UPDATE ProductGroupPacks SET [1CNomenclatureID] = @NomenclatureID, [1CCharacteristicID] = @CharacteristicID
					WHERE ProductID = @ProductID

					UPDATE a SET a.[1CNomenclatureID] = @NomenclatureID, a.[1CCharacteristicID] = @CharacteristicID
					FROM
					ProductSpools a
					JOIN
					vGroupPackSpools b ON a.ProductID = b.ProductID
					WHERE b.ProductGroupPackID = @ProductID
				END
				IF @ProductKindID IN (1,3) -- паллеты
				BEGIN
					UPDATE ProductItems SET [1CNomenclatureID] = @NomenclatureID, [1CCharacteristicID] = @CharacteristicID
					WHERE ProductID = @ProductID 
				END
			END
			ELSE
			BEGIN	
				SET @StateID = @StateID
			END
	/*	
		SET @StateID = 0
		SELECT @StateID = [dbo].[GetProductState](@ProductID)

		UPDATE a SET StateID = @StateID
				FROM Products a 
				WHERE a.ProductID = @ProductID AND (a.StateID <> @StateID OR (a.StateID IS NULL AND @StateID IS NOT NULL))

		IF @ProductKindID = 2
			UPDATE a SET StateID = @StateID
				FROM Products a JOIN vGroupPackSpools b ON a.ProductID = b.ProductID
				WHERE b.ProductGroupPackID = @ProductID AND (a.StateID <> @StateID OR (a.StateID IS NULL AND @StateID IS NOT NULL))
*/
			DECLARE @TableDel t_DocBrokeDecisionProducts
			INSERT INTO @TableDel(DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied])
			SELECT DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied]  FROM 
					deleted a 
					WHERE a.DocID = @DocID AND a.ProductID = @ProductID AND a.StateID = @StateID
			DECLARE @TableIns t_DocBrokeDecisionProducts
			INSERT INTO @TableIns(DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied])
			SELECT DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied]  FROM 
					inserted a 
					WHERE a.DocID = @DocID AND a.ProductID = @ProductID AND a.StateID = @StateID
			
			EXEC [dbo].[RefreshProductState] @ProductID, @TableIns, @TableDel

		END
		ELSE
		RAISERROR (N'Продукция уже отгружена. Изменение запрещено.', -- Message text.  
           10, -- Severity,  
           1 -- State,  
           ); 
	
	FETCH NEXT FROM decisions
	INTO @ProductID, @DocID, @StateID, @Quantity, @ProductKindID, @NomenclatureID, @CharacteristicID, @DecisionApplied

	END

	CLOSE decisions

	DEALLOCATE decisions
	
END

GO


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[ChangeProductAfterDeleteBrokeDecision]
   ON  [dbo].[DocBrokeDecisionProducts]
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	DECLARE @DocID uniqueidentifier, @ProductID uniqueidentifier, @StateID int, @Quantity decimal(15,5), @ProductKindID INT,
		@NomenclatureID UNIQUEIDENTIFIER, @CharacteristicID UNIQUEIDENTIFIER, @WeightCoefficient float, @CoreDiameter decimal(18,5)
		, @ShiftID int, @PlaceID int, @DecisionApplied bit, @Date datetime
		
	
	DECLARE decisions CURSOR
	FOR
	SELECT a.ProductID, a.DocID, a.StateID, a.Quantity, b.ProductKindID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.[DecisionApplied], d.Date
	FROM
	deleted a
	JOIN
	vProductsInfo b ON a.ProductID = b.ProductID
	JOIN 
	Docs d ON a.DocID = d.DocID
	ORDER BY StateID desc 

	OPEN decisions

	FETCH NEXT FROM decisions
	INTO @ProductID, @DocID, @StateID, @Quantity, @ProductKindID, @NomenclatureID, @CharacteristicID, @DecisionApplied, @Date

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF NOT EXISTS (SELECT b.ProductID FROM DocOutProducts b JOIN DocMovement c ON b.DocID = c.DocID AND c.DocOrderID IS NOT NULL WHERE b.ProductID = @ProductID)--dbo.AllowEditDoc(@DocID) = 1
		BEGIN
			IF @StateID = 2 -- Утилизация 
			BEGIN

				IF @DecisionApplied = 1
				BEGIN
					DECLARE @Result bit
					EXEC [dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] @ProductID,@DocID,@StateID,@Quantity,NULL,NULL,@Result
				END
			END
			ELSE IF @StateID = 5 -- На переделку
			BEGIN
				IF @ProductKindID = 0 --тамбура
				BEGIN
					UPDATE a SET a.[1CNomenclatureID] = b.[1CNomenclatureID], a.[1CCharacteristicID] = b.[1CCharacteristicID]
					FROM
					ProductSpools a
					JOIN
					(
						SELECT pi.ProductID, ISNULL(b.[1CNomenclatureID], pi.[1CNomenclatureID]) AS [1CNomenclatureID],
							ISNULL(b.[1CCharacteristicID], pi.[1CCharacteristicID]) AS [1CCharacteristicID]
						FROM 
						DocProductionProducts pi
						LEFT JOIN
						(
							SELECT TOP 1 dbdp.ProductID, dbdp.[1CNomenclatureID], dbdp.[1CCharacteristicID]
							FROM
							DocBrokeDecisionProducts dbdp
							JOIN
							Docs d ON dbdp.DocID = d.DocID AND d.Date < @Date
							WHERE dbdp.ProductID = @ProductID AND dbdp.[1CNomenclatureID] IS NOT NULL
							ORDER BY d.Date DESC
						) b ON pi.ProductID = b.ProductID
						WHERE pi.ProductID = @ProductID
					) b ON a.ProductID = b.ProductID
					WHERE a.ProductID = @ProductID
				END
				IF @ProductKindID = 2 -- ГУ
				BEGIN
					UPDATE a SET a.[1CNomenclatureID] = b.[1CNomenclatureID], a.[1CCharacteristicID] = b.[1CCharacteristicID]
					FROM
					ProductGroupPacks a
					JOIN
					(
						SELECT pi.ProductID, ISNULL(b.[1CNomenclatureID], pi.[1CNomenclatureID]) AS [1CNomenclatureID],
							ISNULL(b.[1CCharacteristicID], pi.[1CCharacteristicID]) AS [1CCharacteristicID]
						FROM 
						DocProductionProducts pi
						LEFT JOIN
						(
							SELECT TOP 1 dbdp.ProductID, dbdp.[1CNomenclatureID], dbdp.[1CCharacteristicID]
							FROM
							DocBrokeDecisionProducts dbdp
							JOIN
							Docs d ON dbdp.DocID = d.DocID AND d.Date < @Date
							WHERE dbdp.ProductID = @ProductID AND dbdp.[1CNomenclatureID] IS NOT NULL
							ORDER BY d.Date DESC
						) b ON pi.ProductID = b.ProductID
						WHERE pi.ProductID = @ProductID
					) b ON a.ProductID = b.ProductID
					WHERE a.ProductID = @ProductID

					UPDATE a SET a.[1CNomenclatureID] = c.[1CNomenclatureID], a.[1CCharacteristicID] = c.[1CCharacteristicID]
					FROM
					ProductSpools a
					JOIN
					vGroupPackSpools b ON a.ProductID = b.ProductID
					JOIN
					ProductGroupPacks c ON b.ProductGroupPackID = c.ProductID
					WHERE c.ProductID = @ProductID
				END
				IF @ProductKindID = 1 -- палеты
				BEGIN
					UPDATE a SET a.[1CNomenclatureID] = b.[1CNomenclatureID], a.[1CCharacteristicID] = b.[1CCharacteristicID]
					FROM
					ProductItems a
					JOIN
					(
						SELECT pi.ProductID, ISNULL(b.[1CNomenclatureID], pi.[1CNomenclatureID]) AS [1CNomenclatureID],
							ISNULL(b.[1CCharacteristicID], pi.[1CCharacteristicID]) AS [1CCharacteristicID]
						FROM 
						DocProductionProducts pi
						LEFT JOIN
						(
							SELECT TOP 1 dbdp.ProductID, dbdp.[1CNomenclatureID], dbdp.[1CCharacteristicID]
							FROM
							DocBrokeDecisionProducts dbdp
							JOIN
							Docs d ON dbdp.DocID = d.DocID AND d.Date < @Date
							WHERE dbdp.ProductID = @ProductID AND dbdp.[1CNomenclatureID] IS NOT NULL
							ORDER BY d.Date DESC
						) b ON pi.ProductID = b.ProductID
						WHERE pi.ProductID = @ProductID
					) b ON a.ProductID = b.ProductID
				END
			END
			ELSE
			BEGIN
				SET @StateID = @StateID
			END
			/*
			SET @StateID = 0
			SELECT @StateID = [dbo].[GetProductState](@ProductID)
			UPDATE a SET StateID = @StateID
				FROM Products a 
				WHERE a.ProductID = @ProductID AND (a.StateID <> @StateID OR (a.StateID IS NULL AND @StateID IS NOT NULL))

			IF @ProductKindID = 2
				UPDATE a SET StateID = @StateID
					FROM Products a JOIN vGroupPackSpools b ON a.ProductID = b.ProductID
					WHERE b.ProductGroupPackID = @ProductID AND (a.StateID <> @StateID OR (a.StateID IS NULL AND @StateID IS NOT NULL))
					*/
			DECLARE @TableDel t_DocBrokeDecisionProducts
			INSERT INTO @TableDel(DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied])
			SELECT DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied]  FROM 
					deleted a 
					WHERE a.DocID = @DocID AND a.ProductID = @ProductID AND a.StateID = @StateID
			DECLARE @TableIns t_DocBrokeDecisionProducts
			INSERT INTO @TableIns(DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied])
			SELECT DocID, ProductID,StateID,Quantity,Comment,[1CNomenclatureID],[1CCharacteristicID],[DecisionApplied]  FROM 
					inserted a 
					WHERE a.DocID = @DocID AND a.ProductID = @ProductID AND a.StateID = @StateID
			
			EXEC [dbo].[RefreshProductState] @ProductID, @TableIns, @TableDel

		END
		ELSE
		RAISERROR (N'Продукция уже отгружена. Изменение запрещено.', -- Message text.  
           10, -- Severity,  
           1 -- State,  
           ); 
	FETCH NEXT FROM decisions
	INTO @ProductID, @DocID, @StateID, @Quantity, @ProductKindID, @NomenclatureID, @CharacteristicID, @DecisionApplied, @Date

	END

	CLOSE decisions

	DEALLOCATE decisions

END

GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProducts] TO [PalletRepacker]
    AS [dbo];

