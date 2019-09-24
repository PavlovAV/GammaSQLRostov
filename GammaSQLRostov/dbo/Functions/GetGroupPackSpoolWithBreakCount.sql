
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetGroupPackSpoolWithBreakCount]
(
	@ProductID uniqueidentifier
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
	
	SELECT @Result = COUNT(a.ProductID)
	FROM 
	vGroupPackSpools a
	WHERE 
	a.ProductGroupPackID = @ProductID
	AND a.BreakNumber > 0
	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolWithBreakCount] TO [PalletRepacker]
    AS [dbo];

