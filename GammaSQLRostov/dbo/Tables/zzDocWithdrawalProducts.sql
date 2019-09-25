CREATE TABLE [dbo].[zzDocWithdrawalProducts] (
    [DocID]              UNIQUEIDENTIFIER NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [Quantity]           DECIMAL (15, 5)  NULL,
    [CompleteWithdrawal] BIT              NULL,
    [TransactionType]    TINYINT          NULL,
    [zzDate]             DATETIME         NULL,
    [zzUserID]           VARCHAR (100)    NULL
);




GO
GRANT SELECT
    ON OBJECT::[dbo].[zzDocWithdrawalProducts] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzDocWithdrawalProducts] TO PUBLIC
    AS [dbo];

