CREATE TABLE [dbo].[ProductKindRejectionReasons] (
    [ProductKindID]       TINYINT          NOT NULL,
    [1CRejectionReasonID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_ProductKindRejectionReasons] PRIMARY KEY CLUSTERED ([ProductKindID] ASC, [1CRejectionReasonID] ASC),
    CONSTRAINT [FK_ProductKindRejectionReasons_1CRejectionReasons] FOREIGN KEY ([1CRejectionReasonID]) REFERENCES [dbo].[1CRejectionReasons] ([1CRejectionReasonID]),
    CONSTRAINT [FK_ProductKindRejectionReasons_ProductKinds] FOREIGN KEY ([ProductKindID]) REFERENCES [dbo].[ProductKinds] ([ProductKindID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductKindRejectionReasons] TO [PalletRepacker]
    AS [dbo];

