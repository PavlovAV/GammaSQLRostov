CREATE TABLE [dbo].[Branches] (
    [BranchID]             INT              NOT NULL,
    [EnterpriseID]         INT              NOT NULL,
    [Name]                 VARCHAR (255)    NULL,
    [Address]              VARCHAR (8000)   NULL,
    [Phones]               VARCHAR (8000)   NULL,
    [WebInfo]              VARCHAR (8000)   NULL,
    [QualityContacts]      VARCHAR (8000)   NULL,
    [1CSubdivisionID]      UNIQUEIDENTIFIER NULL,
    [LastAvailableJobTime] DATETIME         NULL,
    CONSTRAINT [PK_Branches] PRIMARY KEY CLUSTERED ([BranchID] ASC),
    CONSTRAINT [FK_Branches_Enterprises] FOREIGN KEY ([EnterpriseID]) REFERENCES [dbo].[Enterprises] ([EnterpriseID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Branches] TO [PalletRepacker]
    AS [dbo];

