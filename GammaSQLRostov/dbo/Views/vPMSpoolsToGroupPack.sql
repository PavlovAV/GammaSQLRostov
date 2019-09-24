











CREATE VIEW [dbo].[vPMSpoolsToGroupPack]
AS
SELECT c.ProductID, d.ProductGroupPackID, a.Date AS PMDate, a.ShiftId, g.Name + ' ' + h.Name AS NomenclatureName,
	e.Number AS PMNumber, d.WrNumber, ISNULL(d.Weight, f.DecimalWeight) AS Weight, a.PlaceID, f.[1CNomenclatureID], f.[1CCharacteristicID]
FROM 
Docs a
JOIN
Places b ON a.PlaceID = b.PlaceID
JOIN
DocProductionProducts c ON a.DocID = c.DocID
LEFT JOIN
(
	SELECT DISTINCT ISNULL(d.ProductID,a.ProductID) AS ProductID, a.ProductGroupPackID, 
		e.Number AS WrNumber, f.Weight
	FROM
	vGroupPackSpools a
	JOIN
	DocProductionProducts b ON a.ProductID = b.ProductID
	LEFT JOIN
	DocProductionWithdrawals c ON b.DocID = c.DocProductionID 
	LEFT JOIN
	DocWithdrawalProducts d ON c.DocWithdrawalID = d.DocID
	JOIN
	Products e ON a.ProductGroupPackID = e.ProductID
	JOIN
	ProductGroupPacks f ON e.ProductID = f.ProductID
) d ON c.ProductID = d.ProductID
JOIN
Products e ON c.ProductID = e.ProductID
JOIN
ProductSpools f ON e.ProductID = f.ProductID
JOIN
[1CNomenclature] g ON f.[1CNomenclatureID] = g.[1CNomenclatureID]
JOIN
[1CCharacteristics] h ON f.[1CCharacteristicID] = h.[1CCharacteristicID]
WHERE b.PlaceGroupID = 0



GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPMSpoolsToGroupPack] TO [PalletRepacker]
    AS [dbo];

