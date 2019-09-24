
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetGroupPackSpools] 
	-- Add the parameters for the stored procedure here
	(
		@DocID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
SELECT g.ProductID, g.DocID, g.[1CNomenclatureID], g.[1CCharacteristicID], g.Number, g.NomenclatureName,
	dbo.CalculateSpoolWeightBeforeDate(g.ProductID, h.Date) AS Weight, g.ProductKindID, g.Date, g.Barcode,
	CASE
		WHEN g.Quantity < 10 THEN g.Quantity*1000
		ELSE g.Quantity
	END AS Quantity, g.Place, g.PlaceID, g.ShiftID, g.StateID, g.ChangeStateQuantity, g.RejectionReason, g.IsConfirmed,
	g.IsWrittenOff, g.State
FROM
DocProductionWithdrawals d
JOIN
DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
JOIN
vProductsInfo g ON f.ProductID = g.ProductID
JOIN
Docs h ON f.DocID = h.DocID
WHERE d.DocProductionID = @DocID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpools] TO [PalletRepacker]
    AS [dbo];

