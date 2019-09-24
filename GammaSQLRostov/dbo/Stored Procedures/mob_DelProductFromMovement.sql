
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[mob_DelProductFromMovement] '4DA01BB0-BC46-E811-9F91-28565A070C02', '2180213110500001', 2
CREATE PROCEDURE [dbo].[mob_DelProductFromMovement] 
	-- Add the parameters for the stored procedure here
	(
		@DocMovementID uniqueidentifier,
		@Barcode varchar(20), -- ШК или номер
		@DocDirection int -- 0 - in, 1 - out, 2 - outin
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductID uniqueidentifier, @ResultMessage nvarchar(1000), @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier
		, @Quantity decimal(15,3), @DocID uniqueidentifier, @AlreadyRemoved bit, @IsConfirmed bit, @InPlaceZoneID uniqueidentifier, @InPlaceZoneName varchar(200)
	DECLARE @DocIds table(DocID uniqueidentifier)
	
	SELECT @ProductID = ProductID 
	FROM
	Products 
	WHERE Barcode = @Barcode OR Number = @Barcode

	IF @ProductID IS NULL
	BEGIN
		SET @ResultMessage = 'Продукт с данным шк не найден в базе'
	END
	ELSE
	BEGIN
		SELECT TOP 1 @DocID = a.DocID, @IsConfirmed = ISNULL(d.IsConfirmed,0), @InPlaceZoneID = b.PlaceZoneID, @InPlaceZoneName = b_p.[Name]
		FROM 
		DocMovement a
		LEFT JOIN
		DocInProducts b ON a.DocID = b.DocID AND b.ProductID = @ProductID AND @DocDirection IN (0,2)
		LEFT JOIN 
		PlaceZones b_p ON b.PlaceZoneID = b_p.PlaceZoneID
		LEFT JOIN
		DocOutProducts c ON a.DocID = c.DocID AND c.ProductID = @ProductID AND @DocDirection = 1
		JOIN
		Docs d ON a.DocID = d.DocID 
		WHERE 
		a.DocID = @DocMovementID AND (b.DocID IS NOT NULL OR c.DocID IS NOT NULL)

		IF @DocID IS NULL
		BEGIN
			SET @AlreadyRemoved = 1			
		END
		ELSE IF @IsConfirmed = 0
		BEGIN
			IF @DocDirection IN (0,2)
				DELETE FROM DocInProducts WHERE DocID = @DocMovementID AND ProductID = @ProductID
			IF @DocDirection IN (1,2)
				DELETE FROM DocOutProducts WHERE DocID = @DocMovementID AND ProductID = @ProductID
		END		
	END

	IF @ResultMessage = '' OR @ResultMessage IS NULL
	BEGIN
		SELECT a.NomenclatureID, a.CharacteristicID, a.Quantity, a.ResultMessage, a.AlreadyRemoved, a.ProductID, a.IsConfirmed,
				c.Name + ' ' + d.Name AS NomenclatureName, 
				ISNULL(@InPlaceZoneName+'#','') + b.ShortNomenclatureName AS ShortNomenclatureName, a.QualityID, @InPlaceZoneID AS PlaceZoneID, a.ProductKindID
			FROM
			(
			SELECT	CASE
					WHEN a.ProductKindID = 0 THEN d.[1CNomenclatureID]
					WHEN a.ProductKindID = 1 THEN c.[1CNomenclatureID]
					WHEN a.ProductKindID = 2 THEN b.[1CNomenclatureID]
				END AS NomenclatureID,
				CASE
					WHEN a.ProductKindID = 0 THEN d.[1CCharacteristicID]
					WHEN a.ProductKindID = 1 THEN c.[1CCharacteristicID]
					WHEN a.ProductKindID = 2 THEN b.[1CCharacteristicID]
				END AS CharacteristicID,
				CASE
					WHEN a.ProductKindID = 0 THEN dbo.CalculateSpoolWeightBeforeDate(a.ProductID, getdate())
					WHEN a.ProductKindID = 1 THEN c.Quantity
					WHEN a.ProductKindID = 2 THEN b.Weight
				END AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyRemoved,0) AS AlreadyRemoved, a.ProductID, @IsConfirmed AS IsConfirmed
				, f.[1CQualityID] AS QualityID, a.ProductKindID
				FROM
				Products a
				LEFT JOIN
				ProductGroupPacks b ON a.ProductID = b.ProductID
				LEFT JOIN
				ProductItems c ON a.ProductID = c.ProductID
				LEFT JOIN
				ProductSpools d ON a.ProductID = d.ProductID
				LEFT JOIN 
				dbo.vProductsCurrentStateInfo f ON a.ProductID = f.ProductID
				WHERE a.ProductID = @ProductID
				) a
			JOIN
			vShortNomenclatureName b ON a.[NomenclatureID] = b.[1CNomenclatureID] AND a.[CharacteristicID] = b.[1CCharacteristicID]
			JOIN
			[1CNomenclature] c ON a.[NomenclatureID] = c.[1CNomenclatureID]
			JOIN
			[1CCharacteristics] d ON a.[CharacteristicID] = d.[1CCharacteristicID]
	END
	ELSE
	BEGIN
		SELECT NULL AS NomenclatureID, NULL AS CharacteristicID, NULL AS Quantity, @ResultMessage AS ResultMessage
		, ISNULL(@AlreadyRemoved,0) AS AlreadyRemoved, @ProductID AS ProductID, @IsConfirmed AS IsConfirmed, NULL AS NomenclatureName, 
				NULL AS ShortNomenclatureName, NULL AS QualityID, NULL AS PlaceZoneID, NULL AS ProductKindID
	END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromMovement] TO [PalletRepacker]
    AS [dbo];

