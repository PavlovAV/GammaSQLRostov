CREATE TABLE [dbo].[1CWarehouses] (
    [1CWarehouseID]      UNIQUEIDENTIFIER NOT NULL,
    [IsMetadata]         BIT              NOT NULL,
    [Marked]             BIT              NOT NULL,
    [Folder]             BIT              NOT NULL,
    [ParentID]           UNIQUEIDENTIFIER NULL,
    [1CCode]             CHAR (9)         NOT NULL,
    [Description]        NVARCHAR (50)    NOT NULL,
    [1CSubdivisionID]    UNIQUEIDENTIFIER NULL,
    [Transportation]     BIT              NULL,
    [Transit]            BIT              NULL,
    [ResponsibleStorage] BIT              NULL,
    CONSTRAINT [PK_1CWarehouses] PRIMARY KEY CLUSTERED ([1CWarehouseID] ASC),
    CONSTRAINT [FK_1CWarehouses_1CSubdivisions] FOREIGN KEY ([1CSubdivisionID]) REFERENCES [dbo].[1CSubdivisions] ([1CSubdivisionID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CWarehouses] TO [PalletRepacker]
    AS [dbo];

