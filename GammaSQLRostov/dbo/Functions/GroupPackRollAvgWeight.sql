
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GroupPackRollAvgWeight]
(
	@ProductID uniqueidentifier
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
	
	SELECT @Result = (a.Weight/Count(*))
	FROM 
	ProductGroupPacks a
	JOIN
	DocProductionProducts b ON a.ProductID = b.ProductID
	JOIN
	DocProduction c ON b.DocID = c.DocID
	JOIN
	DocProductionWithdrawals d ON c.DocID = d.DocProductionID
	JOIN
	DocWithdrawalProducts e ON e.DocID = d.DocWithdrawalID
	JOIN
	ProductSpools f ON e.ProductID = f.ProductID
	WHERE
	a.ProductID = @ProductID AND f.Weight < 10
	GROUP BY a.Weight

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GroupPackRollAvgWeight] TO [PalletRepacker]
    AS [dbo];

