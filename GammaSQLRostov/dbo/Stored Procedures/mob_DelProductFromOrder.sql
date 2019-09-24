

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_DelProductFromOrder] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderID uniqueidentifier,
		@Barcode varchar(20), -- ШК или номер
		@IsDocOut bit 
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductID uniqueidentifier, @ResultMessage nvarchar(1000), @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier
		, @Quantity decimal(15,3), @DocMovementID uniqueidentifier, @AlreadyRemoved bit
--	DECLARE @DocIds table(DocID uniqueidentifier)
	
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
		IF @IsDocOut = 1
		BEGIN
			SELECT TOP 1 @DocMovementID = a.DocID
			FROM
			DocMovement a
			JOIN
			DocOutProducts b ON a.DocID = b.DocID AND b.ProductID = @ProductID
			WHERE a.DocOrderID = @DocOrderID
		END
		ELSE 
		BEGIN
			SELECT TOP 1 @DocMovementID = a.DocID
			FROM
			DocMovement a
			JOIN
			DocInProducts b ON a.DocID = b.DocID AND b.ProductID = @ProductID
			WHERE a.DocOrderID = @DocOrderID
		END

		IF @DocMovementID IS NULL
		BEGIN
			SET @AlreadyRemoved = 1
		END
		ELSE
		BEGIN
			IF @IsDocOut = 1
			BEGIN
				DELETE DocOutProducts 
				WHERE DocID = @DocMovementID AND ProductID = @ProductID
			END
			ELSE 
			BEGIN
				DELETE DocInProducts
				WHERE DocID = @DocMovementID AND ProductID = @ProductID
			END
		END
	END

	IF @ResultMessage = '' OR @ResultMessage IS NULL
	BEGIN
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
			END AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyRemoved,0) AS AlreadyRemoved, 
			'' AS NomenclatureName, '' AS ShortNomenclatureName, a.Number, a.ProductID
				, e.CountBreak AS BreakNumber --dbo.GetSpoolsFieldsForProduct(a.ProductID,1) AS BreakNumber
				, e.CountProductSpools --dbo.GetSpoolsFieldsForProduct(a.ProductID,2) AS CountProductSpools
				, e.CountProductSpoolsWithBreak --dbo.GetSpoolsFieldsForProduct(a.ProductID,3) AS CountProductSpoolsWithBreak
				, f.[1CQualityID] AS QualityID
			FROM
			Products a
			LEFT JOIN
			ProductGroupPacks b ON a.ProductID = b.ProductID
			LEFT JOIN
			ProductItems c ON a.ProductID = c.ProductID
			LEFT JOIN
			ProductSpools d ON a.ProductID = d.ProductID
			LEFT JOIN 
			vSpoolsForProduct e ON a.ProductID = e.ProductID
			LEFT JOIN 
			dbo.vProductsCurrentStateInfo f ON a.ProductID = f.ProductID
			WHERE a.ProductID = @ProductID
	END
	ELSE
	BEGIN
		SELECT NULL AS NomenclatureID, NULL AS CharacteristicID, NULL AS Quantity, @ResultMessage AS ResultMessage
		, ISNULL(@AlreadyRemoved,0) AS AlreadyRemoved, '' AS NomenclatureName, '' AS ShortNomenclatureName, '' AS Number, @ProductID AS ProductID
		,NULL AS BreakNumber,NULL AS CountProductSpools,NULL AS CountProductSpoolsWithBreak, NULL AS QualityID
	END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelProductFromOrder] TO [PalletRepacker]
    AS [dbo];

