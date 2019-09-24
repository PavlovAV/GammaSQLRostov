
CREATE VIEW [dbo].[vPalletBarcodes]
AS
SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CBarcodeTypeID], a.Barcode
FROM
[1CBarcodes] a
JOIN
[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID] AND a.[1CMeasureUnitID] = c.[MeasureUnitPallet]



GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPalletBarcodes] TO [PalletRepacker]
    AS [dbo];

