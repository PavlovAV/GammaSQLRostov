CREATE TABLE [dbo].[CriticalLogs] (
    [Log]       VARCHAR (500) NULL,
    [LogDate]   DATETIME      CONSTRAINT [DF_CriticalLogs_EventDate] DEFAULT (getdate()) NULL,
    [LogUserID] VARCHAR (100) CONSTRAINT [DF_CriticalLogs_LogUserID] DEFAULT (suser_sname()) NULL
);


GO
GRANT UPDATE
    ON OBJECT::[dbo].[CriticalLogs] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[CriticalLogs] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[CriticalLogs] TO PUBLIC
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[CriticalLogs] TO PUBLIC
    AS [dbo];

