


-- =============================================
-- Author:		Pavlov
-- Create date: 14.12.2018
-- Description:	Текущий статус продукта
-- =============================================
CREATE FUNCTION [dbo].[GetProductState]
(
	@ProductID uniqueidentifier,
	@TableIns dbo.t_DocBrokeDecisionProducts READONLY,
	@TableDel dbo.t_DocBrokeDecisionProducts READONLY
)
RETURNS int
AS
BEGIN
	DECLARE @ProductState int = 0
	
	SELECT TOP 1 @ProductState = a.StateID
		FROM 
			(
			SELECT DocID, ProductID, 
					CASE StateID WHEN -1 THEN 2 WHEN 9999999 THEN 2 ELSE StateID END AS StateID 
				FROM (
					SELECT a.DocID, a.ProductID, 
							MAX(CASE WHEN a.StateID = 2 THEN CASE WHEN a.DecisionApplied = 1 THEN -1 ELSE 9999999 END ELSE a.StateID END) AS StateID 
						FROM (
						SELECT a.DocID, a.ProductID, a.StateID, a.DecisionApplied
						FROM DocBrokeDecisionProducts a 
							LEFT OUTER JOIN @TableDel b ON a.DocID = b.DocID AND a.ProductID = b.ProductID AND a.StateID = b.StateID
						WHERE a.ProductID = @ProductID AND b.DocID IS NULL
						UNION
						SELECT a.DocID, a.ProductID, a.StateID, a.DecisionApplied
						FROM @TableIns a
						) a
						GROUP BY a.DocID, a.ProductID
					) a
			) a
			JOIN Docs b ON a.DocID = b.DocID
		ORDER BY b.Date DESC

	/*SELECT TOP 1 @ProductState = a.StateID
		FROM 
			(
			SELECT DocID, ProductID, 
					CASE StateID WHEN -1 THEN 2 WHEN 9999999 THEN 2 ELSE StateID END AS StateID 
				FROM (
					SELECT a.DocID, a.ProductID, 
							MAX(CASE WHEN a.StateID = 2 THEN CASE WHEN a.DecisionApplied = 1 THEN -1 ELSE 9999999 END ELSE a.StateID END) AS StateID 
						FROM DocBrokeDecisionProducts a 
						WHERE ProductID = @ProductID 
						GROUP BY a.DocID, a.ProductID
					) a
			) a
			JOIN Docs b ON a.DocID = b.DocID
		ORDER BY b.Date DESC
		*/

	RETURN @ProductState

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductState] TO [PalletRepacker]
    AS [dbo];

