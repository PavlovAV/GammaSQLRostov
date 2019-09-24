CREATE TABLE [dbo].[ProductGroupPacks] (
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NOT NULL,
    [Weight]             DECIMAL (10, 4)  NULL,
    [GrossWeight]        DECIMAL (10, 4)  NULL,
    [Diameter]           SMALLINT         NULL,
    [ManualWeightInput]  BIT              CONSTRAINT [DF_ProductGroupPacks_ManualWeightInput] DEFAULT ((1)) NULL,
    CONSTRAINT [PK_ProductGroupPacks] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_ProductGroupPacks_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_ProductGroupPacks_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_ProductGroupPacks_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO
CREATE NONCLUSTERED INDEX [IX_FK_ProductGroupPacks_1CNomenclature]
    ON [dbo].[ProductGroupPacks]([1CNomenclatureID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexNomChar]
    ON [dbo].[ProductGroupPacks]([1CNomenclatureID] ASC, [1CCharacteristicID] ASC)
    INCLUDE([ProductID], [Weight], [GrossWeight]);


GO
CREATE NONCLUSTERED INDEX [IX_FK_ProductGroupPacks_1CCharacteristics]
    ON [dbo].[ProductGroupPacks]([1CCharacteristicID] ASC);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateSpoolWeights]
   ON  [dbo].[ProductGroupPacks]
   AFTER INSERT,UPDATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @NumSpools int, @Weight decimal(15,5)

	SELECT @NumSpools = COUNT(*), @Weight = a.Weight
	FROM
	inserted a 
	JOIN
	vGroupPackSpools b ON a.ProductID = b.ProductGroupPackID
	GROUP BY a.ProductID, a.Weight
	
	BEGIN TRANSACTION weight
		UPDATE a SET a.Quantity = @Weight/@NumSpools
		FROM
		DocProductionProducts a
		JOIN
		vGroupPackSpools b ON a.ProductID = b.ProductID
		JOIN
		inserted c ON b.ProductGroupPackID = c.ProductID
		WHERE a.Quantity < 0.01
	COMMIT
	

END

GO
CREATE TRIGGER [dbo].[zzuProductGroupPacks] ON dbo.ProductGroupPacks
AFTER  UPDATE AS 
INSERT INTO zzProductGroupPacks
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER [dbo].[zziProductGroupPacks] ON dbo.ProductGroupPacks
AFTER  INSERT AS 
INSERT INTO zzProductGroupPacks
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER [dbo].[zzdProductGroupPacks] ON dbo.ProductGroupPacks
AFTER  DELETE AS 
INSERT INTO zzProductGroupPacks
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED

GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductGroupPacks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductGroupPacks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductGroupPacks] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Признак того, что вес был введен вручную', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProductGroupPacks', @level2type = N'COLUMN', @level2name = N'ManualWeightInput';

