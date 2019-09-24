CREATE TYPE [dbo].[t_DocBrokeDecisionProducts] AS TABLE (
    [DocID]              UNIQUEIDENTIFIER NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [StateID]            TINYINT          NOT NULL,
    [Quantity]           DECIMAL (18, 5)  NULL,
    [Comment]            VARCHAR (1000)   NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [DecisionApplied]    BIT              NULL,
    PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC, [StateID] ASC));

