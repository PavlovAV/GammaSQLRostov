
CREATE VIEW [dbo].[vSpoolProduction] 
AS
SELECT SUM(dpp.Quantity) AS Quantity, YEAR (d.Date) AS YEAR, MONTH(d.Date) AS [MONTH]
FROM Docs d 
JOIN DocProductionProducts dpp ON dpp.DocID = d.DocID
WHERE d.PlaceID IN (1, 2) AND d.Date >= '20160401' AND d.Date < '20170925'
GROUP BY YEAR (d.Date), MONTH(d.Date)

GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolProduction] TO [PalletRepacker]
    AS [dbo];

