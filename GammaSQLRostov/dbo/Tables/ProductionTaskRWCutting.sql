CREATE TABLE [dbo].[ProductionTaskRWCutting] (
    [ProductionTaskRWCuttingID] UNIQUEIDENTIFIER CONSTRAINT [DF_ProductionTaskRWCutting_ProductionTaskRWCuttingID] DEFAULT (newsequentialid()) NOT NULL,
    [ProductionTaskID]          UNIQUEIDENTIFIER NOT NULL,
    [CutIndex]                  SMALLINT         NULL,
    [1CNomenclatureID]          UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID]        UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_ProductionTaskRWCutting] PRIMARY KEY CLUSTERED ([ProductionTaskRWCuttingID] ASC),
    CONSTRAINT [FK_ProductionTaskRWCutting_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_ProductionTaskRWCutting_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_ProductionTaskRWCutting_ProductionTasks] FOREIGN KEY ([ProductionTaskID]) REFERENCES [dbo].[ProductionTasks] ([ProductionTaskID]) ON DELETE CASCADE
);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[SetCuttingNomenclatureIDAfterInsert]
   ON  [dbo].[ProductionTaskRWCutting]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 /* 
	UPDATE a SET a.[1CNomenclatureID] = b.[1CNomenclatureID]
	FROM
	ProductionTaskRWCutting a
	JOIN
	inserted i ON a.ProductionTaskRWCuttingID = i.ProductionTaskRWCuttingID AND a.[1CNomenclatureID] IS NULL
	JOIN
	ProductionTasks b ON a.ProductionTaskID = b.ProductionTaskID
	*/

END

GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskRWCutting] TO [PalletRepacker]
    AS [dbo];

