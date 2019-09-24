


-- =============================================
-- Author:		<Павлов Александр>
-- Create date: <15.11.2017>
-- Description:	<Добавление продукта в приказ по ProductID>
-- =============================================
--exec dbo.[mob_AddProductIdToOrder] @DocOrderID='4BBB09B2-A4F0-11E6-BE75-002590EBA5B7',@OrderType=0,@PersonID='94874554-68A6-E611-A7A3-00241DC986EB',@ProductID='00000000-0000-0000-0000-000000000000',@IsDocOut=1,@ProductKindID=3,@NomenclatureID='5FE4B6AC-E8BB-11E3-B85D-002590304E93',@CharacteristicID='151CC4A4-E8C2-11E3-B85D-002590304E93',@QualityID='D05404A0-6BCE-449B-A798-41EBE5E5B977',@QuantityRos=4

CREATE PROCEDURE [dbo].[mob_AddProductIdToOrder] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderID uniqueidentifier,
		@OrderType int,
		@PersonID uniqueidentifier,
		@ProductID uniqueidentifier,
		@IsDocOut bit,
		@ProductKindID int, 
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier,
		@QuantityRos int,
		@ShiftID tinyint
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ResultMessage nvarchar(1000)--, @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier
		--, @Quantity decimal(15,3)
		, @AlreadyAdded bit, @DocMovementID uniqueidentifier, @OutPlaceID int, @OutPlace varchar(50)--, @ProductKindID int
		, @IsAddProduct int = 0

	DECLARE @DocIds table(DocID uniqueidentifier)
	
	--SELECT @ProductKindID = ProductKindID 
	--FROM
	--Products a
	--WHERE ProductID = @ProductID
	IF CAST(@ProductID AS varchar(100)) = '00000000-0000-0000-0000-000000000000'
		SET @ProductID = NULL
	IF CAST(@CharacteristicID AS varchar(100)) = '00000000-0000-0000-0000-000000000000'
		SET @CharacteristicID = NULL
	--PRINT CAST(@ProductKindID AS varchar(100))
	--PRINT CAST(@ProductID AS varchar(100))

	IF @ProductKindID <> 3 AND @ProductID IS NULL
	BEGIN
		SET @ResultMessage = 'Продукт с данным шк не найден в базе'
	END
	ELSE IF @ProductKindID <> 3 
		AND
			(
				@IsDocOut = 1 AND 
				EXISTS 
				(
					SELECT * 
					FROM
					DocOutProducts a
					JOIN
					DocMovement b ON a.DocID = b.DocID AND b.DocOrderID = @DocOrderID
					WHERE a.ProductID = @ProductID
				)
			)
		OR 
			(
				@IsDocOut = 0 AND
				EXISTS 
				(
					SELECT *
					FROM
					DocInProducts a
					JOIN
					DocMovement b ON a.DocID = b.DocID AND b.DocOrderID = @DocOrderID
					WHERE a.ProductID = @ProductID
				)
			)
	BEGIN
		SET @AlreadyAdded = 1
	END
	ELSE IF @ProductKindID <> 3 AND @IsDocOut = 1 AND (NOT EXISTS 
			(SELECT * FROM Rests WHERE ProductID = @ProductID AND Quantity > 0) OR
			NOT EXISTS (SELECT * FROM vProductsInfo WHERE ProductID = @ProductID AND Quantity > 0))
	BEGIN
		SET @ResultMessage = 'Данное изделие не числится на остатках'
	END
	ELSE IF @ProductKindID <> 3 AND @IsDocOut = 1 AND NOT EXISTS
		(
			SELECT * FROM
			DocShipmentOrders a
			LEFT JOIN
			[1CDocShipmentOrderGoods] b ON a.DocOrderID = b.[1CDocShipmentOrderID] AND @OrderType = 0
			LEFT JOIN
			[1CDocInternalOrderGoods] c ON a.DocOrderID = c.[1CDocInternalOrderID] AND @OrderType = 1
			JOIN
			vProductsInfo d ON (b.[1CNomenclatureID] = d.[1CNomenclatureID] AND (b.[1CCharacteristicID] = d.[1CCharacteristicID] OR (b.[1CCharacteristicID] IS NULL AND d.[1CCharacteristicID] IS NULL))) OR
				(c.[1CNomenclatureID] = d.[1CNomenclatureID] AND (c.[1CCharacteristicID] = d.[1CCharacteristicID] OR (c.[1CCharacteristicID] IS NULL AND d.[1CCharacteristicID] IS NULL)))
			WHERE a.DocOrderID = @DocOrderID AND d.ProductID = @ProductID
		)
	BEGIN
		SET @ResultMessage = 'Номенклатура не совпадает с приказом'
	END
	ELSE IF @ProductKindID <> 3 AND @IsDocOut = 1 AND NOT EXISTS
		(
			SELECT * FROM
			DocShipmentOrders a
			LEFT JOIN
			[1CDocShipmentOrderGoods] b ON a.DocOrderID = b.[1CDocShipmentOrderID] AND @OrderType = 0
			LEFT JOIN
			[1CDocInternalOrderGoods] c ON a.DocOrderID = c.[1CDocInternalOrderID] AND @OrderType = 1
			JOIN
			vProductsInfo d ON (b.[1CNomenclatureID] = d.[1CNomenclatureID] AND b.[1CCharacteristicID] = d.[1CCharacteristicID] AND
				(b.[1CQualityID] = d.[1CQualityID] OR b.[1CQualityID] IS NULL)) OR
				(c.[1CNomenclatureID] = d.[1CNomenclatureID] AND c.[1CCharacteristicID] = d.[1CCharacteristicID] AND
				(c.[1CQualityID] = d.[1CQualityID] OR c.[1CQualityID] IS NULL))
			WHERE a.DocOrderID = @DocOrderID AND d.ProductID = @ProductID
		)
	BEGIN
		SET @ResultMessage = 'Качество продукта не совпадает с приказом'
	END
	ELSE IF @IsDocOut = 1 AND @ProductKindID = 2 AND EXISTS
		(
			SELECT * FROM
			vProductsInfo d 
			JOIN
			DocProductionProducts a ON d.ProductID = a.ProductID
			JOIN
			DocProductionWithdrawals b ON a.DocID = b.DocProductionID
			JOIN
			DocWithdrawalProducts c ON b.DocWithdrawalID = c.DocID
			JOIN
			vProductsInfo e ON c.ProductID = e.ProductID
			WHERE
			d.ProductID = @ProductID
			AND NOT (d.[1CQualityID] = e.[1CQualityID] OR (d.[1CQualityID] IS NULL AND e.[1CQualityID] IS NULL)) 
		)
	BEGIN
		SET @ResultMessage = 'Качество содержимого в групповой упаковке не совпадает с приказом'
	END
	ELSE IF @ProductKindID = 3 AND @IsDocOut = 1 AND NOT EXISTS
		(
			SELECT * FROM
			DocShipmentOrders a
			LEFT JOIN
			[1CDocShipmentOrderGoods] b ON a.DocOrderID = b.[1CDocShipmentOrderID] AND @OrderType = 0 AND b.[1CNomenclatureID] = @NomenclatureID AND (b.[1CCharacteristicID] = @CharacteristicID OR (b.[1CCharacteristicID] IS NULL AND @CharacteristicID IS NULL))
			LEFT JOIN
			[1CDocInternalOrderGoods] c ON a.DocOrderID = c.[1CDocInternalOrderID] AND @OrderType = 1 AND c.[1CNomenclatureID] = @NomenclatureID AND (c.[1CCharacteristicID] = @CharacteristicID OR (c.[1CCharacteristicID] IS NULL AND @CharacteristicID IS NULL))
			WHERE a.DocOrderID = @DocOrderID AND (b.[1CDocShipmentOrderID] IS NOT NULL OR c.[1CDocInternalOrderID] IS NOT NULL)
		)
	BEGIN
		SET @ResultMessage = 'Россыпь: Номенклатура не совпадает с приказом'
	END
	ELSE IF @ProductKindID = 3 AND @IsDocOut = 1 AND NOT EXISTS
		(
			SELECT * FROM
			DocShipmentOrders a
			LEFT JOIN
			[1CDocShipmentOrderGoods] b ON a.DocOrderID = b.[1CDocShipmentOrderID] AND @OrderType = 0 AND b.[1CNomenclatureID] = @NomenclatureID AND (b.[1CCharacteristicID] = @CharacteristicID OR (b.[1CCharacteristicID] IS NULL AND @CharacteristicID IS NULL)) AND (b.[1CQualityID] = @QualityID OR b.[1CQualityID] IS NULL)
			LEFT JOIN
			[1CDocInternalOrderGoods] c ON a.DocOrderID = c.[1CDocInternalOrderID] AND @OrderType = 1 AND c.[1CNomenclatureID] = @NomenclatureID AND (c.[1CCharacteristicID] = @CharacteristicID OR (c.[1CCharacteristicID] IS NULL AND @CharacteristicID IS NULL)) AND (c.[1CQualityID] = @QualityID OR c.[1CQualityID] IS NULL)
			WHERE a.DocOrderID = @DocOrderID AND (b.[1CDocShipmentOrderID] IS NOT NULL OR c.[1CDocInternalOrderID] IS NOT NULL)
		)
	BEGIN
		SET @ResultMessage = 'Россыпь: Качество продукта не совпадает с приказом'
	END
	

	IF @ResultMessage = '' OR @ResultMessage IS NULL
	BEGIN
		SELECT TOP 1 @DocMovementID = a.DocID
		FROM
		DocMovement a
		JOIN
		Docs b ON a.DocID = b.DocID
		WHERE a.DocOrderID = @DocOrderID AND (b.IsConfirmed IS NULL OR b.IsConfirmed = 0)
		IF @AlreadyAdded <> 1 OR @AlreadyAdded IS NULL
		BEGIN		
				BEGIN TRANSACTION trans

					IF @DocMovementID IS NULL 
					BEGIN
						INSERT INTO Docs (DocTypeID, Date, UserID, IsConfirmed, ShiftID)
						OUTPUT INSERTED.DocID INTO @DocIds
						VALUES (2, getdate(), dbo.CurrentUserID(), 0, @ShiftID)

						SELECT TOP 1 @DocMovementID = DocID FROM @DocIds

						INSERT INTO DocMovement (DocID, DocOrderID, OrderTypeID, OutDate, OutPlaceID, InDate, InPlaceID)
						SELECT @DocMovementID, @DocOrderID, @OrderType, a.OutDate, a.OutPlaceID, a.InDate, a.InPlaceID
						FROM
						DocShipmentOrders a WHERE a.DocOrderID = @DocOrderID						
					END

					IF @ProductKindID = 3
					BEGIN
						DECLARE @ProductItemID uniqueidentifier
						--INSERT INTO @ProductItem (ProductID, ProductItemID)
						SELECT DISTINCT @ProductID = [pi].ProductID, @ProductItemID = [pi].ProductItemID 
							FROM 
								DocProduction dp 
								JOIN DocProductionProducts dpp ON dp.DocID = dpp.DocID 
								JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
								JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
							WHERE dp.DocOrderId = @DocOrderID AND p.ProductKindID = 3 AND p.[1CNomenclatureID] = @NomenclatureID AND (p.[1CCharacteristicID] = @CharacteristicID OR (p.[1CCharacteristicID] IS NULL OR @CharacteristicID IS NULL)) AND p.[1CQualityID] = @QualityID
						--SELECT @ProductID = ProductID, @ProductItemID = ProductItemID FROM @ProductItem

						IF @ProductItemID IS NULL
						BEGIN
							DECLARE @PlaceID int
							SELECT @PlaceID = a.OutPlaceID
								FROM DocShipmentOrders a 
								WHERE a.DocOrderID = @DocOrderID
							--EXEC [dbo].[CreateProductR] @DocOrderId, 0, @PlaceID, @NomenclatureID, @CharacteristicID, @QualityID, NULL, @ProductID, @ProductItemID
							EXEC [dbo].[CreateProductR] @DocOrderID=@DocOrderID, @ShiftId=@ShiftID, @PlaceID=@PlaceID, @NomenclatureID=@NomenclatureID, @CharacteristicID=@CharacteristicID, @QualityID=@QualityID, @Quantity=NULL, @ProductID=@ProductID OUTPUT, @ProductItemID=@ProductItemID OUTPUT
							SET @IsAddProduct = 1
						END
