

CREATE VIEW [dbo].[vProductGroupPackWithSpools]
WITH SCHEMABINDING
AS
		SELECT g.ProductID
			, SUM(ISNULL(BreakNumber,0)) AS CountBreak
			, COUNT_BIG(*) AS CountProductSpools
			, SUM(CASE WHEN BreakNumber > 0 THEN 1 ELSE 0 END) CountProductSpoolsWithBreak
		FROM 
			dbo.ProductGroupPacks g
				JOIN dbo.DocProductionProducts pp ON g.ProductID = pp.ProductID
				JOIN dbo.DocProductionWithdrawals w ON pp.DocID = w.DocProductionID
				JOIN dbo.DocWithdrawalProducts wp ON w.DocWithdrawalID = wp.DocID
				JOIN dbo.ProductSpools p ON wp.ProductID = p.ProductID 
			GROUP BY 
				g.ProductID


GO
CREATE UNIQUE CLUSTERED INDEX [ix_vProductGroupPackWithSpools]
    ON [dbo].[vProductGroupPackWithSpools]([ProductID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductGroupPackWithSpools] TO [PalletRepacker]
    AS [dbo];

