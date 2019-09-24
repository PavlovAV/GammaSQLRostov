CREATE TABLE [dbo].[DocInventarisationProducts] (
    [DocID]              UNIQUEIDENTIFIER NOT NULL,
    [Barcode]            VARCHAR (50)     NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [Quantity]           DECIMAL (18, 5)  NULL,
    [1CQualityID]        UNIQUEIDENTIFIER NULL,
    [NomenclatureName]   AS               ([dbo].[GetNomenclatureName]([1CNomenclatureID],[1CCharacteristicID],[1CQualityID])),
    CONSTRAINT [PK_DocInventarisationProducts] PRIMARY KEY CLUSTERED ([DocID] ASC, [Barcode] ASC),
    CONSTRAINT [FK_DocInventarisationProducts_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID]),
    CONSTRAINT [FK_DocInventarisationProducts_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInventarisationProducts] TO [PalletRepacker]
    AS [dbo];

