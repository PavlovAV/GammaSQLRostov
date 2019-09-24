


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSpoolsFieldsForProduct]
(
	@ProductID uniqueidentifier,
	@FieldId smallint
)
RETURNS tinyint
AS
BEGIN
	DECLARE @Result tinyint = NULL

	SELECT 
		@Result = ISNULL(Result,0)
	FROM
		(
		SELECT CASE @FieldId
			WHEN 1 THEN BreakNumber
			WHEN 2 THEN 1
			WHEN 3 THEN CASE WHEN BreakNumber > 0 THEN 1 ELSE 0 END
			END AS Result
		FROM 
			ProductSpools p
		WHERE
			p.ProductID = @ProductID
		UNION
		SELECT CASE @FieldId
			WHEN 1 THEN SUM(BreakNumber)
			WHEN 2 THEN COUNT(*)
			WHEN 3 THEN SUM(CASE WHEN BreakNumber > 0 THEN 1 ELSE 0 END)
			END AS Result
		FROM
			(
			SELECT 
			p.ProductID, p.BreakNumber
			FROM 
				ProductGroupPacks g
				JOIN DocProductionProducts pp ON g.ProductID = pp.ProductID
				JOIN DocProductionWithdrawals w ON pp.DocID = w.DocProductionID
				JOIN DocWithdrawalProducts wp ON w.DocWithdrawalID = wp.DocID
				JOIN ProductSpools p ON wp.ProductID = p.ProductID
			WHERE
				g.ProductID = @ProductID
			GROUP BY 
				p.ProductID, p.BreakNumber
			) a 
		) p
	RETURN @Result
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolsFieldsForProduct] TO [PalletRepacker]
    AS [dbo];

