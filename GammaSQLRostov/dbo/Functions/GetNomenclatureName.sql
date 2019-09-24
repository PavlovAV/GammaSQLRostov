-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetNomenclatureName]
(
	@NomenclatureID uniqueidentifier,
	@CharacteristicID uniqueidentifier,
	@QualityID uniqueidentifier
)
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @NomenclatureName VARCHAR(1000)
	
	SELECT @NomenclatureName = b.Name + ' ' + ISNULL(c.Name,'') + ISNULL(', '+d.Description,'')
	FROM
	(SELECT @NomenclatureID AS [1CNomenclatureID],
	@CharacteristicID AS [1CCharacteristicID],
	@QualityID AS [1CQualityID]) a
	JOIN
	[1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
	LEFT JOIN
	[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
	LEFT JOIN
	[1CQuality] d ON a.[1CQualityID] = d.[1CQualityID] AND d.[1CCode] <> '000000001' -- годный не выводим в названии

	RETURN @NomenclatureName

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNomenclatureName] TO [PalletRepacker]
    AS [dbo];

