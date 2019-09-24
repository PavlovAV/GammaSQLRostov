-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductionTaskBatchSGBProperties] 
	-- Add the parameters for the stored procedure here
	(
		@ProductionTaskBatchID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT a.Diameter, a.DiameterPlus, a.DiameterMinus, a.Crepe, a.ProductionTaskID, e.IsActual
	FROM
	ProductionTaskSGB a
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
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBProperties] TO [PalletRepacker]
    AS [dbo];

