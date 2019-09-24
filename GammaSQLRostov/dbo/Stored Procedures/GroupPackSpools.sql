-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GroupPackSpools]
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
	dbo.CalculateSpoolWeightBeforeDate(g.ProductID, h.Date)*1000 AS Quantity, g.Date, g.PlaceID
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
    ON OBJECT::[dbo].[GroupPackSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackSpools] TO [PalletRepacker]
    AS [dbo];

