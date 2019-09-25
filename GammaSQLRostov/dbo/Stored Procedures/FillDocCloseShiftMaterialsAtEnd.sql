


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec [dbo].[FillDocCloseShiftMaterialsAtBegin] @PlaceID=1,@ShiftID=2,@CloseDate='20190511 19:39:18.383'

CREATE PROCEDURE [dbo].[FillDocCloseShiftMaterialsAtEnd] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @ShiftID int, @CloseDate DateTime
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @PlaceGroupID int
	SELECT @PlaceGroupID = PlaceGroupID FROM Places WHERE PlaceID = @PlaceID

	SELECT b.[1CNomenclatureID] AS NomenclatureID, b.[1CCharacteristicID] AS CharacteristicID, NULL as WithdrawByFact, m.[1CMeasureUnitID] AS MeasureUnitID,
		m.Name AS MeasureUnit, SUM(b.Quantity) AS Quantity, d.Name + ' ' + ISNULL(c.Name,'') AS NomenclatureName
	FROM
		Rests a JOIN vProductsInfo b ON a.ProductID = b.ProductID
		JOIN
			[1CNomenclature] d ON b.[1CNomenclatureID] = d.[1CNomenclatureID]
		LEFT JOIN
			[1CCharacteristics] c ON b.[1CCharacteristicID] = c.[1CCharacteristicID]
		LEFT JOIN 
			[1CMeasureUnits] m ON m.[1CMeasureUnitQualifierID] = d.[1CBaseMeasureUnitQualifier] AND m.[1CNomenclatureID] = d.[1CNomenclatureID]
		JOIN Places p ON a.PlaceID = p.PlaceID
	WHERE 
		a.PlaceID = @PlaceID AND ((@PlaceGroupID = 0 AND 1 = 0) OR (@PlaceGroupID = 1 AND b.ProductKindID = 0 AND NOT EXISTS (SELECT PlaceID FROM SourceSpools t WHERE t.PlaceID = @PlaceID AND (Unwinder1Spool = a.ProductID OR Unwinder2Spool = a.ProductID OR Unwinder3Spool = a.ProductID OR Unwinder4Spool = a.ProductID))) OR (@PlaceGroupID = 3 AND b.ProductKindID = 0) OR (@PlaceGroupID = 2 AND b.ProductKindID IN (0,2) AND NOT EXISTS (SELECT PlaceID FROM SourceSpools t WHERE t.PlaceID = @PlaceID AND (Unwinder1Spool = a.ProductID OR Unwinder2Spool = a.ProductID OR Unwinder3Spool = a.ProductID OR Unwinder4Spool = a.ProductID)))) 
		AND ISNULL(p.PlaceWithdrawalMaterialTypeID,2) = 2 
	GROUP BY 
		b.[1CNomenclatureID], b.[1CCharacteristicID], m.[1CMeasureUnitID],
		m.Name, d.Name + ' ' + ISNULL(c.Name,'')

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [PalletRepacker]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtEnd] TO [Wrapper]
    AS [dbo];

