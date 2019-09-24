CREATE TABLE [dbo].[PlaceGroup1CNomenclature] (
    [PlaceGroupID]     SMALLINT         NOT NULL,
    [1CNomenclatureID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_PlaceGroup1CNomenclature] PRIMARY KEY CLUSTERED ([PlaceGroupID] ASC, [1CNomenclatureID] ASC),
    CONSTRAINT [FK_PlaceGroup1CNomenclature_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_PlaceGroup1CNomenclature_PlaceGroups] FOREIGN KEY ([PlaceGroupID]) REFERENCES [dbo].[PlaceGroups] ([PlaceGroupID])
);


GO
CREATE NONCLUSTERED INDEX [indexNomenclatureID]
    ON [dbo].[PlaceGroup1CNomenclature]([1CNomenclatureID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[PlaceGroup1CNomenclature] TO [PalletRepacker]
    AS [dbo];

