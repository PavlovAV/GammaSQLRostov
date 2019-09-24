
CREATE VIEW [dbo].[vProductionTaskProducts]
AS
	SELECT c.ProductionTaskID, e.PlaceID, b.DocID,a.ProductKindID,a.ProductID, a.Number, e.Date,
	CASE 
		WHEN a.ProductKindID = 0 THEN sn.Name + ' ' + sc.Name
		WHEN a.ProductKindID = 1 THEN pn.Name + ' ' + pc.Name
	END AS NomenclatureName,
	CASE 
		WHEN a.ProductKindID = 0 THEN spools.[1CNomenclatureID]
		WHEN a.ProductKindID = 1 THEN d.[1CNomenclatureID]
	END AS NomenclatureID,
	CASE 
		WHEN a.ProductKindID = 0 THEN spools.[1CCharacteristicID]
		WHEN a.ProductKindID = 1 THEN d.[1CCharacteristicID]
	END AS CharacteristicID,
	CASE 
		WHEN a.ProductKindID = 0 THEN b.Quantity
		WHEN a.ProductKindID = 1 THEN d.Quantity
	END AS Quantity
	, a.StateID, c.DocID AS DocProductionID
	FROM Products a
	JOIN DocProductionProducts b ON a.ProductID = b.ProductID
	JOIN DocProduction c ON b.DocID = c.DocID
	JOIN Docs e ON b.DocID = e.DocID
	LEFT JOIN
	ProductSpools spools ON a.ProductID = spools.ProductID AND a.ProductKindID = 0
	LEFT JOIN [1CNomenclature] sn ON spools.[1CNomenclatureID] = sn.[1CNomenclatureID]
	LEFT JOIN [1CCharacteristics] sc ON sc.[1CCharacteristicID] = spools.[1CCharacteristicID]
	LEFT JOIN
	ProductPallets pal ON pal.ProductID = a.ProductID AND a.ProductKindID = 1
	LEFT JOIN
	ProductItems d ON pal.ProductID = d.ProductID
	LEFT JOIN [1CNomenclature] pn ON pn.[1CNomenclatureID] = d.[1CNomenclatureID]
	LEFT JOIN [1CCharacteristics] pc ON pc.[1CCharacteristicID] = d.[1CCharacteristicID]
	WHERE e.DocTypeID = 0 AND c.ProductionTaskID IS NOT NULL







GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskProducts] TO [PalletRepacker]
    AS [dbo];

