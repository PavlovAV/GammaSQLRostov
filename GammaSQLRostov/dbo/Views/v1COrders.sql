



CREATE VIEW [dbo].[v1COrders]
AS
SELECT a.[1COrderID], a.[1CDate] AS Date, a.[1CNumber] AS Number, a.Shipper, a.Consignee, a.Buyer, a.[1COutSubdivisionID], g.BranchID AS OutBranchID,
	a.[1CInSubdivisionID], h.BranchID AS InBranchID, b.OutDate, b.InDate, b.Driver, b.DriverDocument,
	b.VehicleNumber, ISNULL(b.IsShipped, 0) AS IsShipped,
	CASE
		WHEN NOT EXISTS (SELECT * FROM DocMovement WHERE DocOrderID = a.[1COrderID]) THEN CAST(0 AS Bit)
		WHEN EXISTS 
			(
				SELECT * FROM 
				DocMovement dm
				LEFT JOIN
				DocInProducts di ON dm.DocID = di.DocID --AND (di.IsConfirmed IS NULL OR di.IsConfirmed = 0)
				LEFT JOIN
				DocOutProducts do ON do.DocID = dm.DocID 
				WHERE dm.DocOrderID = a.[1COrderID] AND
					((
						(di.DocID IS NOT NULL OR do.DocID IS NOT NULL)
						AND
						(di.IsConfirmed IS NULL OR di.IsConfirmed = 0)
					) 
						OR 
						(di.DocID IS NULL AND do.DocID IS NULL)
					)
			) THEN CAST(0 AS Bit)
		ELSE CAST(1 AS Bit)
	END AS IsConfirmed,
	b.InActivePersonID, d.Name AS InActivePerson, b.InShiftId, b.InPlaceID,
	b.OutActivePersonID, c.Name AS OutActivePerson, b.OutShiftID, b.OutPlaceID, 
	 a.OrderKindID, a.OrderType, j.Name AS InPlaceName, i.Name AS OutPlaceName, a.Warehouse, 
	 a.Shipper1CCode, a.Consignee1CCode, a.Buyer1CCode
FROM
(
	SELECT a.[1CDocShipmentOrderID] AS [1COrderID], a.[1CDate], a.[1CNumber], ISNULL(g.Description,b.Description) AS Shipper, ISNULL(g.[1CCode],b.[1CCode]) AS Shipper1CCode,
		ISNULL(h.Description, c.Description) AS Consignee, ISNULL(h.[1CCode],c.[1CCode]) AS Consignee1CCode, ISNULL(k.Description, e.Description) AS Buyer, ISNULL(k.[1CCode],e.[1CCode]) AS Buyer1CCode, d.[1CSubdivisionID] AS [1COutSubdivisionID],
		NULL AS [1CInSubdivisionID], 0 AS OrderKindID, 'Приказ' AS OrderType, d.[Description] AS Warehouse, i.[Description] AS WarehouseLoad
	FROM
	[1CDocShipmentOrder] a
	LEFT JOIN
	[1CContractors] b ON a.[1CShipperID] = b.[1CContractorID]
	LEFT JOIN
	[1CContractors] c ON a.[1CConsigneeID] = c.[1CContractorID]
	LEFT JOIN
	[1CWarehouses] d ON a.[1CWarehouseID] = d.[1CWarehouseID]
	LEFT JOIN
	[1CContractors] e ON a.[1CContractorID] = e.[1CContractorID]
	LEFT JOIN
	[1CDocBuyerOrders] f ON a.[1CDocBuyerOrderID] = f.[1CDocBuyerOrderID]
	LEFT JOIN
	[1CContractors] g ON f.[1CShipperID] = g.[1CContractorID]
	LEFT JOIN
	[1CContractors] h ON f.[1CConsigneeID] = h.[1CContractorID]
	LEFT JOIN
	[1CWarehouses] i ON f.[1CWarehouseLoadID] = i.[1CWarehouseID]
	LEFT JOIN
	[1CContractors] k ON f.[1CContractorID] = k.[1CContractorID]

	UNION ALL
	SELECT [1CDocInternalOrderID] AS [1COrderID], [1CDate], [1CNumber],
		b.Description AS Shipper, b.[1CCode] AS Shipper1CCode, c.Description AS Consignee, c.[1CCode] AS Consignee1CCode, c.Description AS Buyer, c.[1CCode] AS Buyer1CCode,
		b.[1CSubdivisionID] AS [1COutSubdivisionID], 
		c.[1CSubdivisionID] AS [1CInSubdivisionID],
		1 AS OrderKindID, 'Внутренний заказ' AS OrderType, d.[Description] AS Warehouse, i.[Description] AS WarehouseLoad
	FROM
	[1CDocInternalOrders] a
	JOIN
	[1CTransportPoints] b ON a.[1CTransportPointStartID] = b.[1CTransportPointID]
	JOIN
	[1CTransportPoints] c ON a.[1CTransportPointFinishID] = c.[1CTransportPointID]
	LEFT JOIN
	[1CWarehouses] d ON a.[1CWarehouseUnloadID] = d.[1CWarehouseID]
	LEFT JOIN
	[1CWarehouses] i ON a.[1CWarehouseLoadID] = i.[1CWarehouseID]
) a
LEFT JOIN
DocShipmentOrders b ON a.[1COrderID] = b.DocOrderID
LEFT JOIN
Persons c ON b.OutActivePersonID = c.PersonID
LEFT JOIN
Persons d ON b.InActivePersonID = d.PersonID
JOIN
Branches g ON a.[1COutSubdivisionID] = g.[1CSubdivisionID]
LEFT JOIN
Branches h ON a.[1CInSubdivisionID] = h.[1CSubdivisionID]
LEFT JOIN
Places i ON b.OutPlaceID = i.PlaceID
LEFT JOIN
Places j ON b.InPlaceID = j.PlaceID















GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrders] TO [PalletRepacker]
    AS [dbo];

