CREATE TABLE [dbo].[ProductionTaskStates] (
    [ProductionTaskStateID] TINYINT      NOT NULL,
    [Name]                  VARCHAR (50) NOT NULL,
    [IsActual]              BIT          CONSTRAINT [DF_ProductionTaskStates_IsActual] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_ProductionTaskStates] PRIMARY KEY CLUSTERED ([ProductionTaskStateID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskStates] TO [PalletRepacker]
    AS [dbo];

