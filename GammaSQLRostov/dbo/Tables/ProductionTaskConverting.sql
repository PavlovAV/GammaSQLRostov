CREATE TABLE [dbo].[ProductionTaskConverting] (
    [ProductionTaskID]        UNIQUEIDENTIFIER NOT NULL,
    [RobotProductNumber]      INT              NULL,
    [RobotProductDescription] VARCHAR (500)    NULL,
    [GroupPackLabelPNG]       VARBINARY (MAX)  NULL,
    [GroupPackLabelMD5]       VARCHAR (32)     NULL,
    [GroupPackLabelZPL]       VARCHAR (MAX)    NULL,
    [TransportPackLabelPNG]   VARBINARY (MAX)  NULL,
    [TransportPackLabelMD5]   VARCHAR (32)     NULL,
    [TransportPackLabelZPL]   VARCHAR (MAX)    NULL,
    CONSTRAINT [PK_ProductionTaskConverting] PRIMARY KEY CLUSTERED ([ProductionTaskID] ASC),
    CONSTRAINT [FK_ProductionTaskConverting_ProductionTasks] FOREIGN KEY ([ProductionTaskID]) REFERENCES [dbo].[ProductionTasks] ([ProductionTaskID]) ON DELETE CASCADE
);




GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskConverting] TO [PalletRepacker]
    AS [dbo];


GO

CREATE TRIGGER zzuProductionTaskConverting ON ProductionTaskConverting
AFTER  UPDATE AS 
INSERT INTO zzProductionTaskConverting
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zziProductionTaskConverting ON ProductionTaskConverting
AFTER  INSERT AS 
INSERT INTO zzProductionTaskConverting
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzdProductionTaskConverting ON ProductionTaskConverting
AFTER  DELETE AS 
INSERT INTO zzProductionTaskConverting
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED