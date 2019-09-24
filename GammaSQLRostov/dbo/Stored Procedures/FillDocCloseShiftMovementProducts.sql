


CREATE PROCEDURE [dbo].[FillDocCloseShiftMovementProducts] 
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
	SELECT c.NomenclatureName,
           c.Number,
           c.ProductID,
           c.Quantity,
           c.ProductKindName,
           c.OrderTypeName,
           c.InPlace,
           c.InPlaceZone,
		   c.InDate,
           c.OutPlace,
           c.OutPlaceZone,
		   c.OutDate,
		   CAST(CASE WHEN c.InPlaceID = @PlaceID THEN 1 ELSE 0 END AS bit) AS IsMovementIn,
		   CAST(CASE WHEN c.OutPlaceID = @PlaceID THEN 1 ELSE 0 END AS bit) AS IsMovementOut,
		   c.DocMovementID,
		   c.[1CNomenclatureID] AS NomenclatureID,
		   c.[1CCharacteristicID] AS CharacteristicID,
		   cc.BaseMeasureUnit AS MeasureUnit,
		   cc.BaseMeasureUnitID AS MeasureUnitID,
		   cc.NomenclatureKindID
		FROM
			vDocMovementProducts c JOIN Docs d ON c.DocMovementID = d.DocID
			LEFT JOIN vProductsInfo cc ON c.ProductID = cc.ProductID
		WHERE
			((c.InPlaceID = @PlaceID AND --d.ShiftID = @ShiftID AND 
			 c.InDate BETWEEN DATEADD(hh, -1, dbo.GetShiftBeginTime(DATEADD(hh, -1, @CloseDate))) 
			 AND DATEADD(hh, 1, dbo.GetShiftEndTime(DATEADD(hh, -1, @CloseDate)))
			)
			OR 
			(c.OutPlaceID = @PlaceID AND --d.ShiftID = @ShiftID AND 
			 c.OutDate BETWEEN DATEADD(hh, -1, dbo.GetShiftBeginTime(DATEADD(hh, -1, @CloseDate))) 
			 AND DATEADD(hh, 1, dbo.GetShiftEndTime(DATEADD(hh, -1, @CloseDate)))
			))
			AND NOT EXISTS
			(
				SELECT aa.DocID FROM DocCloseShiftMovementProducts aa JOIN Docs bb ON aa.DocID = bb.DocID WHERE aa.ProductID = c.ProductID AND bb.PlaceID = PlaceID AND bb.Date < @CloseDate AND (aa.DateMovement = c.InDate OR aa.DateMovement = c.OutDate)
			)

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMovementProducts] TO [PalletRepacker]
    AS [dbo];

