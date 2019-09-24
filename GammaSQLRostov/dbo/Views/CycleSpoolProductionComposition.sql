







--SELECT * FROM [CycleSpoolProduction] 

CREATE VIEW [dbo].[CycleSpoolProductionComposition]
AS
SELECT Cycle, MAX(Date) AS [CycleDateEnd], MIN(Date) AS [CycleDateBegin], 
       --SpoolKind, 
	   Place, SUM(Weight) *1000 AS Weight, a.PlaceID, 
	   CASE WHEN a.Composition LIKE '%Ц-%' THEN 'Ц'
						  WHEN a.Composition LIKE '%ОМ%' THEN 'ОМ'
						  WHEN a.Composition LIKE '%ЦМ%' THEN 'ЦМ' 
						  WHEN a.Composition LIKE '%М-%' THEN 'М'
						  ELSE a.Composition END + ', ' + a.SortValue /*a.Composition*/   AS Sort, a.RawMaterial, a.Composition,
						a.SortValue
FROM (
		SELECT ROW_NUMBER() OVER (ORDER BY d.PlaceID, d.Date) - RANK() 							
							OVER (PARTITION BY d.PlaceID, n.Name + ' ' +c.Name ORDER BY d.Date) AS [Cycle],
				d.Date, n.Name AS [SpoolKind], 
				p.Name AS [Place], dpp.Quantity AS [Weight], d.PlaceID,
				nsp.SortValue, n.Name + ' ' + c.Name AS Composition
				, nsp.RawMaterial
		FROM ProductSpools ps 
		JOIN [1CNomenclature] n ON n.[1CNomenclatureID] = ps.[1CNomenclatureID]
		JOIN [1CCharacteristics] c ON ps.[1CCharacteristicID] = c.[1CCharacteristicID]
		JOIN DocProductionProducts dpp ON dpp.ProductID = ps.ProductID
		JOIN Docs d ON d.DocID = dpp.DocID
		JOIN Places p ON p.PlaceID = d.PlaceID AND (d.PlaceID IN (1, 2))
		JOIN vNomenclatureSGBProperties nsp ON nsp.[1CNomenclatureID] = n.[1CNomenclatureID]
		WHERE d.Date between '20170101 00:00:00' and GETDATE()
		--ORDER BY PlaceID, Date
		) a
GROUP BY Cycle, --SpoolKind, 
         Place, PlaceID, a.SortValue, a.Composition, a.RawMaterial, a.SortValue







GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CycleSpoolProductionComposition] TO [PalletRepacker]
    AS [dbo];

