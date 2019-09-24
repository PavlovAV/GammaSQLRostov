CREATE PROCEDURE [dbo].[mob_GetBarcodes1CChanges] 
	-- Add the parameters for the stored procedure here
	(
		@StartUTCDate datetime
	)
AS
SELECT b.Barcode, b.[Name], b.NomenclatureID, b.CharacteristicID, b.QualityID, b.MeasureUnitID, b.BarcodeID
	FROM [vBarcodes1C] b
	WHERE 
		b.[NomenclatureID] IS NOT NULL /*AND b.[CharacteristicID] IS NOT NULL*/ AND b.[MeasureUnitID] IS NOT NULL AND b.[QualityID] IS NOT NULL
		AND b.[BarcodeID] IN (SELECT [1CBarcodeID] FROM zz1CBarcodes WHERE zzDate >= DATEADD(MILLISECOND, DATEDIFF(MILLISECOND, GETUTCDATE(),GETDATE()), @StartUTCDate) )
UNION
SELECT b.Barcode, '' AS [Name],   b.[1CNomenclatureID] AS NomenclatureID, b.[1CCharacteristicID] AS CharacteristicID, b.[1CQualityID] AS QualityID, b.[1CMeasureUnitID] AS MeasureUnitID, b.[1CBarcodeID] AS BarcodeID
	FROM [zz1CBarcodes] b
	WHERE 
		zzDate >= DATEADD(MILLISECOND, DATEDIFF(MILLISECOND, GETUTCDATE(),GETDATE()), @StartUTCDate) 
	GROUP BY b.Barcode, b.[1CNomenclatureID], b.[1CCharacteristicID], b.[1CQualityID], b.[1CMeasureUnitID], b.[1CBarcodeID]
	HAVING MIN(zzTransactionType) = 2
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
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetBarcodes1CChanges] TO [PalletRepacker]
    AS [dbo];

