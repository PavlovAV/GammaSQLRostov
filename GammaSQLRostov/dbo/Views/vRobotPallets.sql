



CREATE VIEW [dbo].[vRobotPallets]
AS
SELECT DISTINCT  p.STGCode AS Number, p.STGCode AS Barcode, p.InsertDate AS Date, 
  n.[1CNomenclatureID], c.[1CCharacteristicID],-- b.[1CBarcodeTypeID],
  rp.PlaceID AS PlaceID, u.Coefficient AS Quantity, p.EAN
FROM [1CMeasureUnits] u
JOIN [dbo].[1CCharacteristics] c ON c.MeasureUnitPallet = u.[1CMeasureUnitID]
JOIN [1CNomenclature] n ON n.[1CNomenclatureID] = c.[1CNomenclatureID]  
JOIN [dbo].[RobotProduct1CCharacteristic] rc ON rc.[1CCharCode] = c.[1CCode]
JOIN [MSTR1].[RobotActivation].[dbo].[vStoricoPallet] p ON p.ProdNumber = rc.ProdNumber
JOIN vRobotPlaces rp ON rp.RobotLineID = p.ProductionLine

/*SELECT DISTINCT  p.STGCode AS Number, p.STGCode AS Barcode, MAX(p.InsertDate) AS Date, 
  n.[1CNomenclatureID], c.[1CCharacteristicID],-- b.[1CBarcodeTypeID],
  rp.PlaceID AS PlaceID, u.Coefficient AS Quantity, p.EAN
FROM [1CBarcodes] b
JOIN [dbo].[1CCharacteristics] c ON c.[1CCharacteristicID] = b.[1CCharacteristicID]
JOIN [1CNomenclature] n ON n.[1CNomenclatureID] = c.[1CNomenclatureID]  AND c.[1CNomenclatureID] = n.[1CNomenclatureID]
JOIN [1CMeasureUnits] u ON u.[1CMeasureUnitID] = b.[1CMeasureUnitID]
JOIN [dbo].[RobotProduct1CCharacteristic] rc ON rc.[1CCharCode] = c.[1CCode]
JOIN [MSTR1].[RobotActivation].[dbo].[StoricoPallet] p ON p.ProdNumber = rc.ProdNumber
JOIN vRobotPlaces rp ON rp.RobotLineID = p.ProductionLine
WHERE [1CMeasureUnitQualifierID] = 'CCA324C2-23DE-11E1-831F-50E5493A7A39' AND b.[1CQualityID] = 'D05404A0-6BCE-449B-A798-41EBE5E5B977'
  AND NOT (b.Barcode = '54607075795452' AND b.[1CCharacteristicID] = '5FE4B685-E8BB-11E3-B85D-002590304E93') 
  AND NOT p.STGCode = '14607075791289'
GROUP BY p.STGCode, n.[1CNomenclatureID], c.[1CCharacteristicID],-- b.[1CBarcodeTypeID],
  rp.PlaceID, u.Coefficient, 
  p.EAN
  */








GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPallets] TO [PalletRepacker]
    AS [dbo];

