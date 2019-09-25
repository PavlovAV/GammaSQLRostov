CREATE TABLE [dbo].[zzDocInProducts] (
    [DocID]           UNIQUEIDENTIFIER NOT NULL,
    [ProductID]       UNIQUEIDENTIFIER NOT NULL,
    [IsConfirmed]     BIT              NULL,
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
    ON OBJECT::[dbo].[zzDocInProducts] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzDocInProducts] TO PUBLIC
    AS [dbo];

