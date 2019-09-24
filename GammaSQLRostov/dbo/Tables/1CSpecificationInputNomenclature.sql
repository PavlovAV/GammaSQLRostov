CREATE TABLE [dbo].[1CSpecificationInputNomenclature] (
    [1CSpecificationID]  UNIQUEIDENTIFIER NOT NULL,
    [LineNumber]         DECIMAL (5)      NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitID]    UNIQUEIDENTIFIER NULL,
    [Amount]             DECIMAL (15, 3)  NULL,
    [WithdrawByFact]     BIT              NULL,
    [LinkKey]            DECIMAL (5)      NULL,
    [SelectionType]      DECIMAL (20)     NULL,
    [1CPropertyID]       UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_1CSpecificationInputNomenclature] PRIMARY KEY CLUSTERED ([1CSpecificationID] ASC, [LineNumber] ASC),
    CONSTRAINT [FK_1CSpecificationInputNomenclature_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_1CSpecificationInputNomenclature_1CMeasureUnits] FOREIGN KEY ([1CMeasureUnitID]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CSpecificationInputNomenclature_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_1CSpecificationInputNomenclature_1CProperties] FOREIGN KEY ([1CPropertyID]) REFERENCES [dbo].[1CProperties] ([1CPropertyID]),
    CONSTRAINT [FK_1CSpecificationInputNomenclature_1CSpecifications1] FOREIGN KEY ([1CSpecificationID]) REFERENCES [dbo].[1CSpecifications] ([1CSpecificationID])
);

