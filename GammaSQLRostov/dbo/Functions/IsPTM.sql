-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[IsPTM]
(
	@NomenclatureID uniqueidentifier
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bit;

	WITH ParentFolders ([1CParentID], ContainsPTM)
	AS
	(
		SELECT b.[1CParentID], 
		CASE 
			WHEN b.Name LIKE '%ЧТМ%' THEN 1
			ELSE 0
		END AS ContainsPTM
		FROM
		[1CNomenclature] a
		JOIN
		[1CNomenclature] b ON a.[1CParentID] = b.[1CNomenclatureID]
		WHERE a.[1CNomenclatureID] = @NomenclatureID
		UNION ALL
		SELECT a.[1CParentID], 
		CASE
			WHEN a.Name LIKE '%ЧТМ%' THEN 1
			ELSE 0
		END AS ContainsPTM
		FROM
		[1CNomenclature] a
		JOIN
		ParentFolders b ON a.[1CNomenclatureID] = b.[1CParentID]
	)

	SELECT @Result = MAX(ContainsPTM)
	FROM
	ParentFolders

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[IsPTM] TO [PalletRepacker]
    AS [dbo];

