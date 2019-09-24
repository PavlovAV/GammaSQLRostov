CREATE TABLE [dbo].[zzProductItems] (
    [ProductItemID]      UNIQUEIDENTIFIER NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [Quantity]           INT              NULL,
    [zzTransactionType]  TINYINT          NULL,
    [zzDate]             DATETIME         NULL,
    [zzUserID]           VARCHAR (100)    NULL
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzProductItems] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzProductItems] TO PUBLIC
    AS [dbo];

