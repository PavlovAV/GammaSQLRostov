
-- =============================================
-- Author:		<Павлов Александр>
-- Create date: <20.04.2018>
-- Description:	<Добавление продукта в перемещение по ProductID>
-- =============================================
--exec dbo.[mob_AddProductIdToMovement] @PersonID='94874554-68A6-E611-A7A3-00241DC986EB',@ProductID='00000000-0000-0000-0000-000000000000',@PlaceID=8,@PlaceZoneID='3650B3A7-0584-E711-9F9B-00241DC986EB',@ProductKindID=3,@NomenclatureID='21DEA56A-E5ED-11E5-A7AC-002590EBA5B7',@CharacteristicID='4425F87B-E5EE-11E5-A7AC-002590EBA5B7',@QualityID='D05404A0-6BCE-449B-A798-41EBE5E5B977',@QuantityRos=1000
CREATE PROCEDURE [dbo].[mob_AddProductIdToMovement] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID uniqueidentifier,
		@ProductID uniqueidentifier,
		@PlaceID int, -- склад, на который перемещают
		@PlaceZoneID uniqueidentifier = NULL,
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

	DECLARE  @ResultMessage nvarchar(1000)
		, @Quantity decimal(15,3), @AlreadyAdded bit, @DocMovementID uniqueidentifier, @OutPlaceID int, @OutPlace varchar(50),
		@Date DateTime, @OutPlaceZoneID uniqueidentifier, @PlaceZone varchar(200), @DocOrderID uniqueidentifier, @IsAddProduct int = 0

	DECLARE @DocIds table(DocID uniqueidentifier)
	IF CAST(@ProductID AS varchar(100)) = '00000000-0000-0000-0000-000000000000'
		SET @ProductID = NULL
	IF CAST(@CharacteristicID AS varchar(100)) = '00000000-0000-0000-0000-000000000000'
		SET @CharacteristicID = NULL
	--PRINT CAST(@ProductKindID AS varchar(100))
	--PRINT CAST(@ProductID AS varchar(100))

	IF @ProductKindID <> 3 
	BEGIN
		IF @ProductID IS NULL
			SET @ResultMessage = 'Продукт с данным шк не найден в базе'
		ELSE IF  @ProductKindID <> 3 AND NOT EXISTS 
			(SELECT * FROM Rests WHERE ProductID = @ProductID AND Quantity > 0) OR
			NOT EXISTS (SELECT * FROM vProductsInfo WHERE ProductID = @ProductID AND Quantity > 0)
				SET @ResultMessage = 'Данное изделие не числится на остатках'
	END
