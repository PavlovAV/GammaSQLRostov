CREATE TABLE [dbo].[DocShipments] (
    [1CDocShipmentOrderID] UNIQUEIDENTIFIER NOT NULL,
    [DocID]                UNIQUEIDENTIFIER NOT NULL,
    [PersonID]             INT              NULL,
    [KindID]               TINYINT          CONSTRAINT [DF_DocShipments_KindID] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_DocShipments] PRIMARY KEY CLUSTERED ([1CDocShipmentOrderID] ASC, [DocID] ASC),
    CONSTRAINT [FK_DocShipments_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID])
);




GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocShipments] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocShipments] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocShipments] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocShipments] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocShipments] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0 - отгрузка
1 - внутренний заказ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocShipments', @level2type = N'COLUMN', @level2name = N'KindID';

