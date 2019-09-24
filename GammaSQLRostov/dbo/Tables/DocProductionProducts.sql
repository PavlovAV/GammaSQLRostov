CREATE TABLE [dbo].[DocProductionProducts] (
    [DocID]              UNIQUEIDENTIFIER NOT NULL,
    [ProductID]          UNIQUEIDENTIFIER NOT NULL,
    [Quantity]           DECIMAL (15, 5)  CONSTRAINT [DF_DocProductionProducts_Quantity] DEFAULT ((0)) NULL,
    [1CNomenclatureID]   UNIQUEIDENTIFIER NULL,
    [1CCharacteristicID] UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_DocProductionProducts] PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_DocProductionProducts_DocProduction] FOREIGN KEY ([DocID]) REFERENCES [dbo].[DocProduction] ([DocID]),
    CONSTRAINT [FK_DocProductionProducts_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);


GO
CREATE NONCLUSTERED INDEX [ProductIDIndex]
    ON [dbo].[DocProductionProducts]([ProductID] ASC);


GO
CREATE NONCLUSTERED INDEX [DocIDIndex]
    ON [dbo].[DocProductionProducts]([DocID] ASC);


GO

CREATE TRIGGER zziDocProductionProducts ON DocProductionProducts
AFTER  INSERT AS 
INSERT INTO zzDocProductionProducts
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzuDocProductionProducts ON DocProductionProducts
AFTER  UPDATE AS 
INSERT INTO zzDocProductionProducts
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzdDocProductionProducts ON DocProductionProducts
AFTER  DELETE AS 
INSERT INTO zzDocProductionProducts
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestsAfterInsertDocProductionProduct]
   ON  [dbo].[DocProductionProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS 
	(
		SELECT * FROM 
		inserted a
		JOIN
		Rests b ON a.ProductID = b.ProductID
	)
	BEGIN
		INSERT INTO Rests (ProductID, PlaceID, Quantity, PlaceZoneID)
		SELECT a.ProductID, b.PlaceID, 1, NULL
		FROM
		inserted a
		JOIN
		Docs b ON a.DocID = b.DocID
	END
	ELSE
	BEGIN
		UPDATE a SET a.Quantity = 1
		FROM
		Rests a
		JOIN
		inserted b ON a.ProductID = b.ProductID 
	END

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestsAfterDeleteDocProductionProduct]
   ON  [dbo].[DocProductionProducts]
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE a SET Quantity = 0
	FROM
	Rests a
	JOIN
	deleted b ON a.ProductID = b.ProductID 
	/*DELETE a
	FROM
	Rests a
	JOIN
	deleted b ON a.ProductID = b.ProductID 
	*/
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[GenerateNumberBarcodeProductAfterInsert]
   ON  [dbo].[DocProductionProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
 
	DECLARE @Number varchar(100), @PrevNumber varchar(100), @CurrDate datetime,
    @Year varchar(10), @Month varchar(10), @Day varchar(10), @Place varchar(10), @PlaceID int, @ShiftID tinyint, @DocID uniqueidentifier,
	@ProductKindID int, @DocTypeID int, @ProductID uniqueidentifier, @BranchID int, @BranchUnitID varchar(10)


	IF EXISTS 
	(
		SELECT * 
		FROM inserted a
		JOIN
		Docs b ON a.DocID = b.DocID AND b.DocTypeID = 0 AND (IsFromOldGamma = 0 OR IsFromOldGamma IS NULL)
		WHERE b.BranchID IS NULL OR b.BranchID = (SELECT TOP 1 BranchID FROM LocalSettings)
	)
	BEGIN
		DECLARE docProducts_cursor CURSOR
		FOR
		SELECT a.DocID, ProductID, b.PlaceID, b.Date, c.BranchID, CAST(ISNULL(c.BranchUnitID,0) AS varchar(10)) AS BranchUnitID, b.ShiftID
		FROM 
		inserted a
		JOIN
		Docs b ON a.DocID = b.DocID AND b.DocTypeID = 0
		JOIN
		Places c ON b.PlaceID = c.PlaceID
		WHERE b.IsFromOldGamma = 0 OR b.IsFromOldGamma IS NULL
			
		OPEN docProducts_cursor

		FETCH NEXT FROM docProducts_cursor
		INTO @DocID, @ProductID, @PlaceID, @CurrDate, @BranchID, @BranchUnitID, @ShiftID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT TOP 1 @PrevNumber = c.Number
			FROM
			Docs a
			JOIN
			DocProductionProducts b ON a.DocID = b.DocID
			JOIN
			Products c ON b.ProductID = c.ProductID
			WHERE a.DocTypeID = 0 AND a.PlaceID = @PlaceID
			AND YEAR(a.Date) = YEAR(@CurrDate) AND MONTH(a.Date) = MONTH(@CurrDate)
			AND c.Number IS NOT NULL
			ORDER BY a.Date DESC, c.Number DESC

			SET @PrevNumber = ISNULL(@PrevNumber, '000000000')
		
			SELECT @YEAR = LEFT(CONVERT(varchar, @CurrDate, 12), 2)
		    SELECT @MONTH = SUBSTRING(CONVERT(varchar, @CurrDate, 12), 3, 2)
			SELECT @DAY = SUBSTRING(CONVERT(varchar, @CurrDate, 12), 5, 2)

			SELECT @Number = (CAST(RIGHT(@PrevNumber, 5) as int) + 1)
			SELECT @Number = STUFF('00000', 6 - LEN(@Number), LEN(@number), @Number)
	
			SET @Number = @YEAR + @MONTH + @DAY + CAST(@ShiftID AS varchar) + CAST(@BranchID AS varchar) 
			+ STUFF('00',3 - LEN(@BranchUnitID), LEN(@BranchUnitID), @BranchUnitID) + @Number

			UPDATE Products SET Number = @Number, BarCode = '2' + @Number
			WHERE ProductID = @ProductID AND Number IS NULL

			FETCH NEXT FROM docProducts_cursor
			INTO @DocID, @ProductID, @PlaceID, @CurrDate, @BranchID, @BranchUnitID, @ShiftID
		END

		CLOSE docProducts_cursor
		DEALLOCATE docProducts_cursor
	END

END

GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProductionProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProductionProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProductionProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProductionProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProductionProducts] TO [PalletRepacker]
    AS [dbo];

