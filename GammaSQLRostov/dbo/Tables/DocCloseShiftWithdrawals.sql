CREATE TABLE [dbo].[DocCloseShiftWithdrawals] (
    [DocCloseShiftID] UNIQUEIDENTIFIER NOT NULL,
    [DocWithdrawalID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_DocCloseShiftWithdrawals] PRIMARY KEY CLUSTERED ([DocCloseShiftID] ASC, [DocWithdrawalID] ASC),
    CONSTRAINT [FK_DocCloseShiftWithdrawals_Docs] FOREIGN KEY ([DocCloseShiftID]) REFERENCES [dbo].[Docs] ([DocID]),
    CONSTRAINT [FK_DocCloseShiftWithdrawals_DocWithdrawal] FOREIGN KEY ([DocWithdrawalID]) REFERENCES [dbo].[DocWithdrawal] ([DocID])
);




GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWithdrawals] TO [Dispetcher]
    AS [dbo];

