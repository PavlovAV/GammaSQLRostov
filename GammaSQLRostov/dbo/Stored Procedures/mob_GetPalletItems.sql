-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Получение информации о содержании паллеты
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetPalletItems] 
	-- Add the parameters for the stored procedure here
	(
		@ProductId uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT a.[1CNomenclatureID] AS NomenclatureId, a.[1CCharacteristicID] AS CharacteristicId,
		b.Name + ' ' + c.Name AS NomenclatureName, 
		ISNULL(d.ShortNomenclatureName, b.Name + ' ' + c.Name) AS ShortNomenclatureName,
		a.Quantity
	FROM
	ProductItems a
	JOIN
	[1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
	JOIN
	[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
	LEFT JOIN
	vShortNomenclatureName d ON b.[1CNomenclatureID] = d.[1CNomenclatureID] AND c.[1CCharacteristicID] = d.[1CCharacteristicID]
	WHERE a.ProductId = @ProductId
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPalletItems] TO [PalletRepacker]
    AS [dbo];

