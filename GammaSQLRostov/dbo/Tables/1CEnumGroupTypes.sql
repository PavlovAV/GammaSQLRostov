CREATE TABLE [dbo].[1CEnumGroupTypes] (
    [1CEnumGroupTypeID] INT           NOT NULL,
    [Name]              VARCHAR (40)  NULL,
    [Alias]             VARCHAR (120) NULL,
    CONSTRAINT [PK_1CEnumGroupTypes] PRIMARY KEY CLUSTERED ([1CEnumGroupTypeID] ASC)
);

