CREATE TABLE [dbo].[1CDocInternalOrderGoods] (
    [1CDocInternalOrderID] UNIQUEIDENTIFIER NOT NULL,
    [LineNo]               INT              NOT NULL,
    [1CNomenclatureID]     UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID]   UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitID]      UNIQUEIDENTIFIER NULL,
    [1CQualityID]          UNIQUEIDENTIFIER NULL,
    [Coefficient]          DECIMAL (15, 3)  NULL,
    [Amount]               DECIMAL (15, 3)  NULL,
    CONSTRAINT [PK_1CDocInternalOrderGoods] PRIMARY KEY CLUSTERED ([1CDocInternalOrderID] ASC, [LineNo] ASC),
    CONSTRAINT [FK_1CDocInternalOrderGoods_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CDocInternalOrderGoods_1CDocInternalOrders] FOREIGN KEY ([1CDocInternalOrderID]) REFERENCES [dbo].[1CDocInternalOrders] ([1CDocInternalOrderID]),
    CONSTRAINT [FK_1CDocInternalOrderGoods_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CDocInternalOrderGoods_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CDocInternalOrderGoods_1CQuality] FOREIGN KEY ([1CQualityID]) REFERENCES [dbo].[1CQuality] ([1CQualityID])
);


GO
CREATE NONCLUSTERED INDEX [indexQuality]
    ON [dbo].[1CDocInternalOrderGoods]([1CQualityID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexNomenclature]
    ON [dbo].[1CDocInternalOrderGoods]([1CNomenclatureID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexCharacteristic]
    ON [dbo].[1CDocInternalOrderGoods]([1CCharacteristicID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexNomCharQual]
    ON [dbo].[1CDocInternalOrderGoods]([1CNomenclatureID] ASC, [1CCharacteristicID] ASC, [1CQualityID] ASC)
    INCLUDE([Coefficient], [Amount]);


GO
CREATE NONCLUSTERED INDEX [indexOrderID]
    ON [dbo].[1CDocInternalOrderGoods]([1CDocInternalOrderID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CDocInternalOrderGoods] TO [PalletRepacker]
    AS [dbo];

