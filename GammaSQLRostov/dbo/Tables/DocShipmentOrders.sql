CREATE TABLE [dbo].[DocShipmentOrders] (
    [DocOrderID]        UNIQUEIDENTIFIER NOT NULL,
    [OrderTypeID]       TINYINT          NULL,
    [VehicleNumber]     VARCHAR (50)     NULL,
    [IsShipped]         BIT              NULL,
    [OutPlaceID]        INT              NULL,
    [OutActivePersonID] UNIQUEIDENTIFIER NULL,
    [OutShiftID]        TINYINT          NULL,
    [OutDate]           DATETIME         NULL,
    [InPlaceID]         INT              NULL,
    [InActivePersonID]  UNIQUEIDENTIFIER NULL,
    [InShiftID]         TINYINT          NULL,
    [InDate]            DATETIME         NULL,
    [Driver]            VARCHAR (255)    NULL,
    [DriverDocument]    VARCHAR (255)    NULL,
    CONSTRAINT [PK_DocShipmentOrders] PRIMARY KEY CLUSTERED ([DocOrderID] ASC),
    CONSTRAINT [FK_DocShipmentOrders_OrderTypes] FOREIGN KEY ([OrderTypeID]) REFERENCES [dbo].[OrderTypes] ([OrderTypeID]),
    CONSTRAINT [FK_DocShipmentOrders_Persons] FOREIGN KEY ([OutActivePersonID]) REFERENCES [dbo].[Persons] ([PersonID]),
    CONSTRAINT [FK_DocShipmentOrders_Persons1] FOREIGN KEY ([InActivePersonID]) REFERENCES [dbo].[Persons] ([PersonID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocShipmentOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocShipmentOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocShipmentOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocShipmentOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocShipmentOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocShipmentOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipmentOrders] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Временное поле для заведения водителя в приказ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocShipmentOrders', @level2type = N'COLUMN', @level2name = N'Driver';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Временное поле для заведения доверенности водителя в приказ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocShipmentOrders', @level2type = N'COLUMN', @level2name = N'DriverDocument';

