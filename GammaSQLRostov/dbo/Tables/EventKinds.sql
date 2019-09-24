CREATE TABLE [dbo].[EventKinds] (
    [EventKindID]      INT          IDENTITY (1, 1) NOT NULL,
    [Name]             VARCHAR (50) NOT NULL,
    [IsRemedyRequired] BIT          CONSTRAINT [DF_EventKind_IsRemedyRequired] DEFAULT ((0)) NOT NULL,
    [IsVisible]        BIT          CONSTRAINT [DF_EventKinds_IsVisible] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_EventKinds] PRIMARY KEY CLUSTERED ([EventKindID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[EventKinds] TO [PalletRepacker]
    AS [dbo];

