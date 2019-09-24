CREATE TABLE [dbo].[1CCharacteristicProperties] (
    [1CCharacteristicID] UNIQUEIDENTIFIER NOT NULL,
    [1CPropertyID]       UNIQUEIDENTIFIER NOT NULL,
    [1CPropertyValueID]  UNIQUEIDENTIFIER NULL,
    [ValueText]          VARCHAR (8000)   NULL,
    [ValueNumeric]       DECIMAL (20)     NULL,
    CONSTRAINT [PK_C1CCharacteristicProperties] PRIMARY KEY CLUSTERED ([1CCharacteristicID] ASC, [1CPropertyID] ASC),
    CONSTRAINT [FK_1CCharacteristicProperties_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CCharacteristicProperties_1CProperties] FOREIGN KEY ([1CPropertyID]) REFERENCES [dbo].[1CProperties] ([1CPropertyID]),
    CONSTRAINT [FK_1CCharacteristicProperties_1CPropertyValues] FOREIGN KEY ([1CPropertyValueID]) REFERENCES [dbo].[1CPropertyValues] ([1CPropertyValueID])
);


GO
CREATE NONCLUSTERED INDEX [IX_FK_1CCharacteristicProperties_1CProperties]
    ON [dbo].[1CCharacteristicProperties]([1CPropertyID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexPropertyValueID]
    ON [dbo].[1CCharacteristicProperties]([1CPropertyValueID] ASC)
    INCLUDE([1CPropertyID], [1CCharacteristicID]);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristicProperties] TO [PalletRepacker]
    AS [dbo];

