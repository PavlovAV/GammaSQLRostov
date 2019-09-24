CREATE TABLE [dbo].[1CNomenclature] (
    [1CNomenclatureID]           UNIQUEIDENTIFIER NOT NULL,
    [NomenclatureKindID]         TINYINT          NULL,
    [1CBaseMeasureUnitQualifier] UNIQUEIDENTIFIER NULL,
    [1CCode]                     VARCHAR (11)     NOT NULL,
    [1CParentID]                 UNIQUEIDENTIFIER NULL,
    [Name]                       VARCHAR (255)    NULL,
    [IsArchive]                  BIT              CONSTRAINT [DF_1CNomenclature_IsArchive] DEFAULT ((0)) NULL,
    [IsFolder]                   BIT              NOT NULL,
    [Marking]                    NVARCHAR (25)    NULL,
    [PrintName]                  VARCHAR (1000)   NULL,
    [FullName]                   VARCHAR (8000)   NULL,
    [1CMeaureUnitStorage]        UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitSet]           UNIQUEIDENTIFIER NULL,
    [1CDeleted]                  BIT              NULL,
    CONSTRAINT [PK_C1CNomenclature] PRIMARY KEY CLUSTERED ([1CNomenclatureID] ASC),
    CONSTRAINT [FK_1CNomenclature_1CMeasureUnitQualifiers] FOREIGN KEY ([1CBaseMeasureUnitQualifier]) REFERENCES [dbo].[1CMeasureUnitQualifiers] ([1CMeasureUnitQualifierID]),
    CONSTRAINT [FK_1CNomenclature_1CMeasureUnits] FOREIGN KEY ([1CMeaureUnitStorage]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CNomenclature_1CMeasureUnits1] FOREIGN KEY ([1CMeasureUnitSet]) REFERENCES [dbo].[1CMeasureUnits] ([1CMeasureUnitID]),
    CONSTRAINT [FK_1CNomenclature_1CNomenclature] FOREIGN KEY ([1CParentID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID])
);


GO
CREATE NONCLUSTERED INDEX [IX_FK_1CNomenclature_1CNomenclature]
    ON [dbo].[1CNomenclature]([1CParentID] ASC);


GO
CREATE NONCLUSTERED INDEX [BaseMeasureUnitQualifierIndex]
    ON [dbo].[1CNomenclature]([1CBaseMeasureUnitQualifier] ASC);


GO
CREATE NONCLUSTERED INDEX [IndexNom]
    ON [dbo].[1CNomenclature]([1CNomenclatureID] ASC)
    INCLUDE([1CMeasureUnitSet], [Name], [1CParentID], [1CBaseMeasureUnitQualifier]);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CNomenclature] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Вид номенклатуры', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'1CNomenclature', @level2type = N'COLUMN', @level2name = N'NomenclatureKindID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Единица хранения', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'1CNomenclature', @level2type = N'COLUMN', @level2name = N'1CMeaureUnitStorage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Единица отчетов', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'1CNomenclature', @level2type = N'COLUMN', @level2name = N'1CMeasureUnitSet';

