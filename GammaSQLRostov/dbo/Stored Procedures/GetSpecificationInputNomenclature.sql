-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Получение входной номенклатуры по спецификации на бумагу ПРС для БДМ
-- =============================================

CREATE PROCEDURE [dbo].[GetSpecificationInputNomenclature] 
	-- Add the parameters for the stored procedure here
	(
		@NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier, @PlaceGroupID int = null
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
    -- Insert statements for procedure here
	WITH InputNomenclature ([1CNomenclatureID], [1CCharacteristicID], NomenclatureName)
	AS
	(
		SELECT DISTINCT b.[1CNomenclatureID], b.[1CCharacteristicID], c.Name AS NomenclatureName
		FROM
		v1CWorkingSpecifications a
		JOIN
		[1CSpecificationInputNomenclature] b ON a.[1CSpecificationID] = b.[1CSpecificationID]
		JOIN
		[1CNomenclature] c ON b.[1CNomenclatureID] = c.[1CNomenclatureID] AND c.[NomenclatureKindID] = 1
		JOIN
		PlaceGroup1CNomenclature d ON @PlaceGroupID IS NULL OR (d.PlaceGroupID = @PlaceGroupID AND d.[1CNomenclatureID] = c.[1CParentID])
		WHERE a.[1CNomenclatureID] = @NomenclatureID AND a.[1CCharacteristicID] = @CharacteristicID
	)
	

	SELECT DISTINCT a.[1CNomenclatureID], a.[1CCharacteristicID], a.NomenclatureName, a.CharacteristicName
	FROM
	(
		SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], NomenclatureName, b.Name AS CharacteristicName
		FROM
		InputNomenclature a
		JOIN
		[1CCharacteristics] b ON a.[1CCharacteristicID] = b.[1CCharacteristicID]
		UNION
		SELECT c.[1CNomenclatureAnalogID] AS [1CNomenclatureID], c.[1CCharacteristicAnalogID] AS [1CCharacteristicID], e.Name AS NomenclatureName, d.Name AS CharacteristicName
		FROM
		InputNomenclature a
		JOIN
		[1CNomenclatureAnalogs] c ON a.[1CNomenclatureID] = c.[1CNomenclatureID] AND a.[1CCharacteristicID] = c.[1CCharacteristicID]
									AND c.[1CCharacteristicAnalogID] IS NOT NULL
		JOIN
		[1CCharacteristics] d ON c.[1CCharacteristicAnalogID] = d.[1CCharacteristicID]
		JOIN
		[1CNomenclature] e ON e.[1CNomenclatureID] = c.[1CNomenclatureAnalogID]
		UNION
		SELECT a.[1CNomenclatureID], b.[1CCharacteristicID], a.NomenclatureName, b.Name AS CharacteristicName
		FROM
		InputNomenclature a
		LEFT JOIN
		[1CCharacteristics] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
		LEFT JOIN
		(
			SELECT [1CNomenclatureID], [1CCharacteristicID]
			FROM InputNomenclature WHERE [1CNomenclatureID] IS NOT NULL AND [1CCharacteristicID] IS NOT NULL
		) c ON a.[1CNomenclatureID] = c.[1CNomenclatureID] AND c.[1CCharacteristicID] = b.[1CCharacteristicID]
		WHERE a.[1CCharacteristicID] IS NULL AND c.[1CNomenclatureID] IS NULL
		UNION
		SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.NomenclatureName, b.Name AS CharacteristicName
		FROM
		InputNomenclature a
		LEFT JOIN
		[1CCharacteristics] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
		WHERE a.[1CCharacteristicID] IS NULL
	) a
	JOIN
	vCharacteristicSGBProperties b ON a.[1CCharacteristicID] = b.[1CCharacteristicID]
	WHERE a.[1CNomenclatureID] IS NOT NULL AND a.[1CCharacteristicID] IS NOT NULL
	AND b.CoreDiameter IS NOT NULL AND b.Format IS NOT NULL --AND b.LayerNumberNumeric = 1
/*	
	SELECT DISTINCT * FROM
	(
		SELECT [1CNomenclatureID], Name
		FROM 
		InputNomenclature
		UNION ALL
		SELECT b.[1CNomenclatureAnalogID] AS [1CNomenclatureID], c.Name
		FROM InputNomenclature a
		JOIN
		[1CNomenclatureAnalogs] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND
			((a.[1CCharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL) OR (a.[1CCharacteristicID] = b.[1CCharacteristicID]))
		JOIN
		[1CNomenclature] c ON b.[1CNomenclatureAnalogID] = c.[1CNomenclatureID] 
	) a
*/

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationInputNomenclature] TO [PalletRepacker]
    AS [dbo];

