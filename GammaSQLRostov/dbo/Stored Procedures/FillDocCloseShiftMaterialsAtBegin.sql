


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--exec [dbo].[FillDocCloseShiftMaterialsAtBegin] @PlaceID=1,@ShiftID=2,@CloseDate='20190511 19:39:18.383'

CREATE PROCEDURE [dbo].[FillDocCloseShiftMaterialsAtBegin] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @ShiftID int, @CloseDate DateTime
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DocID uniqueidentifier = (SELECT TOP(1) c.DocID FROM Docs c WHERE c.DocTypeID = 3 AND c.PlaceID = @PlaceID AND c.Date < @CloseDate ORDER BY c.Date DESC)

	SELECT b.[1CNomenclatureID] AS NomenclatureID, b.[1CCharacteristicID] AS CharacteristicID, ISNULL(b.WithdrawByFact,1) AS WithdrawByFact, m.[1CMeasureUnitID] AS MeasureUnitID,
		m.Name MeasureUnit, b.Quantity + ISNULL((SELECT ROUND(SUM(r.Quantity)/1000,3) AS QuantityUnwinderSpool FROM DocCloseShiftRemainders r JOIN vProductsBaseInfo i ON r.ProductID = i.ProductID WHERE r.DocID = @DocID AND r.RemainderTypeID IS NULL AND i.[1CCharacteristicID] IS NOT NULL AND i.[1CCharacteristicID] = b.[1CCharacteristicID]),0) AS Quantity, d.Name + ' ' + ISNULL(c.Name,'') AS NomenclatureName
	FROM
		DocCloseShiftMaterials b
		JOIN
			[1CNomenclature] d ON b.[1CNomenclatureID] = d.[1CNomenclatureID]
		LEFT JOIN
			[1CCharacteristics] c ON b.[1CCharacteristicID] = c.[1CCharacteristicID]
		LEFT JOIN 
			[1CMeasureUnits] m ON (b.[1CMeasureUnitID] IS NOT NULL AND m.[1CMeasureUnitID] = b.[1CMeasureUnitID]) OR (b.[1CMeasureUnitID] IS NULL AND m.[1CMeasureUnitQualifierID] = d.[1CBaseMeasureUnitQualifier] AND m.[1CNomenclatureID] = d.[1CNomenclatureID])
	WHERE b.DocCloseShiftMaterialTypeID = 3 AND b.DocID = @DocID
	GROUP BY 
		b.[1CNomenclatureID], b.[1CCharacteristicID], m.[1CMeasureUnitID],
		m.Name, b.Quantity, d.Name + ' ' + ISNULL(c.Name,''), ISNULL(b.WithdrawByFact,1)

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [PalletRepacker]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftMaterialsAtBegin] TO [Wrapper]
    AS [dbo];

