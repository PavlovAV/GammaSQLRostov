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

