






CREATE VIEW [dbo].[vDocProducts]
AS
SELECT DISTINCT ProductID, DocID, DocTypeID, Date
FROM
(
	SELECT a.ProductID, a.DocID, b.DocTypeID, b.Date
	FROM DocProductionProducts a
	JOIN Docs b ON a.DocID = b.DocID
	UNION ALL
	SELECT a.ProductID, a.DocID, b.DocTypeID, b.Date
	FROM DocBrokeProducts a
	JOIN Docs b ON a.DocID = b.DocID
	UNION ALL
	SELECT a.ProductID, a.DocID, b.DocTypeID, b.Date
	FROM DocWithdrawalProducts a
	JOIN Docs b ON a.DocID = b.DocID
	UNION ALL
	SELECT a.ProductID, a.DocID, b.DocTypeID, b.Date
	FROM
	DocInProducts a
	JOIN
	Docs b ON a.DocID = b.DocID
	UNION ALL
	SELECT a.ProductID, a.DocID, b.DocTypeID, b.Date
	FROM
	DocOutProducts a
	JOIN
	Docs b ON a.DocID = b.DocID
	UNION ALL
	SELECT a.ProductID, a.DocID, b.DocTypeID, b.Date
	FROM
	DocUnpackProducts a
	JOIN
	Docs b ON a.DocID = b.DocID
) a










GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocProducts] TO [PalletRepacker]
    AS [dbo];

