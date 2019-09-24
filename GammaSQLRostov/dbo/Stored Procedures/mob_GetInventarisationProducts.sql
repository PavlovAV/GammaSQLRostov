


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Получение списка продуктов инвентаризации
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetInventarisationProducts]
	-- Add the parameters for the stored procedure here
	(
		@DocInventarisationID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], n.Name + ' ' + ISNULL(c.Name,'')  + ISNULL(Char(13) + 'Качество - '+e.Description,'') AS NomenclatureName, i.ShortNomenclatureName + ISNULL(Char(13) + '; '+e.Description,'') AS ShortNomenclatureName, SUM(a.Quantity) AS Quantity
	FROM
	DocInventarisationProducts a
	--JOIN
	--vProductsInfo b ON a.ProductID = b.ProductID
	LEFT JOIN
	[1CNomenclature] n ON a.[1CNomenclatureID] = n.[1CNomenclatureID]
	LEFT JOIN
	[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
	LEFT JOIN
	dbo.vShortNomenclatureName i ON i.[1CNomenclatureID] = a.[1CNomenclatureID] AND i.[1CCharacteristicID] = a.[1CCharacteristicID]
	LEFT JOIN
	[1CQuality] e ON (a.[1CQualityID] = e.[1CQualityID] AND a.[1CQualityID] IS NOT NULL) OR (e.[1CQualityID] = 'D05404A0-6BCE-449B-A798-41EBE5E5B977' AND a.[1CQualityID] IS NULL) --или совпадает, или не указан, значит Годный
	WHERE a.DocID = @DocInventarisationID
	GROUP BY a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], n.Name + ' ' + ISNULL(c.Name,'')   + ISNULL(Char(13) + 'Качество - '+e.Description,''), i.ShortNomenclatureName  + ISNULL(Char(13) + '; '+e.Description,'')
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationProducts] TO [PalletRepacker]
    AS [dbo];

