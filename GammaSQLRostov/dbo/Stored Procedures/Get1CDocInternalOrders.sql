
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[Get1CDocInternalOrders]
AS		
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Загрузка данных'
	IF object_id('tempdb..#RefRegions') is null
		SELECT * INTO #RefRegions FROM [server1c].gamma.dbo.RefRegions
	IF object_id('tempdb..#RefWarehouses') is null
		SELECT * INTO #RefWarehouses FROM [server1c].gamma.dbo.RefWarehouses
	IF object_id('tempdb..#RefTransportPoints') is null
		SELECT * INTO #RefTransportPoints FROM [server1c].gamma.dbo.RefTransportPoints
	IF object_id('tempdb..#RefSubdivisions') is null
		SELECT * INTO #RefSubdivisions FROM [server1c].gamma.dbo.RefSubdivisions
	IF object_id('tempdb..#DocInternalOrders') is null
		SELECT * INTO #DocInternalOrders FROM [server1c].gamma.dbo.DocInternalOrders
	IF object_id('tempdb..#DocInternalOrders_T_Goods') is null
		SELECT * INTO #DocInternalOrders_T_Goods FROM [server1c].gamma.dbo.DocInternalOrders_T_Goods
	IF object_id('tempdb..#RefNomenkl') is null
		SELECT * INTO #RefNomenkl FROM [server1c].gamma.dbo.RefNomenkl
	IF object_id('tempdb..#RefCharNomenkl') is null
		SELECT * INTO #RefCharNomenkl FROM [server1c].gamma.dbo.RefCharNomenkl  
	IF object_id('tempdb..#RefMeasureUnits') is null
		SELECT * INTO #RefMeasureUnits FROM [server1c].gamma.dbo.RefMeasureUnits
	IF object_id('tempdb..#RefQuality') is null
		SELECT * INTO #RefQuality FROM [server1c].gamma.dbo.RefQuality

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--- Получение регионов'
	UPDATE a SET a.Marked = b.Marked, a.Folder = b.Folder, a.[1CParentID] = b.[_1S_IDRRef],
		a.[1CCode] = b.[_1S_Code], a.Description = b.Description
	FROM
	[1CRegions] a
	JOIN
	#RefRegions b ON a.[1CRegionID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefRegions c ON b.ParentIDRef = c.IDRef
	WHERE
	NOT (((a.Marked IS NULL AND b.Marked IS NULL) OR 			a.Marked = b.Marked) 
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR  			a.Folder = b.Folder) 
	AND ((a.[1CParentID] IS NULL AND b.[_1S_IDRRef] IS NULL) OR a.[1CParentID] = b.[_1S_IDRRef])
	AND ((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR  		a.[1CCode] = b.[_1S_Code]) 
	AND ((a.Description IS NULL AND b.Description IS NULL) OR 	a.Description = b.Description))

	INSERT INTO [1CRegions] ([1CRegionID], Marked, Folder, [1CParentID], [1CCode], Description)
	SELECT a.[_1S_IDRRef], a.Marked, a.Folder, b.[_1S_IDRRef], a._1S_Code, a.Description
	FROM
	#RefRegions a
	LEFT JOIN
	#RefRegions b ON a.ParentIDRef = b.IDRef
	WHERE 
	NOT EXISTS 
	(
		SELECT * FROM [1CRegions] WHERE [1CRegionID] = a.[_1S_IDRRef]
	)
	
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
	WHERE
	NOT (((a.Marked IS NULL AND b.Marked IS NULL) OR 			a.Marked = b.Marked) 
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR  			a.Folder = b.Folder) 
	AND ((a.[1CRegionID] IS NULL AND c.[_1S_IDRRef] IS NULL) OR a.[1CRegionID] = c.[_1S_IDRRef])
	AND ((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR  		a.[1CCode] = b.[_1S_Code]) 
	AND ((a.Description IS NULL AND b.Description IS NULL) OR 	a.Description = b.Description)
	AND ((a.IsOwn IS NULL AND b.IsOwn IS NULL) OR				a.IsOwn = b.IsOwn)
	AND ((a.[1CDistributiveCenterID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR a.[1CDistributiveCenterID] = d.[_1S_IDRRef])
	AND ((a.[1CSubDivisionID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR a.[1CSubDivisionID] = e.[_1S_IDRRef]))

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

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--- Получение внутренних приказов'
	DELETE a
	FROM
	[1CDocInternalOrders] a
	WHERE NOT EXISTS (SELECT * FROM #DocInternalOrders WHERE [_1S_IDRRef] = a.[1CDocInternalOrderID])

	UPDATE a SET a.Marked = b.Marked, a.Posted = b.Posted, a.[1CDate] = b.[_1S_date], a.[1CNumber] = b.[_1S_Number],
		a.[1CTransportPointStartID] = c.[_1S_IDRRef], a.[1CTransportPointFinishID] = d.[_1S_IDRRef],
		a.DateStartFrom = b.Date_Start_From, a.DateStartTo = b.Date_Start_To,
		a.DateFinishFrom = b.Date_Finish_From, a.DateFinishTo = b.Date_Finish_To,
		a.[1CWarehouseLoadID] = e.[_1S_IDRRef], a.[1CWarehouseUnloadID] = f.[_1S_IDRRef]
	FROM
	[1CDocInternalOrders] a
	JOIN
	#DocInternalOrders b ON a.[1CDocInternalOrderID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefTransportPoints c ON b.[IDRef_PointStart] = c.[IDRef]
	LEFT JOIN
	#RefTransportPoints d ON b.[IDRef_PointFinish] = d.IDRef
	LEFT JOIN
	#RefWarehouses e ON b.[IDRef_Warehouse_Load] = e.IDRef
	LEFT JOIN
	#RefWarehouses f ON b.[IDRef_Warehouse_Unload] = f.IDRef
	WHERE
	NOT (((a.Marked IS NULL AND b.Marked IS NULL) OR							a.Marked = b.Marked) 
	AND ((a.Posted IS NULL AND b.Posted IS NULL) OR 							a.Posted = b.Posted) 
	AND ((a.[1CDate] IS NULL AND b.[_1S_date] IS NULL) OR 						a.[1CDate] = b.[_1S_date]) 
	AND ((a.[1CNumber] IS NULL AND b.[_1S_Number] IS NULL) OR					a.[1CNumber] = b.[_1S_Number])
	AND ((a.[1CTransportPointStartID] IS NULL AND c.[_1S_IDRRef] IS NULL) OR 	a.[1CTransportPointStartID] = c.[_1S_IDRRef]) 
	AND ((a.[1CTransportPointFinishID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR	a.[1CTransportPointFinishID] = d.[_1S_IDRRef])
	AND ((a.DateStartFrom IS NULL AND b.Date_Start_From IS NULL) OR 			a.DateStartFrom = b.Date_Start_From) 
	AND ((a.DateStartTo IS NULL AND b.Date_Start_To IS NULL) OR					a.DateStartTo = b.Date_Start_To)
	AND ((a.DateFinishFrom IS NULL AND b.Date_Finish_From IS NULL) OR 			a.DateFinishFrom = b.Date_Finish_From) 
	AND ((a.DateFinishTo IS NULL AND b.Date_Finish_To IS NULL) OR				a.DateFinishTo = b.Date_Finish_To)
	AND ((a.[1CWarehouseLoadID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR 			a.[1CWarehouseLoadID] = e.[_1S_IDRRef]) 
	AND ((a.[1CWarehouseUnloadID] IS NULL AND f.[_1S_IDRRef] IS NULL) OR		a.[1CWarehouseUnloadID] = f.[_1S_IDRRef]))

	INSERT INTO [1CDocInternalOrders] ([1CDocInternalOrderID], Marked, Posted, [1CDate], [1CNumber], [1CTransportPointStartID],
		[1CTransportPointFinishID], DateStartFrom, DateStartTo, DateFinishFrom, DateFinishTo, 
		[1CWarehouseLoadID], [1CWarehouseUnloadID])
	SELECT a.[_1S_IDRRef], a.Marked, a.Posted, a.[_1S_Date], a.[_1S_Number], b.[_1S_IDRRef],
			c.[_1S_IDRRef], a.Date_Start_From, a.Date_Start_To, a.Date_Finish_From, a.Date_Finish_To,
			d.[_1S_IDRRef], e.[_1S_IDRRef]
	FROM
	#DocInternalOrders a
	LEFT JOIN
	#RefTransportPoints b ON a.[IDRef_PointStart] = b.[IDRef]
	LEFT JOIN
	#RefTransportPoints c ON a.[IDRef_PointFinish] = c.IDRef
	LEFT JOIN
	#RefWarehouses d ON a.[IDRef_Warehouse_Load] = d.IDRef
	LEFT JOIN
	#RefWarehouses e ON a.[IDRef_Warehouse_Unload] = e.IDRef
	WHERE
	NOT EXISTS (SELECT * FROM [1CDocInternalOrders] WHERE [1CDocInternalOrderID] = a.[_1S_IDRRef])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--- Получение состава внутренних приказов'
	DELETE a
	FROM
	[1CDocInternalOrderGoods] a
	WHERE NOT EXISTS 
	(
		SELECT * 
		FROM 
		#DocInternalOrders_T_Goods g
		JOIN
		#DocInternalOrders o ON g.IDRef = o.IDRef
		WHERE g._LineNo = a.[LineNo] AND o.[_1S_IDRRef] = a.[1CDocInternalOrderID]
	)

	UPDATE a SET a.[1CNomenclatureID] = d.[_1S_IDRRef], a.[1CCharacteristicID] = e.[_1S_IDRRef],
		a.[1CMeasureUnitID] = f.[_1S_IDRRef], a.[1CQualityID] = g.[_1S_IDRRef], a.Coefficient = c.Coefficient,
		a.Amount = c.Amount
	FROM
	[1CDocInternalOrderGoods] a
	JOIN
	#DocInternalOrders b ON a.[1CDocInternalOrderID] = b.[_1S_IDRRef]
	JOIN
	#DocInternalOrders_T_Goods c ON b.IDRef = c.IDRef AND a.[LineNo] = c._LineNo
	LEFT JOIN
	#RefNomenkl d ON c.IDRef_Nomenkl = d.IDRef
	LEFT JOIN
	#RefCharNomenkl e ON c.IDRef_CharNomenkl = e.IDRef
	LEFT JOIN
	#RefMeasureUnits f ON c.IDRef_Unit = f.IDRef
	LEFT JOIN
	#RefQuality g ON c.IDRef_Quality = g.IDRef
	WHERE
	NOT (((a.[1CNomenclatureID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR 	a.[1CNomenclatureID] = d.[_1S_IDRRef]) 
	AND ((a.[1CCharacteristicID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR a.[1CCharacteristicID] = e.[_1S_IDRRef])
	AND ((a.[1CMeasureUnitID] IS NULL AND f.[_1S_IDRRef] IS NULL) OR  	a.[1CMeasureUnitID] = f.[_1S_IDRRef]) 
	AND ((a.[1CQualityID] IS NULL AND g.[_1S_IDRRef] IS NULL) OR  		a.[1CQualityID] = g.[_1S_IDRRef]) 
	AND ((a.Coefficient IS NULL AND c.Coefficient IS NULL) OR 			a.Coefficient = c.Coefficient)
	AND ((a.Amount IS NULL AND c.Amount IS NULL) OR 					a.Amount = c.Amount))

	INSERT INTO [1CDocInternalOrderGoods] ([1CDocInternalOrderID], [LineNo], [1CNomenclatureID], [1CCharacteristicID],
		[1CMeasureUnitID], [1CQualityID], Coefficient, Amount)
	SELECT a.[_1S_IDRRef], b._LineNo, c.[_1S_IDRRef], d.[_1S_IDRRef], e.[_1S_IDRRef], f.[_1S_IDRRef], b.Coefficient, b.Amount
	FROM
	#DocInternalOrders a
	JOIN
	#DocInternalOrders_T_Goods b ON a.IDRef = b.IDRef
	LEFT JOIN
	#RefNomenkl c ON b.IDRef_Nomenkl = c.IDRef
	LEFT JOIN
	#RefCharNomenkl d ON b.IDRef_CharNomenkl = d.IDRef
	LEFT JOIN
	#RefMeasureUnits e ON b.IDRef_Unit = e.IDRef
	LEFT JOIN
	#RefQuality f ON b.IDRef_Quality = f.IDRef
	WHERE b.[_LineNo] IS NOT NULL AND
	NOT EXISTS
	(
		SELECT * FROM [1CDocInternalOrderGoods] ig WHERE
			ig.[1CDocInternalOrderID] = a.[_1S_IDRRef] AND ig.[LineNo] = b._LineNo
	)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocInternalOrders] TO [PalletRepacker]
    AS [dbo];

