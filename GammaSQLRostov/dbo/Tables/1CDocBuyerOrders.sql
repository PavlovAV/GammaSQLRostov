CREATE TABLE [dbo].[1CDocBuyerOrders] (
    [1CDocBuyerOrderID]        UNIQUEIDENTIFIER NOT NULL,
    [Marked]                   TINYINT          NOT NULL,
    [Posted]                   TINYINT          NOT NULL,
    [1CDate]                   DATETIME         NULL,
    [1CNumber]                 CHAR (11)        NOT NULL,
    [BuyerOrderNumber]         NVARCHAR (50)    NULL,
    [1CContractorID]           UNIQUEIDENTIFIER NULL,
    [1CConsigneeID]            UNIQUEIDENTIFIER NULL,
    [1CShipperID]              UNIQUEIDENTIFIER NULL,
    [1CTransportPointStartID]  UNIQUEIDENTIFIER NULL,
    [1CTransportPointFinishID] UNIQUEIDENTIFIER NULL,
    [DateStartFrom]            DATETIME         NULL,
    [DateStartTo]              DATETIME         NULL,
    [DateFinishFrom]           DATETIME         NULL,
    [DateFinishTo]             DATETIME         NULL,
    [1CWarehouseLoadID]        UNIQUEIDENTIFIER NULL,
    [SelfPickup]               BIT              NULL,
    CONSTRAINT [PK_1CDocBuyerOrders] PRIMARY KEY CLUSTERED ([1CDocBuyerOrderID] ASC),
    CONSTRAINT [FK_1CDocBuyerOrders_1CContractors] FOREIGN KEY ([1CContractorID]) REFERENCES [dbo].[1CContractors] ([1CContractorID]),
    CONSTRAINT [FK_1CDocBuyerOrders_1CContractors1] FOREIGN KEY ([1CConsigneeID]) REFERENCES [dbo].[1CContractors] ([1CContractorID]),
    CONSTRAINT [FK_1CDocBuyerOrders_1CContractors2] FOREIGN KEY ([1CShipperID]) REFERENCES [dbo].[1CContractors] ([1CContractorID]),
    CONSTRAINT [FK_1CDocBuyerOrders_1CTransportPoints] FOREIGN KEY ([1CTransportPointStartID]) REFERENCES [dbo].[1CTransportPoints] ([1CTransportPointID]),
    CONSTRAINT [FK_1CDocBuyerOrders_1CTransportPoints1] FOREIGN KEY ([1CTransportPointFinishID]) REFERENCES [dbo].[1CTransportPoints] ([1CTransportPointID]),
    CONSTRAINT [FK_1CDocBuyerOrders_1CWarehouses] FOREIGN KEY ([1CWarehouseLoadID]) REFERENCES [dbo].[1CWarehouses] ([1CWarehouseID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocBuyerOrders] TO [PalletRepacker]
    AS [dbo];

