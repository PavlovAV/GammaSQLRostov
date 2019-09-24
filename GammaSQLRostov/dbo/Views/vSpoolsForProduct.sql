


--Катушки + групповые упаковки, в составе которых есть катушки.
--Для подсчета % катушек с обрывами при отгрузке

CREATE VIEW [dbo].[vSpoolsForProduct]
AS

		SELECT ProductID
			, BreakNumber AS CountBreak
			, 1 AS CountProductSpools
			, CASE WHEN BreakNumber > 0 THEN 1 ELSE 0 END CountProductSpoolsWithBreak
		FROM 
			ProductSpools p
		UNION
		SELECT ProductID, CountBreak, CountProductSpools, CountProductSpoolsWithBreak
		FROM 
			vProductGroupPackWithSpools WITH (NOEXPAND)


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vSpoolsForProduct] TO [PalletRepacker]
    AS [dbo];

