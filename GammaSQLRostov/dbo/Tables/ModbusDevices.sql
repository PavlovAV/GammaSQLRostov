CREATE TABLE [dbo].[ModbusDevices] (
    [ModbusDeviceID]     INT            NOT NULL,
    [ModbusDeviceTypeID] INT            NOT NULL,
    [IPAddress]          NVARCHAR (50)  NOT NULL,
    [Name]               VARCHAR (500)  NULL,
    [TimerTick]          INT            NOT NULL,
    [ServiceAddress]     NVARCHAR (250) NULL,
    CONSTRAINT [PK_ModbusDevices] PRIMARY KEY CLUSTERED ([ModbusDeviceID] ASC),
    CONSTRAINT [FK_ModbusDevices_ModbusDeviceTypes] FOREIGN KEY ([ModbusDeviceTypeID]) REFERENCES [dbo].[ModbusDeviceTypes] ([ModbusDeviceTypeID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDevices] TO [PalletRepacker]
    AS [dbo];

