CREATE TABLE [dbo].[zzProducts] (
    [ProductID]       UNIQUEIDENTIFIER NOT NULL,
    [Number]          VARCHAR (20)     NULL,
    [BarCode]         VARCHAR (20)     NULL,
    [ProductKindID]   TINYINT          NULL,
    [StateID]         TINYINT          NULL,
    [TransactionType] TINYINT          NULL,
    [zzDate]          DATETIME         NULL,
    [zzUserID]        VARCHAR (100)    NULL
);




GO
GRANT SELECT
    ON OBJECT::[dbo].[zzProducts] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzProducts] TO PUBLIC
    AS [dbo];

