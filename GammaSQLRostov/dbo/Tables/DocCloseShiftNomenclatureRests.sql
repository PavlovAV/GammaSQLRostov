CREATE TABLE [dbo].[DocCloseShiftNomenclatureRests] (
    [DocCloseShiftNomenclatureRestID] UNIQUEIDENTIFIER CONSTRAINT [DF_DocCloseShiftNomenclatureRests_DocCloseShiftNomenclatureRestID] DEFAULT (newsequentialid()) NOT NULL,
    [DocID]                           UNIQUEIDENTIFIER NOT NULL,
    [1CNomenclatureID]                UNIQUEIDENTIFIER NOT NULL,
    [1CCharacteristicID]              UNIQUEIDENTIFIER NOT NULL,
    [Quantity]                        DECIMAL (15, 5)  NOT NULL,
    CONSTRAINT [PK_DocCloseShiftNomenclatureRests] PRIMARY KEY CLUSTERED ([DocCloseShiftNomenclatureRestID] ASC),
    CONSTRAINT [FK_DocCloseShiftNomenclatureRests_1CCharacteristics] FOREIGN KEY ([1CCharacteristicID]) REFERENCES [dbo].[1CCharacteristics] ([1CCharacteristicID]),
    CONSTRAINT [FK_DocCloseShiftNomenclatureRests_1CNomenclature] FOREIGN KEY ([1CNomenclatureID]) REFERENCES [dbo].[1CNomenclature] ([1CNomenclatureID]),
    CONSTRAINT [FK_DocCloseShiftNomenclatureRests_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID])
);




GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Изменение количества рассыпухи при закрытии смены
-- =============================================
CREATE TRIGGER [dbo].[UpdateNomenclatureRestsAfterAddDocCloseShift]
   ON  [dbo].[DocCloseShiftNomenclatureRests]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	UPDATE a SET a.Quantity = ISNULL(a.Quantity,0) + b.Quantity
	FROM
	NomenclatureRests a
	JOIN
	inserted b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND 
		((a.[1CCharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL) OR a.[1CCharacteristicID] = b.[1CCharacteristicID])

	INSERT INTO NomenclatureRests ([1CNomenclatureID], [1CCharacteristicID], Quantity)
	SELECT i.[1CNomenclatureID], i.[1CCharacteristicID], i.Quantity
	FROM inserted i
	WHERE
	NOT EXISTS 
	(
		SELECT * FROM NomenclatureRests 
		WHERE [1CNomenclatureID] = i.[1CNomenclatureID] AND 
		(([1CCharacteristicID] IS NULL AND i.[1CCharacteristicID] IS NULL) OR [1CCharacteristicID] = i.[1CCharacteristicID])
	)

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Изменение количества рассыпухи при закрытии смены
-- =============================================
CREATE TRIGGER [dbo].[UpdateNomenclatureRestsAfterDeleteDocCloseShift]
   ON  [dbo].[DocCloseShiftNomenclatureRests]
   AFTER Delete
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	UPDATE a SET a.Quantity = ISNULL(a.Quantity,0) - b.Quantity
	FROM
	NomenclatureRests a
	JOIN
	deleted b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND 
		((a.[1CCharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL) OR a.[1CCharacteristicID] = b.[1CCharacteristicID])

END

GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Переходные остатки (неполные паллеты)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocCloseShiftNomenclatureRests';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftNomenclatureRests] TO [Dispetcher]
    AS [dbo];

