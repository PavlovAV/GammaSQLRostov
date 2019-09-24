CREATE TABLE [dbo].[ProductSpools] (
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NOT NULL,
    [RealFormat]         INT              NULL,
    [Diameter]           INT              NOT NULL,
    [Weight]             INT              CONSTRAINT [DF_ProductSpools_Weight] DEFAULT ((0)) NOT NULL,
    [DecimalWeight]      DECIMAL (15, 5)  NOT NULL,
    [Length]             DECIMAL (8, 2)   NULL,
    [RealBasisWeight]    DECIMAL (10, 4)  NULL,
    [ToughnessKindID]    TINYINT          CONSTRAINT [DF_ProductSpools_ToughnessKindID] DEFAULT ((1)) NULL,
    [BreakNumber]        TINYINT          NULL,
    [CurrentDiameter]    INT              NULL,
    [CurrentLength]      DECIMAL (8, 2)   NULL,
    CONSTRAINT [PK_ProductSpools] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_ProductSpools_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_ProductSpools_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_ProductSpools_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO
CREATE NONCLUSTERED INDEX [IX_FK_ProductSpools_1CCharacteristics]
    ON [dbo].[ProductSpools]([1CCharacteristicID] ASC);


GO
CREATE NONCLUSTERED INDEX [IX_FK_ProductSpools_1CNomenclature]
    ON [dbo].[ProductSpools]([1CNomenclatureID] ASC);


GO
CREATE NONCLUSTERED INDEX [indexNomChar]
    ON [dbo].[ProductSpools]([1CNomenclatureID] ASC, [1CCharacteristicID] ASC)
    INCLUDE([ProductID], [DecimalWeight]);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateSpoolCurrentParametersAfterInsert]
   ON  [dbo].[ProductSpools]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	UPDATE a SET a.CurrentDiameter = a.Diameter, a.CurrentLength = a.Length
	FROM
	ProductSpools a
	JOIN
	Inserted b ON a.ProductID = b.ProductID 
	

	

END

GO
CREATE TRIGGER zziProductSpools ON dbo.ProductSpools
AFTER  INSERT AS 
INSERT INTO zzProductSpools
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER zzuProductSpools ON dbo.ProductSpools
AFTER  UPDATE AS 
INSERT INTO zzProductSpools
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER zzdProductSpools ON dbo.ProductSpools
AFTER  DELETE AS 
INSERT INTO zzProductSpools
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED

GO
-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <29.12.2017>
-- Description:	Обновляем текущий диаметр и длину в переходном рулоне
-- =============================================
CREATE TRIGGER [dbo].[UpdateSpoolCurrentParametersAfterUpdate]
   ON  [dbo].[ProductSpools]
   FOR UPDATE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	IF UPDATE([Diameter]) OR UPDATE([Length])
	BEGIN
		UPDATE a SET a.CurrentDiameter = a.Diameter, a.CurrentLength = a.Length
		FROM
		ProductSpools a
		JOIN
		inserted b ON a.ProductID = b.ProductID
		JOIN
		deleted d ON a.ProductID = d.ProductID AND (ISNULL(b.Diameter,-1) <> ISNULL(d.Diameter,-1) OR ISNULL(b.Length,-1) <> ISNULL(d.Length,-1))
		JOIN
		DocCloseShiftRemainders c ON a.ProductID = c.ProductID
		WHERE 
		(ISNULL(d.CurrentDiameter,0) = 0 AND ISNULL(b.Diameter,0) <> 0)  
		OR (ISNULL(d.CurrentLength,0) = 0 AND ISNULL(b.Length,0) <> 0)  
	END
	

END

GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[ProductSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[ProductSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[ProductSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[ProductSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[ProductSpools] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Диаметр выпущенного тамбура в мм', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProductSpools', @level2type = N'COLUMN', @level2name = N'Diameter';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Прочность бумаги
(0-выше, 1-цель, 2-ниже)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProductSpools', @level2type = N'COLUMN', @level2name = N'ToughnessKindID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Количество обрывов', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProductSpools', @level2type = N'COLUMN', @level2name = N'BreakNumber';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Диаметр тамбура с учетом списаний и брака в мм', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'ProductSpools', @level2type = N'COLUMN', @level2name = N'CurrentDiameter';

