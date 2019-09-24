CREATE TABLE [dbo].[RolePermits] (
    [RoleID]   UNIQUEIDENTIFIER NOT NULL,
    [PermitID] UNIQUEIDENTIFIER NOT NULL,
    [Mark]     TINYINT          NOT NULL,
    CONSTRAINT [PK_RolePermits] PRIMARY KEY CLUSTERED ([RoleID] ASC, [PermitID] ASC),
    CONSTRAINT [FK_RolePermits_Permits] FOREIGN KEY ([PermitID]) REFERENCES [dbo].[Permits] ([PermitID]) ON DELETE CASCADE,
    CONSTRAINT [FK_RolePermits_Roles1] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID]) ON DELETE CASCADE
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RolePermits] TO [PalletRepacker]
    AS [dbo];

