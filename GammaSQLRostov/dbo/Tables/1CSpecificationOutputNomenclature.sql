CREATE TABLE [dbo].[1CSpecificationOutputNomenclature] (
    [1CSpecificationID]  UNIQUEIDENTIFIER NOT NULL,
    [LineNumber]         DECIMAL (5)      NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [Amount]             DECIMAL (15, 3)  NULL,
    CONSTRAINT [PK_1CSpecificationOutputNomenclature] PRIMARY KEY CLUSTERED ([1CSpecificationID] ASC, [LineNumber] ASC),
    CONSTRAINT [FK_1CSpecificationOutputNomenclature_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CSpecificationOutputNomenclature_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CSpecificationOutputNomenclature_1CSpecifications1] FOREIGN KEY ([1CSpecificationID]) REFERENCES [dbo].[1CSpecifications] ([1CSpecificationID])
);

