-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetNomenclatureNameForSGB]
(
	@NomenclatureID uniqueidentifier,
	@CharacteristicID uniqueidentifier = null
)
RETURNS varchar(8000)
AS
BEGIN
	DECLARE @Result varchar(8000)
	
	SELECT TOP 1 @Result = 'Бумага-основа ' + a.Purpose + ', ' + a.Composition +', '
		+ a.ColorGroup + ', ' + a.BasisWeight
	FROM
	vNomenclatureSGBProperties a --vCharacteristicSGBProperties a 
	WHERE a.[1CNomenclatureID] = @NomenclatureID --AND b.[1CCharacteristicID] = @CharacteristicID

	RETURN @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureNameForSGB] TO [PalletRepacker]
    AS [dbo];

