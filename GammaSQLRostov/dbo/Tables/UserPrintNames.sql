CREATE TABLE [dbo].[UserPrintNames] (
    [UserPrintNameID] UNIQUEIDENTIFIER CONSTRAINT [DF_UserPrintNames_UserPrintNameID] DEFAULT (newsequentialid()) NOT NULL,
    [UserID]          UNIQUEIDENTIFIER NULL,
    [PrintName]       VARCHAR (255)    NULL,
    CONSTRAINT [PK_UserPrintNames] PRIMARY KEY CLUSTERED ([UserPrintNameID] ASC),
    CONSTRAINT [FK_UserPrintNames_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);

