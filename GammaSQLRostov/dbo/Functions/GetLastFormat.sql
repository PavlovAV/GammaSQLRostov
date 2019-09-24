
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetLastFormat]
(
	@PlaceID int
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Format int 
	
	SELECT TOP 1 @Format = ISNULL(a.RealFormat, 0)
	FROM
	ProductSpools a
	JOIN
	DocProductionProducts b ON a.ProductID = b.ProductID
	JOiN
	Docs c ON b.DocID = c.DocID
	WHERE c.PlaceID = @PlaceID AND c.DocTypeID = 0
	ORDER BY c.Date DESC
	

	RETURN ISNULL(@Format, 0)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastFormat] TO [PalletRepacker]
    AS [dbo];

