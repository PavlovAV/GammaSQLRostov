
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetGroupPackDiameter]
(
	@ProductID uniqueidentifier
)
RETURNS int
AS
BEGIN
	DECLARE @Result decimal(18,5)
	
	SELECT @Result = MAX(g.Diameter)
	FROM
	ProductGroupPacks a
	JOIN
	DocProductionProducts b ON a.ProductID = b.ProductID
	JOIN
	DocProduction c ON b.DocID = c.DocID
	JOIN
	DocProductionWithdrawals d ON c.DocID = d.DocProductionID
	JOIN
	DocWithdrawal e ON e.DocID = d.DocWithdrawalID
	JOIN
	DocWithdrawalProducts f ON f.DocID = e.DocID
	JOIN
	ProductSpools g ON g.ProductID = f.ProductID
	WHERE 
	a.ProductID = @ProductID

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackDiameter] TO [PalletRepacker]
    AS [dbo];

