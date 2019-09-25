CREATE TABLE [dbo].[DocCloseShiftWastes] (
    [DocCloseWhiftWasteID] UNIQUEIDENTIFIER CONSTRAINT [DF_DocCloseShiftWastes_DocCloseWhiftWasteID] DEFAULT (newsequentialid()) NOT NULL,
    [DocID]                UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]     UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID]   UNIQUEIDENTIFIER NULL,
    [Quantity]             DECIMAL (15, 5)  CONSTRAINT [DF_DocCloseShiftWastes_Quantity] DEFAULT ((0)) NOT NULL,
    [1CMeasureUnitID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_DocCloseShiftWastes] PRIMARY KEY CLUSTERED ([DocCloseWhiftWasteID] ASC),
    CONSTRAINT [FK_DocCloseShiftWastes_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_DocCloseShiftWastes_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_DocCloseShiftWastes_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_DocCloseShiftWastes_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID])
);




GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftWastes] TO [Dispetcher]
    AS [dbo];

