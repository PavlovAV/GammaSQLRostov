CREATE TABLE [dbo].[1CCharacteristics] (
    [1CCharacteristicID] UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NOT NULL,
    [1CCode]             VARCHAR (20)     NOT NULL,
    [MeasureUnitPackage] UNIQUEIDENTIFIER NULL,
    [MeasureUnitPallet]  UNIQUEIDENTIFIER NULL,
    [Name]               VARCHAR (255)    NULL,
    [IsActive]           BIT              CONSTRAINT [DF_1CCharacteristics_IsActive] DEFAULT ((1)) NOT NULL,
    [PrintName]          VARCHAR (8000)   NULL,
    [PackageLabelPath]   NVARCHAR (1024)  NULL,
    [1CDeleted]          BIT              NULL,
    CONSTRAINT [PK_C1CCharacteristics] PRIMARY KEY CLUSTERED ([1CCharacteristicID] ASC),
    CONSTRAINT [FK_1CCharacteristics_1CMeasureUnits] FOREIGN KEY ([MeasureUnitPackage]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CCharacteristics_1CMeasureUnits1] FOREIGN KEY ([MeasureUnitPallet]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CCharacteristics_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID])
);


GO
CREATE NONCLUSTERED INDEX [IndexChar]
    ON [dbo].[1CCharacteristics]([1CCharacteristicID] ASC)
    INCLUDE([MeasureUnitPackage], [1CNomenclatureID], [Name], [MeasureUnitPallet]);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160907-105402]
    ON [dbo].[1CCharacteristics]([MeasureUnitPackage] ASC, [MeasureUnitPallet] ASC);


GO
CREATE NONCLUSTERED INDEX [NomenclatureIndex]
    ON [dbo].[1CCharacteristics]([1CNomenclatureID] ASC)
    INCLUDE([MeasureUnitPackage], [Name], [MeasureUnitPallet]);


GO

CREATE TRIGGER [dbo].[SetPackageLabelPathOn1CCharacteristics] ON [dbo].[1CCharacteristics]
AFTER  INSERT, UPDATE AS 
BEGIN
IF (SELECT Count(*) FROM [1CCharacteristics] c JOIN inserted i ON c.[1CCharacteristicID] = i.[1CCharacteristicID]
	LEFT JOIN deleted d ON c.[1CCharacteristicID] = d.[1CCharacteristicID] AND ISNULL(i.[1CCode],'') = ISNULL(d.[1CCode],'')
WHERE d.[1CCharacteristicID] IS NULL)>0
UPDATE c SET PackageLabelPath = c.[1CCode] + '-lab_gr.pdf'
FROM [1CCharacteristics] c JOIN inserted i ON c.[1CCharacteristicID] = i.[1CCharacteristicID]
	LEFT JOIN deleted d ON c.[1CCharacteristicID] = d.[1CCharacteristicID] AND ISNULL(i.[1CCode],'') = ISNULL(d.[1CCode],'')
WHERE d.[1CCharacteristicID] IS NULL
END
GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CCharacteristics] TO [PalletRepacker]
    AS [dbo];

