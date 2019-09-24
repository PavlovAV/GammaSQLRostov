
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetProductionTaskSGIMadeQuantity]
(
	@ProductionTaskBatchId uniqueidentifier
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
		
	SELECT @Result = SUM(ISNULL(e.Quantity,0))
	FROM
	--ProductionTaskBatches a
	--JOIN
	BatchProductionTasks f --ON a.ProductionTaskBatchId = f.ProductionTaskBatchId
	JOIN
	ProductionTasks b ON f.ProductionTaskId = b.ProductionTaskId
	JOIN
	DocProduction c ON b.ProductionTaskID = c.ProductionTaskId
	JOIN
	DocProductionProducts d ON d.DocId = c.DocId
	JOIN
	ProductItems e ON e.ProductId = d.ProductId
	JOIN
	Docs g ON d.DocID = g.DocID AND g.IsConfirmed = 1
	WHERE
	f.ProductionTaskBatchId = @ProductionTaskBatchId

	RETURN @Result

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskSGIMadeQuantity] TO [PalletRepacker]
    AS [dbo];

