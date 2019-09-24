CREATE TABLE [dbo].[1CQuality] (
    [1CQualityID] UNIQUEIDENTIFIER NOT NULL,
    [ParentID]    UNIQUEIDENTIFIER NULL,
    [1CCode]      CHAR (9)         NOT NULL,
    [Marked]      BIT              CONSTRAINT [DF_1CQuality_Marked] DEFAULT ((0)) NOT NULL,
    [IsFolder]    BIT              CONSTRAINT [DF_1CQuality_IsFolder] DEFAULT ((0)) NOT NULL,
    [Description] NVARCHAR (40)    NOT NULL,
    CONSTRAINT [PK_1CQuality] PRIMARY KEY CLUSTERED ([1CQualityID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CQuality] TO [PalletRepacker]
    AS [dbo];

