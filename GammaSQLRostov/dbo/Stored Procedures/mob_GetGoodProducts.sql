
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
--exec dbo.mob_GetGoodProducts @DocOrderID='4BBB09B2-A4F0-11E6-BE75-002590EBA5B7',@NomenclatureID='5FE4B6AC-E8BB-11E3-B85D-002590304E93',@CharacteristicID='151CC4A4-E8C2-11E3-B85D-002590304E93',@QualityID='D05404A0-6BCE-449B-A798-41EBE5E5B977',@IsOutDoc=1
CREATE PROCEDURE [dbo].[mob_GetGoodProducts] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderId uniqueidentifier,
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier,
		@IsOutDoc bit
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	IF CAST(@CharacteristicID AS varchar(100)) = '00000000-0000-0000-0000-000000000000'
		SET @CharacteristicID = NULL
	SELECT a.Number, 
	--CASE WHEN a.QuantityPackage IS NOT NULL AND b.ProductID IS NULL THEN a.QuantityPackage ELSE a.Quantity END AS Quantity
	a.Quantity
	--,CAST(100*[dbo].[GetSpoolsFieldsForProduct](a.ProductID, 3)/[dbo].[GetSpoolsFieldsForProduct](a.ProductID, 2) AS DECIMAL(10,2)) AS SpoolWithBreakPercent
	,CASE WHEN b.ProductID IS NULL THEN NULL ELSE CAST(100*CASE WHEN b.CountProductSpools = 0 THEN NULL ELSE b.CountProductSpoolsWithBreak/CASE WHEN b.CountProductSpools = 0 THEN 1 ELSE b.CountProductSpools END END AS DECIMAL(10,2)) END AS SpoolWithBreakPercent
	,CASE WHEN b.ProductID IS NULL THEN '' ELSE CAST(ISNULL(b.CountProductSpoolsWithBreak,0) AS varchar(10)) + ' из ' + CAST(ISNULL(b.CountProductSpools,0) AS varchar(10)) END AS SpoolWithBreak
	,CASE WHEN a.ProductKindID = 3 THEN 1 ELSE 0 END AS IsProductR --россыпь
	--,a.CoefficientPackage
	--, a.QuantityPackage --количество групповых упаковок
	FROM
	vDocMovementProducts a
	LEFT JOIN vSpoolsForProduct b ON a.ProductID = b.ProductID
	WHERE
	((@IsOutDoc = 0 AND a.IsAccepted = 1) OR (@IsOutDoc = 1 AND a.IsShipped = 1))
	AND
	DocOrderID = @DocOrderId
	AND
	[1CNomenclatureID] = @NomenclatureID
	AND
	([1CCharacteristicID] = @CharacteristicID OR ([1CCharacteristicID] IS NULL AND @CharacteristicID IS NULL))
	AND
	(([1CQualityID] = @QualityID AND @QualityID IS NOT NULL) OR ([1CQualityID] IS NULL AND @QualityID IS NULL))

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetGoodProducts] TO [PalletRepacker]
    AS [dbo];

