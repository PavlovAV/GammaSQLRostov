
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetActiveSourceSpools] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID integer
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
SELECT a.SpoolID FROM
(
SELECT Unwinder1Spool AS SpoolID, Unwinder1Active AS IsActive
FROM SourceSpools
WHERE PlaceID = @PlaceID
UNION ALL
SELECT Unwinder2Spool AS SpoolID, Unwinder2Active AS IsActive
FROM SourceSpools
WHERE PlaceID = @PlaceID
UNION ALL
SELECT Unwinder3Spool AS SpoolID, Unwinder3Active AS IsActive
FROM SourceSpools
WHERE PlaceID = @PlaceID
UNION ALL
SELECT Unwinder4Spool AS SpoolID, Unwinder4Active AS IsActive
FROM SourceSpools
WHERE PlaceID = @PlaceID
) a
WHERE a.IsActive = 1


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetActiveSourceSpools] TO [PalletRepacker]
    AS [dbo];