--PRINT CAST(@ProductItemID AS varchar(100))	
--PRINT CAST(@QuantityRos AS varchar(10))
						DECLARE @QuantityUpdate decimal(15,3)
						SELECT @QuantityUpdate = SUM(ISNULL(Quantity,0) + @QuantityRos*ISNULL(f.Coefficient,1)) 
							FROM ProductItems [pi] 
								JOIN [1CNomenclature] n ON [pi].[1CNomenclatureID] = n.[1CNomenclatureID]
								LEFT JOIN [1CCharacteristics] c ON [pi].[1CCharacteristicID] = c.[1CCharacteristicID]
								LEFT JOIN [1CMeasureUnits] f ON ISNULL(c.[MeasureUnitPackage], n.[1CMeasureUnitSet]) = f.[1CMeasureUnitID]
							WHERE [pi].ProductItemID = @ProductItemID
						
						UPDATE [pi]
							SET Quantity = ISNULL(Quantity,0) + @QuantityRos*ISNULL(f.Coefficient,1)
							FROM ProductItems [pi] 
								JOIN [1CNomenclature] n ON [pi].[1CNomenclatureID] = n.[1CNomenclatureID]
								LEFT JOIN [1CCharacteristics] c ON [pi].[1CCharacteristicID] = c.[1CCharacteristicID]
								LEFT JOIN [1CMeasureUnits] f ON ISNULL(c.[MeasureUnitPackage], n.[1CMeasureUnitSet]) = f.[1CMeasureUnitID]
							WHERE [pi].ProductItemID = @ProductItemID
							
						IF @IsAddProduct = 1
							IF @IsDocOut = 1
							BEGIN
								INSERT INTO DocOutProducts (DocID, ProductID, Date, PersonID)
									VALUES (@DocMovementID, @ProductID, getdate(), @PersonID)
						--так как транзакцмя еще не закоммичена, то триггер обновления Quantity в DocInProducts и DocOutProducts записывает 0
								UPDATE DocOutProducts SET Quantity = @QuantityUpdate
									WHERE DocID = @DocMovementID AND ProductID = @ProductID
							END
							ELSE 
							BEGIN
								INSERT INTO DocInProducts (DocID, ProductID, Date, PersonID)
									VALUES (@DocMovementID, @ProductID, getdate(), @PersonID)
						--так как транзакцмя еще не закоммичена, то триггер обновления Quantity в DocInProducts и DocOutProducts записывает 0
								UPDATE DocInProducts SET Quantity = @QuantityUpdate
									WHERE DocID = @DocMovementID AND ProductID = @ProductID
								UPDATE a SET a.InPlaceID = b.InPlaceID
								FROM
								DocMovement a
								JOIN
								DocShipmentOrders b ON a.DocOrderID = b.DocOrderID
								WHERE a.InPlaceID IS NULL
							END		
					END
					ELSE
					BEGIN
					--IF @ProductKindID <> 3 OR (@ProductKindID = 3 AND @IsAddProduct = 1) 
						IF @IsDocOut = 1
						BEGIN
							INSERT INTO DocOutProducts (DocID, ProductID, Date, PersonID)
							VALUES (@DocMovementID, @ProductID, getdate(), @PersonID)
						END
						ELSE 
						BEGIN
							INSERT INTO DocInProducts (DocID, ProductID, Date, PersonID)
							VALUES (@DocMovementID, @ProductID, getdate(), @PersonID)

							UPDATE a SET a.InPlaceID = b.InPlaceID
							FROM
							DocMovement a
							JOIN
							DocShipmentOrders b ON a.DocOrderID = b.DocOrderID
							WHERE a.InPlaceID IS NULL
						END			
					END			
				COMMIT TRANSACTION trans
			END
			
			SELECT a.NomenclatureID, a.CharacteristicID, a.Quantity, a.ResultMessage, a.AlreadyAdded, a.OutPlace, a.DocMovementID,
				c.Name + ' ' + d.Name AS NomenclatureName, b.ShortNomenclatureName AS ShortNomenclatureName, a.Number, a.ProductID
				, e.CountBreak AS BreakNumber --dbo.GetSpoolsFieldsForProduct(a.ProductID,1) AS BreakNumber
				, e.CountProductSpools --dbo.GetSpoolsFieldsForProduct(a.ProductID,2) AS CountProductSpools
				, e.CountProductSpoolsWithBreak --dbo.GetSpoolsFieldsForProduct(a.ProductID,3) AS CountProductSpoolsWithBreak
				, a.[1CQualityID] AS QualityID
			FROM
			(
				SELECT	CASE
					WHEN a.ProductKindID = 0 THEN d.[1CNomenclatureID]
					WHEN a.ProductKindID IN (1,3) THEN c.[1CNomenclatureID]
					WHEN a.ProductKindID = 2 THEN b.[1CNomenclatureID]
				END AS NomenclatureID,
				CASE
					WHEN a.ProductKindID = 0 THEN d.[1CCharacteristicID]
					WHEN a.ProductKindID IN (1,3) THEN c.[1CCharacteristicID]
					WHEN a.ProductKindID = 2 THEN b.[1CCharacteristicID]
				END AS CharacteristicID,
				CASE
					WHEN a.ProductKindID = 0 THEN dbo.CalculateSpoolWeightBeforeDate(a.ProductID, getdate())
					WHEN a.ProductKindID = 1 THEN c.Quantity
					WHEN a.ProductKindID = 2 THEN b.Weight
					WHEN a.ProductKindID = 3 THEN @QuantityRos*ISNULL(cf.Coefficient,1)
				END AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded, @OutPlace AS OutPlace, @DocMovementID AS DocMovementID,
				a.Number, a.ProductID
				, e.[1CQualityID]
				FROM
				Products a
				LEFT JOIN
				ProductGroupPacks b ON a.ProductID = b.ProductID
				LEFT JOIN
				(ProductItems c 
					JOIN [1CNomenclature] cn ON c.[1CNomenclatureID] = cn.[1CNomenclatureID]
					LEFT JOIN [1CCharacteristics] cc ON c.[1CCharacteristicID] = cc.[1CCharacteristicID]
					LEFT JOIN [1CMeasureUnits] cf ON ISNULL(cc.[MeasureUnitPackage], cn.[1CMeasureUnitSet]) = cf.[1CMeasureUnitID]) 
					ON a.ProductID = c.ProductID		
				LEFT JOIN
				ProductSpools d ON a.ProductID = d.ProductID
				LEFT JOIN dbo.vProductsCurrentStateInfo e ON a.ProductID = e.ProductID
				WHERE a.ProductID = @ProductID
			) a
			JOIN
			vShortNomenclatureName b ON a.[NomenclatureID] = b.[1CNomenclatureID] AND (a.[CharacteristicID] = b.[1CCharacteristicID] OR (a.[CharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL))
			JOIN
			[1CNomenclature] c ON a.[NomenclatureID] = c.[1CNomenclatureID]
			LEFT JOIN
			[1CCharacteristics] d ON a.[CharacteristicID] = d.[1CCharacteristicID] OR (a.[CharacteristicID] IS NULL AND d.[1CCharacteristicID] IS NULL)
			LEFT JOIN 
			vSpoolsForProduct e ON a.ProductID = e.ProductID
	
	END
	ELSE
	BEGIN
		SELECT NULL AS NomenclatureID, NULL AS CharacteristicID, NULL AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded,
			@OutPlace AS OutPlace, @DocMovementID AS DocMovementID, '' AS NomenclatureName, '' AS Number, @ProductID AS ProductID,
			'' AS ShortNomenclatureName
			,NULL AS BreakNumber,NULL AS CountProductSpools,NULL AS CountProductSpoolsWithBreak, NULL AS QualityID



	END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToOrder] TO [PalletRepacker]
    AS [dbo];

