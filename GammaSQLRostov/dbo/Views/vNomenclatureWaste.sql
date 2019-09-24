

CREATE VIEW [dbo].[vNomenclatureWaste]
AS
--Затраты сырья на каждую продукцию
WITH cteMaterialCostsForProducts 
AS
	(
	SELECT 
		a.ProductID,-- SUM(a.QuantityWithdrawalProducts) AS Quantity, --ProductionQuantity, 
		SUM(a.QuantityWithdrawalProducts * a.Quantity  / a.ProductionQuantity) AS QuantityMaterialCostsForProducts
	FROM
		(
		SELECT
			a.ProductID, a.Quantity, --p.Number, p.ProductionQuantity, 
			wp.ProductID AS ProductIDWP, wp.Quantity AS QuantityWithdrawalProducts, 
			SUM(c.Quantity) AS ProductionQuantity--, wp.Quantity * (a.Quantity  / SUM(c.Quantity)) AS QuantityMaterialCostsForProducts
		FROM
			DocProductionProducts a 
			JOIN
			DocProductionWithdrawals b ON b.DocProductionID = a.DocID--a.DocID = b.DocWithdrawalID
			JOIN
			DocWithdrawalProducts wp ON wp.DocID = b.DocWithdrawalID
			JOIN
			DocProductionWithdrawals bb ON b.DocWithdrawalID = bb.DocWithdrawalID--a.DocID = b.DocWithdrawalID
			JOIN
			DocProductionProducts c ON bb.DocProductionID = c.DocID
	--	WHERE a.DocID IN (SELECT s.DocID FROM [DocCloseShiftDocs] s WHERE s.DocCloseShiftID = '79B07166-4280-E711-8677-902B34CC4BD7')
		GROUP BY
			a.ProductID, a.Quantity, 
			wp.ProductID, wp.Quantity
		--ORDER BY
			--a.ProductID, a.Quantity, 
			--wp.ProductID, wp.Quantity
		) a
	GROUP BY
		a.ProductID,a.Quantity--, a.ProductionQuantity
	--ORDER BY 
		--a.ProductID,a.Quantity--, a.ProductionQuantity
	)
--Произведено продукции + отобранные образцы
,cteNomenclature_Characteristics 
AS
	(
	SELECT 
		s.DocCloseShiftID AS DocID, b.[1CNomenclatureID], b.[1CCharacteristicID], b.[Quantity], NULL AS [1CMeasureUnitID], m.QuantityMaterialCostsForProducts
	FROM 
		[dbo].[DocCloseShiftDocs] s 
		JOIN [DocProductionProducts] b ON s.DocID = b.DocID 
		LEFT JOIN cteMaterialCostsForProducts m ON b.ProductID = m.ProductID
	--UNION ALL 
	--Отобранные образцы
	--SELECT 
		--b.DocID, b.[1CNomenclatureID], b.[1CCharacteristicID], b.[Quantity] * m.[Coefficient] AS [Quantity], b.[1CMeasureUnitID], NULL AS QuantityMaterialCostsForProducts
	--FROM 
		--DocCloseShiftSamples b
		--LEFT JOIN
		--[1CMeasureUnits] m ON b.[1CMeasureUnitID] = m.[1CMeasureUnitID]
	)
