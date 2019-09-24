CREATE TABLE [dbo].[Enterprises] (
    [EnterpriseID]    INT            NOT NULL,
    [Name]            VARCHAR (255)  NULL,
    [Address]         VARCHAR (8000) NULL,
    [Phones]          VARCHAR (8000) NULL,
    [WebInfo]         VARCHAR (8000) NULL,
    [QualityContacts] VARCHAR (8000) NULL,
    CONSTRAINT [PK_Enterprises] PRIMARY KEY CLUSTERED ([EnterpriseID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Enterprises] TO [PalletRepacker]
    AS [dbo];

