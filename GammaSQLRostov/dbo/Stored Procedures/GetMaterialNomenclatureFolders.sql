-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetMaterialNomenclatureFolders] 
	-- Add the parameters for the stored procedure here
	(
		@MaterialTypeID int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.[1CNomenclatureID] AS FolderID, a.Name, a.[1CParentID] AS ParentID
	FROM [1CNomenclature] a
	JOIN
	MaterialTypeNomenclature b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
	WHERE
	a.IsFolder = 1 AND b.MaterialTypeID = @MaterialTypeID

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetMaterialNomenclatureFolders] TO [PalletRepacker]
    AS [dbo];

