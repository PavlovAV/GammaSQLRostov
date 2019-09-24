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
    [Date]            DATETIME         DEFAULT (getdate()) NOT NULL,
    [Comment]         VARCHAR (8000)   NULL,
    [IsFromOldGamma]  BIT              DEFAULT ((0)) NULL,
    [BranchID]        TINYINT          NULL,
    [PersonGuid]      UNIQUEIDENTIFIER NULL,
    [TransactionType] TINYINT          NULL,
    [zzDate]          DATETIME         DEFAULT (getdate()) NOT NULL,
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

