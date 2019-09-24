CREATE TABLE [dbo].[ProductionTaskBatches] (
    [ProductionTaskBatchID] UNIQUEIDENTIFIER CONSTRAINT [DF_ProductionTaskBatches_ProductionTaskBatchID] DEFAULT (newsequentialid()) NOT NULL,
    [BatchKindID]           SMALLINT         NOT NULL,
    [ProductionTaskStateID] TINYINT          NOT NULL,
    [UserID]                UNIQUEIDENTIFIER NULL,
    [Number]                VARCHAR (255)    NULL,
    [Date]                  DATETIME         NULL,
    [Comment]               VARCHAR (8000)   NULL,
    [ProcessModelID]        SMALLINT         NULL,
    [PartyControl]          BIT              CONSTRAINT [DF_ProductionTaskBatches_PartyControl] DEFAULT ((0)) NULL,
    [1CContractorID]        UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_ProductionTaskBatches] PRIMARY KEY CLUSTERED ([ProductionTaskBatchID] ASC),
    CONSTRAINT [FK_ProductionTaskBatches_1CContractors] FOREIGN KEY ([1CContractorID]) REFERENCES [dbo].[1CContractors] ([1CContractorID]),
    CONSTRAINT [FK_ProductionTaskBatches_ProcessModels] FOREIGN KEY ([ProcessModelID]) REFERENCES [dbo].[ProcessModels] ([ProcessModelID]),
    CONSTRAINT [FK_ProductionTaskBatches_ProductionTaskStates] FOREIGN KEY ([ProductionTaskStateID]) REFERENCES [dbo].[ProductionTaskStates] ([ProductionTaskStateID])
);


GO

CREATE TRIGGER zziProductionTaskBatches ON ProductionTaskBatches
AFTER  INSERT AS 
INSERT INTO zzProductionTaskBatches
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzuProductionTaskBatches ON ProductionTaskBatches
AFTER  UPDATE AS 
INSERT INTO zzProductionTaskBatches
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzdProductionTaskBatches ON ProductionTaskBatches
AFTER  DELETE AS 
INSERT INTO zzProductionTaskBatches
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[SetProductionTaskBatchNumberAfterInsert]
   ON  [dbo].[ProductionTaskBatches]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	DECLARE @Number varchar(100), @PrevNumber int, @ProductionTaskBatchID uniqueidentifier

	SELECT @ProductionTaskBatchID = ProductionTaskBatchID FROM inserted

	DECLARE @BranchID int
	SET @BranchID = (SELECT TOP 1 BranchID FROM LocalSettings)

	SELECT @Number = CAST((RIGHT(MAX(CAST(Number AS int)), LEN(MAX(CAST(Number AS int))) - 1) + 1) AS varchar(10))
	FROM
	ProductionTaskBatches
	WHERE ProductionTaskBatchID <> @ProductionTaskBatchID
	
--	SELECT @Number = CAST((@PrevNumber + 1) AS varchar)
	

	UPDATE a SET Number = CAST(@BranchID AS varchar(1)) + @Number
	FROM
	ProductionTaskBatches a
	JOIN
	inserted b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID AND b.Number IS NULL

END

GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductionTaskBatches] TO [PalletRepacker]
    AS [dbo];

