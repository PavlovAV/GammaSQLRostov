CREATE TABLE [dbo].[1CDocShipmentOrder] (
    [1CDocShipmentOrderID] UNIQUEIDENTIFIER NOT NULL,
    [Marked]               BIT              NOT NULL,
    [Posted]               BIT              NOT NULL,
    [1CDate]               DATETIME         NULL,
    [1CNumber]             CHAR (11)        NOT NULL,
    [1CContractorID]       UNIQUEIDENTIFIER NULL,
    [1CConsigneeID]        UNIQUEIDENTIFIER NULL,
    [1CShipperID]          UNIQUEIDENTIFIER NULL,
    [1CWarehouseID]        UNIQUEIDENTIFIER NULL,
    [1CDocBuyerOrderID]    UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CDocShipmentOrder] PRIMARY KEY CLUSTERED ([1CDocShipmentOrderID] ASC),
    CONSTRAINT [FK_1CDocShipmentOrder_1CContractors] FOREIGN KEY ([1CContractorID]) REFERENCES [dbo].[1CContractors] ([1CContractorID]),
    CONSTRAINT [FK_1CDocShipmentOrder_1CContractors1] FOREIGN KEY ([1CConsigneeID]) REFERENCES [dbo].[1CContractors] ([1CContractorID]),
    CONSTRAINT [FK_1CDocShipmentOrder_1CContractors2] FOREIGN KEY ([1CShipperID]) REFERENCES [dbo].[1CContractors] ([1CContractorID]),
    CONSTRAINT [FK_1CDocShipmentOrder_1CDocBuyerOrders] FOREIGN KEY ([1CDocBuyerOrderID]) REFERENCES [dbo].[1CDocBuyerOrders] ([1CDocBuyerOrderID]),
    CONSTRAINT [FK_1CDocShipmentOrder_1CWarehouses] FOREIGN KEY ([1CWarehouseID]) REFERENCES [dbo].[1CWarehouses] ([1CWarehouseID])
);


GO
CREATE NONCLUSTERED INDEX [DocShipmentOrderID]
    ON [dbo].[1CDocShipmentOrder]([1CDocShipmentOrderID] ASC)
    INCLUDE([1CDocBuyerOrderID], [1CWarehouseID], [1CContractorID], [1CDate]);


GO
CREATE NONCLUSTERED INDEX [index1CDate]
    ON [dbo].[1CDocShipmentOrder]([1CDate] DESC)
    INCLUDE([1CDocShipmentOrderID]);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrder] TO [PalletRepacker]
    AS [dbo];

