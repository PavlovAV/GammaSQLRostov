CREATE TABLE [dbo].[zzDocs] (
    [DocID]           UNIQUEIDENTIFIER NOT NULL,
    [IsMarked]        BIT              NULL,
    [DocTypeID]       INT              NULL,
    [Number]          VARCHAR (50)     NULL,
    [IsConfirmed]     BIT              NOT NULL,
    [UserID]          UNIQUEIDENTIFIER NULL,
    [PersonID]        INT              NULL,
    [PrintName]       VARCHAR (255)    NULL,
    [PlaceID]         INT              NULL,
    [ShiftID]         TINYINT          NULL,
    [Date]            DATETIME         NOT NULL,
    [Comment]         VARCHAR (8000)   NULL,
    [IsFromOldGamma]  BIT              NULL,
    [BranchID]        TINYINT          NULL,
    [PersonGuid]      UNIQUEIDENTIFIER NULL,
    [TransactionType] TINYINT          NULL,
    [zzDate]          DATETIME         NULL,
    [zzUserID]        VARCHAR (100)    NULL
);




GO
GRANT INSERT
    ON OBJECT::[dbo].[zzDocs] TO PUBLIC
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[zzDocs] TO PUBLIC
    AS [dbo];

