CREATE TABLE [dbo].[1CNomenclatureGroups] (
    [1CNomenclatureGroupID] UNIQUEIDENTIFIER NOT NULL,
    [1CCode]                CHAR (9)         NULL,
    [1CEnumGroupTypeID]     INT              NULL,
    [Description]           VARCHAR (140)    NULL,
    [1CMeasureUnitID]       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CNomenclatureGroups] PRIMARY KEY CLUSTERED ([1CNomenclatureGroupID] ASC),
    CONSTRAINT [FK_1CNomenclatureGroups_1CEnumGroupTypes] FOREIGN KEY ([1CEnumGroupTypeID]) REFERENCES [dbo].[1CEnumGroupTypes] ([1CEnumGroupTypeID]),
    CONSTRAINT [FK_1CNomenclatureGroups_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID])
);