--Сгруппированые номенклатуры произведенной продукции
,cteNomenclature AS 
	(
	SELECT a.DocID, n.[1CNomenclatureID], n.[Name] AS NomenclatureName, c.[1CCharacteristicID], c.[Name] AS CharacteristicName, 
		Sum(a.Quantity) AS Quantity, ROUND(Sum(a.Quantity)/ (SELECT sum(nc.Quantity) FROM cteNomenclature_Characteristics nc WHERE nc.DocID = a.DocID),4) AS PartQuantity
		,SUM(a.QuantityMaterialCostsForProducts) AS QuantityMaterialCosts
	FROM 
		cteNomenclature_Characteristics a
		JOIN
		[1CNomenclature] n ON a.[1CNomenclatureID] = n.[1CNomenclatureID]
		JOIN
		[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
--	WHERE a.[DocID] = '0BCEE1F8-FA16-E711-A172-902B34CC6873'
	GROUP BY 
		a.DocID, n.[1CNomenclatureID], n.[Name], c.[1CCharacteristicID], c.[Name]
	),
--Отходы из спецификации по номенклатуре
cteSpecificationWastes
AS
	(
	SELECT s.[1CNomenclatureID] AS [s1CNomenclatureID], m.[1CNomenclatureID]
		, ISNULL(m.[1CCharacteristicID],c.[1CCharacteristicID]) AS [1CCharacteristicID], m.[1CPlaceID]
	FROM
		[1CSpecificationWastes] s 
		JOIN [1CMainSpecifications] m ON s.[1CSpecificationID] = m.[1CSpecificationID]
		LEFT JOIN [1CCharacteristics] c ON c.[1CNomenclatureID] = m.[1CNomenclatureID] AND m.[1CCharacteristicID] IS NULL
	GROUP BY 
		s.[1CNomenclatureID], m.[1CNomenclatureID]
		, ISNULL(m.[1CCharacteristicID],c.[1CCharacteristicID]), m.[1CPlaceID]
	)
--Сгруппированные отходы в рамках документа закрытия смены
, cte_DocCloseShiftWastes
AS
	(
	SELECT 
		w.DocID, w.[1CNomenclatureID], w.[1CCharacteristicID], w.[1CMeasureUnitID], SUM(Quantity) AS Quantity
	FROM
		[dbo].[DocCloseShiftWastes] w
	GROUP BY 
		w.DocID, w.[1CNomenclatureID], w.[1CCharacteristicID], w.[1CMeasureUnitID]
	)
--Отходы по смене с привязкой к произведенной номенклатуре по смене
,cteNomenclature_Waste
AS
	(
	SELECT 
		--w.[1CNomenclatureID],nc.[1CNomenclatureID],nc.[1CCharacteristicID],p.[1CPlaceID]
		nc.*,d.Number, d.[Date], d.UserID, p.[Name] AS PlaceName, w.Quantity AS QuantityWaste
		,w.[1CNomenclatureID] AS [1CNomenclatureIDWaste], [Extent2].[Name] AS [NomenclatureNameWaste]
		,w.[1CCharacteristicID] AS [1CCharacteristicIDWaste], [Extent3].[Name] AS [CharacteristicNameWaste]
		,w.[1CMeasureUnitID] AS [1CMeasureUnitIDWaste], [Extent4].[Name] AS [MeasureUnitNameWaste], [Extent4].[Coefficient] AS MeasureUnitCoefficientWaste
		,s.[1CNomenclatureID] AS s1, s.[1CNomenclatureID] AS c1
	FROM    
		cteNomenclature nc
		JOIN 
		[Docs] d ON nc.DocID = d.DocID
		JOIN 
		Places p ON d.PlaceID = p.PlaceID
		JOIN 
		cte_DocCloseShiftWastes AS w ON d.DocID = w.DocID
		JOIN [dbo].[1CNomenclature] AS [Extent2] ON w.[1CNomenclatureID] = [Extent2].[1CNomenclatureID]
		LEFT JOIN [dbo].[1CCharacteristics] AS [Extent3] ON w.[1CCharacteristicID] = [Extent3].[1CCharacteristicID]
		JOIN [dbo].[1CMeasureUnits] AS [Extent4] ON w.[1CMeasureUnitID] = [Extent4].[1CMeasureUnitID]
		JOIN
		cteSpecificationWastes s 
			ON w.[1CNomenclatureID] = s.[s1CNomenclatureID] 
				AND s.[1CNomenclatureID] = nc.[1CNomenclatureID] 
				AND (s.[1CCharacteristicID] = nc.[1CCharacteristicID])-- OR (s.[1CCharacteristicID] IS NULL AND nc.[1CCharacteristicID] IS NOT NULL)) 
				AND s.[1CPlaceID] = p.[1CPlaceID]
	WHERE nc.Quantity <> 0--w.Quantity <> 0 --AND d.Number = 'SDF/2412'
	)
--, cte_DocCloseShiftNomenclature
--AS
--	(
	SELECT 
		DocID, Number, UserID, Date, PlaceName, NomenclatureName, CharacteristicName,Quantity,PartQuantity, NomenclatureNameWaste, CharacteristicNameWaste, QuantityWaste * MeasureUnitCoefficientWaste AS BaseMeasureUnitQuantityWaste,
		MeasureUnitCoefficientWaste * QuantityWaste * ISNULL(Quantity / (SELECT SUM(t.Quantity) AS Quantity 
			FROM cteNomenclature_Waste t 
			WHERE t.DocID = a.DocID AND t.[1CNomenclatureIDWaste] = a.[1CNomenclatureIDWaste] AND t.[1CCharacteristicIDWaste] = a.[1CCharacteristicIDWaste]
			HAVING COUNT(DISTINCT t.[1CCharacteristicID])>1
		),1) /*AS QuantityWastePerCharacteristic*/ AS QuantityWaste, a.QuantityMaterialCosts, a.QuantityMaterialCosts / Quantity AS QuantityMaterialCostsPerUnitNomenclature
	FROM 
		cteNomenclature_Waste a
	--WHERE Date>= '20170801' AND Date < '20170901' AND PlaceName = 'X-5' 
		--AND NomenclatureName = 'Полотенца бумажные кухонные Veiro Домашние, БЕЛЫЙ, 2-сл., арт. 3П22'
		--AND CharacteristicName = '2*12 рулонов в уп., 40 уп. на паллете'
		--AND DocID = '79B07166-4280-E711-8677-902B34CC4BD7'
	/*)
--Сгруппрованные данные по номенклатуре
, cte_Nomenclature
AS
	(
	SELECT 
		DocID, [Date], PlaceName, NomenclatureName, CharacteristicName, Quantity
		, QuantityMaterialCosts  
		, SUM(QuantityWastePerCharacteristic) AS QuantityWaste
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
--WHERE 
--	Date>= '20170801' AND Date < '20171001'
	--Number IN ('SDF/2420', 'SDF/2412')
	--Number IN ('X-5/3682','X-5/3685','X-5/3689','Синхро-4/2697')
	--AND MeasureUnitNameWaste = 'т' AND QuantityWaste>=1
GROUP BY 
	 PlaceName
	, [Date]
	, NomenclatureName
	, CharacteristicName--, Quantity, PartQuantity, QuantityMaterialCosts, QuantityMaterialCostsPerUnitNomenclature
--ORDER BY 
--	 PlaceName
--	, [Date]
--	, NomenclatureName
--	, CharacteristicName--, Quantity, PartQuantity, QuantityMaterialCosts, QuantityMaterialCostsPerUnitNomenclature
*/




GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureWaste] TO [PalletRepacker]
    AS [dbo];

