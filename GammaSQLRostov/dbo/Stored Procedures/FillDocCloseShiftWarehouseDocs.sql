

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FillDocCloseShiftWarehouseDocs] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @ShiftID int, @CloseDate DateTime, @PersonID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT c.DocMovementID AS DocID
		FROM
			vDocMovementProducts c
		WHERE
			--c.PlaceID = @PlaceID AND c.ShiftID = @ShiftID AND 
			(c.InPersonID = @PersonID AND 
			 c.InDate BETWEEN DATEADD(hh, -1, dbo.GetShiftBeginTime(DATEADD(hh, -1, @CloseDate))) 
			 AND DATEADD(hh, 1, dbo.GetShiftEndTime(DATEADD(hh, -1, @CloseDate)))
			)
			OR 
			(c.OutPersonID = @PersonID AND 
			 c.OutDate BETWEEN DATEADD(hh, -1, dbo.GetShiftBeginTime(DATEADD(hh, -1, @CloseDate))) 
			 AND DATEADD(hh, 1, dbo.GetShiftEndTime(DATEADD(hh, -1, @CloseDate)))
			)
		GROUP BY c.DocMovementID
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseDocs] TO [PalletRepacker]
    AS [dbo];

