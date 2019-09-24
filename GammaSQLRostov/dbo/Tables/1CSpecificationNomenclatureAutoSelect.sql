CREATE TABLE [dbo].[1CSpecificationNomenclatureAutoSelect] (
    [1CSpecificationID] UNIQUEIDENTIFIER NOT NULL,
    [LineNo]            DECIMAL (5)      NOT NULL,
    [1CNomenclatureID]  UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitID]   UNIQUEIDENTIFIER NULL,
    [Amount]            DECIMAL (15, 3)  NULL,
    [LinkKey]           DECIMAL (5)      NULL,
    [1CPropertyValueID] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CSpecificationNomenclatureAutoSelect] PRIMARY KEY CLUSTERED ([1CSpecificationID] ASC, [LineNo] ASC),
    CONSTRAINT [FK_1CSpecificationNomenclatureAutoSelect_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CSpecificationNomenclatureAutoSelect_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CSpecificationNomenclatureAutoSelect_1CSpecifications] FOREIGN KEY ([1CSpecificationID]) REFERENCES [dbo].[1CSpecifications] ([1CSpecificationID])
);

