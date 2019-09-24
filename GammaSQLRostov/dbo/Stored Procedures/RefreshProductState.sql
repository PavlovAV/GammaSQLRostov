

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RefreshProductState] 
	@ProductID uniqueidentifier,
	@TableIns dbo.t_DocBrokeDecisionProducts READONLY,
	@TableDel dbo.t_DocBrokeDecisionProducts READONLY
AS
BEGIN
	DECLARE @StateID int = 0
	SELECT @StateID = [dbo].[GetProductState](@ProductID, @TableIns, @TableDel)
	
	UPDATE a SET StateID = @StateID
		FROM Products a 
		WHERE a.ProductID = @ProductID AND (a.StateID <> @StateID OR (a.StateID IS NULL AND @StateID IS NOT NULL))
	
	UPDATE a SET StateID = @StateID
		FROM Products a JOIN vGroupPackSpools b ON a.ProductID = b.ProductID 
			JOIN Products c ON c.ProductID = b.ProductGroupPackID
		WHERE b.ProductGroupPackID = @ProductID AND c.ProductKindID = 2 AND (a.StateID <> @StateID OR (a.StateID IS NULL AND @StateID IS NOT NULL))
		
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RefreshProductState] TO [PalletRepacker]
    AS [dbo];

