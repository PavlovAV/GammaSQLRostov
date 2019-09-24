CREATE TABLE [dbo].[zzProductionTasks] (
    [ProductionTaskID]   UNIQUEIDENTIFIER NOT NULL,
    [PlaceID]            INT              NULL,
    [PlaceGroupID]       SMALLINT         NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [Quantity]           DECIMAL (18)     NOT NULL,
    [DateBegin]          DATETIME         NULL,
    [DateEnd]            DATETIME         NULL,
    [TransactionType]    TINYINT          NULL,
    [zzDate]             DATETIME         NULL,
    [zzUserID]           VARCHAR (100)    NULL
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzProductionTasks] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzProductionTasks] TO PUBLIC
    AS [dbo];

