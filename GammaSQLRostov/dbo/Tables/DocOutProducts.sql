CREATE TABLE [dbo].[DocOutProducts] (
    [DocID]           UNIQUEIDENTIFIER NOT NULL,
    [ProductID]       UNIQUEIDENTIFIER NOT NULL,
    [PlaceZoneID]     UNIQUEIDENTIFIER NULL,
    [PlaceZoneCellID] UNIQUEIDENTIFIER NULL,
    [PersonID]        UNIQUEIDENTIFIER NULL,
    [Date]            DATETIME         NULL,
    [Quantity]        DECIMAL (15, 5)  NULL,
    CONSTRAINT [PK_DocOutProducts] PRIMARY KEY CLUSTERED ([DocID] ASC, [ProductID] ASC),
    CONSTRAINT [FK_DocOutProducts_DocMovement] FOREIGN KEY ([DocID]) REFERENCES [dbo].[DocMovement] ([DocID]),
    CONSTRAINT [FK_DocOutProducts_PlaceZoneCells] FOREIGN KEY ([PlaceZoneCellID]) REFERENCES [dbo].[PlaceZoneCells] ([PlaceZoneCellID]),
    CONSTRAINT [FK_DocOutProducts_PlaceZones] FOREIGN KEY ([PlaceZoneID]) REFERENCES [dbo].[PlaceZones] ([PlaceZoneID])
);




GO
CREATE NONCLUSTERED INDEX [IndexDocID]
    ON [dbo].[DocOutProducts]([DocID] ASC)
    INCLUDE([PersonID], [ProductID]);


GO

CREATE TRIGGER zzdDocOutProducts ON DocOutProducts
AFTER  DELETE AS 
INSERT INTO zzDocOutProducts
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED

GO

CREATE TRIGGER zzuDocOutProducts ON DocOutProducts
AFTER  UPDATE AS 
INSERT INTO zzDocOutProducts
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestsAfterDeleteDocOutProducts]
   ON  [dbo].[DocOutProducts]
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	IF NOT EXISTS 
		(
			SELECT * FROM 
			Rests a
			JOIN
			Deleted b ON a.ProductID = b.ProductID
		)
	BEGIN
		INSERT INTO Rests (ProductID, PlaceID, Quantity, PlaceZoneID)
		SELECT TOP 1 a.ProductID, b.OutPlaceID, 1, a.PlaceZoneID
		FROM
		deleted a
		JOIN
		DocMovement b ON a.DocID = b.DocID
		JOIN vProductsBaseInfo c ON a.ProductID = c.ProductID AND c.Quantity > 0

	END

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateRestsAfterInsertDocOutProducts]
   ON  [dbo].[DocOutProducts]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	UPDATE a SET Quantity = 0
	FROM
	Rests a
	JOIN
	Inserted b ON a.ProductID = b.ProductID 
	/*DELETE a
	FROM
	Rests a
	JOIN
	Inserted b ON a.ProductID = b.ProductID 
	*/
END

GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[UpdateQuantityAfterInsertDocOutProducts] ON [dbo].[DocOutProducts] 
FOR INSERT 
AS 
BEGIN
 SET NOCOUNT ON;
 UPDATE T
 SET T.Quantity=d.Quantity
 FROM [dbo].[DocOutProducts] T
 JOIN inserted i ON T.ProductID = i.ProductID AND T.DocID = i.DocID AND T.[Date] = i.[Date]
 JOIN vProductsBaseInfo d ON T.ProductID=d.ProductID
END


GO

CREATE TRIGGER zziDocOutProducts ON DocOutProducts
AFTER  INSERT AS 
INSERT INTO zzDocOutProducts
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocOutProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocOutProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocOutProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocOutProducts] TO [Dispetcher]
    AS [dbo];


GO



GO



GO



GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [QualityInspector]
    AS [dbo];


GO



GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocOutProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocOutProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocOutProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocOutProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocOutProducts] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocOutProducts] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocOutProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocOutProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocOutProducts] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocOutProducts] TO [OperatorBDM]
    AS [dbo];

