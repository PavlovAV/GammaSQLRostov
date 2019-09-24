-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindProductionTasks] 
	-- Add the parameters for the stored procedure here
	(
		@BatchKindID integer,
		@ProductionTaskStateID tinyint = null,
		@DateBegin DateTime = null,
		@DateEnd DateTime = null,
		@Number varchar(255) = null
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	 
    -- Insert statements for procedure here
	SELECT DISTINCT a.ProductionTaskBatchID,a.Number, a.Date, c.DateBegin, c.DateEnd,
		d.Name AS ProductionTaskState, ISNULL(nomrw.Name,e.Name) AS Nomenclature, c.Quantity, @BatchKindID AS BatchKindID,
		ISNULL(f.Name, g.Name) AS Place
	FROM 
	ProductionTaskBatches a
	JOIN
	BatchProductionTasks b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID
	JOIN
	ProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID
	LEFT JOIN
	ProductionTaskRWCutting prw ON prw.ProductionTaskID = c.ProductionTaskID
	JOIN
	ProductionTaskStates d ON a.ProductionTaskStateID = d.ProductionTaskStateID
	LEFT JOIN
	[1CNomenclature] e ON e.[1CNomenclatureID] = c.[1CNomenclatureID]
	LEFT JOIN
	[1CNomenclature] nomrw ON nomrw.[1CNomenclatureID] = prw.[1CNomenclatureID]
	LEFT JOIN
	Places f ON c.PlaceID = f.PlaceID
	JOIN
	PlaceGroups g ON c.PlaceGroupID = g.PlaceGroupID
	WHERE 
	((@DateBegin IS NOT NULL AND a.Date >= @DateBegin) OR @DateBegin IS NULL) AND
	((@DateEnd IS NOT NULL AND a.Date <= @DateEnd) OR @DateEnd IS NULL) AND
	((@Number IS NOT NULL AND a.Number = @Number) OR @Number IS NULL) AND
	(@ProductionTaskStateID IS NULL OR (@ProductionTaskStateID IS NOT NULL AND a.ProductionTaskStateID = @ProductionTaskStateID)) AND
	a.BatchKindID = @BatchKindID 
	AND ((a.ProcessModelID IN (0,2) AND c.PlaceGroupID = 0) OR (a.ProcessModelID IN (1,3,4,5) AND c.PlaceGroupID = 1)
	OR c.PlaceGroupID NOT IN (0,1))
	ORDER BY a.Number DESC


	

	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindProductionTasks] TO [PalletRepacker]
    AS [dbo];

