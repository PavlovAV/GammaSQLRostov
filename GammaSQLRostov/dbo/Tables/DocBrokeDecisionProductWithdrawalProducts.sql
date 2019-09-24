CREATE TABLE [dbo].[DocBrokeDecisionProductWithdrawalProducts] (
    [DocWithdrawalID] UNIQUEIDENTIFIER NOT NULL,
    [DocID]           UNIQUEIDENTIFIER NOT NULL,
    [ProductID]       UNIQUEIDENTIFIER NOT NULL,
    [StateID]         TINYINT          NOT NULL,
    CONSTRAINT [PK_DocBrokeDecisionProductWithdrawalProducts] PRIMARY KEY CLUSTERED ([DocWithdrawalID] ASC, [DocID] ASC, [ProductID] ASC, [StateID] ASC),
    CONSTRAINT [FK_DocBrokeDecisionProductWithdrawalProducts_DocBroke] FOREIGN KEY ([DocID]) REFERENCES [dbo].[DocBroke] ([DocID]),
    CONSTRAINT [FK_DocBrokeDecisionProductWithdrawalProducts_DocBrokeDecisionProducts] FOREIGN KEY ([DocID], [ProductID], [StateID]) REFERENCES [dbo].[DocBrokeDecisionProducts] ([DocID], [ProductID], [StateID]),
    CONSTRAINT [FK_DocBrokeDecisionProductWithdrawalProducts_DocWithdrawal] FOREIGN KEY ([DocWithdrawalID]) REFERENCES [dbo].[DocWithdrawal] ([DocID]),
    CONSTRAINT [FK_DocBrokeDecisionProductWithdrawalProducts_DocWithdrawalProducts] FOREIGN KEY ([DocWithdrawalID], [ProductID]) REFERENCES [dbo].[DocWithdrawalProducts] ([DocID], [ProductID]),
    CONSTRAINT [FK_DocBrokeDecisionProductWithdrawalProducts_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID]),
    CONSTRAINT [FK_DocBrokeDecisionProductWithdrawalProducts_ProductStates] FOREIGN KEY ([StateID]) REFERENCES [dbo].[ProductStates] ([StateID])
);


GO
ALTER TABLE [dbo].[DocBrokeDecisionProductWithdrawalProducts] NOCHECK CONSTRAINT [FK_DocBrokeDecisionProductWithdrawalProducts_DocBrokeDecisionProducts];


GO
ALTER TABLE [dbo].[DocBrokeDecisionProductWithdrawalProducts] NOCHECK CONSTRAINT [FK_DocBrokeDecisionProductWithdrawalProducts_DocWithdrawalProducts];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeDecisionProductWithdrawalProducts] TO [PalletRepacker]
    AS [dbo];

