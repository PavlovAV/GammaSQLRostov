

CREATE VIEW [dbo].[vDocCloseShiftNomenclature]
AS
--Затраты сырья на каждую продукцию
WITH cte_DocCloseShiftNomenclature
AS
	(
	SELECT *
	FROM 
		[vNomenclatureWaste] 
	)
--Сгруппрованные данные по номенклатуре
, cte_Nomenclature
AS
	(
	SELECT 
		DocID, [Date], PlaceName, NomenclatureName, CharacteristicName, Quantity
		, QuantityMaterialCosts  
		--, SUM(QuantityWastePerCharacteristic) AS QuantityWaste
		, SUM(QuantityWaste) AS QuantityWaste
	FROM
		cte_DocCloseShiftNomenclature
	GROUP BY 
		DocID, [Date], PlaceName, NomenclatureName, CharacteristicName, Quantity
		, QuantityMaterialCosts  
	)
--Сгруппированные данные по номенклатуре
SELECT 
	PlaceName
	, [Date]
	, NomenclatureName
	, CharacteristicName
	, SUM(Quantity) AS Quantity
	, SUM(QuantityMaterialCosts) AS QuantityMaterialCosts
	, SUM(QuantityMaterialCosts)/SUM(Quantity) AS QuantityMaterialCostsPerUnitNomenclature 
	, SUM(QuantityWaste) AS QuantityWaste
	, SUM(QuantityWaste)/CAST(SUM(Quantity) AS Numeric(18,10)) AS QuantityWastePerUnitNomenclature 
	, CASE WHEN ISNULL(SUM(QuantityMaterialCosts),0) = 0 THEN NULL ELSE SUM(QuantityWaste)/CASE WHEN ISNULL(SUM(QuantityMaterialCosts),0) = 0 THEN 1 ELSE SUM(QuantityMaterialCosts) END END AS QuantityWastePerUnitMaterialCosts 
FROM
	cte_Nomenclature
GROUP BY 
	 PlaceName
	, [Date]
	, NomenclatureName
	, CharacteristicName





GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocCloseShiftNomenclature] TO [PalletRepacker]
    AS [dbo];

