CREATE TABLE [dbo].[1CBarcodeTypes] (
    [1CBarcodeTypeID] UNIQUEIDENTIFIER NOT NULL,
    [IsMetadata]      BIT              NULL,
    [Marked]          BIT              NULL,
    [Folder]          BIT              NULL,
    [1CCode]          CHAR (11)        NULL,
    [Description]     NVARCHAR (25)    NULL,
    [ValueType]       TINYINT          NULL,
    CONSTRAINT [PK_1CBarcodeTypes] PRIMARY KEY CLUSTERED ([1CBarcodeTypeID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodeTypes] TO [PalletRepacker]
    AS [dbo];

