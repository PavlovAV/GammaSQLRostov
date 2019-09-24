-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetShortNomenclatureName]
(
	@NomenclatureID uniqueidentifier,
	@CharacteristicID uniqueidentifier
)
RETURNS varchar(1000)
--WITH SCHEMABINDING
AS
BEGIN
	DECLARE @Result varchar(1000)
	
	SELECT @Result = 
	CASE 
		WHEN EXISTS 
			(
				SELECT a.[1CNomenclatureID] FROM 
				dbo.PlaceGroup1CNomenclature a
				JOIN
				dbo.[1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CParentID]
				WHERE b.[1CNomenclatureID] = @NomenclatureID AND PlaceGroupID IN (0,1,3)
			) THEN
			c.SortValue + ',' + CAST(d.LayerNumberNumeric AS varchar) + 'сл/' + c.Composition + '/' 
			+ CONVERT(varchar(20), CONVERT(float, c.BasisWeightNumeric), 128) + 'г/' + CAST(d.FormatNumeric AS varchar) + '/'
			+ d.Color
		ELSE
			a.Name + ' ' + b.Name
	END
	FROM
	dbo.[1CNomenclature] a
	JOIN
	dbo.[1CCharacteristics] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
	LEFT JOIN	
	dbo.vNomenclatureSGBProperties c ON a.[1CNomenclatureID] = c.[1CNomenclatureID]
	LEFT JOIN
	dbo.vCharacteristicSGBProperties d ON b.[1CCharacteristicID] = d.[1CCharacteristicID]
	WHERE
	a.[1CNomenclatureID] = @NomenclatureID AND b.[1CCharacteristicID] = @CharacteristicID

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShortNomenclatureName] TO [PalletRepacker]
    AS [dbo];

