CREATE TABLE [dbo].[PermitTables] (
    [PermitTableID] UNIQUEIDENTIFIER CONSTRAINT [DF_PermitTables_PermitTableID] DEFAULT (newid()) NOT NULL,
    [PermitID]      UNIQUEIDENTIFIER NOT NULL,
    [Name]          VARCHAR (100)    NOT NULL,
    [Columns]       VARCHAR (8000)   NULL,
    CONSTRAINT [PK_PermitTables_1] PRIMARY KEY CLUSTERED ([PermitTableID] ASC),
    CONSTRAINT [FK_PermitTables_Permits] FOREIGN KEY ([PermitID]) REFERENCES [dbo].[Permits] ([PermitID]) ON DELETE CASCADE
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PermitTables] TO [PalletRepacker]
    AS [dbo];

