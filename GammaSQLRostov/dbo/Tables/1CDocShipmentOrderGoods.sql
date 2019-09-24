CREATE TABLE [dbo].[1CDocShipmentOrderGoods] (
    [1CDocShipmentOrderID] UNIQUEIDENTIFIER NOT NULL,
    [LineNo]               INT              NOT NULL,
    [1CNomenclatureID]     UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID]   UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitID]      UNIQUEIDENTIFIER NULL,
    [1CQualityID]          UNIQUEIDENTIFIER NULL,
    [Coefficient]          DECIMAL (15, 3)  NULL,
    [Amount]               DECIMAL (15, 3)  NULL,
    [LoadToTop]            BIT              NULL,
    CONSTRAINT [PK_1CDocShipmentOrderGoods] PRIMARY KEY CLUSTERED ([1CDocShipmentOrderID] ASC, [LineNo] ASC),
    CONSTRAINT [FK_1CDocShipmentOrderGoods_1CDocShipmentOrder] FOREIGN KEY ([1CDocShipmentOrderID]) REFERENCES [dbo].[1CDocShipmentOrder] ([1CDocShipmentOrderID])
);


GO
CREATE NONCLUSTERED INDEX [indexQuality]
    ON [dbo].[1CDocShipmentOrderGoods]([1CQualityID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexOrderID]
    ON [dbo].[1CDocShipmentOrderGoods]([1CDocShipmentOrderID] ASC);


GO
CREATE NONCLUSTERED INDEX [nix_Nomenclature]
    ON [dbo].[1CDocShipmentOrderGoods]([1CNomenclatureID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexCharacteristic]
    ON [dbo].[1CDocShipmentOrderGoods]([1CCharacteristicID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexNomenclatureCharacteristic]
    ON [dbo].[1CDocShipmentOrderGoods]([1CNomenclatureID] ASC, [1CCharacteristicID] ASC)
    INCLUDE([Coefficient], [Amount], [LoadToTop], [1CQualityID], [1CDocShipmentOrderID]);


GO
CREATE NONCLUSTERED INDEX [indexNomCharQual]
    ON [dbo].[1CDocShipmentOrderGoods]([1CNomenclatureID] ASC, [1CCharacteristicID] ASC, [1CQualityID] ASC)
    INCLUDE([Coefficient], [Amount]);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocShipmentOrderGoods] TO [PalletRepacker]
    AS [dbo];

