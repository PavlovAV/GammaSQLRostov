CREATE TABLE [dbo].[LogEvents] (
    [EventID]       UNIQUEIDENTIFIER NOT NULL,
    [PlaceID]       INT              NULL,
    [DeviceID]      INT              NULL,
    [ShiftID]       TINYINT          NULL,
    [UserID]        UNIQUEIDENTIFIER NULL,
    [PrintName]     VARCHAR (255)    NULL,
    [EventKindID]   INT              NOT NULL,
    [Date]          DATETIME         NOT NULL,
    [Description]   VARCHAR (8000)   NULL,
    [ParentEventID] UNIQUEIDENTIFIER NULL,
    [IsSolved]      BIT              NULL,
    [DateSolved]    DATETIME         NULL,
    [Number]        VARCHAR (50)     NULL,
    [DepartmentID]  SMALLINT         NULL,
    [EventStateID]  INT              NULL,
    CONSTRAINT [PK_LogEvents] PRIMARY KEY CLUSTERED ([EventID] ASC),
    CONSTRAINT [FK_LogEvents_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]),
    CONSTRAINT [FK_LogEvents_Devices] FOREIGN KEY ([DeviceID]) REFERENCES [dbo].[Devices] ([DeviceID]),
    CONSTRAINT [FK_LogEvents_EventKinds] FOREIGN KEY ([EventKindID]) REFERENCES [dbo].[EventKinds] ([EventKindID]),
    CONSTRAINT [FK_LogEvents_LogEvents] FOREIGN KEY ([EventStateID]) REFERENCES [dbo].[EventStates] ([EventStateID]),
    CONSTRAINT [FK_LogEvents_Places] FOREIGN KEY ([PlaceID]) REFERENCES [dbo].[Places] ([PlaceID]),
    CONSTRAINT [FK_LogEvents_Shifts] FOREIGN KEY ([ShiftID]) REFERENCES [dbo].[Shifts] ([ShiftID]),
    CONSTRAINT [FK_LogEvents_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);




GO


-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <2018/09/27>
-- Description:	управляем состоянием
-- =============================================

CREATE TRIGGER [dbo].[SetEventStateD]
   ON  [dbo].[LogEvents]
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--завершена - меняем у родителя, если все ветки завершены и родитель не вершина
	if Exists(SELECT 1 
		FROM deleted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
		WHERE i.IsSolved = 1 AND b.EventID IS NULL AND a.ParentEventID IS NOT NULL)
	UPDATE a SET EventStateID = 2, IsSolved = 1, DateSolved = GETDATE()
		--SELECT * 
		FROM deleted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
		WHERE i.IsSolved = 1 AND b.EventID IS NULL AND a.ParentEventID IS NOT NULL

	--Ожидает подтверждения завершения - меняем у родителя, если все ветки завершены и это вершина
	if Exists(SELECT 1 
		FROM deleted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
		WHERE i.IsSolved = 1 AND b.EventID IS NULL AND a.ParentEventID IS NULL)
	UPDATE a SET EventStateID = 5
		--SELECT * 
		FROM deleted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
		WHERE i.IsSolved = 1 AND b.EventID IS NULL AND a.ParentEventID IS NULL

	--принята в работу - меняем у родителя, если все ветки ожидают принятия в работу или завершены или в работе
	IF EXISTS(SELECT 1 FROM deleted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		WHERE i.EventStateID <> 2)
	UPDATE a SET EventStateID = CASE WHEN b.CountSolvedEvent > 0 AND b.CountNotSolvedEvent = 0 AND b.CountZeroEvent = 0 THEN 2 ELSE CASE WHEN b.CountZeroEvent > 0 AND b.CountSolvedEvent = 0 AND b.CountNotSolvedEvent = 0 THEN 0 ELSE 4 END END--, IsSolved = CASE WHEN b.CountSolvedEvent > 0 AND b.CountNotSolvedEvent = 0 AND b.CountZeroEvent = 0 THEN 2 ELSE CASE WHEN b.CountZeroEvent > 0 AND b.CountSolvedEvent = 0 AND b.CountNotSolvedEvent = 0 THEN 0 ELSE 4 END END 
		FROM deleted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN (SELECT a.EventID, count(b.EventID) AS CountNotSolvedEvent, count(c.EventID) AS CountSolvedEvent, count(d.EventID) AS CountZeroEvent FROM
		LogEvents a 
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventStateID IN (1,0,4)
		LEFT JOIN LogEvents c ON c.ParentEventID = a.EventID AND c.EventStateID = 2
		LEFT JOIN LogEvents d ON d.ParentEventID = a.EventID AND d.EventStateID = 3
		GROUP BY a.EventID
		) b ON a.EventID = b.EventID
		WHERE i.EventStateID <> 2

END

GO


-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <2018/09/27>
-- Description:	управляем состоянием
-- =============================================

