CREATE TABLE [dbo].[Permits] (
    [PermitID]    UNIQUEIDENTIFIER CONSTRAINT [DF_Permits_PermitID] DEFAULT (newid()) NOT NULL,
    [GroupNumber] TINYINT          NULL,
    [Name]        VARCHAR (200)    NULL,
    CONSTRAINT [PK_Permits] PRIMARY KEY CLUSTERED ([PermitID] ASC)
);


GO
CREATE TRIGGER [dbo].[PermitInserted]
ON [dbo].[Permits]
AFTER INSERT
AS
INSERT INTO dbo.RolePermits (PermitID,RoleID,Mark)
SELECT i.PermitID,a.RoleID,1 AS Mark
FROM Roles a,
inserted i
GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Permits] TO [PalletRepacker]
    AS [dbo];

