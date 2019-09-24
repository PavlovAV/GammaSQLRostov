

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Получение информации по продукции
-- =============================================

CREATE PROCEDURE [dbo].[mob_GetInfoProduct] 
	-- Add the parameters for the stored procedure here
	(
		@BarCode varchar(100)
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductID uniqueidentifier
	--RETURN @Name

	SELECT @ProductID = ProductID
		FROM
		Products a
		WHERE Barcode = @Barcode OR Number = @Barcode
		IF @ProductID IS NULL
		BEGIN
			SELECT @ProductID = ProductID
				FROM vProductsFromSykt
				WHERE Barcode = @Barcode OR Number = @Barcode
			IF @ProductID IS NOT NULL
			BEGIN
				EXEC [dbo].[AddProductToRostovFromSykt] @ProductID
			END
		END
		IF @ProductID IS NOT NULL
		
	SELECT 'Номенклатура: ' + p.NomenclatureName 
		+ CHAR(13) + 'Качество: '+q.[Description]
		+ CHAR(13) + 'Состояние: '+p.[State]
		+ CHAR(13) + 'Склад: '+ISNULL(pl.[Name],'нет на остатках') + ISNULL(' ('+pz.[Name]+')','')
		AS [Name]
	FROM
		vProductsInfo p 
		LEFT JOIN [1CQuality] q ON p.[1CQualityID] = q.[1CQualityID]
		LEFT JOIN Rests r ON p.ProductID = r.ProductID
		LEFT JOIN Places pl ON r.PlaceID = pl.PlaceID
		LEFT JOIN PlaceZones pz ON r.PlaceZoneID = pz.PlaceZoneID
	WHERE 
		p.productID = @ProductID

		ELSE
		BEGIN
			SELECT TOP 1 'Номенклатура: ' + n.name + ISNULL(''+c.Name,'') AS [Name] FROM [1CBarcodes] a
				JOIN [1CNomenclature] n ON a.[1CNomenclatureID] = n.[1CNomenclatureID]
				LEFT JOIN [1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
				--LEFT JOIN [1CMeasureUnits] m ON a.[1CMeasureUnitID] = m.[1CMeasureUnitID]
			WHERE a.Barcode = @BarCode
		END
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInfoProduct] TO [PalletRepacker]
    AS [dbo];

