CREATE TABLE [dbo].[1CRegions] (
    [1CRegionID]  UNIQUEIDENTIFIER NOT NULL,
    [Marked]      BIT              NULL,
    [Folder]      BIT              NULL,
    [1CParentID]  UNIQUEIDENTIFIER NULL,
    [1CCode]      CHAR (9)         NULL,
    [Description] NVARCHAR (150)   NULL,
    CONSTRAINT [PK_1CRegions] PRIMARY KEY CLUSTERED ([1CRegionID] ASC),
    CONSTRAINT [FK_1CRegions_1CRegions] FOREIGN KEY ([1CParentID]) REFERENCES [dbo].[1CRegions] ([1CRegionID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRegions] TO [PalletRepacker]
    AS [dbo];

