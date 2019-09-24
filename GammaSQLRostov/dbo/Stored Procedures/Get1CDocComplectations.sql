
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[Get1CDocComplectations]

CREATE PROCEDURE [dbo].[Get1CDocComplectations]
AS		
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'---Загрузка данных'
	IF object_id('tempdb..#RefWarehouses') is null
		SELECT * INTO #RefWarehouses FROM [server1c].gamma.dbo.RefWarehouses
	IF object_id('tempdb..#RefNomenkl') is null
		SELECT * INTO #RefNomenkl FROM [server1c].gamma.dbo.RefNomenkl
	IF object_id('tempdb..#RefCharNomenkl') is null
		SELECT * INTO #RefCharNomenkl FROM [server1c].gamma.dbo.RefCharNomenkl  
	IF object_id('tempdb..#RefMeasureUnits') is null
		SELECT * INTO #RefMeasureUnits FROM [server1c].gamma.dbo.RefMeasureUnits
	IF object_id('tempdb..#RefQuality') is null
		SELECT * INTO #RefQuality FROM [server1c].gamma.dbo.RefQuality
	IF object_id('tempdb..#DocCharNomenklCorrection') is null
		SELECT * INTO #DocCharNomenklCorrection FROM [server1c].gamma.dbo.[DocCharNomenklCorrection]
	IF object_id('tempdb..#DocCharNomenklCorrection_T_Goods') is null
		SELECT * INTO #DocCharNomenklCorrection_T_Goods FROM [server1c].gamma.dbo.[DocCharNomenklCorrection_T_Goods]

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--- Получение приказов на изменение характеристик (перепалетирование)'
	UPDATE a SET a.Marked = b.Marked, a.Posted = b.Posted, a.[Date] = b.[_1S_Date]
		, a.[1CCode] = b.[_1S_Number], a.[1CWarehouseID] = f.[_1S_IDRRef]
	FROM
	[1CDocComplectation] a
	JOIN
	#DocCharNomenklCorrection b ON a.[1CDocComplectationID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefWarehouses f ON b.[IDRef_Warehouse] = f.[IDRef]
	WHERE
	NOT (((a.Marked IS NULL AND b.Marked IS NULL) OR				(a.Marked IS NOT NULL AND b.Marked IS NOT NULL AND	a.Marked = b.Marked) )
	AND ((a.Posted IS NULL AND b.Posted IS NULL) OR 				(a.Posted IS NOT NULL AND b.Posted IS NOT NULL AND a.Posted = b.Posted) )
	AND ((a.[Date] IS NULL AND b.[_1S_Date] IS NULL) OR				(a.[Date] IS NOT NULL AND b.[_1S_Date] IS NULL AND a.[Date] = b.[_1S_Date]))
	AND ((a.[1CCode] IS NULL AND b.[_1S_Number] IS NULL) OR 		(a.[1CCode] IS NOT NULL AND b.[_1S_Number] IS NOT NULL AND	a.[1CCode] = b.[_1S_Number]) )
	AND ((a.[1CWarehouseID] IS NULL AND f.[_1S_IDRRef] IS NULL) OR 		(a.[1CWarehouseID] IS NOT NULL AND f.[_1S_IDRRef] IS NOT NULL AND a.[1CWarehouseID] = f.[_1S_IDRRef]) )
		)

	INSERT INTO [1CDocComplectation] ([1CDocComplectationID], Marked, Posted, [1CCode], [Date], [1CWarehouseID])
	SELECT a.[_1S_IDRRef], a.Marked, a.Posted, a.[_1S_Number], a.[_1S_Date], e.[_1S_IDRRef]
	FROM
	#DocCharNomenklCorrection a
	LEFT JOIN
	#RefWarehouses e ON a.IDRef_Warehouse = e.IDRef
	WHERE NOT EXISTS
	(SELECT [1CDocComplectationID] 
	FROM [1CDocComplectation] ord
	WHERE ord.[1CDocComplectationID] = a.[_1S_IDRRef])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--- Получение номенклатуры приказов на изменение характеристик (перепалетирование)'
	DELETE a 
	--SELECT *
	FROM [1CDocComplectationNomenclature] a
		LEFT JOIN
		#DocCharNomenklCorrection b ON a.[1CDocComplectationID] = b.[_1S_IDRRef]
		LEFT JOIN
		#DocCharNomenklCorrection_T_Goods c ON b.IDRef = c.IDRef AND a.[LineNumber] = c._LineNo
		WHERE c.IDRef IS NULL

	UPDATE a SET a.[1CNomenclatureID] = d.[_1S_IDRRef], a.[1COldCharacteristicID] = eo.[_1S_IDRRef]
		, a.[1CNewCharacteristicID] = en.[_1S_IDRRef]
		, a.[1CMeasureUnitID] = f.[_1S_IDRRef], a.[1CQualityID] = g.[_1S_IDRRef]
		, a.Quantity = CAST(c.Coefficient * c.Amount AS decimal(18,5))
	FROM
	[1CDocComplectationNomenclature] a
	JOIN
	#DocCharNomenklCorrection b ON a.[1CDocComplectationID] = b.[_1S_IDRRef]
	JOIN
	#DocCharNomenklCorrection_T_Goods c ON b.IDRef = c.IDRef AND a.[LineNumber] = c._LineNo
	LEFT JOIN
	#RefNomenkl d ON c.IDRef_Nomenkl = d.IDRef
	LEFT JOIN
	#RefCharNomenkl eo ON eo.IDRef = c.IDRef_CharNomenkl_old
	LEFT JOIN
	#RefCharNomenkl en ON en.IDRef = c.IDRef_CharNomenkl_new
	LEFT JOIN
	#RefMeasureUnits f ON f.IDRef = c.IDRef_Unit
	LEFT JOIN
	#RefQuality g ON g.IDRef = c.IDRef_Quality
	WHERE
	NOT (((a.[1CNomenclatureID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR	(a.[1CNomenclatureID] IS NOT NULL AND d.[_1S_IDRRef] IS NOT NULL AND a.[1CNomenclatureID] = d.[_1S_IDRRef]))
	AND ((a.[1COldCharacteristicID] IS NULL AND eo.[_1S_IDRRef] IS NULL) OR (a.[1COldCharacteristicID] IS NOT NULL AND eo.[_1S_IDRRef] IS NOT NULL AND a.[1COldCharacteristicID] = eo.[_1S_IDRRef]))
	AND ((a.[1CNewCharacteristicID] IS NULL AND en.[_1S_IDRRef] IS NULL) OR (a.[1CNewCharacteristicID] IS NOT NULL AND en.[_1S_IDRRef] IS NOT NULL AND a.[1CNewCharacteristicID] = en.[_1S_IDRRef]))
	AND ((a.[1CMeasureUnitID] IS NULL AND f.[_1S_IDRRef] IS NULL) OR 	(a.[1CMeasureUnitID] IS NOT NULL AND f.[_1S_IDRRef] IS NOT NULL AND a.[1CMeasureUnitID] = f.[_1S_IDRRef]) )
	AND ((a.[1CQualityID] IS NULL AND g.[_1S_IDRRef] IS NULL) OR		(a.[1CQualityID] IS NOT NULL AND g.[_1S_IDRRef] IS NOT NULL AND a.[1CQualityID] = g.[_1S_IDRRef]))
	AND ((c.Coefficient * c.Amount IS NULL AND a.Quantity IS NULL) OR 	(c.Coefficient * c.Amount IS NOT NULL AND a.Quantity IS NULL AND CAST(c.Coefficient * c.Amount AS decimal(18,5)) = a.Quantity) )
	AND ((a.[1CQualityID] IS NULL AND g.[_1S_IDRRef] IS NULL) OR		(a.[1CQualityID] IS NOT NULL AND g.[_1S_IDRRef] IS NOT NULL AND a.[1CQualityID] = g.[_1S_IDRRef]))
		)

	INSERT INTO [1CDocComplectationNomenclature] ([1CDocComplectationID], [LineNumber], [1CNomenclatureID]
		, [1COldCharacteristicID], [1CNewCharacteristicID], [1CMeasureUnitID], [1CQualityID], Quantity)
	SELECT b.[_1S_IDRRef], a._LineNo, c.[_1S_IDRRef], do.[_1S_IDRRef], dn.[_1S_IDRRef], e.[_1S_IDRRef], f.[_1S_IDRRef]
		, CAST(a.Coefficient * a.Amount AS decimal(18,5)) AS Quantity
	FROM
	#DocCharNomenklCorrection_T_Goods a
	JOIN
	#DocCharNomenklCorrection b ON a.IDRef = b.IDRef
	LEFT JOIN
	#RefNomenkl c ON a.IDRef_Nomenkl = c.IDRef
	LEFT JOIN
	#RefCharNomenkl do ON a.IDRef_CharNomenkl_old = do.IDRef
	LEFT JOIN
	#RefCharNomenkl dn ON a.IDRef_CharNomenkl_new = dn.IDRef
	LEFT JOIN
	#RefMeasureUnits e ON a.IDRef_Unit = e.IDRef
	LEFT JOIN
	#RefQuality f ON a.IDRef_Quality = f.IDRef
	WHERE NOT EXISTS
	(
		SELECT ordg.[1CDocComplectationID]
		FROM [1CDocComplectationNomenclature] ordg
		WHERE ordg.[1CDocComplectationID] = b.[_1S_IDRRef] AND ordg.[LineNumber] = a.[_LineNo]
	)
	AND a._lineNo IS NOT NULL AND a.IDRef_Nomenkl IS NOT NULL
--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'---END'
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CDocComplectations] TO [PalletRepacker]
    AS [dbo];

