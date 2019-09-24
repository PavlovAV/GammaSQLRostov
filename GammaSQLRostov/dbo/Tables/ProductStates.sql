CREATE TABLE [dbo].[ProductStates] (
    [StateID]      TINYINT          NOT NULL,
    [1CQualityID]  UNIQUEIDENTIFIER NULL,
    [Name]         VARCHAR (50)     NULL,
    [BrokeActInfo] NVARCHAR (4000)  NULL,
    CONSTRAINT [PK_ProductStates] PRIMARY KEY CLUSTERED ([StateID] ASC),
    CONSTRAINT [FK_ProductStates_1CQuality] FOREIGN KEY ([1CQualityID]) REFERENCES [dbo].[1CQuality] ([1CQualityID])
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductStates] TO [PalletRepacker]
    AS [dbo];

