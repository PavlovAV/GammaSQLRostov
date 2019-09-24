

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetBreakNumberForProduct]
(
	@ProductID uniqueidentifier
)
RETURNS tinyint
AS
BEGIN
	DECLARE @Result tinyint

	SELECT 
		@Result = BreakNumber
	FROM
	(
	SELECT BreakNumber
	FROM 
		ProductSpools p
	WHERE
		p.ProductID = @ProductID
	UNION
	SELECT SUM(BreakNumber) AS BreakNumber
	FROM 
		ProductGroupPacks g
		JOIN DocProductionProducts pp ON g.ProductID = pp.ProductID
		JOIN DocProductionWithdrawals w ON pp.DocID = w.DocProductionID
		JOIN DocWithdrawalProducts wp ON w.DocWithdrawalID = wp.DocID
		JOIN ProductSpools p ON wp.ProductID = p.ProductID
	WHERE
		g.ProductID = @ProductID
	) p
	RETURN @Result
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBreakNumberForProduct] TO [PalletRepacker]
    AS [dbo];

