CREATE TABLE [dbo].[DocCloseShiftRemainders] (
    [DocCloseShiftRemainderID] UNIQUEIDENTIFIER CONSTRAINT [DF_DocCloseShiftRemainders_DocCloseShiftRemainderID] DEFAULT (newsequentialid()) NOT NULL,
    [DocID]                    UNIQUEIDENTIFIER NOT NULL,
    [ProductID]                UNIQUEIDENTIFIER NULL,
    [Quantity]                 DECIMAL (20, 5)  CONSTRAINT [DF_DocCloseShiftRemainders_Quantity] DEFAULT ((0)) NOT NULL,
    [IsSourceProduct]          BIT              CONSTRAINT [DF_DocCloseShiftRemainders_IsSourceProduct] DEFAULT ((0)) NULL,
    [DocWithdrawalID]          UNIQUEIDENTIFIER NULL,
    [RemainderTypeID]          INT              NULL,
    [StateID]                  INT              NULL,
    CONSTRAINT [PK_DocCloseShiftRemainders] PRIMARY KEY CLUSTERED ([DocCloseShiftRemainderID] ASC),
    CONSTRAINT [FK_DocCloseShiftRemainders_Docs] FOREIGN KEY ([DocWithdrawalID]) REFERENCES [dbo].[Docs] ([DocID]),
    CONSTRAINT [FK_DocCloseShiftRemainders_Docs1] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID]),
    CONSTRAINT [FK_DocCloseShiftRemainders_RemainderTypes] FOREIGN KEY ([RemainderTypeID]) REFERENCES [dbo].[RemainderTypes] ([RemainderTypeID])
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftRemainders] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Остатки продукции при передаче смены', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocCloseShiftRemainders';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0 - Выработка
1 - Сырье
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocCloseShiftRemainders', @level2type = N'COLUMN', @level2name = N'IsSourceProduct';

