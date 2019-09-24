

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--EXEC mob_GetBarcodes1C
CREATE PROCEDURE [dbo].[mob_GetBarcodes1C] 
	-- Add the parameters for the stored procedure here
AS
SELECT b.Barcode, b.[Name], b.NomenclatureID, b.CharacteristicID, b.QualityID, b.MeasureUnitID, b.BarcodeID
	FROM [vBarcodes1C] b
	WHERE 
		b.[NomenclatureID] IS NOT NULL /*AND b.[CharacteristicID] IS NOT NULL*/ AND b.[MeasureUnitID] IS NOT NULL AND b.[QualityID] IS NOT NULL
/*
SELECT b.Barcode, n.Name + ISNULL(' ' +c.Name,'') + ISNULL(' ' +q.Description,'') AS [Name],  b.[1CNomenclatureID] AS NomenclatureID, c.[1CCharacteristicID] AS CharacteristicID, b.[1CQualityID] AS QualityID, b.[1CMeasureUnitID] AS MeasureUnitID
	FROM [1CBarcodes] b
		JOIN [1CNomenclature] n ON b.[1CNomenclatureID] = n.[1CNomenclatureID]
		LEFT JOIN [1CCharacteristics] c ON (b.[1CCharacteristicID] IS NULL AND c.[1CNomenclatureID] = b.[1CNomenclatureID]) OR c.[1CCharacteristicID] = b.[1CCharacteristicID]
		LEFT JOIN [1CMeasureUnits] m ON b.[1CMeasureUnitID] = m.[1CMeasureUnitID]
		LEFT JOIN [1CQuality] q ON b.[1CQualityID] = q.[1CQualityID]
	WHERE 
		b.[1CNomenclatureID] IS NOT NULL AND c.[1CCharacteristicID] IS NOT NULL AND m.[1CMeasureUnitID] IS NOT NULL AND q.[1CQualityID] IS NOT NULL
*/

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1C] TO [PalletRepacker]
    AS [dbo];

