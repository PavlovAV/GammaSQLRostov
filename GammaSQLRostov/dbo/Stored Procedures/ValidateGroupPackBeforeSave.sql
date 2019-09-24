-- =============================================
-- Author:		<Matvey Polidanov>
-- Create date: <2016-08-24>
-- Description:	Валидация групповой упаковки перед сохранением
-- =============================================

CREATE PROCEDURE [dbo].[ValidateGroupPackBeforeSave] 
	-- Add the parameters for the stored procedure here
	(
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@Diameter Decimal(15,5),
		@Weight Decimal(15,5),
		@CountRolls int,
		@ProductID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Format decimal(15,5), @CoreDiameter decimal(15,5), @Density decimal(15,5), @Result varchar(2000), @WeightDifferenceBetweenPMandWR decimal(15,5)

	SET @Result = ''
	
	SELECT @Format = CAST(dbo.GetCharSpoolFormat(@CharacteristicID) AS Decimal(15,5))/1000, 
		@CoreDiameter = dbo.GetCharSpoolCoreDiameter(@CharacteristicID)

	SELECT @Density = 4000000*@Weight/(3.14*(@Diameter*@Diameter-@CoreDiameter*@CoreDiameter)*@CountRolls*@Format)

	IF @Density > (SELECT TOP 1 MaxDensity FROM vRangeDensity)
	BEGIN
		SET @Result = 'Указанный вес больше максимально возможного для упаковки такого размера';
	END

	IF @Density < (SELECT TOP 1 MinDensity FROM vRangeDensity)
	BEGIN
		SET @Result = 'Указанный вес меньше минимально возможного для упаковки такого размера';
	END
	
	SET @WeightDifferenceBetweenPMandWR = ABS(@Weight - (SELECT a.DecimalWeight*1000 FROM ProductSpools a JOIN DocProductionProducts b ON a.ProductID = b.ProductID JOIN Docs c ON b.DocID = c.DocID WHERE b.ProductID = @ProductID AND c.PlaceID IN (1,2) AND a.DecimalWeight > 0))
	IF @Result = '' AND @CountRolls = 1 AND @ProductID IS NOT NULL AND dbo.GetSettings('MaxAllowedWeightDifferenceBetweenPMandWR') IS NOT NULL AND @WeightDifferenceBetweenPMandWR IS NOT NULL
	  IF @WeightDifferenceBetweenPMandWR > dbo.GetSettings('MaxAllowedWeightDifferenceBetweenPMandWR')
		BEGIN
			SET @Result = 'Указанный вес существенно (на '+CAST(@WeightDifferenceBetweenPMandWR AS varchar(100))+' кг) отличается от веса тамбура на БДМ. Проведите контрольное взвешивание.';
		END

	SELECT @Result

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ValidateGroupPackBeforeSave] TO [PalletRepacker]
    AS [dbo];

