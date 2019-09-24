CREATE TABLE [dbo].[DocMovementOrderNomenclature] (
    [DocMovementOrderNomenclatureID] UNIQUEIDENTIFIER CONSTRAINT [DF_DocMovementOrderNomenclature_DocMovementOrderNomenclatureID] DEFAULT (newsequentialid()) NOT NULL,
    [DocID]                          UNIQUEIDENTIFIER NULL,
    [1CNomenclatureID]               UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID]             UNIQUEIDENTIFIER NULL,
    [Amount]                         DECIMAL (18, 5)  NULL,
    CONSTRAINT [PK_DocMovementOrderNomenclature] PRIMARY KEY CLUSTERED ([DocMovementOrderNomenclatureID] ASC),
    CONSTRAINT [FK_DocMovementOrderNomenclature_DocMovementOrder] FOREIGN KEY ([DocID]) REFERENCES [dbo].[DocMovementOrder] ([DocID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocMovementOrderNomenclature] TO [PalletRepacker]
    AS [dbo];

