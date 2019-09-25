CREATE TABLE [dbo].[zzRests] (
    [ProductID]         UNIQUEIDENTIFIER NOT NULL,
    [PlaceID]           INT              NULL,
    [Quantity]          INT              NOT NULL,
    [PlaceZoneID]       UNIQUEIDENTIFIER NULL,
    [zzTransactionType] TINYINT          NULL,
    [zzDate]            DATETIME         NULL,
    [zzUserID]          VARCHAR (100)    NULL
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzRests] TO PUBLIC
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[zzRests] TO PUBLIC
    AS [dbo];

