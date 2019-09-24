

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Инвентаризация продукта
-- =============================================
CREATE PROCEDURE [dbo].[mob_AddProductIdToInventarisation] 
	-- Add the parameters for the stored procedure here
	(
		@DocInventarisationID uniqueidentifier,
		@ProductID uniqueidentifier,
		@ProductKindID int, 
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier,
		@QuantityRos int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ResultMessage varchar(500), @AlreadyAdded bit
	
	IF CAST(@ProductID AS varchar(100)) = '00000000-0000-0000-0000-000000000000'
		SET @ProductID = NULL

	SET @ResultMessage = '';
	SET @AlreadyAdded = 0;
	
	IF @ProductKindID <> 3 
	BEGIN
		IF @ProductID IS NULL
			BEGIN
				SET @ResultMessage = 'Продукт с данным шк не найден в базе'
				SET @AlreadyAdded = 1;
			END
		--ELSE IF  @ProductKindID <> 3 AND NOT EXISTS 
		--	(SELECT * FROM Rests WHERE ProductID = @ProductID AND Quantity > 0) OR
		--	NOT EXISTS (SELECT * FROM vProductsInfo WHERE ProductID = @ProductID AND Quantity > 0)
		--		SET @ResultMessage = 'Данное изделие не числится на остатках'
	END
	
	IF @ProductID IS NULL AND @ProductKindID <> 3
	BEGIN
		SET @ResultMessage = 'Продукт россыпью в инвентаризации не обрабатывается'
	END
	
	IF EXISTS 
		(
			SELECT * FROM
			DocInventarisationProducts a
			--LEFT JOIN			
			--Products b ON a.ProductID = b.ProductID
			WHERE a.DocID = @DocInventarisationID AND 
			a.ProductID = @ProductID
		)
	BEGIN
		SET @ResultMessage = 'Данный продукт уже проинвентаризован';
		SET @AlreadyAdded = 1;
	END

	IF (@ResultMessage = '' AND @AlreadyAdded = 0)
	BEGIN
		--SELECT @ProductID = ProductID, @Barcode = ISNULL(Barcode, @Barcode)
		--FROM
		--Products
		--WHERE
		--Barcode = @Barcode OR Number = @Barcode

		--INSERT INTO DocInventarisationProducts (DocID, Barcode, ProductID)
		--VALUES (@DocInventarisationID, @Barcode, @ProductID)
		INSERT INTO DocInventarisationProducts (DocID, Barcode, ProductID, [1CNomenclatureID], [1CCharacteristicID], [1CQualityID], Quantity)
		SELECT @DocInventarisationID, Barcode, ProductID, [1CNomenclatureID], [1CCharacteristicID], [1CQualityID], Quantity
			FROM vProductsInfo WHERE ProductID = @ProductID
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
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductIdToInventarisation] TO [PalletRepacker]
    AS [dbo];

