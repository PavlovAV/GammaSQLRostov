CREATE TABLE [dbo].[Templates] (
    [TemplateID] UNIQUEIDENTIFIER CONSTRAINT [DF_Templates_TemplateID] DEFAULT (newid()) NOT NULL,
    [ReportID]   UNIQUEIDENTIFIER NULL,
    [Name]       VARCHAR (255)    NULL,
    [Template]   IMAGE            NULL,
    [Version]    VARCHAR (30)     NULL,
    CONSTRAINT [PK_Templates] PRIMARY KEY CLUSTERED ([TemplateID] ASC),
    CONSTRAINT [FK_Templates_Reports] FOREIGN KEY ([ReportID]) REFERENCES [dbo].[Reports] ([ReportID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Templates] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Templates] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Templates] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Templates] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Templates] TO [PalletRepacker]
    AS [dbo];

