CREATE TABLE [dbo].[zzProductionTaskConverting] (
    [ProductionTaskID]        UNIQUEIDENTIFIER NOT NULL,
    [RobotProductNumber]      INT              NULL,
    [RobotProductDescription] VARCHAR (500)    NULL,
    [GroupPackLabelPNG]       VARBINARY (MAX)  NULL,
    [GroupPackLabelMD5]       VARCHAR (32)     NULL,
    [GroupPackLabelZPL]       VARCHAR (MAX)    NULL,
    [TransportPackLabelPNG]   VARBINARY (MAX)  NULL,
    [TransportPackLabelMD5]   VARCHAR (32)     NULL,
    [TransportPackLabelZPL]   VARCHAR (MAX)    NULL,
    [zzTransactionType]       TINYINT          NULL,
    [zzDate]                  DATETIME         NULL,
    [zzUserID]                VARCHAR (100)    NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzProductionTaskConverting] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzProductionTaskConverting] TO PUBLIC
    AS [dbo];

