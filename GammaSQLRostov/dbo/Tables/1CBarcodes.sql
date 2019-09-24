CREATE TABLE [dbo].[1CBarcodes] (
    [1CBarcodeID]        UNIQUEIDENTIFIER CONSTRAINT [DF_1CBarcodes_1CBarcodeID] DEFAULT (newsequentialid()) NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitID]    UNIQUEIDENTIFIER NULL,
    [1CQualityID]        UNIQUEIDENTIFIER NULL,
    [1CBarcodeTypeID]    UNIQUEIDENTIFIER NULL,
    [Barcode]            NVARCHAR (30)    NULL,
    CONSTRAINT [PK_1CBarcodes_1] PRIMARY KEY CLUSTERED ([1CBarcodeID] ASC),
    CONSTRAINT [FK_1CBarcodes_1CBarcodeTypes] FOREIGN KEY ([1CBarcodeTypeID]) REFERENCES [dbo].[1CBarcodeTypes] ([1CBarcodeTypeID]),
    CONSTRAINT [FK_1CBarcodes_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CBarcodes_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CBarcodes_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CBarcodes_1CQuality] FOREIGN KEY ([1CQualityID]) REFERENCES [dbo].[1CQuality] ([1CQualityID])
);


GO

CREATE TRIGGER zzi1CBarcodes ON [1CBarcodes]
AFTER  INSERT AS 
INSERT INTO zz1CBarcodes
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzu1CBarcodes ON [1CBarcodes]
AFTER  UPDATE AS 
INSERT INTO zz1CBarcodes
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzd1CBarcodes ON [1CBarcodes]
AFTER  DELETE AS 
INSERT INTO zz1CBarcodes
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED
GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CBarcodes] TO [PalletRepacker]
    AS [dbo];

