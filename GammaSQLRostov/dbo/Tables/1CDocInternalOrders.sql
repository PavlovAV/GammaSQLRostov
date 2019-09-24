CREATE TABLE [dbo].[1CDocInternalOrders] (
    [1CDocInternalOrderID]     UNIQUEIDENTIFIER NOT NULL,
    [Marked]                   BIT              NULL,
    [Posted]                   BIT              NULL,
    [1CDate]                   DATETIME         NULL,
    [1CNumber]                 CHAR (11)        NULL,
    [1CTransportPointStartID]  UNIQUEIDENTIFIER NULL,
    [1CTransportPointFinishID] UNIQUEIDENTIFIER NULL,
    [DateStartFrom]            DATETIME         NULL,
    [DateStartTo]              DATETIME         NULL,
    [DateFinishFrom]           DATETIME         NULL,
    [DateFinishTo]             DATETIME         NULL,
    [1CWarehouseLoadID]        UNIQUEIDENTIFIER NULL,
    [1CWarehouseUnloadID]      UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CDocInternalOrders] PRIMARY KEY CLUSTERED ([1CDocInternalOrderID] ASC),
    CONSTRAINT [FK_1CDocInternalOrders_1CTransportPoints] FOREIGN KEY ([1CTransportPointStartID]) REFERENCES [dbo].[1CTransportPoints] ([1CTransportPointID]),
    CONSTRAINT [FK_1CDocInternalOrders_1CTransportPoints1] FOREIGN KEY ([1CTransportPointFinishID]) REFERENCES [dbo].[1CTransportPoints] ([1CTransportPointID]),
    CONSTRAINT [FK_1CDocInternalOrders_1CWarehouses] FOREIGN KEY ([1CWarehouseLoadID]) REFERENCES [dbo].[1CWarehouses] ([1CWarehouseID]),
    CONSTRAINT [FK_1CDocInternalOrders_1CWarehouses1] FOREIGN KEY ([1CWarehouseUnloadID]) REFERENCES [dbo].[1CWarehouses] ([1CWarehouseID])
);


GO
CREATE NONCLUSTERED INDEX [index1CDate]
    ON [dbo].[1CDocInternalOrders]([1CDate] DESC)
    INCLUDE([1CDocInternalOrderID]);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrders] TO [PalletRepacker]
    AS [dbo];