/*	ELSE IF EXISTS 
		(
			SELECT * FROM DocInProducts a
			JOIN
			DocMovement b ON a.DocID = b.DocID
			JOIN
			Docs c ON b.DocID = c.DocID AND (c.IsConfirmed IS NULL OR c.IsConfirmed = 0) 
			WHERE a.ProductID = @ProductID AND b.InPlaceID = @PlaceID AND (a.IsConfirmed IS NULL OR a.IsConfirmed = 0)
		)
	BEGIN
		SET @AlreadyAdded = 1
	END
*/
	SELECT @OutPlaceID = a.PlaceID, @OutPlace = b.Name, @OutPlaceZoneID = a.PlaceZoneID
			FROM 
			Rests a
			JOIN
			Places b ON a.PlaceID = b.PlaceID
			WHERE ProductID = @ProductID
	
	SELECT @PlaceZone = [name]
		FROM PlaceZones
		WHERE PlaceZoneID = @PlaceZoneID
			

	IF @ResultMessage = '' OR @ResultMessage IS NULL
	BEGIN
		SELECT TOP 1 @DocMovementID = a.DocID, @DocOrderID = a.DocOrderID
			FROM
			DocMovement a
			JOIN
			Docs b ON a.DocID = b.DocID
			WHERE 
			((OutPlaceID IS NULL AND @OutPlaceID IS NULL) OR (OutPlaceID IS NOT NULL AND @OutPlaceID IS NOT NULL AND OutPlaceID = @OutPlaceID))
			AND InPlaceID = @PlaceID
			AND (b.IsConfirmed IS NULL OR b.IsConfirmed = 0)
			AND OrderTypeID = 3 
			AND b.PersonGuid = @PersonID
			AND b.ShiftID = @ShiftID
			--Если смена с 8, то с 8 часов ищем документы позднее 8:00, если смена с 20 - то документы с 20:00
			AND ((DATEPART(hour,GETDATE()) BETWEEN 8 AND 19 AND (b.Date >= DATETIMEFROMPARTS (year(GETDATE()), month(GETDATE()), day(GETDATE()), 8, 0, 0, 0))) OR (DATEPART(hour,GETDATE()) BETWEEN 20 AND 24 AND (b.Date >= DATETIMEFROMPARTS (year(GETDATE()), month(GETDATE()), day(GETDATE()), 20, 0, 0, 0))) OR (DATEPART(hour,GETDATE()) BETWEEN 0 AND 7 AND (b.Date >= DATETIMEFROMPARTS (year(DATEADD(DAY,-1,GETDATE())), month(DATEADD(DAY,-1,GETDATE())), day(DATEADD(DAY,-1,GETDATE())), 20, 0, 0, 0))))
			ORDER BY b.Date DESC
		IF @AlreadyAdded <> 1 OR @AlreadyAdded IS NULL
		BEGIN		
			SELECT @Date = getdate();
	
				BEGIN TRANSACTION trans
					IF @DocMovementID IS NULL 
					BEGIN
						INSERT INTO Docs (DocTypeID, Date, UserID, IsConfirmed, PersonGuid, ShiftID)
						OUTPUT INSERTED.DocID INTO @DocIds
						VALUES (2, @Date, dbo.CurrentUserID(), 
							0,--CASE
							--	WHEN @OutPlaceID = @PlaceID THEN 1
							--	ELSE 0
							--END,
							@PersonID,
							@ShiftID)

						SELECT TOP 1 @DocMovementID = DocID FROM @DocIds

						INSERT INTO DocMovement (DocID, OutDate, OutPlaceID, InDate, InPlaceID,OrderTypeID)
						VALUES (@DocMovementID, @Date, @OutPlaceID, @Date, @PlaceID,3)
					END

					IF @ProductKindID = 3
					BEGIN
						DECLARE @ProductItemID uniqueidentifier
						--INSERT INTO @ProductItem (ProductID, ProductItemID)
						/*SELECT DISTINCT @ProductID = [pi].ProductID, @ProductItemID = [pi].ProductItemID 
							FROM 
								DocProduction dp 
								JOIN DocProductionProducts dpp ON dp.DocID = dpp.DocID 
								JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
								JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND [pi].[1CCharacteristicID] = p.[1CCharacteristicID]
							WHERE dp.DocOrderId = @DocOrderID AND p.ProductKindID = 3 AND p.[1CNomenclatureID] = @NomenclatureID AND p.[1CCharacteristicID] = @CharacteristicID AND p.[1CQualityID] = @QualityID
							*/
						SELECT TOP 1 @ProductID = [pi].ProductID, @ProductItemID = [pi].ProductItemID 
							FROM 
								vDocMovementProducts dp
								JOIN vProductsInfo p ON dp.ProductID = p.ProductID 
								JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] 
									AND (([pi].[1CCharacteristicID] = p.[1CCharacteristicID] AND [pi].[1CCharacteristicID] IS NOT NULL AND p.[1CCharacteristicID] IS NOT NULL) OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
							WHERE dp.DocMovementID = @DocMovementID AND p.ProductKindID = 3 AND p.[1CNomenclatureID] = @NomenclatureID AND ((p.[1CCharacteristicID] = @CharacteristicID AND @CharacteristicID IS NOT NULL) OR (p.[1CCharacteristicID] IS NULL AND @CharacteristicID IS NULL)) AND p.[1CQualityID] = @QualityID
							ORDER BY 
							  p.Date DESC

						--SELECT @ProductID = ProductID, @ProductItemID = ProductItemID FROM @ProductItem
--PRINT 'ProductID '+ISNULL(CAST(@ProductID AS varchar(100)),'NULL')	
--PRINT 'EXEC [dbo].[CreateProductR] @DocOrderId='+ISNULL(CAST(@DocOrderId AS varchar(100)),'NULL')+', 0, @PlaceID='+ISNULL(CAST(@PlaceID AS varchar(100)),'NULL')+', @NomenclatureID='+ISNULL(CAST(@NomenclatureID AS varchar(100)),'NULL')+', @CharacteristicID='+ISNULL(CAST(@CharacteristicID AS varchar(100)),'NULL')+', @QualityID='+ISNULL(CAST(@QualityID AS varchar(100)),'NULL')+', NULL, @ProductID=NULL, @ProductItemID=NULL'
						IF @ProductItemID IS NULL
						BEGIN
							EXEC [dbo].[CreateProductR] @DocOrderID=@DocOrderID, @ShiftId=@ShiftID, @PlaceID=@PlaceID, @NomenclatureID=@NomenclatureID, @CharacteristicID=@CharacteristicID, @QualityID=@QualityID, @Quantity=NULL, @ProductID=@ProductID OUTPUT, @ProductItemID=@ProductItemID OUTPUT
							SET @IsAddProduct = 1
						END
							
						
--PRINT 'ProductID '+ISNULL(CAST(@ProductID AS varchar(100)),'NULL')	

--PRINT CAST(@ProductItemID AS varchar(100))	
--PRINT CAST(@QuantityRos AS varchar(10))
						DECLARE @QuantityUpdate decimal(15,3)
						SELECT @QuantityUpdate = SUM(ISNULL(Quantity,0) + @QuantityRos*ISNULL(f.Coefficient,1)) FROM ProductItems [pi] 
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
							BEGIN
								INSERT INTO DocOutProducts (DocID, ProductID, Date, PlaceZoneID, PersonID, Quantity)
								VALUES (@DocMovementID, @ProductID, @Date, @OutPlaceZoneID,@PersonID,@QuantityRos)

								INSERT INTO DocInProducts (DocID, ProductID, Date, PlaceZoneID, PersonID,Quantity)
								VALUES (@DocMovementID, @ProductID, @Date, @PlaceZoneID,@PersonID,@QuantityRos)
							END
							
							--так как транзакцмя еще не закоммичена, то триггер обновления Quantity в DocInProducts и DocOutProducts записывает 0
							UPDATE DocOutProducts SET Quantity = @QuantityUpdate
								WHERE DocID = @DocMovementID AND ProductID = @ProductID
							UPDATE DocInProducts SET Quantity = @QuantityUpdate
								WHERE DocID = @DocMovementID AND ProductID = @ProductID
							
					END
					ELSE
					--IF @ProductKindID <> 3 OR (@ProductKindID = 3 AND @IsAddProduct = 1) 
					BEGIN
						INSERT INTO DocOutProducts (DocID, ProductID, Date, PlaceZoneID, PersonID)
						VALUES (@DocMovementID, @ProductID, @Date, @OutPlaceZoneID,@PersonID)

						INSERT INTO DocInProducts (DocID, ProductID, Date, PlaceZoneID, PersonID)
						VALUES (@DocMovementID, @ProductID, @Date, @PlaceZoneID,@PersonID)
					END
				COMMIT TRANSACTION trans
			END
--PRINT 'ProductID '+ISNULL(CAST(@ProductID AS varchar(100)),'NULL')				
			SELECT a.NomenclatureID, a.CharacteristicID, a.Quantity, a.ResultMessage, a.AlreadyAdded, a.OutPlace, a.DocMovementID,
				c.Name + ' ' + d.Name AS NomenclatureName, 
				ISNULL(@PlaceZone + '#','') +  b.ShortNomenclatureName AS ShortNomenclatureName, a.Number, @Date AS Date, NumberAndInPlaceZone , a.QualityID, @PlaceZoneID AS PlaceZoneID
				,ISNULL(l.Coefficient,1) AS CoefficientPackage, ISNULL(m.Coefficient,1) AS CoefficientPallet
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
					WHEN a.ProductKindID = 0 THEN dbo.CalculateSpoolWeightBeforeDate(a.ProductID, @Date)
					WHEN a.ProductKindID = 1 THEN c.Quantity
					WHEN a.ProductKindID = 2 THEN b.Weight
					WHEN a.ProductKindID = 3 THEN @QuantityRos*ISNULL(cf.Coefficient,1)
				END AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded, @OutPlace AS OutPlace, @DocMovementID AS DocMovementID,
				a.Number ,Number + ISNULL('/n/b'+@PlaceZone,'') AS NumberAndInPlaceZone 
				, f.[1CQualityID] AS QualityID
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
				LEFT JOIN 
				dbo.vProductsCurrentStateInfo f ON a.ProductID = f.ProductID
				WHERE a.ProductID = @ProductID
			) a
			JOIN
			vShortNomenclatureName b ON a.[NomenclatureID] = b.[1CNomenclatureID] AND (a.[CharacteristicID] = b.[1CCharacteristicID] OR (a.[CharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL))
			JOIN
			[1CNomenclature] c ON a.[NomenclatureID] = c.[1CNomenclatureID]
			LEFT JOIN
			[1CCharacteristics] d ON a.[CharacteristicID] = d.[1CCharacteristicID] OR (a.[CharacteristicID] IS NULL AND d.[1CCharacteristicID] IS NULL)
			LEFT JOIN
			[1CMeasureUnits] l ON ISNULL(d.[MeasureUnitPackage], c.[1CMeasureUnitSet]) = l.[1CMeasureUnitID]
			LEFT JOIN
			[1CMeasureUnits] m ON d.[MeasureUnitPallet] = m.[1CMeasureUnitID]

	END
	ELSE
	BEGIN
		SELECT NULL AS NomenclatureID, NULL AS CharacteristicID, NULL AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded,
			@OutPlace AS OutPlace, @DocMovementID AS DocMovementID, '' AS NomenclatureName, '' AS Number, @Date AS Date, '' AS NumberAndInPlaceZone
			, NULL AS QualityID, '' AS ShortNomenclatureName, NULL AS PlaceZoneID, NULL AS CoefficientPackage, NULL AS CoefficientPallet
	END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToMovement] TO [PalletRepacker]
    AS [dbo];

