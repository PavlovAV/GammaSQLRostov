CREATE TABLE [dbo].[RemotePrinters] (
    [RemotePrinterID]      INT           NOT NULL,
    [PrinterName]          VARCHAR (500) NOT NULL,
    [Alias]                VARCHAR (500) NULL,
    [RemotePrinterLabelID] INT           NOT NULL,
    [IpAdress]             VARCHAR (15)  NULL,
    [Port]                 INT           NULL,
    CONSTRAINT [PK_RemotePrinters] PRIMARY KEY CLUSTERED ([RemotePrinterID] ASC),
    CONSTRAINT [FK_RemotePrinters_RemotePrinterLabels] FOREIGN KEY ([RemotePrinterLabelID]) REFERENCES [dbo].[RemotePrinterLabels] ([RemotePrinterLabelID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RemotePrinters] TO [PalletRepacker]
    AS [dbo];

