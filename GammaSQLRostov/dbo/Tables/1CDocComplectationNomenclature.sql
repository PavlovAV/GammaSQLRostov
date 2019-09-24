CREATE TABLE [dbo].[1CDocComplectationNomenclature] (
    [1CDocComplectationID]  UNIQUEIDENTIFIER NOT NULL,
    [LineNumber]            DECIMAL (5)      NOT NULL,
    [1CNomenclatureID]      UNIQUEIDENTIFIER NOT NULL,
    [1COldCharacteristicID] UNIQUEIDENTIFIER NOT NULL,
    [1CNewCharacteristicID] UNIQUEIDENTIFIER NOT NULL,
    [Quantity]              DECIMAL (18, 5)  NULL,
    [1CMeasureUnitID]       UNIQUEIDENTIFIER NULL,
    [1CQualityID]           UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CDocComplectationNomenclature_1] PRIMARY KEY CLUSTERED ([1CDocComplectationID] ASC, [LineNumber] ASC),
    CONSTRAINT [FK_1CDocComplectationNomenclature_1CCharacteristics] FOREIGN KEY ([1COldCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CDocComplectationNomenclature_1CCharacteristics1] FOREIGN KEY ([1CNewCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CDocComplectationNomenclature_1CDocComplectation] FOREIGN KEY ([1CDocComplectationID]) REFERENCES [dbo].[1CDocComplectation] ([1CDocComplectationID]),
    CONSTRAINT [FK_1CDocComplectationNomenclature_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CDocComplectationNomenclature_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CDocComplectationNomenclature_1CQuality] FOREIGN KEY ([1CQualityID]) REFERENCES [dbo].[1CQuality] ([1CQualityID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocComplectationNomenclature] TO [PalletRepacker]
    AS [dbo];

