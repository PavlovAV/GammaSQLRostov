CREATE TABLE [dbo].[BatchProductionTasks] (
    [ProductionTaskBatchID] UNIQUEIDENTIFIER NOT NULL,
    [ProductionTaskID]      UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_BatchProductionTasks] PRIMARY KEY CLUSTERED ([ProductionTaskBatchID] ASC, [ProductionTaskID] ASC),
    CONSTRAINT [FK_BatchProductionTasks_ProductionTaskBatches] FOREIGN KEY ([ProductionTaskBatchID]) REFERENCES [dbo].[ProductionTaskBatches] ([ProductionTaskBatchID]) ON DELETE CASCADE,
    CONSTRAINT [FK_BatchProductionTasks_ProductionTasks] FOREIGN KEY ([ProductionTaskID]) REFERENCES [dbo].[ProductionTasks] ([ProductionTaskID]) ON DELETE CASCADE
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[BatchProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[BatchProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[BatchProductionTasks] TO [PalletRepacker]
    AS [dbo];

