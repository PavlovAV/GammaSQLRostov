CREATE TABLE [dbo].[zzDocCloseShiftRemainders] (
    [DocCloseShiftRemainderID] UNIQUEIDENTIFIER NOT NULL,
    [DocID]                    UNIQUEIDENTIFIER NOT NULL,
    [ProductID]                UNIQUEIDENTIFIER NULL,
    [Quantity]                 DECIMAL (20, 5)  NOT NULL,
    [IsSourceProduct]          BIT              NULL,
    [DocWithdrawalID]          UNIQUEIDENTIFIER NULL,
    [RemainderTypeID]          INT              NULL,
    [StateID]                  INT              NULL,
    [zzTransactionType]        TINYINT          NULL,
    [zzDate]                   DATETIME         NULL,
    [zzUserID]                 VARCHAR (100)    NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzDocCloseShiftRemainders] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzDocCloseShiftRemainders] TO PUBLIC
    AS [dbo];

