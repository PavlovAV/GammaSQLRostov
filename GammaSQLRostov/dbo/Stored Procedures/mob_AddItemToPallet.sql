-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Добавление номенклатуры к паллете
-- =============================================
CREATE PROCEDURE [dbo].[mob_AddItemToPallet] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderId uniqueidentifier,
		@ProductId uniqueidentifier,
		@Barcode varchar(40),
		@Quantity integer -- количество пачек
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ResultMessage varchar(200), @NomenclatureId uniqueidentifier, @CharacteristicId uniqueidentifier,
		@NomenclatureName varchar(200), @ShortNomenclatureName varchar(200), @QuantityRolls integer
    -- Insert statements for procedure here
	IF EXISTS (SELECT * FROM Products WHERE Barcode = @Barcode OR Number = @Barcode) 
	BEGIN
		IF 
		(
			(
				SELECT COUNT(*) 
				FROM
				Products a
				JOIN
				ProductItems b ON a.ProductID = b.ProductID
				WHERE a.BarCode = @Barcode OR a.Number = @Barcode
			) > 1
		)
		BEGIN
			SET @ResultMessage = 'В данной паллете больше, чем 1 номенклатура. Просканируйте ШК конкретной номенклатуры';
		END
		ELSE 
		BEGIN
			SELECT TOP 1 @NomenclatureId = b.[1CNomenclatureID], @CharacteristicId = b.[1CCharacteristicID],
				@NomenclatureName = c.Name + ' ' + d.Name,
				@ShortNomenclatureName = ISNULL(e.ShortNomenclatureName, c.Name + ' ' + d.Name)
			FROM
			Products a
			JOIN
			ProductItems b ON a.ProductID = b.ProductID
			JOIN
			[1CNomenclature] c ON b.[1CNomenclatureID] = c.[1CNomenclatureID]
			JOIN
			[1CCharacteristics] d ON b.[1CCharacteristicID] = d.[1CCharacteristicID]
			LEFT JOIN
			vShortNomenclatureName e ON c.[1CNomenclatureID] = e.[1CNomenclatureID] 
				AND e.[1CCharacteristicID] = d.[1CCharacteristicID]
			WHERE a.Barcode = @Barcode OR a.Number = @Barcode
		END
	END
	ELSE IF EXISTS (SELECT * FROM NomenclatureBarcodes WHERE Barcode = @Barcode)
	BEGIN
		SELECT TOP 1 @NomenclatureId = b.[1CNomenclatureID], @CharacteristicId = c.[1CCharacteristicID],
				@NomenclatureName = b.Name + ' ' + c.Name,
				@ShortNomenclatureName = ISNULL(d.ShortNomenclatureName, b.Name + ' ' + c.Name)
		FROM
		NomenclatureBarcodes a
		JOIN
		[1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
		JOIN
		[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
		LEFT JOIN
		vShortNomenclatureName d ON b.[1CNomenclatureID] = d.[1CNomenclatureID] AND c.[1CCharacteristicID] = d.[1CCharacteristicID]
		WHERE Barcode = @Barcode
	END
	ELSE 
	BEGIN
		SET @ResultMessage = 'Не удалось найти номенклатуру по штрихкоду';
	END

	-- Если ошибок не было, то добавляем к паллете
	IF (@ResultMessage IS NULL OR @ResultMessage = '')
	BEGIN
		SELECT @QuantityRolls = @Quantity*ISNULL(b.Coefficient,0)
		FROM
		[1CCharacteristics] a
		JOIN
		[1CMeasureUnits] b ON a.MeasureUnitPackage = b.[1CMeasureUnitID]
		WHERE a.[1CCharacteristicID] = @CharacteristicId

		IF EXISTS (SELECT * FROM ProductItems WHERE [1CNomenclatureID] = @NomenclatureID
			AND [1CCharacteristicID] = @CharacteristicId AND ProductID = @ProductId)
		BEGIN
			UPDATE ProductItems SET Quantity = Quantity + @QuantityRolls
			WHERE
			[1CNomenclatureID] = @NomenclatureID
			AND [1CCharacteristicID] = @CharacteristicId AND ProductID = @ProductId
		END
		ELSE 
		BEGIN
			INSERT INTO ProductItems (ProductID, [1CNomenclatureID], [1CCharacteristicID], Quantity)
			VALUES (@ProductId, @NomenclatureId, @CharacteristicId, @QuantityRolls)
		END
	END

	SELECT @NomenclatureID AS NomenclatureID, @CharacteristicID AS CharacteristicID, 
		@NomenclatureName AS NomenclatureName, @ShortNomenclatureName AS ShortNomenclatureName,
		@QuantityRolls AS Quantity, ISNULL(@ResultMessage,'') AS ResultMessage
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddItemToPallet] TO [PalletRepacker]
    AS [dbo];

