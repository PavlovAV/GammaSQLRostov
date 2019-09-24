CREATE TABLE [dbo].[Roles] (
    [RoleID]    UNIQUEIDENTIFIER CONSTRAINT [DF_Roles_RoleID] DEFAULT (newid()) NOT NULL,
    [Name]      VARCHAR (32)     NOT NULL,
    [Comment]   VARCHAR (8000)   NULL,
    [IsDeleted] BIT              NULL,
    CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED ([RoleID] ASC)
);


GO
CREATE TRIGGER [dbo].[RoleInserted]
ON [dbo].[Roles]
AFTER INSERT
AS
DECLARE  @RoleName varchar(50)
SELECT @RoleName = Name FROM inserted
INSERT INTO dbo.RolePermits (PermitID,RoleID,Mark)
SELECT a.PermitID,i.RoleID,1 AS Mark
FROM Permits a,
inserted i

DECLARE @RoleID uniqueidentifier
SELECT @RoleID = RoleID FROM inserted
exec('CREATE ROLE [' + @RoleName + ']')
exec dbo.mxp_RecreateRolePermits @RoleID

GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Roles] TO [PalletRepacker]
    AS [dbo];

