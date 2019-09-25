CREATE TABLE [dbo].[DocProducts] (
    [DocID]          UNIQUEIDENTIFIER NOT NULL,
    [ProductID]      UNIQUEIDENTIFIER NOT NULL,
    [IsInConfirmed]  BIT              NULL,
    [IsOutConfirmed] BIT              NULL,
    CONSTRAINT [PK_DocProducts] PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_DocProducts_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID]) ON DELETE CASCADE
);




GO
CREATE NONCLUSTERED INDEX [IX_FK_DocProducts_Products]
    ON [dbo].[DocProducts]([ProductID] ASC);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestsAfterInsert]
   ON  [dbo].[DocProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
	DECLARE @ProductID uniqueidentifier, @DocID uniqueidentifier

	DECLARE docProduct CURSOR FOR 
	SELECT a.DocID, a.ProductID 
	FROM inserted a
	JOIN
	Docs b ON a.DocID = b.DocID AND b.DocTypeID NOT IN (0,1)
	
	OPEN DocProduct

	FETCH NEXT FROM docProduct
	INTO @DocID, @ProductID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS (SELECT * FROM Rests WHERE ProductID = @ProductID)
		BEGIN
			UPDATE a SET a.Quantity = ISNULL(a.Quantity,0) + d.Movement
				FROM
				Rests a
				JOIN
				inserted b ON a.ProductID = b.ProductID
				JOIN
				Docs c ON b.DocID = c.DocID
				JOIN
				DocTypes d ON c.DocTypeID = d.DocTypeID
				WHERE b.DocID = @DocID AND b.ProductID = @ProductID
		END
		ELSE
		BEGIN
			INSERT INTO Rests
				SELECT a.ProductID, g.PlaceID, c.Movement AS Quantity
				FROM
				inserted a
				JOIN
				Docs b ON a.DocID = b.DocID
				JOIN
				DocTypes c ON c.DocTypeID = b.DocTypeID
				LEFT JOIN
				DocProductionProducts f ON a.ProductID = f.ProductID
				LEFT JOIN
				Docs g ON f.DocID = g.DocID AND g.DocTypeID = 0
				WHERE a.ProductID = @ProductID AND a.DocID = @DocID 
		END
		
		FETCH NEXT FROM docProduct
			INTO @DocID, @ProductID
	END

	CLOSE docproduct

	DEALLOCATE DocProduct
*/
END

GO
DISABLE TRIGGER [dbo].[UpdateRestsAfterInsert]
    ON [dbo].[DocProducts];


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestsAfterDelete]
   ON  [dbo].[DocProducts]
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*	
	DECLARE @ProductID uniqueidentifier, @DocID uniqueidentifier

	DECLARE docProduct CURSOR FOR 
	SELECT a.DocID, a.ProductID 
	FROM deleted a
	JOIN
	Docs b ON a.DocID = b.DocID AND b.DocTypeID NOT IN (0,1)

	OPEN docProduct

	FETCH NEXT FROM docProduct
	INTO @DocID, @ProductID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF EXISTS (SELECT * FROM Rests WHERE ProductID = @ProductID)
		BEGIN
			UPDATE a SET a.PlaceID = c.PlaceID, a.Quantity = ISNULL(a.Quantity,0) - d.Movement
				FROM
				Rests a
				JOIN
				deleted b ON a.ProductID = b.ProductID
				JOIN
				Docs c ON b.DocID = c.DocID
				JOIN
				DocTypes d ON c.DocTypeID = d.DocTypeID
				WHERE b.DocID = @DocID AND b.ProductID = @ProductID
		END
		ELSE
		BEGIN
			INSERT INTO Rests
				SELECT a.ProductID, g.PlaceID, -c.Movement AS Quantity
				FROM
				deleted a
				JOIN
				Docs b ON a.DocID = b.DocID
				JOIN
				DocTypes c ON c.DocTypeID = b.DocTypeID
				LEFT JOIN
				DocProductionProducts f ON a.ProductID = f.ProductID
				LEFT JOIN
				Docs g ON f.DocID = g.DocID
				WHERE a.ProductID = @ProductID AND a.DocID = @DocID
		END
		
		FETCH NEXT FROM docProduct
			INTO @DocID, @ProductID
	END

	CLOSE docproduct

	DEALLOCATE docproduct
*/
END


GO
DISABLE TRIGGER [dbo].[UpdateRestsAfterDelete]
    ON [dbo].[DocProducts];


GO

CREATE TRIGGER zziDocProducts ON DocProducts
AFTER  INSERT AS 
INSERT INTO zzDocProducts
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzuDocProducts ON DocProducts
AFTER  UPDATE AS 
INSERT INTO zzDocProducts
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED
GO

CREATE TRIGGER zzdDocProducts ON DocProducts
AFTER  DELETE AS 
INSERT INTO zzDocProducts
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED
GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocProducts] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Табличная часть движения продукции', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocProducts';

