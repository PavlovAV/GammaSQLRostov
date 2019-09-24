-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FindNomenclatureByStringWithFilter] 
	-- Add the parameters for the stored procedure here
	(
		@SearchString VARCHAR(500),
		@Id INT, -- ID группы переделов или типа материала can be null
		@FilterByPlaceGroup BIT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	 
    -- Insert statements for procedure here
	IF @FilterByPlaceGroup = 1
	BEGIN
		SELECT DISTINCT c.[1CNomenclatureID], c.Name
		FROM
		PlaceGroup1CNomenclature pgc
		JOIN
		[1CNomenclature] c ON pgc.[1CNomenclatureID] = c.[1CParentID]
		WHERE (@Id IS NULL OR pgc.PlaceGroupID = @Id) AND (c.IsFolder = 0 OR c.IsFolder IS NULL) AND (c.IsArchive IS NULL OR c.IsArchive = 0)
		AND c.Name LIKE '%' + @SearchString + '%'
	END
	ELSE
	BEGIN
		SELECT DISTINCT c.[1CNomenclatureID], c.Name
		FROM
		MaterialTypeNomenclature mtn
		JOIN
		[1CNomenclature] c ON mtn.[1CNomenclatureID] = c.[1CParentID]
		WHERE (@Id IS NULL OR mtn.MaterialTypeID = @Id) AND (c.IsFolder = 0 OR c.IsFolder IS NULL) AND (c.IsArchive IS NULL OR c.IsArchive = 0)
		AND c.Name LIKE '%' + @SearchString + '%'
	END


	

	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FindNomenclatureByStringWithFilter] TO [PalletRepacker]
    AS [dbo];

