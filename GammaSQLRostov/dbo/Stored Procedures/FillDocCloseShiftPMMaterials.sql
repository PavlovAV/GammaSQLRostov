

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec [dbo].[FillDocCloseShiftMaterials] @PlaceID=1,@ShiftID=1,@CloseDate='20181121 10:13:03'
CREATE PROCEDURE [dbo].[FillDocCloseShiftPMMaterials] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @ShiftID int, @CloseDate DateTime
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Products TABLE (NomenclatureID uniqueidentifier, CharacteristicID uniqueidentifier, Quantity decimal(15,5), 
	ProductID uniqueidentifier, DocID uniqueidentifier, 
	NomenclatureName varchar(400), Number varchar(50))

	INSERT INTO @Products exec dbo.FillDocCloseShiftPMSpools @PlaceID, @ShiftID, @CloseDate

	SELECT a.NomenclatureID, a.CharacteristicID, a.WithdrawByFact, a.MeasureUnitID,
		a.MeasureUnit, a.Quantity, a.NomenclatureName
	FROM
		vProductionMaterials a
		JOIN @Products b ON a.ProductNomenclatureID = b.NomenclatureID AND a.ProductCharacteristicID = b.CharacteristicID AND a.ProductPlaceID = @PlaceID
	GROUP BY 
		a.NomenclatureID, a.CharacteristicID, a.WithdrawByFact, a.MeasureUnitID,
		a.MeasureUnit, a.Quantity, a.NomenclatureName

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftPMMaterials] TO [PalletRepacker]
    AS [dbo];

