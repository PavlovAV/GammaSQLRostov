CREATE TABLE [dbo].[zzDocShipmentOrders] (
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
    [zzTransactionType] TINYINT          NULL,
    [zzDate]            DATETIME         NULL,
    [zzUserID]          VARCHAR (100)    NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzDocShipmentOrders] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzDocShipmentOrders] TO PUBLIC
    AS [dbo];

