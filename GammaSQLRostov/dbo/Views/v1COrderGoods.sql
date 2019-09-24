
CREATE VIEW [dbo].[v1COrderGoods]
AS
	
SELECT a.[1CDocOrderID] AS DocOrderID, a.[1CNomenclatureID], a.[1CCharacteristicID], e.[1CQualityID], e.Description AS Quality
		, a.Quantity, a.IsOrderNomenclature, a.OutQuantity, 
		a.InQuantity, a.AcceptedQuantity, b.Name + ' ' + ISNULL(c.Name,'') + ISNULL(Char(13) + 'Качество - '+e.Description,'') AS NomenclatureName, d.ShortNomenclatureName
		,a.BreakNumber, a.CountProduct, a.CountProductSpools, a.CountProductSpoolsWithBreak
		,f.Coefficient AS CoefficientPackage, g.Coefficient AS CoefficientPallet
FROM
(
	SELECT a.[1CDocOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], a.Quantity, SUM(OutQuantity) AS OutQuantity, a.IsOrderNomenclature,
		SUM(InQuantity) AS InQuantity, SUM(a.AcceptedQuantity) AS AcceptedQuantity
		,SUM(BreakNumber) AS BreakNumber, SUM(CountProduct) AS CountProduct
		, SUM(CountProductSpools) AS CountProductSpools, SUM(CountProductSpoolsWithBreak) AS CountProductSpoolsWithBreak
	FROM
	(
		SELECT ISNULL(a.[1CDocOrderID], b.[1CDocOrderID]) AS [1CDocOrderID], ISNULL(a.[1CNomenclatureID], b.[1CNomenclatureID]) AS [1CNomenclatureID],
			ISNULL(a.[1CCharacteristicID],b.[1CCharacteristicID]) AS [1CCharacteristicID], a.[1CQualityID], 
			ISNULL(a.Quantity,'0') AS Quantity, 
			CASE
				WHEN a.[1CDocOrderID] IS NOT NULL THEN 1
				ELSE 0
			END AS IsOrderNomenclature,
			ISNULL(OutQuantity,0) AS OutQuantity, ISNULL(InQuantity,0) AS InQuantity, ISNULL(b.AcceptedQuantity,0) AS AcceptedQuantity
			, ISNULL(BreakNumber,0) AS BreakNumber, ISNULL(CountProduct,0) AS CountProduct
			, ISNULL(b.CountProductSpools,0) AS CountProductSpools, ISNULL(b.CountProductSpoolsWithBreak,0) AS CountProductSpoolsWithBreak
		FROM	
			(
				SELECT a.[1CDocShipmentOrderID] AS [1CDocOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID],
					CASE
						WHEN a.LoadToTop = 1 THEN 'До полн.'
						ELSE CAST(CAST((a.Coefficient*a.Amount) AS float) AS varchar)
					END AS Quantity
					FROM
					[1CDocShipmentOrderGoods] a
					WHERE a.[1CNomenclatureID] IS NOT NULL --AND a.[1CCharacteristicID] IS NOT NULL
					UNION ALL
					SELECT a.[1CDocInternalOrderID] AS [1CDocOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], 
						CAST(CAST((a.Coefficient*a.Amount) AS float) AS varchar) AS Quantity
					FROM
					[1CDocInternalOrderGoods] a
					WHERE a.[1CNomenclatureID] IS NOT NULL --AND a.[1CCharacteristicID] IS NOT NULL
			) a
			FULL JOIN
			(
				SELECT a.DocOrderID AS [1CDocOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], 
					SUM(ISNULL(a.OutQuantity,0)) AS OutQuantity, SUM(ISNULL(a.InQuantity,0)) AS InQuantity, 
					SUM(ISNULL(a.AcceptedQuantity,0)) AS AcceptedQuantity
					, SUM(ISNULL(a.BreakNumber,0)) AS BreakNumber
					, SUM(ISNULL(a.CountProduct,0)) AS CountProduct
					, SUM(ISNULL(a.CountProductSpools,0)) AS CountProductSpools
					, SUM(ISNULL(a.CountProductSpoolsWithBreak,0)) AS CountProductSpoolsWithBreak
				FROM
				vDocMovementGoods a
				WHERE a.DocOrderID IS NOT NULL
				GROUP BY a.DocOrderID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID]
			) b ON a.[1CDocOrderID] = b.[1CDocOrderID] AND
			a.[1CNomenclatureID] = b.[1CNomenclatureID] AND (a.[1CCharacteristicID] = b.[1CCharacteristicID] OR (a.[1CCharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL))
			AND (a.[1CQualityID] IS NULL OR a.[1CQualityID] = b.[1CQualityID])
	) a
	GROUP BY a.[1CDocOrderID], a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CQualityID], a.Quantity, a.IsOrderNomenclature
) a
JOIN
[1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
LEFT JOIN
[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
LEFT JOIN
vShortNomenclatureName d ON a.[1CNomenclatureID] = d.[1CNomenclatureID] AND (a.[1CCharacteristicID] = d.[1CCharacteristicID] OR (a.[1CCharacteristicID] IS NULL AND d.[1CCharacteristicID] IS NULL))
LEFT JOIN
[1CQuality] e ON ISNULL(a.[1CQualityID],'D05404A0-6BCE-449B-A798-41EBE5E5B977') = e.[1CQualityID]
LEFT JOIN
[1CMeasureUnits] f ON c.[MeasureUnitPackage] = f.[1CMeasureUnitID]
LEFT JOIN
[1CMeasureUnits] g ON c.[MeasureUnitPallet] = g.[1CMeasureUnitID]

GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1COrderGoods] TO [PalletRepacker]
    AS [dbo];

