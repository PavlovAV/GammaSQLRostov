CREATE TABLE [dbo].[zzProductSpools] (
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [RealFormat]         INT              NULL,
    [Diameter]           INT              NOT NULL,
    [Weight]             DECIMAL (15, 5)  NOT NULL,
    [DecimalWeight]      DECIMAL (15, 5)  NULL,
    [Length]             DECIMAL (8, 2)   NULL,
    [RealBasisWeight]    DECIMAL (10, 4)  NULL,
    [ToughnessKindID]    TINYINT          NULL,
    [BreakNumber]        TINYINT          NULL,
    [CurrentDiameter]    INT              NULL,
    [CurrentLength]      DECIMAL (8, 2)   NULL,
    [TransactionType]    TINYINT          NULL,
    [zzDate]             DATETIME         NULL,
    [zzUserID]           VARCHAR (100)    NULL
);


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzProductSpools] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzProductSpools] TO PUBLIC
    AS [dbo];

