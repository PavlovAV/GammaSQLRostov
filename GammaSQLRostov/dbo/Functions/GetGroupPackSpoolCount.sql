-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetGroupPackSpoolCount]
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

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetGroupPackSpoolCount] TO [PalletRepacker]
    AS [dbo];

