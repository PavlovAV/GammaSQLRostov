
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Инвентаризация продукта
-- =============================================
CREATE PROCEDURE [dbo].[mob_AddProductToInventarisation] 
	-- Add the parameters for the stored procedure here
	(
		@DocInventarisationID uniqueidentifier,
		@Barcode varchar(50) -- шк или номер
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductID uniqueidentifier, @ResultMessage varchar(500), @AlreadyAdded bit

	SET @ResultMessage = '';
	SET @AlreadyAdded = 0;
	IF EXISTS 
		(
			SELECT * FROM
			DocInventarisationProducts a
			LEFT JOIN			
			Products b ON a.ProductID = b.ProductID
			WHERE a.DocID = @DocInventarisationID AND 
			(
				a.Barcode = @Barcode
				OR
				b.Barcode = @Barcode OR b.Number = @Barcode
			)
		)
	BEGIN
		SET @ResultMessage = 'Данный продукт уже проинвентаризован';
		SET @AlreadyAdded = 1;
	END

	IF (@ResultMessage = '' AND @AlreadyAdded = 0)
	BEGIN
		SELECT @ProductID = ProductID, @Barcode = ISNULL(Barcode, @Barcode)
		FROM
		Products
		WHERE
		Barcode = @Barcode OR Number = @Barcode

		INSERT INTO DocInventarisationProducts (DocID, Barcode, ProductID)
		VALUES (@DocInventarisationID, @Barcode, @ProductID)
	END
	
	IF (@ProductID IS NOT NULL)
	BEGIN
		SELECT @ResultMessage AS ResultMessage, @AlreadyAdded AS AlreadyAdded, b.[1CNomenclatureID] AS NomenclatureID, 
			b.[1CCharacteristicID] AS CharacteristicID, b.[1CQualityID] AS QualityID, b.ProductID,
			b.Quantity, b.NomenclatureName, b.ShortNomenclatureName
		FROM
		(SELECT @ResultMessage AS ResultMessage, @AlreadyAdded AS AlreadyAdded) a, 
		(SELECT [1CNomenclatureID], [1CCharacteristicID], [1CQualityID], ProductID,
			Quantity, NomenclatureName, ShortNomenclatureName FROM vProductsInfo
			WHERE ProductID = @ProductID) b
	END
	ELSE
	BEGIN
		SELECT @ResultMessage AS ResultMessage, @AlreadyAdded AS AlreadyAdded, NULL AS NomenclatureID, 
			NULL AS CharacteristicID, NULL AS QualityID, NULL AS ProductID, NULL AS Quantity, NULL AS NomenclatureName, NULL AS ShortNomenclatureName
	END
	

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToInventarisation] TO [PalletRepacker]
    AS [dbo];

