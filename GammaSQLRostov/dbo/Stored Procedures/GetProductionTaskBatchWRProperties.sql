-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductionTaskBatchWRProperties] 
	-- Add the parameters for the stored procedure here
	(
		@ProductionTaskBatchID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT a.ProductionTaskID, a.NumFilmLayers, a.IsWithCarton, a.IsEndProtected, a.GroupPackConfig, e.IsActual
	FROM
	ProductionTaskWR a
	JOIN
	ProductionTasks b ON a.ProductionTaskID = b.ProductionTaskID
	JOIN
	BatchProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID
	JOIN
	ProductionTaskBatches d ON c.ProductionTaskBatchID = d.ProductionTaskBatchID
	JOIN
	ProductionTaskStates e ON e.ProductionTaskStateID = d.ProductionTaskStateID
	WHERE 
	d.ProductionTaskBatchID = @ProductionTaskBatchID AND
	((b.PlaceGroupID = 1 AND d.ProcessModelID IN (1,3)) OR (b.PlaceGroupID = 0 AND d.ProcessModelID IN (0,2)))

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchWRProperties] TO [PalletRepacker]
    AS [dbo];

