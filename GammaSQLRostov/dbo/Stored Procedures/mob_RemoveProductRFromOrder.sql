

CREATE PROCEDURE [dbo].[mob_RemoveProductRFromOrder] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderId uniqueidentifier,
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier,
		@Quantity int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	--SET NOCOUNT ON;
	IF @CharacteristicID ='00000000-0000-0000-0000-000000000000'
		SET @CharacteristicID = NULL
	IF @QualityID ='00000000-0000-0000-0000-000000000000'
		SET @QualityID = NULL
BEGIN TRAN
	UPDATE [pi]
		SET Quantity = [pi].Quantity - @Quantity*ISNULL(f.Coefficient,1)
		FROM 
			DocProduction dp 
			JOIN DocProductionProducts dpp ON dp.DocID = dpp.DocID 
			JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
			JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
			JOIN [1CNomenclature] n ON pi.[1CNomenclatureID] = n.[1CNomenclatureID]
			LEFT JOIN [1CCharacteristics] h ON h.[1CCharacteristicID] = [pi].[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON ISNULL(h.[MeasureUnitPackage], n.[1CMeasureUnitSet]) = f.[1CMeasureUnitID]
		WHERE dp.DocOrderId = @DocOrderID AND p.ProductKindID = 3 AND p.[1CNomenclatureID] = @NomenclatureID 
		AND (p.[1CCharacteristicID] = @CharacteristicID OR (p.[1CCharacteristicID] IS NULL AND @CharacteristicID  IS NULL))
		AND
		(p.[1CQualityID] = @QualityID OR (p.[1CQualityID] IS NULL AND @QualityID IS NULL))
		AND ISNULL(p.IsConfirmed,0) = 0 --если подтвержден - то это неполная паллета со своим штрихкодом на наклеенной этикетке
		AND p.ProductKindID = 3
		--((p.[1CQualityID] = @QualityID AND p.[1CQualityID] IS NOT NULL AND ISNULL(@QualityID,'00000000-0000-0000-0000-000000000000') <> '00000000-0000-0000-0000-000000000000') OR (p.[1CQualityID] IS NULL AND ISNULL(@QualityID,'00000000-0000-0000-0000-000000000000') = '00000000-0000-0000-0000-000000000000'))

	UPDATE [dip]
		SET Quantity = [pi].Quantity
		FROM 
			DocProduction dp 
			JOIN DocProductionProducts dpp ON dp.DocID = dpp.DocID 
			JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
			JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
			JOIN [1CNomenclature] n ON pi.[1CNomenclatureID] = n.[1CNomenclatureID]
			JOIN vDocMovementProducts a ON p.ProductID = a.ProductID AND a.DocOrderID = @DocOrderId
			JOIN DocInProducts dip ON dip.DocID = a.DocMovementID AND dip.ProductID = a.ProductID AND dip.PersonID = a.InPersonID
			LEFT JOIN [1CCharacteristics] h ON h.[1CCharacteristicID] = [pi].[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON ISNULL(h.[MeasureUnitPackage], n.[1CMeasureUnitSet]) = f.[1CMeasureUnitID]
		WHERE dp.DocOrderId = @DocOrderID AND p.ProductKindID = 3 AND p.[1CNomenclatureID] = @NomenclatureID 
		AND (p.[1CCharacteristicID] = @CharacteristicID OR (p.[1CCharacteristicID] IS NULL AND @CharacteristicID  IS NULL))
		AND
		(p.[1CQualityID] = @QualityID OR (p.[1CQualityID] IS NULL AND @QualityID IS NULL))
		AND ISNULL(p.IsConfirmed,0) = 0 --если подтвержден - то это неполная паллета со своим штрихкодом на наклеенной этикетке
		AND p.ProductKindID = 3

	UPDATE [dop]
		SET Quantity = [pi].Quantity
		FROM 
			DocProduction dp 
			JOIN DocProductionProducts dpp ON dp.DocID = dpp.DocID 
			JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
			JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
			JOIN [1CNomenclature] n ON pi.[1CNomenclatureID] = n.[1CNomenclatureID]
			JOIN vDocMovementProducts a ON p.ProductID = a.ProductID AND a.DocOrderID = @DocOrderId
			JOIN DocOutProducts dop ON dop.DocID = a.DocMovementID AND dop.ProductID = a.ProductID AND dop.PersonID = a.OutPersonID
			LEFT JOIN [1CCharacteristics] h ON h.[1CCharacteristicID] = [pi].[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON ISNULL(h.[MeasureUnitPackage], n.[1CMeasureUnitSet]) = f.[1CMeasureUnitID]
		WHERE dp.DocOrderId = @DocOrderID AND p.ProductKindID = 3 AND p.[1CNomenclatureID] = @NomenclatureID 
		AND (p.[1CCharacteristicID] = @CharacteristicID OR (p.[1CCharacteristicID] IS NULL AND @CharacteristicID  IS NULL))
		AND
		(p.[1CQualityID] = @QualityID OR (p.[1CQualityID] IS NULL AND @QualityID IS NULL))
		AND ISNULL(p.IsConfirmed,0) = 0 --если подтвержден - то это неполная паллета со своим штрихкодом на наклеенной этикетке
		AND p.ProductKindID = 3

COMMIT TRAN
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromOrder] TO [PalletRepacker]
    AS [dbo];

