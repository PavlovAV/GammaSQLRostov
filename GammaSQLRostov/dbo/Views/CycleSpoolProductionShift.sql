


CREATE VIEW [dbo].[CycleSpoolProductionShift]
AS
SELECT Cycle, MAX(Date) AS [CycleDateEnd], MIN(Date) AS [CycleDateBegin], 
       --SpoolKind, 
	   Place, SUM(Weight) *1000 AS Weight, a.PlaceID, a.Composition, a.ShiftID
FROM (
		SELECT ROW_NUMBER() OVER (ORDER BY d.PlaceID, d.Date) - RANK() 
							OVER (PARTITION BY d.PlaceID, nsp.SortValue + ' ' + nsp.Composition + ' ' + nsp.ColorGroup, d.ShiftID ORDER BY d.Date) AS [Cycle],
				d.Date, n.Name AS [SpoolKind], 
				p.Name AS [Place], dpp.Quantity AS [Weight], d.PlaceID,
				nsp.SortValue, 
				nsp.SortValue + ' ' + nsp.Composition + ' ' + nsp.ColorGroup AS Composition

				, nsp.RawMaterial, d.ShiftID
		FROM ProductSpools ps 
		JOIN [1CNomenclature] n ON n.[1CNomenclatureID] = ps.[1CNomenclatureID]
		JOIN [1CCharacteristics] c ON ps.[1CCharacteristicID] = c.[1CCharacteristicID]
		JOIN DocProductionProducts dpp ON dpp.ProductID = ps.ProductID
		JOIN Docs d ON d.DocID = dpp.DocID
		JOIN Places p ON p.PlaceID = d.PlaceID AND (d.PlaceID IN (1, 2))
		JOIN vNomenclatureSGBProperties nsp ON nsp.[1CNomenclatureID] = n.[1CNomenclatureID]
		WHERE d.Date between '20180101 00:00:00' and GETDATE()
		) a
GROUP BY Cycle, Place, PlaceID, a.SortValue, a.Composition, a.RawMaterial, a.SortValue, a.ShiftID
GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionShift] TO [Wrapper]
    AS [dbo];

