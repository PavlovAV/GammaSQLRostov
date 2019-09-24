CREATE PROCEDURE [dbo].[GetDocCloseShiftConvertingProduction]
(@DocID uniqueidentifier)
AS 
BEGIN
SELECT b.Name + ' ' + c.Name AS NomenclatureName, SUM(ISNULL(Quantity,0)) AS Quantity
FROM
(
	SELECT 'Передано предыдущей сменой' AS Type, c.[1CNomenclatureID], c.[1CCharacteristicID],
		NULL AS NumPallets, CAST (-b.Quantity/e.Coefficient AS int) AS NumPacks, -b.Quantity AS Quantity
	FROM
	(
		SELECT TOP 1 b.ProductID
		FROM
		DocCloseShiftDocs a
		JOIN
		DocProductionProducts b ON a.DocID = b.DocID
		JOIN
		Docs c ON a.DocID = c.DocID
		WHERE a.DocCloseShiftID = @DocID
		ORDER BY c.Date
	) a
	JOIN
	DocCloseShiftRemainders b ON a.ProductID = b.ProductID
	JOIN
	vProductsInfo c ON a.ProductID = c.ProductID
	JOIN
	[1CCharacteristics] d ON c.[1CCharacteristicID] = d.[1CCharacteristicID]
	JOIN
	[1CMeasureUnits] e ON d.MeasureUnitPackage = e.[1CMeasureUnitID]
	

	UNION ALL
	

	SELECT 'Выработка' AS Type, d.[1CNomenclatureID], d.[1CCharacteristicID], 
		COUNT(d.ProductID) AS NumPallets, CAST(SUM(d.Quantity)/f.Coefficient AS int) AS NumPacks, SUM(d.Quantity) AS Quantity
	FROM
	DocCloseShiftDocs a
	JOIN
	Docs b ON a.DocID = b.DocID AND b.DocTypeID = 0
	JOIN
	DocProductionProducts c ON b.DocID = c.DocID
	JOIN
	ProductItems d ON c.ProductID = d.ProductID
	JOIN
	[1CCharacteristics] e ON d.[1CCharacteristicID] = e.[1CCharacteristicID]
	JOIN
	[1CMeasureUnits] f ON e.MeasureUnitPackage = f.[1CMeasureUnitID]
	WHERE
	a.DocCloseShiftID = @DocID
	GROUP BY a.DocCloseShiftID, d.[1CNomenclatureID], d.[1CCharacteristicID], f.Coefficient
	

	UNION ALL


	SELECT 'Передано следующей смене' AS Type, b.[1CNomenclatureID], b.[1CCharacteristicID],
		NULL AS NumPallets, CAST(a.Quantity/d.Coefficient AS int) AS NumPacks, a.Quantity AS Quantity
	FROM 
	DocCloseShiftRemainders a
	JOIN
	vProductsInfo b ON b.ProductID = a.ProductID
	JOIN
	[1CCharacteristics] c ON b.[1CCharacteristicID] = c.[1CCharacteristicID]
	JOIN
	[1CMeasureUnits] d ON c.[MeasureUnitPackage] = d.[1CMeasureUnitID]
	WHERE a.DocID = @DocID
	

	UNION ALL


	SELECT 'Отобранные образцы' AS Type, a.[1CNomenclatureID], a.[1CCharacteristicID],
		NULL AS NumPallets, CAST(a.Quantity*b.Coefficient/d.Coefficient AS int) AS NumPacks, a.Quantity*b.Coefficient AS Quantity
	FROM
	DocCloseShiftSamples a
	JOIN
	[1CMeasureUnits] b ON a.[1CMeasureUnitID] = b.[1CMeasureUnitID]
	JOIN
	[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
	JOIN
	[1CMeasureUnits] d ON c.MeasureUnitPackage = d.[1CMeasureUnitID]
	WHERE
	a.DocID = @DocID


	UNION ALL


	SELECT 'Остатки от переходов' AS Type, a.[1CNomenclatureID], a.[1CCharacteristicID],
		NULL AS NumPallets, CAST(a.Quantity/c.Coefficient AS int) AS NumPacks, a.Quantity
	FROM
	DocCloseShiftNomenclatureRests a
	JOIN
	[1CCharacteristics] b ON a.[1CCharacteristicID] = b.[1CCharacteristicID]
	JOIN
	[1CMeasureUnits] c ON b.MeasureUnitPackage = c.[1CMeasureUnitID]
	WHERE
	a.DocID = @DocID
) a
JOIN
[1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
JOIN
[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]

GROUP BY b.Name, c.Name
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingProduction] TO [PalletRepacker]
    AS [dbo];

