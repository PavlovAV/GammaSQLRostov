CREATE TABLE [dbo].[zzDocBrokeDecisionProducts] (
    [DocID]              UNIQUEIDENTIFIER NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [StateID]            TINYINT          NOT NULL,
    [Quantity]           DECIMAL (18, 5)  NULL,
    [Comment]            VARCHAR (1000)   NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [DecisionApplied]    BIT              NOT NULL,
    [zzTransactionType]  TINYINT          NULL,
    [zzDate]             DATETIME         NULL,
    [zzUserID]           VARCHAR (100)    NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzDocBrokeDecisionProducts] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzDocBrokeDecisionProducts] TO PUBLIC
    AS [dbo];

