CREATE TABLE [dbo].[zzDocOutProducts] (
    [DocID]           UNIQUEIDENTIFIER NOT NULL,
    [ProductID]       UNIQUEIDENTIFIER NOT NULL,
    [PlaceZoneID]     UNIQUEIDENTIFIER NULL,
    [PlaceZoneCellID] UNIQUEIDENTIFIER NULL,
    [PersonID]        UNIQUEIDENTIFIER NULL,
    [Date]            DATETIME         NULL,
    [Quantity]        DECIMAL (15, 5)  NULL,
    [TransactionType] TINYINT          NULL,
    [zzDate]          DATETIME         NULL,
    [zzUserID]        VARCHAR (100)    NULL
);




GO
GRANT SELECT
    ON OBJECT::[dbo].[zzDocOutProducts] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzDocOutProducts] TO PUBLIC
    AS [dbo];

