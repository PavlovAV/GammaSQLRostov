CREATE TABLE [dbo].[1CPlaceProperties] (
    [1CPlaceID]         UNIQUEIDENTIFIER NOT NULL,
    [1CPropertyID]      UNIQUEIDENTIFIER NOT NULL,
    [1CPropertyValueID] UNIQUEIDENTIFIER NULL,
    [ValueText]         VARCHAR (8000)   NULL,
    [ValueNumeric]      DECIMAL (18, 5)  NULL,
    CONSTRAINT [PK_1CPlaceProperties] PRIMARY KEY CLUSTERED ([1CPlaceID] ASC, [1CPropertyID] ASC),
    CONSTRAINT [FK_1CPlaceProperties_1CPlaces] FOREIGN KEY ([1CPlaceID]) REFERENCES [dbo].[1CPlaces] ([1CPlaceID]),
    CONSTRAINT [FK_1CPlaceProperties_1CProperties] FOREIGN KEY ([1CPropertyID]) REFERENCES [dbo].[1CProperties] ([1CPropertyID]),
    CONSTRAINT [FK_1CPlaceProperties_1CPropertyValues] FOREIGN KEY ([1CPropertyValueID]) REFERENCES [dbo].[1CPropertyValues] ([1CPropertyValueID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaceProperties] TO [PalletRepacker]
    AS [dbo];

