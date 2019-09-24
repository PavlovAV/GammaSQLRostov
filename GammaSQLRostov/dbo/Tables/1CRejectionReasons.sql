CREATE TABLE [dbo].[1CRejectionReasons] (
    [1CRejectionReasonID] UNIQUEIDENTIFIER NOT NULL,
    [IsMarked]            BIT              NULL,
    [IsFolder]            BIT              NULL,
    [ParentID]            UNIQUEIDENTIFIER NULL,
    [Description]         VARCHAR (100)    NULL,
    [FullDescription]     NTEXT            NULL,
    CONSTRAINT [PK_1CRejectionReasons] PRIMARY KEY CLUSTERED ([1CRejectionReasonID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CRejectionReasons] TO [PalletRepacker]
    AS [dbo];

