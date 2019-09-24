CREATE TABLE [dbo].[1CNomenclatureAnalogs] (
    [ID]                       UNIQUEIDENTIFIER CONSTRAINT [DF_1CNomenclatureAnalogs_ID] DEFAULT (newsequentialid()) NOT NULL,
    [1CNomenclatureID]         UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID]       UNIQUEIDENTIFIER NULL,
    [1CNomenclatureAnalogID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicAnalogID] UNIQUEIDENTIFIER NULL,
    [1COutputNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1COutputCharacteristicID] UNIQUEIDENTIFIER NULL,
    [1CSpecificationID]        UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitID]          UNIQUEIDENTIFIER NULL,
    [Amount]                   DECIMAL (15, 3)  NULL,
    [1CMeasureUnitAnalogID]    UNIQUEIDENTIFIER NULL,
    [AmountAnalog]             DECIMAL (15, 3)  NULL,
    [Priority]                 DECIMAL (5)      NULL,
    CONSTRAINT [PK_1CNomenclatureAnalogs] PRIMARY KEY CLUSTERED ([ID] ASC),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CCharacteristics1] FOREIGN KEY ([1CCharacteristicAnalogID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CCharacteristics2] FOREIGN KEY ([1COutputCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CMeasureUnits1] FOREIGN KEY ([1CMeasureUnitAnalogID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CNomenclature1] FOREIGN KEY ([1CNomenclatureAnalogID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CNomenclature2] FOREIGN KEY ([1COutputNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CNomenclatureAnalogs_1CSpecifications] FOREIGN KEY ([1CSpecificationID]) REFERENCES [dbo].[1CSpecifications] ([1CSpecificationID])
);


GO
CREATE NONCLUSTERED INDEX [idxNomenclatureID]
    ON [dbo].[1CNomenclatureAnalogs]([1CNomenclatureID] ASC)
    INCLUDE([AmountAnalog], [1CMeasureUnitAnalogID], [Amount], [1CNomenclatureAnalogID]);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureAnalogs] TO [PalletRepacker]
    AS [dbo];

