


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[mob_RemoveProductRFromMovement] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceIdTo int, --- склад приемки
		@PersonID uniqueidentifier, -- пользователь
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier,
		@PlaceZoneID uniqueidentifier,
		@Quantity int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
	IF @CharacteristicID ='00000000-0000-0000-0000-000000000000'
		SET @CharacteristicID = NULL
	IF @QualityID ='00000000-0000-0000-0000-000000000000'
		SET @QualityID = NULL
BEGIN TRAN
	UPDATE [pi]
		SET Quantity = [pi].Quantity - @Quantity*ISNULL(f.Coefficient,1)
		FROM 
			DocProduction dp 
			JOIN DocProductionProducts dpp ON dp.DocID = dpp.DocID 
			JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
			JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
			JOIN vDocMovementProducts a ON p.ProductID = a.ProductID
			LEFT JOIN [1CCharacteristics] h ON h.[1CCharacteristicID] = [pi].[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON h.[MeasureUnitPackage] = f.[1CMeasureUnitID]
		WHERE (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND ((ISNULL(@PlaceZoneID,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000'  AND a.InPlaceZoneID IS NOT NULL AND a.InPlaceZoneID = @PlaceZoneID) OR (ISNULL(@PlaceZoneID,'00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' AND a.InPlaceZoneID IS NULL))
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -14,GETDATE())
	AND
	a.[1CNomenclatureID] = @NomenclatureID
	AND
	(a.[1CCharacteristicID] = @CharacteristicID OR (a.[1CCharacteristicID] IS NULL AND @CharacteristicID  IS NULL))
	AND 
	(a.[1CQualityID] = @QualityID OR (a.[1CQualityID] IS NULL AND @QualityID IS NULL))
	--((a.[1CQualityID] = @QualityID AND a.[1CQualityID] IS NOT NULL AND ISNULL(@QualityID,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000') OR (a.[1CQualityID] IS NULL AND ISNULL(@QualityID,'00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000'))

	UPDATE [dip]
		SET Quantity = [pi].Quantity
		FROM 
			DocProduction dp 
			JOIN DocProductionProducts dpp ON dp.DocID = dpp.DocID 
			JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
			JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
			JOIN vDocMovementProducts a ON p.ProductID = a.ProductID
			JOIN DocInProducts dip ON dip.DocID = a.DocMovementID AND dip.ProductID = a.ProductID AND dip.PersonID = a.InPersonID
			LEFT JOIN [1CCharacteristics] h ON h.[1CCharacteristicID] = [pi].[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON h.[MeasureUnitPackage] = f.[1CMeasureUnitID]
		WHERE (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND ((ISNULL(@PlaceZoneID,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000'  AND a.InPlaceZoneID IS NOT NULL AND a.InPlaceZoneID = @PlaceZoneID) OR (ISNULL(@PlaceZoneID,'00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' AND a.InPlaceZoneID IS NULL))
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -14,GETDATE())
	AND
	a.[1CNomenclatureID] = @NomenclatureID
	AND
	(a.[1CCharacteristicID] = @CharacteristicID OR (a.[1CCharacteristicID] IS NULL AND @CharacteristicID  IS NULL))
	AND 
	(a.[1CQualityID] = @QualityID OR (a.[1CQualityID] IS NULL AND @QualityID IS NULL))

	UPDATE [dop]
		SET Quantity = [pi].Quantity
		FROM 
			DocProduction dp 
			JOIN DocProductionProducts dpp ON dp.DocID = dpp.DocID 
			JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
			JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
			JOIN vDocMovementProducts a ON p.ProductID = a.ProductID
			JOIN DocOutProducts dop ON dop.DocID = a.DocMovementID AND dop.ProductID = a.ProductID AND dop.PersonID = a.OutPersonID
			LEFT JOIN [1CCharacteristics] h ON h.[1CCharacteristicID] = [pi].[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON h.[MeasureUnitPackage] = f.[1CMeasureUnitID]
		WHERE (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND ((ISNULL(@PlaceZoneID,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000'  AND a.InPlaceZoneID IS NOT NULL AND a.InPlaceZoneID = @PlaceZoneID) OR (ISNULL(@PlaceZoneID,'00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' AND a.InPlaceZoneID IS NULL))
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -14,GETDATE())
	AND
	a.[1CNomenclatureID] = @NomenclatureID
	AND
	(a.[1CCharacteristicID] = @CharacteristicID OR (a.[1CCharacteristicID] IS NULL AND @CharacteristicID  IS NULL))
	AND 
	(a.[1CQualityID] = @QualityID OR (a.[1CQualityID] IS NULL AND @QualityID IS NULL))
COMMIT TRAN
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromMovement] TO [PalletRepacker]
    AS [dbo];

