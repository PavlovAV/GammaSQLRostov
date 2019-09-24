CREATE TABLE [dbo].[RemotePrinterLabels] (
    [RemotePrinterLabelID] INT           IDENTITY (1, 1) NOT NULL,
    [LabelName]            VARCHAR (500) NOT NULL,
    CONSTRAINT [PK_RemotePrinterLabelss] PRIMARY KEY CLUSTERED ([RemotePrinterLabelID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinterLabels] TO [PalletRepacker]
    AS [dbo];

