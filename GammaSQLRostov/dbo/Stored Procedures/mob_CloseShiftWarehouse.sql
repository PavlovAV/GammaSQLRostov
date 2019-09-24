

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[mob_CloseShiftWarehouse] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID uniqueidentifier,
		@ShiftID int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DocID uniqueidentifier
	DECLARE @DocIds table (DocID uniqueidentifier)
	DECLARE @CloseDate DATETIME = GETDATE()
	DECLARE @R int
	
	SELECT TOP 1 @DocID = DocID FROM
	Docs c
	WHERE 
	c.DocTypeID = 3 AND c.PersonGuid = @PersonID AND c.Date BETWEEN DATEADD(hh, -1, dbo.GetShiftBeginTime(DATEADD(hh, -1, @CloseDate))) 
			 AND DATEADD(hh, 1, dbo.GetShiftEndTime(DATEADD(hh, -1, @CloseDate)))
	
	IF @DocID IS NULL
	BEGIN
		BEGIN TRY	
		--BEGIN TRANSACTION doc	
			SET @DocID = newid();

			INSERT INTO Docs (DocID, DocTypeID, UserID, PrintName, Date, PersonGuid, ShiftID, PlaceID)
				SELECT @DocID, 3 AS DocTypeID, dbo.CurrentUserID() AS UserID, Name AS PrintName, @CloseDate AS Date, PersonID, @ShiftID, PlaceID
					FROM
					Persons WHERE PersonID = @PersonID
			
			INSERT INTO @DocIds
				EXEC [dbo].[FillDocCloseShiftWarehouseDocs] NULL, @ShiftID, @CloseDate, @PersonID
			
			INSERT INTO DocCloseShiftDocs(DocCloseShiftID,DocID)
				SELECT @DocID, DocID
					FROM @DocIds				

		--COMMIT TRANSACTION doc
		SET @R = 1
		END TRY
		BEGIN CATCH
			SET @R = -1
		END CATCH
	END
	ELSE
	BEGIN
		SET @R = 0
	END
	SELECT @R AS Result	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CloseShiftWarehouse] TO [PalletRepacker]
    AS [dbo];

