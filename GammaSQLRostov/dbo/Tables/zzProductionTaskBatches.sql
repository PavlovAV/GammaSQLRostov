CREATE TABLE [dbo].[zzProductionTaskBatches] (
    [ProductionTaskBatchID] UNIQUEIDENTIFIER NOT NULL,
    [BatchKindID]           SMALLINT         NOT NULL,
    [ProductionTaskStateID] TINYINT          NOT NULL,
    [UserID]                UNIQUEIDENTIFIER NULL,
    [Number]                VARCHAR (255)    NULL,
    [Date]                  DATETIME         NULL,
    [Comment]               VARCHAR (8000)   NULL,
    [ProcessModelID]        SMALLINT         NULL,
    [PartyControl]          BIT              NULL,
    [1CContractorID]        UNIQUEIDENTIFIER NULL,
    [TransactionType]       TINYINT          NULL,
    [zzDate]                DATETIME         NULL,
    [zzUserID]              VARCHAR (100)    NULL
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzProductionTaskBatches] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzProductionTaskBatches] TO PUBLIC
    AS [dbo];

