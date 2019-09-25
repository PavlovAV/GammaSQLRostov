



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[mob_RemoveProductRFromInventarisation] 
	-- Add the parameters for the stored procedure here
	(
		@DocInventarisationId uniqueidentifier,
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
			DocInventarisationProducts dpp 
			JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
			JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
			JOIN [1CCharacteristics] h ON h.[1CCharacteristicID] = [pi].[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON h.[MeasureUnitPackage] = f.[1CMeasureUnitID]
		WHERE dpp.DocID = @DocInventarisationID AND p.ProductKindID = 3 AND p.[1CNomenclatureID] = @NomenclatureID 
		AND (p.[1CCharacteristicID] = @CharacteristicID OR (p.[1CCharacteristicID] IS NULL AND @CharacteristicID  IS NULL))
		AND (p.[1CQualityID] = @QualityID OR (p.[1CQualityID] IS NULL AND @QualityID IS NULL))
		AND ISNULL(p.IsConfirmed,0) = 0 --если подтвержден - то это неполная паллета со своим штрихкодом на наклеенной этикетке
		AND p.ProductKindID = 3

	UPDATE [dpp]
		SET Quantity = [pi].Quantity
		FROM 
			DocInventarisationProducts dpp 
			JOIN vProductsInfo p ON dpp.ProductID = p.ProductID 
			JOIN ProductItems [pi] ON [pi].ProductID = p.ProductID AND [pi].[1CNomenclatureID] = p.[1CNomenclatureID] AND ([pi].[1CCharacteristicID] = p.[1CCharacteristicID] OR ([pi].[1CCharacteristicID] IS NULL AND p.[1CCharacteristicID] IS NULL))
			JOIN [1CCharacteristics] h ON h.[1CCharacteristicID] = [pi].[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON h.[MeasureUnitPackage] = f.[1CMeasureUnitID]
		WHERE dpp.DocID = @DocInventarisationID AND p.ProductKindID = 3 AND p.[1CNomenclatureID] = @NomenclatureID 
		AND (p.[1CCharacteristicID] = @CharacteristicID OR (p.[1CCharacteristicID] IS NULL AND @CharacteristicID  IS NULL))
		AND (p.[1CQualityID] = @QualityID OR (p.[1CQualityID] IS NULL AND @QualityID IS NULL))
		AND ISNULL(p.IsConfirmed,0) = 0 --если подтвержден - то это неполная паллета со своим штрихкодом на наклеенной этикетке
		AND p.ProductKindID = 3

COMMIT TRAN
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_RemoveProductRFromInventarisation] TO [PalletRepacker]
    AS [dbo];

