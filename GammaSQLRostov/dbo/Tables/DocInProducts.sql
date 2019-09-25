CREATE TABLE [dbo].[DocInProducts] (
    [DocID]           UNIQUEIDENTIFIER NOT NULL,
    [ProductID]       UNIQUEIDENTIFIER NOT NULL,
    [IsConfirmed]     BIT              CONSTRAINT [DF_DocInProducts_IsConfirmed] DEFAULT ((0)) NULL,
    [PlaceZoneID]     UNIQUEIDENTIFIER NULL,
    [PlaceZoneCellID] UNIQUEIDENTIFIER NULL,
    [PersonID]        UNIQUEIDENTIFIER NULL,
    [Date]            DATETIME         NULL,
    [Quantity]        DECIMAL (15, 5)  NULL,
    CONSTRAINT [PK_DocInProducts] PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_DocInProducts_DocMovement] FOREIGN KEY ([DocID]) REFERENCES [dbo].[DocMovement] ([DocID]),
    CONSTRAINT [FK_DocInProducts_PlaceZoneCells] FOREIGN KEY ([PlaceZoneCellID]) REFERENCES [dbo].[PlaceZoneCells] ([PlaceZoneCellID]),
    CONSTRAINT [FK_DocInProducts_PlaceZones] FOREIGN KEY ([PlaceZoneID]) REFERENCES [dbo].[PlaceZones] ([PlaceZoneID])
);




GO
CREATE NONCLUSTERED INDEX [IndexDocID]
    ON [dbo].[DocInProducts]([DocID] ASC)
    INCLUDE([IsConfirmed], [PersonID], [ProductID]);


GO

CREATE TRIGGER zzdDocInProducts ON DocInProducts
AFTER  DELETE AS 
INSERT INTO zzDocInProducts
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED

GO

CREATE TRIGGER zzuDocInProducts ON DocInProducts
AFTER  UPDATE AS 
INSERT INTO zzDocInProducts
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateQuantityAfterInsertDocInProducts] ON [dbo].[DocInProducts] 
FOR INSERT 
AS 
BEGIN
 SET NOCOUNT ON;
 UPDATE T
 SET T.Quantity=d.Quantity
 FROM [dbo].[DocInProducts] T
 JOIN inserted i ON T.ProductID = i.ProductID AND T.DocID = i.DocID AND T.[Date] = i.[Date]
 JOIN vProductsBaseInfo d ON T.ProductID=d.ProductID
END


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestsAfterInsertDocInProducts]
   ON  [dbo].[DocInProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	IF NOT EXISTS 
		(
			SELECT * FROM Rests a JOIN inserted b ON a.ProductID = b.ProductID
		)
	BEGIN
		INSERT INTO Rests (ProductID, PlaceID, Quantity, PlaceZoneID)
		SELECT a.ProductID, b.InPlaceID, 1, a.PlaceZoneID
		FROM
		inserted a
		JOIN
		DocMovement b ON a.DocID = b.DocID
	END
	ELSE 
	BEGIN
		UPDATE a SET a.PlaceID = c.InPlaceID, a.PlaceZoneID = b.PlaceZoneID
		FROM
		Rests a
		JOIN
		inserted b ON a.ProductID = b.ProductID
		JOIN
		DocMovement c ON b.DocID = c.DocID
	END

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestsAfterDeleteDocInProducts]
   ON  [dbo].[DocInProducts]
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	IF EXISTS 
		(SELECT * 
			FROM Rests a
			JOIN
			Deleted b ON a.ProductID = b.ProductID
		)
		AND EXISTS
		(
			SELECT *
			FROM DocOutProducts a
			JOIN
			Deleted b ON a.DocID = b.DocID AND a.ProductID = b.ProductID
		)
	BEGIN
		UPDATE a SET Quantity = 0
			FROM
				Rests a
				JOIN
				deleted b ON a.ProductID = b.ProductID 
		/*DELETE a
		FROM
		Rests a
		JOIN
		Deleted b ON a.ProductID = b.ProductID
		*/
	END
	ELSE 
	BEGIN
		UPDATE a SET a.PlaceID = c.OutPlaceID, a.PlaceZoneID = d.PlaceZoneID
		FROM
		Rests a
		JOIN
		Deleted b ON a.ProductID = b.ProductID
		JOIN
		DocMovement c ON b.DocID = c.DocID
		LEFT JOIN
		DocOutProducts d ON b.DocID = d.DocID AND d.ProductID = b.ProductID
	END

END

GO

CREATE TRIGGER zziDocInProducts ON DocInProducts
AFTER  INSERT AS 
INSERT INTO zzDocInProducts
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocInProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocInProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocInProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocInProducts] TO [Dispetcher]
    AS [dbo];


GO



GO



GO



GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [QualityInspector]
    AS [dbo];


GO



GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocInProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocInProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocInProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocInProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocInProducts] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocInProducts] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocInProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocInProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocInProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocInProducts] TO [OperatorBDM]
    AS [dbo];

