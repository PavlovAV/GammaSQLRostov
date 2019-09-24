CREATE TABLE [dbo].[zzDocWithdrawalProducts] (
    [DocID]              UNIQUEIDENTIFIER NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [Quantity]           DECIMAL (15, 5)  NULL,
    [CompleteWithdrawal] BIT              NULL,
    [TransactionType]    TINYINT          NULL,
    [zzDate]             DATETIME         NULL,
    [zzUserID]           VARCHAR (100)    NULL
);

