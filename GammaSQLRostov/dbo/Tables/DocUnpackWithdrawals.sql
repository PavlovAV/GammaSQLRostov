CREATE TABLE [dbo].[DocUnpackWithdrawals] (
    [DocID]           UNIQUEIDENTIFIER NOT NULL,
    [DocWithdrawalID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_DocUnpackWithdrawals] PRIMARY KEY CLUSTERED ([DocID] ASC, [DocWithdrawalID] ASC),
    CONSTRAINT [FK_DocUnpackWithdrawals_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID]),
    CONSTRAINT [FK_DocUnpackWithdrawals_DocWithdrawal] FOREIGN KEY ([DocWithdrawalID]) REFERENCES [dbo].[DocWithdrawal] ([DocID])
);




GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocUnpackWithdrawals] TO [Baler]
    AS [dbo];