CREATE TRIGGER [dbo].[SetEventStateIU]
   ON  [dbo].[LogEvents]
   AFTER INSERT, UPDATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	--DECLARE @N varchar(100), @C varchar(100)
	--SELECT @N = number FROM inserted i
	--SELECT @c = CAST(COUNT(*) AS VARCHAR(100)) +'|'+ ISNULL(max(a.Number),'NULL')
	--	FROM inserted i JOIN LogEvents a ON i.ParentEventID = a.EventID
	--	LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
	--	WHERE i.IsSolved = 1 AND b.EventStateID IS NULL
	--PRINT @N + '/' +@c
	
	--завершена - меняем у родителя, если все ветки завершены и родитель не вершина
	if Exists(SELECT 1 
		FROM inserted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
		WHERE i.IsSolved = 1 AND b.EventID IS NULL AND a.ParentEventID IS NOT NULL)
	UPDATE a SET EventStateID = 2, IsSolved = 1, DateSolved = GETDATE()
		--SELECT * 
		FROM inserted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
		WHERE i.IsSolved = 1 AND b.EventID IS NULL AND a.ParentEventID IS NOT NULL
	
	--Ожидает подтверждения завершения - меняем у родителя, если все ветки завершены и это вершина
	if Exists(SELECT 1 
		FROM inserted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
		WHERE i.IsSolved = 1 AND b.EventID IS NULL AND a.ParentEventID IS NULL)
	UPDATE a SET EventStateID = 5
		--SELECT * 
		FROM inserted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventID <> i.EventID AND ISNULL(b.IsSolved,0) <> 1
		WHERE i.IsSolved = 1 AND b.EventID IS NULL AND a.ParentEventID IS NULL

	--принята в работу - меняем у родителя, если все ветки ожидают принятия в работу или завершены или в работе
	if Exists(SELECT 1 
		FROM inserted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		WHERE i.EventStateID IN (1,3,4) AND ISNULL(i.IsSolved,0) = 0)
	UPDATE a SET EventStateID = 4 
		FROM inserted i JOIN LogEvents a ON i.ParentEventID = a.EventID
		WHERE i.EventStateID IN (1,3,4) AND ISNULL(i.IsSolved,0) = 0
	
	--SELECT @c = CAST(COUNT(*) AS VARCHAR(100)) +'|'+ ISNULL(max(a.Number),'NULL')
	--	FROM inserted i JOIN LogEvents a ON i.ParentEventID = a.EventID
	--	WHERE i.EventStateID IN (1,3,4) AND ISNULL(i.IsSolved,0) = 0
	--PRINT @c
	
	--завершена - меняем если признак завершена
	if Exists(SELECT 1 
		FROM inserted i JOIN LogEvents a ON i.EventID = a.EventID
		WHERE i.IsSolved = 1 AND ISNULL(i.EventStateID,2) <> 2)
	UPDATE a SET EventStateID = 2, IsSolved = 1, DateSolved = GETDATE()
		FROM inserted i JOIN LogEvents a ON i.EventID = a.EventID
		WHERE i.IsSolved = 1 AND ISNULL(i.EventStateID,2) <> 2

	if Exists(SELECT 1 
		FROM inserted i JOIN LogEvents a ON i.EventID = a.EventID
		WHERE ISNULL(i.IsSolved,0) <> 1 AND i.EventStateID = 2)
	UPDATE a SET IsSolved = 1, DateSolved = GETDATE(), EventStateID = 2 
		FROM inserted i JOIN LogEvents a ON i.EventID = a.EventID
		WHERE ISNULL(i.IsSolved,0) <> 1 AND i.EventStateID = 2

	--отменяем завершена
	if Exists(SELECT 1 
		FROM inserted i LEFT JOIN deleted d ON i.EventID = d.EventID JOIN LogEvents a ON i.EventID = a.EventID
		WHERE i.IsSolved = 1 AND ISNULL(d.IsSolved,0) <> 1)
	UPDATE a SET IsSolved = 0, EventStateID = CASE WHEN b.CountSolvedEvent > 0 AND b.CountNotSolvedEvent = 0 AND b.CountZeroEvent = 0 THEN 2 ELSE CASE WHEN b.CountZeroEvent > 0 AND b.CountSolvedEvent = 0 AND b.CountNotSolvedEvent = 0 THEN 0 ELSE 4 END END
		FROM inserted i JOIN deleted d ON i.EventID = d.EventID JOIN LogEvents a ON i.EventID = a.EventID
		LEFT JOIN (SELECT a.EventID, count(b.EventID) AS CountNotSolvedEvent, count(c.EventID) AS CountSolvedEvent, count(d.EventID) AS CountZeroEvent FROM
		LogEvents a 
		LEFT JOIN LogEvents b ON b.ParentEventID = a.EventID AND b.EventStateID IN (1,0,4)
		LEFT JOIN LogEvents c ON c.ParentEventID = a.EventID AND c.EventStateID = 2
		LEFT JOIN LogEvents d ON d.ParentEventID = a.EventID AND d.EventStateID = 3
		GROUP BY a.EventID
		) b ON a.EventID = b.EventID
		WHERE ISNULL(i.IsSolved,0) = 1 AND ISNULL(i.EventStateID,2) <> 2 AND ISNULL(d.EventStateID,2) = 2
END

GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogEvents] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [Viewer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[LogEvents] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [Viewer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[LogEvents] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [Viewer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogEvents] TO [Baler]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [PalletRepacker]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogEvents] TO [Baler]
    AS [dbo];

