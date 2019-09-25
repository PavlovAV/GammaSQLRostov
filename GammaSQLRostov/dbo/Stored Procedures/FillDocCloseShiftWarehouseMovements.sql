
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FillDocCloseShiftWarehouseMovements] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @ShiftID int, @CloseDate DateTime, @PersonID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO CriticalLogs([Log]) VALUES ('Запуск FillDocCloseShiftWarehouseMovements @PlaceID '+CAST(@PlaceID AS varchar(10))+', @ShiftID '+CAST(@ShiftID AS varchar(10))+', @CloseDate' + CONVERT(VARCHAR(100), @CloseDate,113) + ', @PersonID ' + CAST(@PersonID AS varchar(100)) )
    
    -- Insert statements for procedure here
	SELECT c.NomenclatureName,
           c.Number,
           c.ProductID,
           c.Quantity,
           c.ProductKindName,
           c.OrderTypeName,
           c.InPlace,
           c.InPlaceZone,
           c.OutPlace,
           c.OutPlaceZone
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

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftWarehouseMovements] TO [PalletRepacker]
    AS [dbo];

