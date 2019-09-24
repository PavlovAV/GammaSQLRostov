CREATE TABLE [dbo].[Users] (
    [UserID]         UNIQUEIDENTIFIER CONSTRAINT [DF_Users_UserID] DEFAULT (newid()) NOT NULL,
    [RoleID]         UNIQUEIDENTIFIER NOT NULL,
    [Login]          VARCHAR (50)     NOT NULL,
    [Name]           VARCHAR (200)    NULL,
    [Post]           VARCHAR (200)    NULL,
    [PostTypeID]     INT              NULL,
    [PassChange]     DATETIME         NULL,
    [PassMustChange] BIT              NULL,
    [Exports]        BIT              CONSTRAINT [DF_Users_Exports] DEFAULT ((0)) NOT NULL,
    [DBAdmin]        BIT              CONSTRAINT [DF_Users_DBAdmin] DEFAULT ((0)) NOT NULL,
    [ProgramAdmin]   BIT              CONSTRAINT [DF_Users_ProgramAdmin] DEFAULT ((0)) NULL,
    [ShiftID]        TINYINT          CONSTRAINT [DF_Users_ShiftID] DEFAULT ((0)) NOT NULL,
    [MobileComputer] BIT              CONSTRAINT [DF_Users_MobileComputer] DEFAULT ((0)) NULL,
    [DepartmentID]   SMALLINT         NULL,
    CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED ([UserID] ASC),
    CONSTRAINT [FK_Users_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]),
    CONSTRAINT [FK_Users_PostTypes] FOREIGN KEY ([PostTypeID]) REFERENCES [dbo].[PostTypes] ([PostTypeID]),
    CONSTRAINT [FK_Users_Roles1] FOREIGN KEY ([RoleID]) REFERENCES [dbo].[Roles] ([RoleID])
);


GO
CREATE NONCLUSTERED INDEX [IX_FK_Users_Roles1]
    ON [dbo].[Users]([RoleID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Users] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Учетные данные для мобильного терминала', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Users', @level2type = N'COLUMN', @level2name = N'MobileComputer';

