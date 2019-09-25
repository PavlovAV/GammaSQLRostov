
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec [dbo].[FillDocCloseShiftPMSpools] @PlaceID=1,@ShiftID=1,@CloseDate='20181121 10:13:03'
CREATE PROCEDURE [dbo].[FillDocCloseShiftPMSpools] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @ShiftID int, @CloseDate DateTime
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	INSERT INTO CriticalLogs([Log]) VALUES ('Запуск FillDocCloseShiftPMSpools @PlaceID '+CAST(@PlaceID AS varchar(10))+', @ShiftID '+CAST(@ShiftID AS varchar(10))+', @CloseDate' + CONVERT(VARCHAR(100), @CloseDate,113) )
    
    -- Insert statements for procedure here
	SELECT a.[1CNomenclatureID] AS NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID, b.Quantity, a.ProductID, c.DocID,
	d.Name + ' ' + e.Name AS NomenclatureName, f.Number
	FROM
	ProductSpools a
	JOIN
	DocProductionProducts b ON a.ProductID = b.ProductID 
	JOIN
	Docs c ON b.DocID = c.DocID
	JOIN
	[1CNomenclature] d ON a.[1CNomenclatureID] = d.[1CNomenclatureID]
	JOIN
	[1CCharacteristics] e ON a.[1CCharacteristicID] = e.[1CCharacteristicID]
	JOIN
	Products f ON a.ProductID = f.ProductID
	WHERE 
	c.PlaceID = @PlaceID AND c.ShiftID = @ShiftID AND --c.IsConfirmed = 1 AND
	c.Date BETWEEN DATEADD(hh, -1, dbo.GetShiftBeginTime(DATEADD(hh, -1, @CloseDate))) 
		AND DATEADD(hh, 1, dbo.GetShiftEndTime(DATEADD(hh, -1, @CloseDate)))

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMSpools] TO [PalletRepacker]
    AS [dbo];

