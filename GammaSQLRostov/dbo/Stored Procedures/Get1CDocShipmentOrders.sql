
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[Get1CDocShipmentOrders]
AS		
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'---Загрузка данных'
	IF object_id('tempdb..#DocBuyerOrders') is null
		SELECT * INTO #DocBuyerOrders FROM [server1c].gamma.dbo.DocBuyerOrders
	IF object_id('tempdb..#RefContractors') is null
		SELECT * INTO #RefContractors FROM [server1c].gamma.dbo.RefContractors
	IF object_id('tempdb..#RefWarehouses') is null
		SELECT * INTO #RefWarehouses FROM [server1c].gamma.dbo.RefWarehouses
	IF object_id('tempdb..#RRefTransportPoints') is null
		SELECT * INTO #RefTransportPoints FROM [server1c].gamma.dbo.RefTransportPoints
	IF object_id('tempdb..#DocShipmentOrder') is null
		SELECT * INTO #DocShipmentOrder FROM [server1c].gamma.dbo.DocShipmentOrder
	IF object_id('tempdb..#DocShipmentOrder_T_Goods') is null
		SELECT * INTO #DocShipmentOrder_T_Goods FROM [server1c].gamma.dbo.DocShipmentOrder_T_Goods
	IF object_id('tempdb..#RefNomenkl') is null
		SELECT * INTO #RefNomenkl FROM [server1c].gamma.dbo.RefNomenkl
	IF object_id('tempdb..#RefCharNomenkl') is null
		SELECT * INTO #RefCharNomenkl FROM [server1c].gamma.dbo.RefCharNomenkl  
	IF object_id('tempdb..#RefMeasureUnits') is null
		SELECT * INTO #RefMeasureUnits FROM [server1c].gamma.dbo.RefMeasureUnits
	IF object_id('tempdb..#RefQuality') is null
		SELECT * INTO #RefQuality FROM [server1c].gamma.dbo.RefQuality
	IF object_id('tempdb..#RefRegions') is null
		SELECT * INTO #RefRegions FROM [server1c].gamma.dbo.RefRegions
	IF object_id('tempdb..#RefSubdivisions') is null
		SELECT * INTO #RefSubdivisions FROM [server1c].gamma.dbo.RefSubdivisions

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'---	Получение транспортных точек'
	DELETE a
	FROM
	[1CTransportPoints] a
	WHERE NOT EXISTS (SELECT * FROM #RefTransportPoints WHERE _1S_IDRRef = a.[1CTransportPointID])
	
	UPDATE a SET a.Marked = b.Marked, a.Folder = b.Folder, a.[1CCode] = b.[_1S_Code], a.Description = b.Description,
		a.[1CRegionID] = c.[_1S_IDRRef], a.IsOwn = b.IsOwn, a.[1CDistributiveCenterID] = d.[_1S_IDRRef], a.[1CSubDivisionID] = e.[_1S_IDRRef]
	FROM
	[1CTransportPoints] a
	JOIN
	#RefTransportPoints b ON a.[1CTransportPointID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefRegions c ON b.IDRef_Region = c.IDRef
	LEFT JOIN
	#RefTransportPoints d ON b.IDRef_DistributiveCenter = d.IDRef
	LEFT JOIN
	#RefSubdivisions e ON b.IDRef_Subdivision = e.IDRef

	INSERT INTO [1CTransportPoints] ([1CTransportPointID], [1CCode], Marked, Folder, Description, [1CRegionID], IsOwn, [1CDistributiveCenterID],
		[1CSubdivisionID])
	SELECT a.[_1S_IDRRef], a.[_1S_Code], a.Marked, a.Folder, a.Description, b.[_1S_IDRRef], a.IsOwn, c.[_1S_IDRRef], d.[_1S_IDRRef]
	FROM
	#RefTransportPoints a
	LEFT JOIN
	#RefRegions b ON a.IDRef_Region = b.IDRef
	LEFT JOIN
	#RefTransportPoints c ON a.IDRef_DistributiveCenter = c.IDRef
	LEFT JOIN
	#RefSubdivisions d ON a.IDRef_Subdivision = d.IDRef
	WHERE NOT EXISTS (SELECT * FROM [1CTransportPoints] WHERE [1CTransportPointID] = a.[_1S_IDRRef])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'---	Получение заказов покупателей'
	UPDATE a SET a.Marked = b.Marked, a.Posted = b.Posted, a.[1CDate] = b.[_1S_Date]
		, a.[1CNumber] = b.[_1S_Number], a.BuyerOrderNumber = b.BuyerOrderNumber
		, a.DateStartFrom = b.[Date_Start_From], a.DateStartTo = b.[Date_Start_To]
		, a.DateFinishFrom = b.[Date_Finish_From], a.DateFinishTo = b.[Date_Finish_To], a.SelfPickup = b.SelfPickup
		, a.[1CContractorID] = c.[_1S_IDRRef]
		, a.[1CConsigneeID] = d.[_1S_IDRRef], a.[1CShipperID] = e.[_1S_IDRRef]
		, a.[1CWarehouseLoadID] = f.[_1S_IDRRef], a.[1CTransportPointStartID] = g.[_1S_IDRREf]
		, a.[1CTransportPointFinishID] = h.[_1S_IDRRef]
	FROM
	[1CDocBuyerOrders] a
	JOIN
	#DocBuyerOrders b ON a.[1CDocBuyerOrderID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefContractors c ON b.[IDRef_Contractor] = c.[IDRef]
	LEFT JOIN
	#RefContractors d ON b.[IDRef_Сonsignee] = d.[IDRef]
	LEFT JOIN
	#RefContractors e ON b.[IDRef_Shipper] = e.[IDRef]
	LEFT JOIN
	#RefWarehouses f ON b.[IDRef_Warehouse] = f.[IDRef]
	LEFT JOIN
	#RefTransportPoints g ON b.[IDRef_PointStart] = g.[IDRef]
	LEFT JOIN
	#RefTransportPoints h ON b.[IDRef_PointFinish] = h.IDRef
	WHERE
	NOT (((a.Marked IS NULL AND b.Marked IS NULL) OR							a.Marked = b.Marked) 
	AND ((a.Posted IS NULL AND b.Posted IS NULL) OR 							a.Posted = b.Posted) 
	AND ((a.[1CDate] IS NULL AND b.[_1S_Date] IS NULL) OR						a.[1CDate] = b.[_1S_Date])
	AND ((a.[1CNumber] IS NULL AND b.[_1S_Number] IS NULL) OR 					a.[1CNumber] = b.[_1S_Number]) 
	AND ((a.BuyerOrderNumber IS NULL AND b.BuyerOrderNumber IS NULL) OR			a.BuyerOrderNumber = b.BuyerOrderNumber)
	AND ((a.DateStartFrom IS NULL AND b.[Date_Start_From] IS NULL) OR 			a.DateStartFrom = b.[Date_Start_From]) 
	AND ((a.DateStartTo IS NULL AND b.[Date_Start_To] IS NULL) OR				a.DateStartTo = b.[Date_Start_To])
	AND ((a.DateFinishFrom IS NULL AND b.[Date_Finish_From] IS NULL) OR 		a.DateFinishFrom = b.[Date_Finish_From]) 
	AND ((a.DateFinishTo IS NULL AND b.[Date_Finish_To] IS NULL) OR 			a.DateFinishTo = b.[Date_Finish_To]) 
	AND ((a.SelfPickup IS NULL AND b.SelfPickup IS NULL) OR						a.SelfPickup = b.SelfPickup)
	AND ((a.[1CContractorID] IS NULL AND c.[_1S_IDRRef] IS NULL) OR				a.[1CContractorID] = c.[_1S_IDRRef])
	AND ((a.[1CConsigneeID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR 				a.[1CConsigneeID] = d.[_1S_IDRRef]) 
	AND ((a.[1CShipperID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR				a.[1CShipperID] = e.[_1S_IDRRef])
	AND ((a.[1CWarehouseLoadID] IS NULL AND f.[_1S_IDRRef] IS NULL) OR 			a.[1CWarehouseLoadID] = f.[_1S_IDRRef]) 
	AND ((a.[1CTransportPointStartID] IS NULL AND g.[_1S_IDRREf] IS NULL) OR	a.[1CTransportPointStartID] = g.[_1S_IDRREf])
	AND ((a.[1CTransportPointFinishID] IS NULL AND h.[_1S_IDRRef] IS NULL) OR	a.[1CTransportPointFinishID] = h.[_1S_IDRRef]))

	INSERT INTO [1CDocBuyerOrders] ([1CDocBuyerOrderID], Marked, Posted, [1CDate], [1CNumber], BuyerOrderNumber,
		[1CContractorID], [1CConsigneeID], [1CShipperID], [1CTransportPointStartID], [1CTransportPointFinishID],
		DateStartFrom, DateStartTo, DateFinishFrom, DateFinishTo, [1CWarehouseLoadID], SelfPickup)
	SELECT a.[_1S_IDRRef], a.Marked, a.Posted, a.[_1S_Date], a.[_1S_Number], a.BuyerOrderNumber
		, c.[_1S_IDRRef], d.[_1S_IDRRef], e.[_1S_IDRRef], g.[_1S_IDRRef], h.[_1S_IDRRef]
		, a.[Date_Start_From], a.[Date_Start_To], a.[Date_Finish_From], a.[Date_Finish_To]
		, f.[_1S_IDRRef], a.SelfPickup
	FROM
	#DocBuyerOrders a
	LEFT JOIN
	#RefContractors c ON a.[IDRef_Contractor] = c.[IDRef]
	LEFT JOIN
	#RefContractors d ON a.[IDRef_Сonsignee] = d.[IDRef]
	LEFT JOIN
	#RefContractors e ON a.[IDRef_Shipper] = e.[IDRef]
	LEFT JOIN
	#RefWarehouses f ON a.[IDRef_Warehouse] = f.[IDRef]
	LEFT JOIN
	#RefTransportPoints g ON a.[IDRef_PointStart] = g.[IDRef]
	LEFT JOIN
	#RefTransportPoints h ON a.[IDRef_PointFinish] = h.IDRef
	WHERE NOT EXISTS
	(
		SELECT ord.[1CDocBuyerOrderID]
		FROM
		[1CDocBuyerOrders] ord
		WHERE ord.[1CDocBuyerOrderID] = a.[_1S_IDRRef]
	)
--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--- Получение приказов на отгрузку'
	UPDATE a SET a.Marked = b.Marked, a.Posted = b.Posted, a.[1CDate] = b.[_1S_Date]
		, a.[1CNumber] = b.[_1S_Number], a.[1CContractorID] = c.[_1S_IDRRef]
		, a.[1CConsigneeID] = d.[_1S_IDRRef], a.[1CShipperID] = e.[_1S_IDRRef]
		, a.[1CWarehouseID] = f.[_1S_IDRRef], a.[1CDocBuyerOrderID] = g.[_1S_IDRRef]
	FROM
	[1CDocShipmentOrder] a
	JOIN
	#DocShipmentOrder b ON a.[1CDocShipmentOrderID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefContractors c ON b.[IDRef_Contractor] = c.[IDRef]
	LEFT JOIN
	#RefContractors d ON b.[IDRef_Сonsignee] = d.[IDRef]
	LEFT JOIN
	#RefContractors e ON b.[IDRef_Shipper] = e.[IDRef]
	LEFT JOIN
	#RefWarehouses f ON b.[IDRef_Warehouse] = f.[IDRef]
	LEFT JOIN
	#DocBuyerOrders g ON b.IDRef_BuyerOrder = g.IDRef
	WHERE
	NOT (((a.Marked IS NULL AND b.Marked IS NULL) OR					a.Marked = b.Marked) 
	AND ((a.Posted IS NULL AND b.Posted IS NULL) OR 					a.Posted = b.Posted) 
	AND ((a.[1CDate] IS NULL AND b.[_1S_Date] IS NULL) OR				a.[1CDate] = b.[_1S_Date])
	AND ((a.[1CNumber] IS NULL AND b.[_1S_Number] IS NULL) OR 			a.[1CNumber] = b.[_1S_Number]) 
	AND ((a.[1CContractorID] IS NULL AND c.[_1S_IDRRef] IS NULL) OR		a.[1CContractorID] = c.[_1S_IDRRef])
	AND ((a.[1CConsigneeID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR 		a.[1CConsigneeID] = d.[_1S_IDRRef]) 
	AND ((a.[1CShipperID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR		a.[1CShipperID] = e.[_1S_IDRRef])
	AND ((a.[1CWarehouseID] IS NULL AND f.[_1S_IDRRef] IS NULL) OR 		a.[1CWarehouseID] = f.[_1S_IDRRef]) 
	AND ((a.[1CDocBuyerOrderID] IS NULL AND g.[_1S_IDRRef] IS NULL) OR	a.[1CDocBuyerOrderID] = g.[_1S_IDRRef]))

	INSERT INTO [1CDocShipmentOrder] ([1CDocShipmentOrderID], Marked, Posted, [1CDate], [1CNumber], [1CContractorID], [1CConsigneeID]
		, [1CShipperID], [1CWarehouseID], [1CDocBuyerOrderID])
	SELECT a.[_1S_IDRRef], a.Marked, a.Posted, a.[_1S_Date], a.[_1S_Number], b.[_1S_IDRRef], c.[_1S_IDRRef], d.[_1S_IDRRef]
		, e.[_1S_IDRRef], f.[_1S_IDRRef]
	FROM
	#DocShipmentOrder a
	LEFT JOIN
	#RefContractors b ON a.IDRef_Contractor = b.IDRef
	LEFT JOIN
	#RefContractors c ON a.[IDRef_Сonsignee] = c.IDRef
	LEFT JOIN
	#RefContractors d ON a.IDRef_Shipper = d.IDRef
	LEFT JOIN
	#RefWarehouses e ON a.IDRef_Warehouse = e.IDRef
	LEFT JOIN
	#DocBuyerOrders f ON a.IDRef_BuyerOrder = f.IDRef
	WHERE NOT EXISTS
	(SELECT [1CDocShipmentOrderID] 
	FROM [1CDocShipmentOrder] ord
	WHERE ord.[1CDocShipmentOrderID] = a.[_1S_IDRRef])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--- Получение номенклатуры приказов на отгрузку'
	DELETE a 
	--SELECT *
	FROM [1CDocShipmentOrderGoods] a
		LEFT JOIN
		#DocShipmentOrder b ON a.[1CDocShipmentOrderID] = b.[_1S_IDRRef]
		LEFT JOIN
		#DocShipmentOrder_T_Goods c ON b.IDRef = c.IDRef AND a.[LineNo] = c._LineNo
		WHERE c.IDRef IS NULL AND a.[1CDocShipmentOrderID] NOT IN ('67916C1F-0306-11E6-9E78-002590EBA5B7')

	UPDATE a SET a.[1CNomenclatureID] = d.[_1S_IDRRef], a.[1CCharacteristicID] = e.[_1S_IDRRef]
		, a.[1CMeasureUnitID] = f.[_1S_IDRRef], a.[1CQualityID] = g.[_1S_IDRRef]
		, a.Coefficient = c.Coefficient, a.Amount = c.Amount, a.LoadToTop = c.LoadToTop
	FROM
	[1CDocShipmentOrderGoods] a
	JOIN
	#DocShipmentOrder b ON a.[1CDocShipmentOrderID] = b.[_1S_IDRRef]
	JOIN
	#DocShipmentOrder_T_Goods c ON b.IDRef = c.IDRef AND a.[LineNo] = c._LineNo
	LEFT JOIN
	#RefNomenkl d ON c.IDRef_Nomenkl = d.IDRef
	LEFT JOIN
	#RefCharNomenkl e ON e.IDRef = c.IDRef_CharNomenkl
	LEFT JOIN
	#RefMeasureUnits f ON f.IDRef = c.IDRef_Unit
	LEFT JOIN
	#RefQuality g ON g.IDRef = c.IDRef_Quality
	WHERE
	NOT (((a.[1CNomenclatureID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR	a.[1CNomenclatureID] = d.[_1S_IDRRef])  
	AND ((a.[1CCharacteristicID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR a.[1CCharacteristicID] = e.[_1S_IDRRef])
	AND ((a.[1CMeasureUnitID] IS NULL AND f.[_1S_IDRRef] IS NULL) OR 	a.[1CMeasureUnitID] = f.[_1S_IDRRef]) 
	AND ((a.[1CQualityID] IS NULL AND g.[_1S_IDRRef] IS NULL) OR		a.[1CQualityID] = g.[_1S_IDRRef])
	AND ((a.Coefficient IS NULL AND c.Coefficient IS NULL) OR 			a.Coefficient = c.Coefficient) 
	AND ((a.Amount IS NULL AND c.Amount IS NULL) OR 					a.Amount = c.Amount) 
	AND ((a.LoadToTop IS NULL AND c.LoadToTop IS NULL) OR				a.LoadToTop = c.LoadToTop))

	INSERT INTO [1CDocShipmentOrderGoods] ([1CDocShipmentOrderID], [LineNo], [1CNomenclatureID]
		, [1CCharacteristicID], [1CMeasureUnitID], [1CQualityID], [Coefficient], Amount, LoadToTop)
	SELECT b.[_1S_IDRRef], a._LineNo, c.[_1S_IDRRef], d.[_1S_IDRRef], e.[_1S_IDRRef], f.[_1S_IDRRef]
		, a.Coefficient, a.Amount, a.LoadToTop
	FROM
	#DocShipmentOrder_T_Goods a
	JOIN
	#DocShipmentOrder b ON a.IDRef = b.IDRef
	LEFT JOIN
	#RefNomenkl c ON a.IDRef_Nomenkl = c.IDRef
	LEFT JOIN
	#RefCharNomenkl d ON a.IDRef_CharNomenkl = d.IDRef
	LEFT JOIN
	#RefMeasureUnits e ON a.IDRef_Unit = e.IDRef
	LEFT JOIN
	#RefQuality f ON a.IDRef_Quality = f.IDRef
	WHERE NOT EXISTS
	(
		SELECT ordg.[1CDocShipmentOrderID]
		FROM [1CDocShipmentOrderGoods] ordg
		WHERE ordg.[1CDocShipmentOrderID] = b.[_1S_IDRRef] AND ordg.[LineNo] = a.[_LineNo]
	)
	AND a._lineNo IS NOT NULL AND a.IDRef_Nomenkl IS NOT NULL
--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'---Get1CDocInternalOrders'
	EXEC dbo.Get1CDocInternalOrders
--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'---END'
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocShipmentOrders] TO [PalletRepacker]
    AS [dbo];

