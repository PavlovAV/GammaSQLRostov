
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FillDocCloseShiftConvertingPallets] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @ShiftID int, @CloseDate DateTime
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.[1CNomenclatureID] AS NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID, a.Quantity, a.ProductID, c.DocID,
	d.Name + ' ' + e.Name AS NomenclatureName, f.Number
	FROM
	ProductItems a
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
		AND DATEADD(hh,1, dbo.GetShiftEndTime(DATEADD(hh, -1, @CloseDate)))

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingPallets] TO [PalletRepacker]
    AS [dbo];

