CREATE TABLE [dbo].[1CTransportPoints] (
    [1CTransportPointID]     UNIQUEIDENTIFIER NOT NULL,
    [1CCode]                 CHAR (9)         NULL,
    [Marked]                 BIT              NULL,
    [Folder]                 BIT              NULL,
    [Description]            NVARCHAR (100)   NULL,
    [1CRegionID]             UNIQUEIDENTIFIER NULL,
    [IsOwn]                  BIT              NULL,
    [1CDistributiveCenterID] UNIQUEIDENTIFIER NULL,
    [1CSubDivisionID]        UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CTransportPoints] PRIMARY KEY CLUSTERED ([1CTransportPointID] ASC),
    CONSTRAINT [FK_1CTransportPoints_1CRegions] FOREIGN KEY ([1CRegionID]) REFERENCES [dbo].[1CRegions] ([1CRegionID]),
    CONSTRAINT [FK_1CTransportPoints_1CSubdivisions] FOREIGN KEY ([1CSubDivisionID]) REFERENCES [dbo].[1CSubdivisions] ([1CSubdivisionID]),
    CONSTRAINT [FK_1CTransportPoints_1CTransportPoints] FOREIGN KEY ([1CDistributiveCenterID]) REFERENCES [dbo].[1CTransportPoints] ([1CTransportPointID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CTransportPoints] TO [PalletRepacker]
    AS [dbo];

