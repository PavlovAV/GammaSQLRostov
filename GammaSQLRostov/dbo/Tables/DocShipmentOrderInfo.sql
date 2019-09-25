CREATE TABLE [dbo].[DocShipmentOrderInfo] (
    [1CDocShipmentOrderID] UNIQUEIDENTIFIER NOT NULL,
    [ActivePersonID]       INT              NULL,
    [VehicleNumber]        NVARCHAR (50)    NULL,
    [ShiftID]              TINYINT          NULL,
    [IsShipped]            BIT              CONSTRAINT [DF_DocShipmentOrderInfo_IsShipped] DEFAULT ((0)) NULL,
    [KindID]               TINYINT          CONSTRAINT [DF_DocShipmentOrderInfo_KindID] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_DocShipmentOrderInfo] PRIMARY KEY CLUSTERED ([1CDocShipmentOrderID] ASC, [KindID] ASC)
);




GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrderInfo] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0 - отгрузка
1 - внутренний заказ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocShipmentOrderInfo', @level2type = N'COLUMN', @level2name = N'KindID';

