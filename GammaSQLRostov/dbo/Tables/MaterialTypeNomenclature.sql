CREATE TABLE [dbo].[MaterialTypeNomenclature] (
    [MaterialTypeID]   INT              NOT NULL,
    [1CNomenclatureID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_MaterialTypeNomenclature] PRIMARY KEY CLUSTERED ([MaterialTypeID] ASC, [1CNomenclatureID] ASC),
    CONSTRAINT [FK_MaterialTypeNomenclature_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_MaterialTypeNomenclature_MaterialTypes] FOREIGN KEY ([MaterialTypeID]) REFERENCES [dbo].[MaterialTypes] ([MaterialTypeID])
);

