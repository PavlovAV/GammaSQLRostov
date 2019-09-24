-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[mob_AddProductToOrder] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderID uniqueidentifier,
		@OrderType int,
		@PersonID uniqueidentifier,
		@Barcode varchar(20), -- ШК или номер
		@IsDocOut bit
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductID uniqueidentifier, @ResultMessage nvarchar(1000), @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier
		, @Quantity decimal(15,3), @AlreadyAdded bit, @DocMovementID uniqueidentifier, @OutPlaceID int, @OutPlace varchar(50), @ProductKindID int

	DECLARE @DocIds table(DocID uniqueidentifier)
	
	SELECT @ProductID = ProductID, @ProductKindID = ProductKindID 
	FROM
	Products a
	WHERE Barcode = @Barcode OR Number = @Barcode

	IF @ProductID IS NULL
	BEGIN
		SET @ResultMessage = 'Продукт с данным шк не найден в базе'
	END
	ELSE IF (@IsDocOut = 1 AND EXISTS 
			(
				SELECT * 
				FROM
				DocOutProducts a
				JOIN
				DocMovement b ON a.DocID = b.DocID AND b.DocOrderID = @DocOrderID
				WHERE a.ProductID = @ProductID
			))
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
	ELSE IF @IsDocOut = 1 AND NOT EXISTS 
			(SELECT * FROM Rests WHERE ProductID = @ProductID AND Quantity > 0) OR
			NOT EXISTS (SELECT * FROM vProductsInfo WHERE ProductID = @ProductID AND Quantity > 0)
	BEGIN
		SET @ResultMessage = 'Данное изделие не числится на остатках'
	END
	ELSE IF @IsDocOut = 1 AND NOT EXISTS
		(
			SELECT * FROM
			DocShipmentOrders a
			LEFT JOIN
			[1CDocShipmentOrderGoods] b ON a.DocOrderID = b.[1CDocShipmentOrderID] AND @OrderType = 0
			LEFT JOIN
			[1CDocInternalOrderGoods] c ON a.DocOrderID = c.[1CDocInternalOrderID] AND @OrderType = 1
			JOIN
			vProductsInfo d ON (b.[1CNomenclatureID] = d.[1CNomenclatureID] AND b.[1CCharacteristicID] = d.[1CCharacteristicID]) OR
				(c.[1CNomenclatureID] = d.[1CNomenclatureID] AND c.[1CCharacteristicID] = d.[1CCharacteristicID])
			WHERE a.DocOrderID = @DocOrderID AND d.ProductID = @ProductID
		)
	BEGIN
		SET @ResultMessage = 'Номенклатура не совпадает с приказом'
	END
	ELSE IF @IsDocOut = 1 AND NOT EXISTS
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
						INSERT INTO Docs (DocTypeID, Date, UserID, IsConfirmed)
						OUTPUT INSERTED.DocID INTO @DocIds
						VALUES (2, getdate(), dbo.CurrentUserID(), 0)

						SELECT TOP 1 @DocMovementID = DocID FROM @DocIds

						INSERT INTO DocMovement (DocID, DocOrderID, OrderTypeID, OutDate, OutPlaceID, InDate, InPlaceID)
						SELECT @DocMovementID, @DocOrderID, @OrderType, a.OutDate, a.OutPlaceID, a.InDate, a.InPlaceID
						FROM
						DocShipmentOrders a WHERE a.DocOrderID = @DocOrderID						
					END
				
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
				COMMIT TRANSACTION trans
			END
			
			SELECT a.NomenclatureID, a.CharacteristicID, a.Quantity, a.ResultMessage, a.AlreadyAdded, a.OutPlace, a.DocMovementID,
				c.Name + ' ' + d.Name AS NomenclatureName, b.ShortNomenclatureName AS ShortNomenclatureName, a.Number, a.ProductID
				, e.CountBreak AS BreakNumber --dbo.GetSpoolsFieldsForProduct(a.ProductID,1) AS BreakNumber
				, e.CountProductSpools --dbo.GetSpoolsFieldsForProduct(a.ProductID,2) AS CountProductSpools
				, e.CountProductSpoolsWithBreak --dbo.GetSpoolsFieldsForProduct(a.ProductID,3) AS CountProductSpoolsWithBreak
			FROM
			(
				SELECT	CASE
					WHEN a.ProductKindID = 0 THEN d.[1CNomenclatureID]
					WHEN a.ProductKindID = 1 THEN c.[1CNomenclatureID]
					WHEN a.ProductKindID = 2 THEN b.[1CNomenclatureID]
				END AS NomenclatureID,
				CASE
					WHEN a.ProductKindID = 0 THEN d.[1CCharacteristicID]
					WHEN a.ProductKindID = 1 THEN c.[1CCharacteristicID]
					WHEN a.ProductKindID = 2 THEN b.[1CCharacteristicID]
				END AS CharacteristicID,
				CASE
					WHEN a.ProductKindID = 0 THEN dbo.CalculateSpoolWeightBeforeDate(a.ProductID, getdate())
					WHEN a.ProductKindID = 1 THEN c.Quantity
					WHEN a.ProductKindID = 2 THEN b.Weight
				END AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded, @OutPlace AS OutPlace, @DocMovementID AS DocMovementID,
				a.Number, a.ProductID
				FROM
				Products a
				LEFT JOIN
				ProductGroupPacks b ON a.ProductID = b.ProductID
				LEFT JOIN
				ProductItems c ON a.ProductID = c.ProductID		
				LEFT JOIN
				ProductSpools d ON a.ProductID = d.ProductID
				WHERE a.ProductID = @ProductID
			) a
			JOIN
			vShortNomenclatureName b ON a.[NomenclatureID] = b.[1CNomenclatureID] AND a.[CharacteristicID] = b.[1CCharacteristicID]
			JOIN
			[1CNomenclature] c ON a.[NomenclatureID] = c.[1CNomenclatureID]
			JOIN
			[1CCharacteristics] d ON a.[CharacteristicID] = d.[1CCharacteristicID]
			LEFT JOIN 
			vSpoolsForProduct e ON a.ProductID = e.ProductID
	
	END
	ELSE
	BEGIN
		SELECT NULL AS NomenclatureID, NULL AS CharacteristicID, NULL AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded,
			@OutPlace AS OutPlace, @DocMovementID AS DocMovementID, '' AS NomenclatureName, '' AS Number, @ProductID AS ProductID,
			'' AS ShortNomenclatureName
			,NULL AS BreakNumber,NULL AS CountProductSpools,NULL AS CountProductSpoolsWithBreak



	END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToOrder] TO [PalletRepacker]
    AS [dbo];

