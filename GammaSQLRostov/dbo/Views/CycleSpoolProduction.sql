

CREATE VIEW [dbo].[CycleSpoolProduction]
AS
SELECT Cycle, MAX(Date) AS [CycleDateEnd], MIN(Date) AS [CycleDateBegin], 
       --SpoolKind, 
	   Place, SUM(Weight) *1000 AS Weight, a.PlaceID, a.Composition
FROM (
		SELECT ROW_NUMBER() OVER (ORDER BY d.PlaceID, d.Date) - RANK() 
							OVER (PARTITION BY d.PlaceID, nsp.SortValue + ' ' + nsp.Composition + ' ' + nsp.ColorGroup ORDER BY d.Date) AS [Cycle],
				d.Date, n.Name AS [SpoolKind], 
				p.Name AS [Place], dpp.Quantity AS [Weight], d.PlaceID,
				nsp.SortValue, 
				nsp.SortValue + ' ' + nsp.Composition + ' ' + nsp.ColorGroup AS Composition

				, nsp.RawMaterial
		FROM ProductSpools ps 
		JOIN [1CNomenclature] n ON n.[1CNomenclatureID] = ps.[1CNomenclatureID]
		JOIN [1CCharacteristics] c ON ps.[1CCharacteristicID] = c.[1CCharacteristicID]
		JOIN DocProductionProducts dpp ON dpp.ProductID = ps.ProductID
		JOIN Docs d ON d.DocID = dpp.DocID
		JOIN Places p ON p.PlaceID = d.PlaceID AND (d.PlaceID IN (1, 2))
		JOIN vNomenclatureSGBProperties nsp ON nsp.[1CNomenclatureID] = n.[1CNomenclatureID]
		WHERE d.Date between '20180101 00:00:00' and GETDATE()
		) a
GROUP BY Cycle, Place, PlaceID, a.SortValue, a.Composition, a.RawMaterial, a.SortValue







GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProduction] TO [PalletRepacker]
    AS [dbo];

