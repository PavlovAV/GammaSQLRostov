



CREATE VIEW [dbo].[vNomenclatureStoragePlaces]
AS
SELECT DISTINCT a.PlaceID, a.PlaceZoneID, b.[1CNomenclatureID], b.[1CCharacteristicID], b.[1CQualityID], b.Quantity
FROM
Rests a
JOIN
vProductsInfo b ON a.ProductID = b.ProductID
WHERE a.Quantity > 0


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureStoragePlaces] TO [PalletRepacker]
    AS [dbo];

