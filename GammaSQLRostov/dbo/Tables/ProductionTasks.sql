CREATE TABLE [dbo].[ProductionTasks] (
    [ProductionTaskID]   UNIQUEIDENTIFIER CONSTRAINT [DF_ProductionTasks_ProductionTaskID] DEFAULT (newsequentialid()) NOT NULL,
    [PlaceID]            INT              NULL,
    [PlaceGroupID]       SMALLINT         NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    [Quantity]           DECIMAL (18, 3)  CONSTRAINT [DF_ProductionTasks_Quantity] DEFAULT ((0)) NOT NULL,
    [DateBegin]          DATETIME         NULL,
    [DateEnd]            DATETIME         NULL,
    CONSTRAINT [PK_ProductionTasks] PRIMARY KEY CLUSTERED ([ProductionTaskID] ASC),
    CONSTRAINT [FK_ProductionTasks_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_ProductionTasks_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_ProductionTasks_Places] FOREIGN KEY ([PlaceID]) REFERENCES [dbo].[Places] ([PlaceID])
);


GO
CREATE TRIGGER zziProductionTasks ON dbo.ProductionTasks
AFTER  INSERT AS 
INSERT INTO zzProductionTasks
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER zzuProductionTasks ON dbo.ProductionTasks
AFTER  UPDATE AS 
INSERT INTO zzProductionTasks
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER zzdProductionTasks ON dbo.ProductionTasks
AFTER  DELETE AS 
INSERT INTO zzProductionTasks
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED

GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTasks] TO [PalletRepacker]
    AS [dbo];

