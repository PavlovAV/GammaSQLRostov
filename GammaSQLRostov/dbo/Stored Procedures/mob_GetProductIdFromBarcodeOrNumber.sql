

-- =============================================
-- Author:		<Павлов Александр>
-- Create date: <15.11.2017>
-- Description:	Получение ProductID по ШК или номеру
-- =============================================
--exec mob_GetProductIdFromBarcodeOrNumber @Barcode='2180605210700401'
CREATE PROCEDURE [dbo].[mob_GetProductIdFromBarcodeOrNumber] 
	-- Add the parameters for the stored procedure here
	(
		@Barcode varchar(20) -- ШК или номер
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @ProductID uniqueidentifier, @ProductKindID int, @Count int, @1CNomenclatureID uniqueidentifier, @1CCharacteristicID uniqueidentifier, @1CMeasureUnitID uniqueidentifier, @1CQualityID uniqueidentifier

	--IF (SELECT COUNT(*) FROM Products a WHERE Barcode = @Barcode OR Number = @Barcode) = 1
	--BEGIN
		SELECT @ProductID = ProductID, @ProductKindID = ProductKindID  
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
				SELECT @ProductKindID = ProductKindID  
					FROM
						Products a
					WHERE @ProductID = ProductID

			END
			ELSE
			BEGIN
			IF LEN(@Barcode)>1
				BEGIN
					SELECT @Count = COUNT(*), @1CNomenclatureID = MAX([1CNomenclatureID]), @1CCharacteristicID = MAX([1CCharacteristicID]), @1CMeasureUnitID = MAX([1CMeasureUnitID]), @1CQualityID = MAX([1CQualityID]) 
						FROM [1CBarcodes] WHERE Barcode = @Barcode OR Barcode = LEFT(@Barcode,LEN(@Barcode)-1)
					IF @Count>0
					BEGIN
						SET @ProductKindID = 3
						IF @Count > 1
							SELECT @1CNomenclatureID = NULL, @1CCharacteristicID = NULL, @1CMeasureUnitID = NULL, @1CQualityID = NULL 
					END
				END
			END
		END
	--END

	SELECT @ProductID AS ProductID, @ProductKindID AS ProductKindID, @1CNomenclatureID AS [NomenclatureID], @1CCharacteristicID AS [CharacteristicID], @1CMeasureUnitID AS [MeasureUnitID], @1CQualityID AS [QualityID]

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetProductIdFromBarcodeOrNumber] TO [PalletRepacker]
    AS [dbo];

