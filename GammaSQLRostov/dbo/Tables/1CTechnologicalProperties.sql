CREATE TABLE [dbo].[1CTechnologicalProperties] (
    [1CTechnologicalPropertyID] UNIQUEIDENTIFIER NOT NULL,
    [Marked]                    BIT              NULL,
    [Folder]                    BIT              CONSTRAINT [DF_1CTechnologicalProperties_Folder] DEFAULT ((0)) NOT NULL,
    [ParentID]                  UNIQUEIDENTIFIER NULL,
    [1CCode]                    CHAR (9)         NULL,
    [Description]               NVARCHAR (100)   NULL,
    [1CPropertyID]              UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CTechologicalProperties] PRIMARY KEY CLUSTERED ([1CTechnologicalPropertyID] ASC),
    CONSTRAINT [FK_1CTechologicalProperties_1CProperties] FOREIGN KEY ([1CPropertyID]) REFERENCES [dbo].[1CProperties] ([1CPropertyID]),
    CONSTRAINT [FK_1CTechologicalProperties_1CProperties1] FOREIGN KEY ([1CPropertyID]) REFERENCES [dbo].[1CProperties] ([1CPropertyID])
);

