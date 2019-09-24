-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductionTaskByBatchID] 
	-- Add the parameters for the stored procedure here
	(
		@ProductionTaskBatchID uniqueidentifier,
		@PlaceGroupID smallint
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT TOP 1 a.DateBegin, a.DateEnd, a.Quantity, ISNULL(a.[1CNomenclatureID], e.[1CNomenclatureID]) AS [1CNomenclatureID]
	, a.[1CCharacteristicID], a.PlaceID,
	a.ProductionTaskID, d.IsActual
	FROM
	ProductionTasks a 
	JOIN
	BatchProductionTasks b ON a.ProductionTaskID = b.ProductionTaskID
	JOIN
	ProductionTaskBatches c ON c.ProductionTaskBatchID = b.ProductionTaskBatchID
	JOIN
	ProductionTaskStates d ON d.ProductionTaskStateID = c.ProductionTaskStateID
	LEFT JOIN
	ProductionTaskRWCutting e ON a.ProductionTaskID = e.ProductionTaskID
	WHERE a.PlaceGroupID = @PlaceGroupID AND b.ProductionTaskBatchID = @ProductionTaskBatchID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskByBatchID] TO [PalletRepacker]
    AS [dbo];

