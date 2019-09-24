


-- =============================================
-- Author:		<Павлов Александр>
-- Create date: <20.04.2018>
-- Description:	<Получение списка номенклатур по перемещению>
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetLastMovementGoodProductsListForPerson] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceIdTo int, --- склад приемки
		@PersonID uniqueidentifier, -- пользователь
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier,
		@PlaceZoneID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT a.Number, 
	--CASE WHEN a.QuantityPackage IS NOT NULL AND b.ProductID IS NULL THEN a.QuantityPackage ELSE a.Quantity END AS Quantity
	a.Quantity
	--,CAST(100*[dbo].[GetSpoolsFieldsForProduct](a.ProductID, 3)/[dbo].[GetSpoolsFieldsForProduct](a.ProductID, 2) AS DECIMAL(10,2)) AS SpoolWithBreakPercent
	,CASE WHEN b.ProductID IS NULL THEN NULL ELSE CAST(100*CASE WHEN b.CountProductSpools = 0 THEN NULL ELSE b.CountProductSpoolsWithBreak/CASE WHEN b.CountProductSpools = 0 THEN 1 ELSE b.CountProductSpools END END AS DECIMAL(10,2)) END AS SpoolWithBreakPercent
	,CASE WHEN b.ProductID IS NULL THEN '' ELSE CAST(ISNULL(b.CountProductSpoolsWithBreak,0) AS varchar(10)) + ' из ' + CAST(ISNULL(b.CountProductSpools,0) AS varchar(10)) END AS SpoolWithBreak
	,CASE WHEN a.ProductKindID = 3 THEN 1 ELSE 0 END AS IsProductR --россыпь
	--,a.CoefficientPackage
	--, a.QuantityPackage --количество групповых упаковок
	
	--SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], a.NomenclatureName, a.ShortNomenclatureName
	--, a.CoefficientPackage, a.CoefficientPallet, SUM(a.Quantity) AS Quantity
	FROM
	vDocMovementProducts a
	LEFT JOIN vSpoolsForProduct b ON a.ProductID = b.ProductID
	WHERE (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND ((ISNULL(@PlaceZoneID,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000' AND a.InPlaceZoneID IS NOT NULL AND a.InPlaceZoneID = @PlaceZoneID) OR (ISNULL(@PlaceZoneID,'00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000' AND a.InPlaceZoneID IS NULL))
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -14,GETDATE())
	AND
	[1CNomenclatureID] = @NomenclatureID
	AND
	--[1CCharacteristicID] = @CharacteristicID
	(([1CCharacteristicID] = @CharacteristicID AND [1CCharacteristicID] IS NOT NULL AND ISNULL(@CharacteristicID,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000') OR ([1CCharacteristicID] IS NULL AND ISNULL(@CharacteristicID,'00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000'))
	AND
	(([1CQualityID] = @QualityID AND [1CQualityID] IS NOT NULL AND ISNULL(@QualityID,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000') OR ([1CQualityID] IS NULL AND ISNULL(@QualityID,'00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000'))
	ORDER BY a.[1CNomenclatureID], a.[1CCharacteristicID] DESC
	

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementGoodProductsListForPerson] TO [PalletRepacker]
    AS [dbo];

