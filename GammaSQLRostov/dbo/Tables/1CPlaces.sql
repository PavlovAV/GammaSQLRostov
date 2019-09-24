CREATE TABLE [dbo].[1CPlaces] (
    [1CPlaceID]   UNIQUEIDENTIFIER NOT NULL,
    [Marked]      BIT              NULL,
    [Folder]      BIT              NULL,
    [ParentID]    UNIQUEIDENTIFIER NULL,
    [Description] NVARCHAR (100)   NULL,
    CONSTRAINT [PK_1CPlaces] PRIMARY KEY CLUSTERED ([1CPlaceID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPlaces] TO [PalletRepacker]
    AS [dbo];

