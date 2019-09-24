CREATE TABLE [dbo].[zzProducts2] (
    [ProductID]       UNIQUEIDENTIFIER NOT NULL,
    [Number]          VARCHAR (20)     NULL,
    [BarCode]         VARCHAR (20)     NULL,
    [ProductKindID]   TINYINT          NULL,
    [TransactionType] TINYINT          NULL,
    [StateID]         TINYINT          NULL,
    [zzDate]          DATETIME         NULL,
    [zzUserID]        VARCHAR (100)    NULL
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzProducts2] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzProducts2] TO PUBLIC
    AS [dbo];

