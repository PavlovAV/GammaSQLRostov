











CREATE VIEW [dbo].[vProductsCurrentStateInfo]
 
AS
SELECT a.ProductID, a.StateID, b.[1CQualityID], a.RejectionReason, a.ChangeStateQuantity, a.IsWrittenOff,
	a.State
FROM
(
	SELECT a.ProductID, ISNULL(a.StateID,0) AS StateID, b.RejectionReason, b.ChangeStateQuantity,
	CAST
	(
		CASE
		WHEN c.Quantity IS NULL OR c.Quantity < 1 THEN 1
		ELSE 0
		END AS Bit
	) AS IsWrittenOff,
	NULLIF
	(
		CASE 
		WHEN c.Quantity IS NULL OR c.Quantity < 1 THEN 'списан'
		WHEN f.IsConfirmed = 1 THEN ISNULL(d.Name,'Годная')
		ELSE 'Не подтвержден'
		END, ''
	) AS State
	FROM
	dbo.Products a
	LEFT JOIN
	(
			SELECT ProductID, DocID, Quantity AS ChangeStateQuantity, Date, RejectionReason
		FROM
		(
			SELECT a.ProductID,b.DocID,b.Quantity,/*ISNULL(c.Date, bd.Date) AS */bd.Date,1 as rn,
			e.[1CRejectionReasonID], d.Description AS RejectionReason
			FROM 
			dbo.DocBrokeProducts b
			JOIN 
			Docs bd ON bd.DocID = b.DocID
			JOIN
			(
			SELECT b.ProductID,MAX(bd.Date) AS Date
			FROM 
			dbo.DocBrokeProducts b
			JOIN 
			Docs bd ON bd.DocID = b.DocID
			GROUP BY b.ProductID
			) a ON a.ProductID = b.ProductID AND bd.Date = a.Date
			LEFT JOIN
			(dbo.DocBrokeProductRejectionReasons e JOIN (SELECT e1.DocID,e1.ProductID, MIN(e1.[1CRejectionReasonID]) AS [1CRejectionReasonID] FROM dbo.DocBrokeProductRejectionReasons e1 GROUP BY e1.DocID,e1.ProductID) ee ON e.ProductID = ee.ProductID AND e.DocID = ee.DocID AND e.[1CRejectionReasonID] = ee.[1CRejectionReasonID]
			) ON b.ProductID = e.ProductID AND b.DocID = e.DocID
			LEFT JOIN
			dbo.[1CRejectionReasons] d ON e.[1CRejectionReasonID] = d.[1CRejectionReasonID]
/*
			SELECT a.ProductID,b.DocID,b.Quantity,/*ISNULL(c.Date, bd.Date) AS */bd.Date,ROW_NUMBER() over(partition by a.ProductID order by /*ISNULL(c.Date, bd.Date)*/bd.Date DESC) as rn,
			e.[1CRejectionReasonID], d.Description AS RejectionReason
			FROM dbo.Products a
			JOIN
			dbo.DocBrokeProducts b ON a.ProductID = b.ProductId
			JOIN 
			Docs bd ON bd.DocID = b.DocID
			--LEFT JOIN
			--dbo.Docs c ON b.DocID = c.DocID AND c.DocTypeID = 4
			LEFT JOIN
			dbo.DocBrokeProductRejectionReasons e ON b.ProductID = e.ProductID AND b.DocID = e.DocID
			LEFT JOIN
			dbo.[1CRejectionReasons] d ON e.[1CRejectionReasonID] = d.[1CRejectionReasonID]
*/		) a
		WHERE a.rn = 1
	) b ON a.ProductID = b.ProductID
	LEFT JOIN
	dbo.Rests c ON a.ProductID = c.ProductID
	LEFT JOIN 
	dbo.ProductStates d ON a.StateID = d.StateID
	JOIN
	dbo.DocProductionProducts e ON a.ProductID = e.ProductID
	JOIN
	dbo.Docs f ON e.DocID = f.DocID AND f.DocTypeID = 0
) a
JOIN
ProductStates b ON a.StateID = b.StateID









GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsCurrentStateInfo] TO [PalletRepacker]
    AS [dbo];

