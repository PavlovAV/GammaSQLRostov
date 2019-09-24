CREATE TABLE [dbo].[zz1CBarcodes] (
    [1CBarcodeID]        UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitID]    UNIQUEIDENTIFIER NULL,
    [1CQualityID]        UNIQUEIDENTIFIER NULL,
    [1CBarcodeTypeID]    UNIQUEIDENTIFIER NULL,
    [Barcode]            NVARCHAR (30)    NULL,
    [zzTransactionType]  TINYINT          NULL,
    [zzDate]             DATETIME         NULL,
    [zzUserID]           VARCHAR (100)    NULL
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[zz1CBarcodes] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[zz1CBarcodes] TO PUBLIC
    AS [dbo];

