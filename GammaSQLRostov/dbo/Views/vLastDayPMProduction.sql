
CREATE VIEW [dbo].[vLastDayPMProduction]
AS

		SELECT MIN(d.Date) AS DateCycleStart, MAX(d.Date) AS DateCycleEnd,
		   n.Name AS [SpoolKind], p.Name AS [Place], SUM(dpp.Quantity) AS [Weight], d.PlaceID,
				nsp.SortValue, nsp.Composition, nsp.RawMaterial
		FROM ProductSpools ps 
		JOIN [1CNomenclature] n ON n.[1CNomenclatureID] = ps.[1CNomenclatureID]
		JOIN DocProductionProducts dpp ON dpp.ProductID = ps.ProductID
		JOIN Docs d ON d.DocID = dpp.DocID
		JOIN Places p ON p.PlaceID = d.PlaceID AND (d.PlaceID IN (1, 2))
		JOIN vNomenclatureSGBProperties nsp ON nsp.[1CNomenclatureID] = n.[1CNomenclatureID]
		WHERE d.Date between DATEADD(DAY, -1, DATEADD(HOUR, 8, CAST(cast(GETDATE() AS date) as datetime))) 
		   and DATEADD(HOUR, 8, CAST(cast(GETDATE() AS date) as datetime))
		GROUP BY n.Name, p.Name, d.PlaceID,
				nsp.SortValue, nsp.Composition, nsp.RawMaterial

GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vLastDayPMProduction] TO [PalletRepacker]
    AS [dbo];

