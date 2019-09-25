


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Получение информации по продукции
-- =============================================
--EXEC [mob_GetNomenclatureCharacteristicQualityFromBarcode]  '55530000120125'
CREATE PROCEDURE [dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] 
	-- Add the parameters for the stored procedure here
	(
		@BarCode varchar(100)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	--DECLARE @name varchar(500) = NULL
	SELECT 
		d.[1CNomenclatureID],e.[1CCharacteristicID],q.[1CQualityID],
		--d.Name + ISNULL(CHAR(13) + e.Name,'')+ ISNULL(CHAR(13) + q.[Description],'') AS [Name],
		d.Name + ISNULL('; ' + e.Name,'')+ ISNULL('; ' + q.[Description],'') AS [Name],
		a.Barcode
	FROM
		[1CBarcodes] a 
		JOIN dbo.[1CNomenclature] d ON a.[1CNomenclatureID] = d.[1CNomenclatureID]
		LEFT JOIN dbo.[1CCharacteristics] e ON (a.[1CCharacteristicID] IS NULL AND a.[1CNomenclatureID] = e.[1CNomenclatureID]) OR (a.[1CCharacteristicID] IS NOT NULL AND e.[1CCharacteristicID] = a.[1CCharacteristicID])
		LEFT JOIN [1CQuality] q ON a.[1CQualityID] = q.[1CQualityID]
	WHERE 
		LEN(@Barcode)>4 AND (a.Barcode = @BarCode OR Barcode = LEFT(@Barcode,CASE WHEN LEN(@Barcode) = 0 THEN 0 ELSE LEN(@Barcode)-1 END) OR (LEN(Barcode) = 14 AND LEN(@Barcode) = 14 AND LEN(Barcode) = 14 AND LEN(@Barcode) = 14 AND LEFT(Barcode,LEN(@Barcode)-4) = LEFT(@Barcode,CASE WHEN LEN(@Barcode) = 0 THEN 0 ELSE LEN(@Barcode)-4 END)) OR (LEN(Barcode) = 13 AND LEN(@Barcode) = 14 AND LEFT(@Barcode,1) = '0' AND Barcode = RIGHT(@Barcode,CASE WHEN LEN(@Barcode) = 0 THEN 0 ELSE LEN(@Barcode)-1 END)))
	--RETURN @Name
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetNomenclatureCharacteristicQualityFromBarcode] TO [PalletRepacker]
    AS [dbo];

