CREATE TABLE [dbo].[LogCheckSourceSpools] (
    [LogEntryID]  BIGINT           IDENTITY (1, 1) NOT NULL,
    [DocID]       UNIQUEIDENTIFIER NOT NULL,
    [CheckResult] VARCHAR (8000)   NULL,
    CONSTRAINT [PK_LogCheckSourceSpools] PRIMARY KEY CLUSTERED ([LogEntryID] ASC)
);


GO
GRANT ALTER
    ON OBJECT::[dbo].[LogCheckSourceSpools] TO PUBLIC
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[LogCheckSourceSpools] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[LogCheckSourceSpools] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[LogCheckSourceSpools] TO PUBLIC
    AS [dbo];

