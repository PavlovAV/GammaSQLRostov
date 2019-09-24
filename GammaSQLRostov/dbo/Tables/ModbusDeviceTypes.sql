CREATE TABLE [dbo].[ModbusDeviceTypes] (
    [ModbusDeviceTypeID] INT           NOT NULL,
    [Name]               VARCHAR (255) NULL,
    CONSTRAINT [PK_ModbusDeviceTypes] PRIMARY KEY CLUSTERED ([ModbusDeviceTypeID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ModbusDeviceTypes] TO [PalletRepacker]
    AS [dbo];

