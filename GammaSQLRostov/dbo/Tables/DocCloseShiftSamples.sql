CREATE TABLE [dbo].[DocCloseShiftSamples] (
    [DocCloseShiftSampleID] UNIQUEIDENTIFIER CONSTRAINT [DF_DocCloseShiftSamples_DocCloseShiftID] DEFAULT (newsequentialid()) NOT NULL,
    [DocID]                 UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]      UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID]    UNIQUEIDENTIFIER NOT NULL,
    [Quantity]              DECIMAL (15, 5)  NOT NULL,
    [1CMeasureUnitID]       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_DocCloseShiftSamples] PRIMARY KEY CLUSTERED ([DocCloseShiftSampleID] ASC),
    CONSTRAINT [FK_DocCloseShiftSamples_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_DocCloseShiftSamples_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_DocCloseShiftSamples_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_DocCloseShiftSamples_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID])
);




GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Образцы для контроля качества', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocCloseShiftSamples';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftSamples] TO [Dispetcher]
    AS [dbo];

