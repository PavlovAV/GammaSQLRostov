-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetNomenclatureFolders] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceGroupID int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT DISTINCT a.[1CNomenclatureID] AS FolderID, a.Name, a.[1CParentID] AS ParentID
	FROM [1CNomenclature] a
	JOIN
	PlaceGroup1CNomenclature b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
	WHERE
	a.IsFolder = 1 AND (@PlaceGroupID IS NULL OR b.PlaceGroupID = @PlaceGroupID)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureFolders] TO [PalletRepacker]
    AS [dbo];

