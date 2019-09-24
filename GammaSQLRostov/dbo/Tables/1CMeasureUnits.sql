CREATE TABLE [dbo].[1CMeasureUnits] (
    [1CMeasureUnitID]          UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]         UNIQUEIDENTIFIER NULL,
    [1CMeasureUnitQualifierID] UNIQUEIDENTIFIER NULL,
    [1CCode]                   VARCHAR (20)     NULL,
    [Coefficient]              DECIMAL (10, 3)  NULL,
    [Name]                     VARCHAR (50)     NULL,
    CONSTRAINT [PK_C1CMeasureUnits] PRIMARY KEY CLUSTERED ([1CMeasureUnitID] ASC),
    CONSTRAINT [FK_1CMeasureUnits_1CMeasureUnitQualifiers] FOREIGN KEY ([1CMeasureUnitQualifierID]) REFERENCES [dbo].[1CMeasureUnitQualifiers] ([1CMeasureUnitQualifierID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnits] TO [PalletRepacker]
    AS [dbo];

