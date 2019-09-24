
CREATE VIEW [dbo].[vDocShipmentOrders]
AS
SELECT DISTINCT a.*,
CASE
WHEN 
	EXISTS
	(
		SELECT *
		FROM
		[1CNomenclature] n
		JOIN
		PlaceGroup1CNomenclature b ON n.[1CParentID] = b.[1CNomenclatureID]
		WHERE n.[1CNomenclatureID] = a.[1CNomenclatureID] AND b.PlaceGroupID IN (0,1,3)
	)
	THEN c.SortValue + ',' + CAST(d.LayerNumberNumeric AS varchar) + 'сл/' + c.Composition + '/' 
	+ CONVERT(varchar(20), CONVERT(float, c.BasisWeightNumeric), 128) + 'г/' + char(13) + Char(10) + CAST(d.FormatNumeric AS varchar) + '/'
	+ d.Color
ELSE 
	a.NomenclatureName
END AS ShortNomenclatureName
FROM
(
SELECT a.[1CDocShipmentOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID], a.Quantity, b.Name + ' ' + c.Name AS NomenclatureName, 
ISNULL(SUM(CollectedQuantity),0) AS CollectedQuantity
FROM
(
	SELECT a.[1CDocShipmentOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID],
	CASE
		WHEN a.LoadToTop = 1 THEN 'До полн.'
		ELSE CAST(CAST((a.Coefficient*a.Amount) AS float) AS varchar)
	END AS Quantity,
	CASE
	WHEN d.ProductKindID = 1 THEN f.Quantity
	WHEN d.ProductKindID = 2 THEN e.Weight
	END AS CollectedQuantity
	FROM
	[1CDocShipmentOrderGoods] a
	LEFT JOIN
	DocShipments b ON a.[1CDocShipmentOrderID] = b.[1CDocShipmentOrderID]
	LEFT JOIN
	DocProducts c ON b.DocID = c.DocID
	LEFT JOIN
	Products d ON c.ProductID = d.ProductID
	LEFT JOIN
	ProductGroupPacks e ON d.ProductID = e.ProductID AND e.[1CNomenclatureID] = a.[1CNomenclatureID] AND e.[1CCharacteristicID] = a.[1CCharacteristicID]
	LEFT JOIN
	ProductItems f ON d.ProductID = f.ProductID AND f.[1CNomenclatureID] = a.[1CNomenclatureID] AND f.[1CCharacteristicID] = a.[1CCharacteristicID]
	WHERE a.[1CNomenclatureID] IS NOT NULL AND a.[1CCharacteristicID] IS NOT NULL
	UNION ALL
	SELECT a.[1CDocInternalOrderID] AS [1CDocShipmentOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID],
		CAST(CAST((a.Coefficient*a.Amount) AS float) AS varchar) AS Quantity,
		CASE
			WHEN d.ProductKindID = 1 THEN f.Quantity
			WHEN d.ProductKindID = 2 THEN e.Weight
		END AS CollectedQuantity
	FROM
	[1CDocInternalOrderGoods] a
	LEFT JOIN
	DocShipments b ON a.[1CDocInternalOrderID] = b.[1CDocShipmentOrderID]
	LEFT JOIN
	DocProducts c ON b.DocID = c.DocId
	Left JOIN
	Products d ON c.ProductID = d.ProductID
	LEFT JOIN
	ProductGroupPacks e ON d.ProductID = e.ProductID AND e.[1CNomenclatureID] = a.[1CNomenclatureID] AND e.[1CCharacteristicID] = a.[1CCharacteristicID]
	LEFT JOIN
	ProductItems f ON d.ProductID = f.ProductID AND f.[1CNomenclatureID] = a.[1CNomenclatureID] AND f.[1CCharacteristicID] = a.[1CCharacteristicID]
	WHERE a.[1CNomenclatureID] IS NOT NULL AND a.[1CCharacteristicID] IS NOT NULL
) a
JOIN
[1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
JOIN
[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
GROUP BY
a.[1CDocShipmentOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID], a.Quantity, b.Name, c.Name
) a
LEFT JOIN
vNomenclatureSGBProperties c ON a.[1CNomenclatureID] = c.[1CNomenclatureID]
LEFT JOIN
vCharacteristicSGBProperties d ON a.[1CCharacteristicID] = d.[1CCharacteristicID]

GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocShipmentOrders] TO [PalletRepacker]
    AS [dbo];

