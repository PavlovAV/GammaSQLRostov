CREATE TABLE [dbo].[PlaceRemotePrinterSettings] (
    [PlaceRemotePrinterID] INT           NOT NULL,
    [SettingName]          VARCHAR (100) NOT NULL,
    [SettingValue]         VARCHAR (100) NOT NULL,
    CONSTRAINT [PK_PlaceRemotePrinterSettings] PRIMARY KEY CLUSTERED ([PlaceRemotePrinterID] ASC, [SettingName] ASC),
    CONSTRAINT [FK_PlaceRemotePrinterSettings_PlaceRemotePrinters] FOREIGN KEY ([PlaceRemotePrinterID]) REFERENCES [dbo].[PlaceRemotePrinters] ([PlaceRemotePrinterID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinterSettings] TO [PalletRepacker]
    AS [dbo];

