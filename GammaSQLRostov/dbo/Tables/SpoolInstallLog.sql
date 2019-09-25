CREATE TABLE [dbo].[SpoolInstallLog] (
    [SpoolInstallLogID] UNIQUEIDENTIFIER CONSTRAINT [DF_SpoolInstallLog_SpoolInstallLogID] DEFAULT (newsequentialid()) NOT NULL,
    [PlaceID]           INT              NULL,
    [ShiftID]           TINYINT          NULL,
    [UnwinderID]        TINYINT          NULL,
    [ProductID]         UNIQUEIDENTIFIER NULL,
    [Date]              DATETIME         NULL,
    CONSTRAINT [PK_SpoolInstallLog] PRIMARY KEY CLUSTERED ([SpoolInstallLogID] ASC),
    CONSTRAINT [FK_SpoolInstallLog_Places] FOREIGN KEY ([PlaceID]) REFERENCES [dbo].[Places] ([PlaceID])
);




GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================

CREATE TRIGGER [dbo].[MovementToPlaceDuringInstallLog]
   ON  [dbo].[SpoolInstallLog]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE R SET PlaceID = i.PlaceID
	FROM 
		Rests r JOIN inserted i ON r.ProductID = i.ProductID
	WHERE 
		r.PlaceID <> i.PlaceID

END
GO
DISABLE TRIGGER [dbo].[MovementToPlaceDuringInstallLog]
    ON [dbo].[SpoolInstallLog];



GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SpoolInstallLog] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SpoolInstallLog] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SpoolInstallLog] TO [PalletRepacker]
    AS [dbo];


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	добавляет документ перемещения при установке рулона на раскат
-- =============================================
CREATE TRIGGER [dbo].[CreateMovementDocAfterUpdate]
   ON  [dbo].[SpoolInstallLog]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  

	DECLARE @ProductID uniqueidentifier,
			@PlaceID int, -- склад, на который перемещают
			@ProductKindID int, 
			@ShiftID tinyint
  
	DECLARE SpoolInstallLog_cursor CURSOR FOR   
		SELECT b.ProductID, c.ProductKindID, b.PlaceID, b.ShiftID
		FROM
			Rests a
			JOIN Inserted b ON a.ProductID = b.ProductID AND ISNULL(a.Quantity,0) <> 0
			JOIN Products c ON a.ProductID = c.ProductID
			JOIN Places d ON b.PlaceID = d.PlaceID AND d.PlaceGroupID IN (1) --перемещают на прс
			JOIN Places e ON a.PlaceID = e.PlaceID AND d.PlaceGroupID IN (0,1) --перемещают с бдм или другой прс
		WHERE
			ISNULL(a.PlaceID,0) <> b.PlaceID
	OPEN SpoolInstallLog_cursor  
  
	FETCH NEXT FROM SpoolInstallLog_cursor   
	INTO @ProductID, @ProductKindID, @PlaceID, @ShiftID
  
	WHILE @@FETCH_STATUS = 0  
	BEGIN  
	  --PRINT '----'+CONVERT(varchar(100),@ProductID)+'--------'+CAST(ISNULL(@PlaceID,'') AS varchar(100))+'----'+CAST(ISNULL(@ProductKindID,'') AS varchar(100))+'--------'+CAST(ISNULL(@ShiftID,'') AS varchar(100))+'--------------'
		
		
		EXEC mob_AddProductIdToMovement 
			NULL,
			@ProductID,
			@PlaceID,
			NULL,
			@ProductKindID, 
			NULL,
			NULL,
			NULL,
			NULL,
			@ShiftID
		FETCH NEXT FROM SpoolInstallLog_cursor   
		INTO @ProductID, @ProductKindID, @PlaceID, @ShiftID
	END    
	CLOSE SpoolInstallLog_cursor;  
	DEALLOCATE SpoolInstallLog_cursor;
	
END
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[CopyToOldSpoolInstallLog]
   ON  [dbo].[SpoolInstallLog]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	/*INSERT INTO 
	Gamma.dbo.SpoolInstallLog (SpoolID, PlaceID, UnwinderID, ShiftID, Date)
	SELECT b.SpoolID, c.PlaceID, a.UnwinderID, a.ShiftID, a.Date
	FROM
	SpoolInstallLog a
	JOIN
	Gamma.dbo.GammaNewToOldSpools b ON a.ProductID = b.ProductID
	JOIN
	Gamma.dbo.GammaNewToOldPlaces c ON a.PlaceID = c.NewPlaceID
	JOIN
	inserted d ON a.ProductID = d.ProductID
	WHERE NOT EXISTS (SELECT SpoolID FROM Gamma.dbo.SpoolInstallLog WHERE SpoolID = b.SpoolID)
	*/
END
GO
DISABLE TRIGGER [dbo].[CopyToOldSpoolInstallLog]
    ON [dbo].[SpoolInstallLog];

