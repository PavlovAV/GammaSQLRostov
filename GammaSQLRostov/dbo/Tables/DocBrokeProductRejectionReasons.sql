CREATE TABLE [dbo].[DocBrokeProductRejectionReasons] (
    [DocID]               UNIQUEIDENTIFIER NOT NULL,
    [ProductID]           UNIQUEIDENTIFIER NOT NULL,
    [1CRejectionReasonID] UNIQUEIDENTIFIER NOT NULL,
    [Comment]             VARCHAR (8000)   NULL,
    CONSTRAINT [PK_DocBrokeProductRejectionReasons] PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC, [1CRejectionReasonID] ASC),
    CONSTRAINT [FK_DocBrokeProductRejectionReasons_1CRejectionReasons] FOREIGN KEY ([1CRejectionReasonID]) REFERENCES [dbo].[1CRejectionReasons] ([1CRejectionReasonID]),
    CONSTRAINT [FK_DocBrokeProductRejectionReasons_DocBrokeProducts] FOREIGN KEY ([DocID], [ProductID]) REFERENCES [dbo].[DocBrokeProducts] ([DocID], [ProductID])
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocBrokeProductRejectionReasons] TO [PalletRepacker]
    AS [dbo];

