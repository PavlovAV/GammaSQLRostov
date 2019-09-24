
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetInventarisationNomenclatureProducts] 
	-- Add the parameters for the stored procedure here
	(
		@DocInventarisationId uniqueidentifier,
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT ISNULL(b.Number, a.Barcode) AS Number, ISNULL(b.Quantity, 0) AS Quantity
	,CASE WHEN b.ProductID IS NULL THEN NULL ELSE CAST(100*CASE WHEN c.CountProductSpools = 0 THEN NULL ELSE c.CountProductSpoolsWithBreak/CASE WHEN c.CountProductSpools = 0 THEN 1 ELSE c.CountProductSpools END END AS DECIMAL(10,2)) END AS SpoolWithBreakPercent
	,CASE WHEN c.ProductID IS NULL THEN '' ELSE CAST(ISNULL(c.CountProductSpoolsWithBreak,0) AS varchar(10)) + ' из ' + CAST(ISNULL(c.CountProductSpools,0) AS varchar(10)) END AS SpoolWithBreak
	,CASE WHEN b.ProductKindID = 3 THEN 1 ELSE 0 END AS IsProductR --россыпь
	
	FROM
	DocInventarisationProducts a
	LEFT JOIN
	vProductsInfo b ON a.ProductID = b.ProductID
	LEFT JOIN vSpoolsForProduct c ON a.ProductID = c.ProductID
	WHERE a.DocID = @DocInventarisationId AND b.[1CNomenclatureID] = @NomenclatureID AND b.[1CCharacteristicID] = @CharacteristicID AND ((b.[1CQualityID] = @QualityID AND @QualityID IS NOT NULL) OR (b.[1CQualityID] IS NULL AND @QualityID IS NULL))

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationNomenclatureProducts] TO [PalletRepacker]
    AS [dbo];

