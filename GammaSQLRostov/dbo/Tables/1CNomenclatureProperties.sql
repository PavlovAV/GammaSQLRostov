CREATE TABLE [dbo].[1CNomenclatureProperties] (
    [1CNomenclatureID]  UNIQUEIDENTIFIER NOT NULL,
    [1CPropertyID]      UNIQUEIDENTIFIER NOT NULL,
    [1CPropertyValueID] UNIQUEIDENTIFIER NULL,
    [ValueText]         VARCHAR (8000)   NULL,
    [ValueNumeric]      DECIMAL (20)     NULL,
    CONSTRAINT [PK_C1CNomenclatureProperties] PRIMARY KEY CLUSTERED ([1CNomenclatureID] ASC, [1CPropertyID] ASC),
    CONSTRAINT [FK_1CNomenclatureProperties_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CNomenclatureProperties_1CProperties] FOREIGN KEY ([1CPropertyID]) REFERENCES [dbo].[1CProperties] ([1CPropertyID]),
    CONSTRAINT [FK_1CNomenclatureProperties_1CPropertyValues] FOREIGN KEY ([1CPropertyValueID]) REFERENCES [dbo].[1CPropertyValues] ([1CPropertyValueID])
);


GO
CREATE NONCLUSTERED INDEX [IX_FK_1CNomenclatureProperties_1CProperties]
    ON [dbo].[1CNomenclatureProperties]([1CPropertyID] ASC);


GO
CREATE NONCLUSTERED INDEX [PropertyValueIndex]
    ON [dbo].[1CNomenclatureProperties]([1CPropertyValueID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclatureProperties] TO [PalletRepacker]
    AS [dbo];

