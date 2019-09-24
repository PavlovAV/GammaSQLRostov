



CREATE VIEW [dbo].[vDocMovementProducts]
AS
	SELECT a.DocID AS DocMovementID, d.ProductID, d.ProductKindID, b.DocOrderID, b.OrderTypeID, b.InPlaceID, b.OutPlaceID, CAST(a.IsShipped AS bit) AS IsShipped, 
		CAST(a.IsAccepted AS bit) AS IsAccepted, CAST(a.IsConfirmed AS bit) AS IsConfirmed, a.OutDate, a.InDate, a.OutPersonID, a.InPersonID, c.Date AS DocDate,
		a.OutPerson, a.InPerson,
	CASE WHEN a.OutQuantity IS NOT NULL OR a.InQuantity IS NOT NULL
	THEN ISNULL(a.OutQuantity, a.InQuantity)
	ELSE CASE 
		WHEN d.ProductKindID = 0 THEN dbo.CalculateSpoolWeightBeforeDate(d.ProductID, c.Date)
		WHEN d.ProductKindID IN (1,2,3) THEN Quantity
	END END AS Quantity, d.[1CNomenclatureID], d.[1CCharacteristicID], ps.[1CQualityID],/*f.[1CQualityID], */
	g.Name + ' ' + ISNULL(h.Name,'') + CASE WHEN ps.[1CQualityID] <> 'D05404A0-6BCE-449B-A798-41EBE5E5B977' AND k.Description <> 'Годный' THEN ' ('+k.Description+')' ELSE '' END AS NomenclatureName, 
	e.ShortNomenclatureName + CASE WHEN ps.[1CQualityID] <> 'D05404A0-6BCE-449B-A798-41EBE5E5B977' AND k.Description <> 'Годный' THEN '/'+k.Description ELSE '' END AS ShortNomenclatureName, d.Number, d.BarCode
	, a.InPlaceZoneID, i.[Name] AS InPlaceZone, a.OutPlaceZoneID, j.[Name] AS OutPlaceZone
	, l.Coefficient AS CoefficientPackage, m.Coefficient AS CoefficientPallet
	, n.[Name] AS ProductKindName, s.[Name] AS OrderTypeName, q.[Name] AS InPlace, r.[Name] AS OutPlace
	FROM
	DocMovement b 
	JOIN
	(
		SELECT a.DocID, a.ProductID, 1 AS IsShipped, 1 AS IsAccepted, b.IsConfirmed, a.Date AS OutDate, b.Date AS InDate,
			a.PersonID AS OutPersonID, b.PersonID AS InPersonID, c.Name AS OutPerson, d.Name AS InPerson
			,b.PlaceZoneID AS InPlaceZoneID, a.PlaceZoneID AS OutPlaceZoneID, a.Quantity AS OutQuantity, b.Quantity AS InQuantity
		FROM
		DocOutProducts a
		JOIN
		DocInProducts b ON a.DocID = b.DocID AND a.ProductID = b.ProductID
		LEFT JOIN
		Persons c ON a.PersonID = c.PersonID
		LEFT JOIN
		Persons d ON b.PersonID = d.PersonID
		UNION 
		SELECT a.DocID, a.ProductID, 1 AS IsShipped, 0 AS IsAccepted, 0 AS IsConfirmed, a.Date AS OutDate, NULL AS InDate,
			a.PersonID AS OutPersonID, NULL AS InPersonID, b.Name AS OutPerson, NULL AS InPerson
			,NULL AS InPlaceZoneID, a.PlaceZoneID AS OutPlaceZoneID, a.Quantity AS OutQuantity, NULL AS InQuantity
		FROM
		DocOutProducts a
		LEFT JOIN
		Persons b ON a.PersonID = b.PersonID 
		WHERE NOT EXISTS (SELECT * FROM DocInProducts WHERE DocID = a.DocID AND ProductID = a.ProductID)
		UNION 
		SELECT a.DocID, a.ProductID, 0 AS IsShipped, 1 AS IsAccepted, a.IsConfirmed, NULL AS OutDate, a.Date AS InDate,
			NULL AS OutPersonID, a.PersonID AS InPersonID, NULL AS OutPerson, b.Name AS InPerson
			,a.PlaceZoneID AS InPlaceZoneID, NULL AS OutPlaceZoneID, NULL AS OutQuantity, a.Quantity AS InQuantity
		FROM
		DocInProducts a
		LEFT JOIN
		Persons b ON a.PersonID = b.PersonID 
		WHERE NOT EXISTS (SELECT * FROM DocOutProducts WHERE DocID = a.DocID AND ProductID = a.ProductID)
	) a ON a.DocID = b.DocID
	JOIN
	Docs c ON b.DocID = c.DocID
	JOIN
	vProductsBaseInfo d ON a.ProductID = d.ProductID
	LEFT JOIN
	vShortNomenclatureName e ON d.[1CNomenclatureID] = e.[1CNomenclatureID] AND (d.[1CCharacteristicID] = e.[1CCharacteristicID] OR (d.[1CCharacteristicID] IS NULL OR e.[1CCharacteristicID] IS NULL))
	JOIN 
	Products p ON a.ProductID = p.ProductID
	LEFT JOIN
	ProductStates ps ON ISNULL(p.StateID,0) = ps.StateID
	--JOIN
	--vProductsCurrentStateInfo f ON f.ProductId = d.ProductID
	JOIN
	[1CNomenclature] g ON g.[1CNomenclatureID] = d.[1CNomenclatureID]
	LEFT JOIN
	[1CCharacteristics] h ON h.[1CCharacteristicID] = d.[1CCharacteristicID]
	LEFT JOIN 
	PlaceZones i ON a.InPlaceZoneID = i.PlaceZoneID
	LEFT JOIN 
	PlaceZones j ON a.OutPlaceZoneID = j.PlaceZoneID
	LEFT JOIN
	[1CQuality] k ON k.[1CQualityID] = ps.[1CQualityID]
	LEFT JOIN
	[1CMeasureUnits] l ON h.[MeasureUnitPackage] = l.[1CMeasureUnitID]
	LEFT JOIN
	[1CMeasureUnits] m ON h.[MeasureUnitPallet] = m.[1CMeasureUnitID]
	JOIN 
	ProductKinds n ON d.ProductKindID = n.ProductKindID
	JOIN
	OrderTypes s ON b.OrderTypeID = s.OrderTypeID
	LEFT JOIN
	Places q ON b.InPlaceID = q.PlaceID
	LEFT JOIN
	Places r ON b.OutPlaceID = r.PlaceID

GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementProducts] TO [PalletRepacker]
    AS [dbo];

