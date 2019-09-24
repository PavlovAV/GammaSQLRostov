-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetNomenclatureShortName]
(
	@NomenclatureID uniqueidentifier,
	@CharacteristicID uniqueidentifier = null
)
RETURNS varchar(8000)
AS
BEGIN
	DECLARE @Result varchar(8000)
	
	SELECT TOP 1 @Result = CASE
	WHEN 
		EXISTS
		(
			SELECT *
			FROM
			[1CNomenclature] n
			JOIN
			PlaceGroup1CNomenclature b ON n.[1CParentID] = b.[1CNomenclatureID]
			WHERE n.[1CNomenclatureID] = @NomenclatureID AND b.PlaceGroupID IN (0,1,3)
		)
	THEN a.SortValue + ',' + CAST(b.LayerNumberNumeric AS varchar) + 'сл/' + a.Composition + '/' 
		+ CONVERT(varchar(20), CONVERT(float, a.BasisWeightNumeric), 128) + 'г/' + char(13) + Char(10) + CAST(b.FormatNumeric AS varchar) + '/'
		+ b.Color
	ELSE c.Name + ' ' + d.Name
	END
	FROM
	vNomenclatureSGBProperties a, vCharacteristicSGBProperties b, [1CNomenclature] c, [1CCharacteristics] d 
	WHERE a.[1CNomenclatureID] = @NomenclatureID AND b.[1CCharacteristicID] = @CharacteristicID
	AND c.[1CNomenclatureID] = @NomenclatureID AND d.[1CCharacteristicID] = @CharacteristicID

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureShortName] TO [PalletRepacker]
    AS [dbo];

