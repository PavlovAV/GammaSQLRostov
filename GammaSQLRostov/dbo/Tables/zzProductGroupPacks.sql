CREATE TABLE [dbo].[zzProductGroupPacks] (
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [Weight]             DECIMAL (10, 4)  NULL,
    [GrossWeight]        DECIMAL (10, 4)  NULL,
    [Diameter]           SMALLINT         NULL,
    [ManualWeightInput]  BIT              NULL,
    [TransactionType]    TINYINT          NULL,
    [zzDate]             DATETIME         NULL,
    [zzUserID]           VARCHAR (100)    NULL
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzProductGroupPacks] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzProductGroupPacks] TO PUBLIC
    AS [dbo];

