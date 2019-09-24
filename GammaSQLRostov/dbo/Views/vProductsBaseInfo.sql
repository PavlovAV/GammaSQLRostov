



CREATE VIEW [dbo].[vProductsBaseInfo]
--WITH SCHEMABINDING  
AS

	SELECT a.ProductID, a.ProductKindID, a.Number,a.BarCode, 
		b.[1CNomenclatureID],
		b.[1CCharacteristicID],
		b.Quantity,
		b.BaseMeasureUnitQuantity,
		b.GrossQuantity, b.BaseMeasureUnitGrossQuantity
	FROM
	dbo.Products a
	JOIN
	(
		SELECT a.ProductID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.DecimalWeight AS Quantity, 
		a.DecimalWeight AS BaseMeasureUnitQuantity, NULL AS GrossQuantity, NULL AS BaseMeasureUnitGrossQuantity
		FROM
		dbo.ProductSpools a
		UNION ALL
		SELECT a.ProductID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.Weight AS Quantity, 
		a.Weight AS BaseMeasureUnitQuantity, a.GrossWeight AS GrossQuantity, a.GrossWeight AS BaseMeasureUnitGrossQuantity
		FROM
		dbo.ProductGroupPacks a
		UNION ALL
		SELECT a.ProductID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.Quantity AS Quantity, 
		a.Quantity AS BaseMeasureUnitQuantity, NULL AS GrossQuantity, NULL AS BaseMeasureUnitGrossQuantity
		FROM
		dbo.ProductItems a
		UNION ALL
		SELECT a.ProductID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.Weight AS Quantity, 
		a.Weight AS BaseMeasureUnitQuantity, NULL AS GrossQuantity, NULL AS BaseMeasureUnitGrossQuantity
		FROM
		dbo.ProductBales a
	) b ON a.ProductID = b.ProductID
	

GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [Viewer1C]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsBaseInfo] TO [PalletRepacker]
    AS [dbo];

