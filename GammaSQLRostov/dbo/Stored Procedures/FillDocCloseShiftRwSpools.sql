-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FillDocCloseShiftRwSpools] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int,
		@ShiftID int,
		@CloseDate DateTime
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    DECLARE @BeginDate DateTime2, @EndDate DateTime2, @MinDate DateTime2

	SELECT @BeginDate = DATEADD(hour, -1, dbo.GetShiftBeginTime(@CloseDate)), @EndDate = DATEADD(hour, 1, dbo.GetShiftEndTime(@CloseDate))

	SELECT @MinDate = MIN(a.Date)
	FROM
	Docs a
	WHERE DocTypeID = 0 AND a.PlaceID = @PlaceID AND ShiftID = @ShiftID
	AND a.Date BETWEEN @BeginDate AND @EndDate

	SELECT a.ProductID, b.[1CCharacteristicID], b.[1CNomenclatureID], b.NomenclatureName, b.ProductionQuantity AS Weight,
		b.Number, b.DocID
	FROM
	(
		SELECT b.ProductID
		FROM
		Docs a
		JOIN
		DocProductionProducts b ON a.DocID = b.DocID
		WHERE DocTypeID = 0 AND a.PlaceID = @PlaceID AND ShiftID = @ShiftID 
		AND a.Date BETWEEN @BeginDate AND @EndDate
		UNION ALL
		SELECT a.ProductID
		FROM
		Products a
		JOIN
		DocProductionProducts b ON a.PRoductID = b.ProductID
		JOIN
		Docs c ON b.DocID = c.DocID
		WHERE NOT EXISTS (SELECT * FROM DocCloseShiftProducts cp WHERE cp.ProductID = a.ProductID)
		AND c.Date < @MinDate AND c.PlaceID = @PlaceID
	) a
	JOIN
	vProductsInfo b ON a.ProductID = b.ProductID
	WHERE b.ProductionQuantity > 0.01
	

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftRwSpools] TO [PalletRepacker]
    AS [dbo];

