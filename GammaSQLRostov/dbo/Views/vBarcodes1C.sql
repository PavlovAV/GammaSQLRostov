


CREATE VIEW [dbo].[vBarcodes1C]
 WITH SCHEMABINDING
AS
SELECT b.Barcode, n.Name + ISNULL(' ' +c.Name,'') + ISNULL(' ' +q.Description,'') AS [Name],  b.[1CNomenclatureID] AS NomenclatureID, c.[1CCharacteristicID] AS CharacteristicID, b.[1CQualityID] AS QualityID, b.[1CMeasureUnitID] AS MeasureUnitID, b.[1CBarcodeID] AS BarcodeID
	FROM [dbo].[1CBarcodes] b
		JOIN [dbo].[1CNomenclature] n ON b.[1CNomenclatureID] = n.[1CNomenclatureID]
		LEFT JOIN [dbo].[1CCharacteristics] c ON (b.[1CCharacteristicID] IS NULL AND c.[1CNomenclatureID] = b.[1CNomenclatureID]) OR c.[1CCharacteristicID] = b.[1CCharacteristicID]
		LEFT JOIN [dbo].[1CMeasureUnits] m ON b.[1CMeasureUnitID] = m.[1CMeasureUnitID]
		LEFT JOIN [dbo].[1CQuality] q ON b.[1CQualityID] = q.[1CQualityID]
--	WHERE 
--		b.[1CNomenclatureID] IS NOT NULL AND c.[1CCharacteristicID] IS NOT NULL AND m.[1CMeasureUnitID] IS NOT NULL AND q.[1CQualityID] IS NOT NULL

GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vBarcodes1C] TO [PalletRepacker]
    AS [dbo];

