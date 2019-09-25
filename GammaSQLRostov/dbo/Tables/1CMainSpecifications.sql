CREATE TABLE [dbo].[1CMainSpecifications] (
    [1CMainSpecificationID] UNIQUEIDENTIFIER CONSTRAINT [DF_1CMainSpecifications_1CMainSpecificationID] DEFAULT (newsequentialid()) NOT NULL,
    [Period]                DATETIME         NOT NULL,
    [1CNomenclatureID]      UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID]    UNIQUEIDENTIFIER NULL,
    [1CSpecificationID]     UNIQUEIDENTIFIER NULL,
    [1CPlaceID]             UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CMainSpecifications] PRIMARY KEY NONCLUSTERED ([1CMainSpecificationID] ASC),
    CONSTRAINT [FK_1CMainSpecifications_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CMainSpecifications_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CMainSpecifications_1CPlaces] FOREIGN KEY ([1CPlaceID]) REFERENCES [dbo].[1CPlaces] ([1CPlaceID]),
    CONSTRAINT [FK_1CMainSpecifications_1CSpecifications] FOREIGN KEY ([1CSpecificationID]) REFERENCES [dbo].[1CSpecifications] ([1CSpecificationID])
);




GO
CREATE CLUSTERED INDEX [Period]
    ON [dbo].[1CMainSpecifications]([Period] DESC);


GO
CREATE NONCLUSTERED INDEX [CharacteristicIndex]
    ON [dbo].[1CMainSpecifications]([1CCharacteristicID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexPlaceID]
    ON [dbo].[1CMainSpecifications]([1CPlaceID] ASC)
    INCLUDE([Period], [1CNomenclatureID], [1CCharacteristicID], [1CSpecificationID]);




GO
CREATE NONCLUSTERED INDEX [NomenclatureIndex]
    ON [dbo].[1CMainSpecifications]([1CNomenclatureID] ASC);


GO
CREATE NONCLUSTERED INDEX [PlaceIndex]
    ON [dbo].[1CMainSpecifications]([1CPlaceID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMainSpecifications] TO [PalletRepacker]
    AS [dbo];

