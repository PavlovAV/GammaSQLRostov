CREATE TABLE [dbo].[1CMeasureUnitQualifiers] (
    [1CMeasureUnitQualifierID] UNIQUEIDENTIFIER NOT NULL,
    [1CCode]                   VARCHAR (20)     NULL,
    [IsInteger]                BIT              NULL,
    [Name]                     VARCHAR (250)    NULL,
    CONSTRAINT [PK_1CMeasureUnitQualifiers] PRIMARY KEY CLUSTERED ([1CMeasureUnitQualifierID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CMeasureUnitQualifiers] TO [PalletRepacker]
    AS [dbo];

