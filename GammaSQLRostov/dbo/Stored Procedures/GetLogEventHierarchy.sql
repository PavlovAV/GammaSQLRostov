
-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <2018-09-25>
-- Description:	<Получение дерева событий по определенной записи>
-- =============================================
CREATE PROCEDURE [dbo].[GetLogEventHierarchy] 
	-- Add the parameters for the stored procedure here
	(
		@EventID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	WITH 
 Rec (EventID, ParentEventID)
 AS (
   SELECT EventID, ParentEventID FROM LogEvents
		WHERE EventID = @EventID
   UNION ALL
   SELECT LogEvents.EventID, LogEvents.ParentEventID
		FROM Rec JOIN LogEvents ON Rec.ParentEventID = LogEvents.EventID
   ),
 
 Rec1 (EventID, ParentEventID)
 AS (
   SELECT EventID, ParentEventID FROM LogEvents
		WHERE EventID IN (SELECT Rec.EventID FROM Rec WHERE Rec.ParentEventID IS NULL)
   UNION ALL
   SELECT LogEvents.EventID, LogEvents.ParentEventID
		FROM Rec1 JOIN LogEvents ON Rec1.EventID = LogEvents.ParentEventID
   )
 SELECT a.*, ISNULL(p.Name,'') AS PlaceName, ISNULL(d.Name,'') AS DeviceName, ISNULL(e.Name,'') AS EventKindName 
	, ISNULL(f.Name,'') AS EventStateName, ISNULL(g.Name,'') AS DepartmentName
	FROM LogEvents a JOIN Rec1 b ON a.EventID = b.EventID
		LEFT JOIN Places p ON a.PlaceID = p.PlaceID
		LEFT JOIN Devices d ON a.DeviceID = d.DeviceID
		LEFT JOIN EventKinds e ON a.EventKindID = e.EventKindID
		LEFT JOIN EventStates f ON a.EventStateID = f.EventStateID
		LEFT JOIN Departments g ON a.DepartmentID = g.DepartmentID

		;

END

	

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO [PalletRepacker]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLogEventHierarchy] TO PUBLIC
    AS [dbo];

