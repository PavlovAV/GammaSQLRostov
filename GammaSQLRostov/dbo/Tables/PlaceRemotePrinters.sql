CREATE TABLE [dbo].[PlaceRemotePrinters] (
    [PlaceRemotePrinterID]     INT IDENTITY (1, 1) NOT NULL,
    [PlaceID]                  INT NOT NULL,
    [ModbusDeviceID]           INT NOT NULL,
    [RemotePrinterID]          INT NOT NULL,
    [IsEnabled]                BIT CONSTRAINT [DF_PlaceRemotePrinters_IsEnabled] DEFAULT ((1)) NULL,
    [IsDefaultPrinterForGamma] BIT CONSTRAINT [DF_PlaceRemotePrinters_IsDefaultPrinterForGamma] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_PlaceRemotePrinters] PRIMARY KEY CLUSTERED ([PlaceRemotePrinterID] ASC),
    CONSTRAINT [FK_PlaceRemotePrinters_ModbusDevices] FOREIGN KEY ([ModbusDeviceID]) REFERENCES [dbo].[ModbusDevices] ([ModbusDeviceID]),
    CONSTRAINT [FK_PlaceRemotePrinters_Places] FOREIGN KEY ([PlaceID]) REFERENCES [dbo].[Places] ([PlaceID]),
    CONSTRAINT [FK_PlaceRemotePrinters_RemotePrinters] FOREIGN KEY ([RemotePrinterID]) REFERENCES [dbo].[RemotePrinters] ([RemotePrinterID])
);




GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceRemotePrinters] TO [PalletRepacker]
    AS [dbo];

