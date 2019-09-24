CREATE TABLE [dbo].[1CSubdivisions] (
    [1CSubdivisionID] UNIQUEIDENTIFIER NOT NULL,
    [IsMetadata]      BIT              NOT NULL,
    [Marked]          BIT              NOT NULL,
    [Folder]          BIT              NULL,
    [ParentID]        UNIQUEIDENTIFIER NULL,
    [1CCode]          CHAR (9)         NOT NULL,
    [Description]     NVARCHAR (100)   NOT NULL,
    CONSTRAINT [PK_1CSubdivisions_1] PRIMARY KEY CLUSTERED ([1CSubdivisionID] ASC)
);

