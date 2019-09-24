


-- =============================================
-- Author:		<Павлов Александр>
-- Create date: <20.04.2018>
-- Description:	<Получение списка номенклатур по перемещению>
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetLastMovementProductsListForPerson] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceIdTo int, --- склад приемки
		@PersonID uniqueidentifier -- пользователь
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	/*SELECT DISTINCT Number, Barcode, ShortNomenclatureName, Quantity, DocMovementID, a.DocDate AS Date
		,Number + ISNULL('/n/b'+a.InPlaceZone,'') AS NumberAndInPlaceZone 
	FROM
	vDocMovementProducts a
	WHERE (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -14,GETDATE())
	ORDER BY a.DocDate DESC
	*/
	
	SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], a.NomenclatureName, ISNULL(a.InPlaceZone + '#','') +  a.ShortNomenclatureName AS ShortNomenclatureName, a.InPlaceZoneID AS PlaceZoneID
	, a.CoefficientPackage, a.CoefficientPallet, SUM(a.Quantity) AS Quantity
	FROM
	vDocMovementProducts a
	WHERE (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -13,GETDATE())
	GROUP BY a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], a.NomenclatureName, ISNULL(a.InPlaceZone + '#','') +  a.ShortNomenclatureName, a.InPlaceZoneID
	, a.CoefficientPackage, a.CoefficientPallet
	ORDER BY a.[1CNomenclatureID], a.[1CCharacteristicID] DESC
	

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsListForPerson] TO [PalletRepacker]
    AS [dbo];

