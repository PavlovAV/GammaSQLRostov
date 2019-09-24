CREATE TABLE [dbo].[1CNomenclatureGroupNomenclature] (
    [1CNomenclatureGroupID] UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_1CNomenclatureGroupNomenclature] PRIMARY KEY CLUSTERED ([1CNomenclatureGroupID] ASC, [1CNomenclatureID] ASC),
    CONSTRAINT [FK_1CNomenclatureGroupNomenclature_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CNomenclatureGroupNomenclature_1CNomenclatureGroups] FOREIGN KEY ([1CNomenclatureGroupID]) REFERENCES [dbo].[1CNomenclatureGroups] ([1CNomenclatureGroupID])
);

