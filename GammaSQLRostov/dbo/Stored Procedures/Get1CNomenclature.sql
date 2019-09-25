-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[Get1CNomenclature]
CREATE PROCEDURE [dbo].[Get1CNomenclature]
AS		
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Загрузка данных'
	SELECT * INTO #RefUnits FROM [Server1c].[Gamma].[dbo].[RefUnits]
	SELECT * INTO #EnumGroupNomenklTypes FROM [Server1C].[Gamma].[dbo].[EnumGroupNomenklTypes]
	SELECT * INTO #RefMeasureUnitsQualifier FROM [Server1c].[Gamma].[dbo].[RefMeasureUnitsQualifier]
	SELECT * INTO #RefMeasureUnits FROM [Server1c].[Gamma].[dbo].[RefMeasureUnits]
	SELECT * INTO #RefNomenkl FROM [Server1c].[Gamma].[dbo].[RefNomenkl]
	SELECT * INTO #RefGroupNomenkl FROM [Server1c].[Gamma].[dbo].[RefGroupNomenkl]
	SELECT * INTO #InfoRgGroupNomenklContent FROM [Server1c].[Gamma].[dbo].[InfoRgGroupNomenklContent]
	SELECT * INTO #RefCharNomenkl FROM [Server1c].[Gamma].[dbo].[RefCharNomenkl]
	SELECT * INTO #RefProperties FROM [Server1c].[Gamma].[dbo].[RefProperties]
	SELECT * INTO #RefPropertyValues FROM [Server1c].[Gamma].[dbo].[RefPropertyValues]
	SELECT * INTO #RefPropertyValuesShared FROM [Server1c].[Gamma].[dbo].[RefPropertyValuesShared]
	SELECT * INTO #RefTechnologicalProperties FROM [server1c].gamma.[dbo].[RefTechnologicalProperties]
	SELECT * INTO #InfoRgPropertyValues FROM [Server1c].[Gamma].[dbo].[InfoRgPropertyValues]
	SELECT * INTO #RefRejectionReasons FROM [Server1c].[Gamma].[dbo].[RefRejectionReasons]
	SELECT * INTO #RefQuality FROM [Server1c].[Gamma].[dbo].[RefQuality]
	SELECT * INTO #RefSpecification FROM [server1c].[Gamma].[dbo].[RefSpecification]
	SELECT * INTO #RefSpecification_T_OutputProducts FROM [server1c].[Gamma].[dbo].[RefSpecification_T_OutputProducts]
	SELECT * INTO #RefSpecification_T_InputProducts FROM [server1c].[gamma].[dbo].[RefSpecification_T_InputProducts]
	SELECT * INTO #RefSpecification_T_NomenklAutoSelect FROM [server1c].gamma.dbo.RefSpecification_T_NomenklAutoSelect
	SELECT * INTO #RefSpecification_T_Wastes FROM [server1c].gamma.dbo.[RefSpecification_T_Wastes]
	SELECT * INTO #InfoRgNomenklMainSpecification FROM [SERVER1C].gamma.dbo.InfoRgNomenklMainSpecification
	SELECT * INTO #InfoRgAnalogs FROM Server1c.gamma.dbo.InfoRgAnalogs
	SELECT * INTO #RefBarcodeTypes FROM [server1c].gamma.dbo.RefBarcodeTypes
	SELECT * INTO #RefSubdivisions FROM [server1c].gamma.dbo.RefSubdivisions
	SELECT * INTO #RefWarehouses FROM [server1c].gamma.dbo.RefWarehouses
	SELECT * INTO #RefContractors FROM [server1c].gamma.dbo.RefContractors
	SELECT * INTO #InfoRgBarcodes FROM [server1c].[gamma].[dbo].[InfoRgBarcodes]

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение переделов'
	BEGIN TRANSACTION places
		UPDATE a
		SET a.Marked = b.Marked, a.Folder = b.Folder, a.Description = b.Description , a.ParentID = c.[_1S_IDRRef]
		FROM
		[1CPlaces] a
		JOIN
		#RefUnits b ON a.[1CPlaceID] = b.[_1S_IDRRef]
		LEFT JOIN
		#RefUnits c ON b.ParentIDRef = c.IDRef
		WHERE
		NOT (((a.Marked IS NULL AND b.Marked IS NULL)			OR a.Marked = b.Marked)
		AND ((a.Folder IS NULL AND b.Folder IS NULL)			OR a.Folder = b.Folder)
		AND ((a.Description IS NULL AND b.Description IS NULL)	OR a.Description = b.Description)
		AND ((a.ParentID IS NULL AND c.[_1S_IDRRef] IS NULL)	OR a.ParentID = c.[_1S_IDRRef]))

		INSERT INTO [1CPlaces] ([1CPlaceID], Marked, Folder, ParentID, Description)
		SELECT a.[_1S_IDRRef] AS [1CPlaceID], a.Marked, a.Folder, b.[_1S_IDRRef], a.Description
		FROM
		#RefUnits a
		LEFT JOIN
		#RefUnits b ON a.ParentIDRef = b.IDRef
		WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CPlaceID] FROM [1CPlaces])
	COMMIT

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение типов групп номенклатуры'
	BEGIN TRANSACTION nomenclatureGroups
		UPDATE a
		SET a.Name = b.[_1S_IDRRef],a.Alias = b.Alias
		FROM
		[1CEnumGroupTypes] a
		JOIN
		#EnumGroupNomenklTypes b ON a.[1CEnumGroupTypeID] = b.[IDRef]
		WHERE
		NOT (((a.Name IS NULL AND b.[_1S_IDRRef] IS NULL)	OR a.Name = b.[_1S_IDRRef])
		AND ((a.Alias IS NULL AND b.Alias IS NULL)			OR a.Alias = b.Alias))

		INSERT INTO [1CEnumGroupTypes] ([1CEnumGroupTypeID],Name,Alias)
		SELECT 
		[IDRef],[_1S_IDRRef],Alias
		FROM #EnumGroupNomenklTypes WHERE [IDRef] NOT IN (SELECT [1CEnumGroupTypeID] FROM [1CEnumGroupTypes])
	COMMIT TRANSACTION

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Коэффициенты единиц измерения'
	BEGIN TRANSACTION measureQualifiers
		INSERT INTO [1CMeasureUnitQualifiers] ([1CMeasureUnitQualifierID],[1CCode],Name,IsInteger)
		SELECT
		[_1S_IDRRef] AS [1CMeasureUnitQualifierID],[_1S_Code] AS [1CCode],[Description] AS Name,IsInteger
		FROM #RefMeasureUnitsQualifier WHERE [_1S_IDRRef] NOT IN (SELECT [1CMeasureUnitQualifierID] FROM [1CMeasureUnitQualifiers])

		UPDATE a
		SET a.[1CCode] = b.[_1S_Code],a.Name = b.Description, a.IsInteger = b.IsInteger
		FROM [1CMeasureUnitQualifiers] a
		JOIN
		#RefMeasureUnitsQualifier b ON a.[1CMeasureUnitQualifierID] = b.[_1S_IDRRef]
		WHERE
		NOT (((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR a.[1CCode] = b.[_1S_Code])
		AND ((a.Name IS NULL AND b.Description IS NULL)		OR a.Name = b.Description)
		AND ((a.IsInteger IS NULL AND b.IsInteger IS NULL)	OR a.IsInteger = b.IsInteger))

	COMMIT

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение единиц измерения'
	BEGIN TRANSACTION
		UPDATE a
		SET a.[1CCode] = b.[_1S_Code],a.[1CMeasureUnitQualifierID] = d.[_1S_IDRRef],
		a.[1CNomenclatureID] = c.[_1S_IDRRef],a.Coefficient = b.[Сoefficient], a.Name = b.Description
		FROM [1CMeasureUnits] a
		JOIN
		#RefMeasureUnits b ON a.[1CMeasureUnitID] = b.[_1S_IDRRef]
		LEFT JOIN
		#RefNomenkl c ON b.OwnerIDRef = c.IDRef
		LEFT JOIN
		#RefMeasureUnitsQualifier d ON b.[MeasureUnitsQualifier] = d.IDRef
		WHERE
		NOT (((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL)						OR a.[1CCode] = b.[_1S_Code])
		AND ((a.[1CMeasureUnitQualifierID] IS NULL AND d.[_1S_IDRRef] IS NULL)	OR a.[1CMeasureUnitQualifierID] = d.[_1S_IDRRef])
		AND ((a.[1CNomenclatureID] IS NULL AND c.[_1S_IDRRef] IS NULL)			OR a.[1CNomenclatureID] = c.[_1S_IDRRef])
		AND ((a.Coefficient IS NULL AND b.[Сoefficient] IS NULL)				OR a.Coefficient = b.[Сoefficient])
		AND ((a.Name IS NULL AND b.Description IS NULL)							OR a.Name = b.Description))

		INSERT INTO [1CMeasureUnits]
		([1CMeasureUnitID],[1CNomenclatureID],[1CMeasureUnitQualifierID],
		[1CCode],[Coefficient],Name)
		SELECT
		a.[_1S_IDRRef] AS [1CMeasureUnitID],b.[_1S_IDRRef] AS [1CNomenclatureID],c.[_1S_IDRRef] AS [1CMeasureUnitQualifierID],
		a.[_1S_Code] AS [1CCode],a.[Сoefficient] AS [Сoefficient],a.[Description] AS Name
		FROM
		#RefMeasureUnits a
		LEFT JOIN
		#RefNomenkl b ON a.OwnerIDRef = b.IDRef
		LEFT JOIN
		#RefMeasureUnitsQualifier c ON a.[MeasureUnitsQualifier] = c.IDRef
		WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CMeasureUnitID] FROM [1CMeasureUnits])

		
	COMMIT 
		
--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение номенклатуры'
	BEGIN TRANSACTION nomenclature
		--- получение папок
		INSERT INTO [1CNomenclature] ([1CNomenclatureID],NomenclatureKindID, [1CBaseMeasureUnitQualifier],[1CCode],[1CParentID],Name
			,IsArchive,IsFolder, Marking, PrintName, FullName, [1CMeaureUnitStorage], [1CMeasureUnitSet], [1CDeleted])
		SELECT
		a.[_1S_IDRRef] AS [1CNomenclatureID],a.KindNomenkl,b.[_1S_IDRRef] AS [1CBaseMeasureUnitQualifier],a.[_1S_Code] AS [1CCode],
		c.[_1S_IDRRef] AS [1CParentID],a.[Description] AS Name,a.IsArchive,a.Folder AS IsFolder, a.Marking, a.PrintDescription, a.FullDescription,
			d.[_1S_IDRRef], e.[_1S_IDRRef], a.Marked
		FROM #RefNomenkl a
		LEFT JOIN
		#RefMeasureUnitsQualifier b ON a.[UnitBaseMeasureByQualifier] = b.[IDref]
		LEFT JOIN
		#RefNomenkl c ON a.ParentIDRef = c.IDRef
		LEFT JOIN
		#RefMeasureUnits d ON a.UnitStorage = d.IDRef
		LEFT JOIN
		#RefMeasureUnits e ON a.UnitSets = e.IDRef
		WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CNomenclatureID] FROM [1CNomenclature])
		AND a.Folder = 1

		UPDATE a
		SET a.[1CCode] = b.[_1S_Code], a.[1CBaseMeasureUnitQualifier] = c.[_1S_IDRRef], a.Marking = b.Marking,
		a.[1CParentID] = d.[_1S_IDRRef],IsArchive = b.IsArchive, a.IsFolder = b.Folder, a.Name = b.[Description],
		a.NomenclatureKindID = b.KindNomenkl, a.PrintName = b.PrintDescription, a.FullName = b.FullDescription,
		a.[1CMeaureUnitStorage] = e.[_1S_IDRRef], a.[1CMeasureUnitSet] = f.[_1S_IDRRef], a.[1CDeleted] = b.Marked
		FROM [1CNomenclature] a
		JOIN
		#RefNomenkl b ON a.[1CNomenclatureID] = b.[_1S_IDRRef]
		LEFT JOIN
		#RefMeasureUnitsQualifier c ON b.[UnitBaseMeasureByQualifier] = c.[IDref]
		LEFT JOIN
		#RefNomenkl d ON b.ParentIDRef = d.IDRef
		LEFT JOIN
		#RefMeasureUnits e ON b.UnitStorage = e.IDRef
		LEFT JOIN
		#RefMeasureUnits f ON b.UnitSets = f.IDRef
		WHERE
		NOT(((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL)							OR (a.[1CCode] IS NOT NULL AND b.[_1S_Code] IS NOT NULL AND a.[1CCode] = b.[_1S_Code])) 
		AND ((a.[1CBaseMeasureUnitQualifier] IS NULL AND c.[_1S_IDRRef] IS NULL)	OR (a.[1CBaseMeasureUnitQualifier] IS NOT NULL AND c.[_1S_IDRRef] IS NOT NULL AND a.[1CBaseMeasureUnitQualifier] = c.[_1S_IDRRef]))
		AND ((a.Marking IS NULL AND b.Marking IS NULL)								OR (a.Marking IS NOT NULL AND b.Marking IS NOT NULL AND a.Marking = b.Marking))
		AND ((a.[1CParentID] IS NULL AND d.[_1S_IDRRef] IS NULL)					OR (a.[1CParentID] IS NOT NULL AND d.[_1S_IDRRef] IS NOT NULL AND a.[1CParentID] = d.[_1S_IDRRef]))
		AND ((a.IsArchive IS NULL AND b.IsArchive IS NULL)							OR (a.IsArchive IS NOT NULL AND b.IsArchive IS NOT NULL AND a.IsArchive = b.IsArchive)) 
		AND ((a.IsFolder IS NULL AND b.Folder IS NULL)								OR (a.IsFolder IS NOT NULL AND b.Folder IS NOT NULL AND a.IsFolder = b.Folder))
		AND ((a.Name IS NULL AND b.[Description] IS NULL)							OR (a.Name IS NOT NULL AND b.[Description] IS NOT NULL AND a.Name = b.[Description]))
		AND ((a.NomenclatureKindID IS NULL AND b.KindNomenkl IS NULL)				OR (a.NomenclatureKindID IS NOT NULL AND b.KindNomenkl IS NOT NULL AND a.NomenclatureKindID = b.KindNomenkl))
		AND ((a.PrintName IS NULL AND b.PrintDescription IS NULL)					OR (a.PrintName IS NOT NULL AND b.PrintDescription IS NOT NULL AND a.PrintName = CAST(b.PrintDescription AS varchar(max))))
		AND ((a.FullName IS NULL AND b.FullDescription IS NULL)						OR (a.FullName IS NOT NULL AND b.FullDescription IS NOT NULL AND a.FullName = CAST(b.FullDescription AS varchar(max))))
		AND ((a.[1CMeaureUnitStorage] IS NULL AND e.[_1S_IDRRef] IS NULL)			OR (a.[1CMeaureUnitStorage] IS NOT NULL AND e.[_1S_IDRRef] IS NOT NULL AND a.[1CMeaureUnitStorage] = e.[_1S_IDRRef]))
		AND ((a.[1CMeasureUnitSet] IS NULL AND f.[_1S_IDRRef] IS NULL)				OR (a.[1CMeasureUnitSet] IS NOT NULL AND f.[_1S_IDRRef] IS NOT NULL AND a.[1CMeasureUnitSet] = f.[_1S_IDRRef]))
		AND ((a.[1CDeleted] IS NULL AND b.[Marked] IS NULL)							OR (a.[1CDeleted] IS NOT NULL AND b.[Marked] IS NOT NULL AND a.[1CDeleted] = b.[Marked])))

		INSERT INTO [1CNomenclature] ([1CNomenclatureID],NomenclatureKindID, [1CBaseMeasureUnitQualifier],[1CCode],[1CParentID],Name
			,IsArchive,IsFolder, Marking, PrintName, FullName, [1CMeaureUnitStorage], [1CMeasureUnitSet], [1CDeleted])
		SELECT
		a.[_1S_IDRRef] AS [1CNomenclatureID],a.KindNomenkl,b.[_1S_IDRRef] AS [1CBaseMeasureUnitQualifier],a.[_1S_Code] AS [1CCode],
		c.[_1S_IDRRef] AS [1CParentID],a.[Description] AS Name,a.IsArchive,a.Folder AS IsFolder, a.Marking, a.PrintDescription, a.FullDescription,
			d.[_1S_IDRRef], e.[_1S_IDRRef], a.Marked
		FROM #RefNomenkl a
		LEFT JOIN
		#RefMeasureUnitsQualifier b ON a.[UnitBaseMeasureByQualifier] = b.[IDref]
		LEFT JOIN
		#RefNomenkl c ON a.ParentIDRef = c.IDRef
		LEFT JOIN
		#RefMeasureUnits d ON a.UnitStorage = d.IDRef
		LEFT JOIN
		#RefMeasureUnits e ON a.UnitSets = e.IDRef
		WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CNomenclatureID] FROM [1CNomenclature])

		UPDATE a SET [1CDeleted] = 1
		--SELECT * 
		FROM [1CNomenclature] a
		LEFT JOIN #RefNomenkl b ON a.[1CNomenclatureID] = b.[_1S_IDRRef]
		WHERE b.[_1S_IDRRef] IS NULL
	COMMIT

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение групп номенклатуры'
	UPDATE a
	SET a.[1CCode] = b.[_1S_Code],a.[1CEnumGroupTypeID] = b.[IDRef_GroupType],
	a.[Description] = b.[Description],a.[1CMeasureUnitID] = c.[_1S_IDRRef]
	FROM [1CNomenclatureGroups] a
	JOIN
	#RefGroupNomenkl b ON a.[1CNomenclatureGroupID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefMeasureUnits c ON b.[IDRef_MeasureUnit] = c.[IDRef]
	WHERE
	NOT (((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL)						OR a.[1CCode] = b.[_1S_Code])
	AND ((a.[1CEnumGroupTypeID] IS NULL AND b.[IDRef_GroupType] IS NULL)	OR a.[1CEnumGroupTypeID] = b.[IDRef_GroupType])
	AND ((a.[Description] IS NULL AND b.[Description] IS NULL)				OR a.[Description] = b.[Description])
	AND ((a.[1CMeasureUnitID] IS NULL AND c.[_1S_IDRRef] IS NULL)			OR a.[1CMeasureUnitID] = c.[_1S_IDRRef]))

	INSERT INTO [1CNomenclatureGroups] ([1CNomenclatureGroupID],[1CCode],[1CEnumGroupTypeID],[Description],[1CMeasureUnitID])
	SELECT a.[_1S_IDRRef],a.[_1S_Code],a.[IDRef_GroupType],a.[Description],b.[_1S_IDRRef]
	FROM 
	#RefGroupNomenkl a
	LEFT JOIN
	#RefMeasureUnits b ON a.[IDRef_MeasureUnit] = b.[IDRef]
	WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CNomenclatureGroupID] FROM [1CNomenclatureGroups])
	
	
--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Заполенение групп номенклатуры'
	DELETE a FROM 
	[1CNomenclatureGroupNomenclature] a
	WHERE NOT EXISTS 
	(
		SELECT * FROM 
		#InfoRgGroupNomenklContent gn
		JOIN
		#RefGroupNomenkl b ON gn.[IDRef_GroupNomenkl] = b.[IDRef]
		JOIN
		#RefNomenkl c ON c.[IDRef] = gn.[IDRef_Nomenkl]
		WHERE b.[_1S_IDRRef] = a.[1CNomenclatureGroupID] AND c.[_1S_IDRRef] = a.[1CNomenclatureID]
	)

	INSERT INTO [1CNomenclatureGroupNomenclature] ([1CNomenclatureGroupID],[1CNomenclatureID])
	SELECT b.[_1S_IDRRef],c.[_1S_IDRRef]
	FROM
	#InfoRgGroupNomenklContent a
	JOIN
	#RefGroupNomenkl b ON a.[IDRef_GroupNomenkl] = b.[IDRef]
	JOIN
	#RefNomenkl c ON c.[IDRef] = a.[IDRef_Nomenkl]
	WHERE NOT EXISTS
	(
		SELECT * FROM
		[1CNomenclatureGroupNomenclature] gn
		WHERE gn.[1CNomenclatureGroupID] = b.[_1S_IDRRef] AND gn.[1CNomenclatureID] = c.[_1S_IDRRef]
	)

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение характеристик номенклатуры'
	UPDATE a 
	SET [1CDeleted] = 1
	FROM
	[1CCharacteristics] a
	WHERE NOT EXISTS (SELECT * FROM #RefCharNomenkl cn WHERE cn.[_1S_IDRRef] = a.[1CCharacteristicID])

	UPDATE a
	SET a.[1CCode] = b.[_1S_Code], a.[1CNomenclatureID] = c.[_1S_IDRRef],
	a.IsActive = b.IsActive, a.MeasureUnitPackage = d.[_1S_IDRRef], a.MeasureUnitPallet = e.[_1S_IDRRef],
	a.Name = b.[Description], a.PrintName = b.PrintDescription, a.[1CDeleted] = b.Marked
	FROM [1CCharacteristics] a
	JOIN
	#RefCharNomenkl b ON a.[1CCharacteristicID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefNomenkl c ON b.OwnerIDRef = c.IDRef
	LEFT JOIN
	#RefMeasureUnits d ON b.[UnitPackage] = d.IDRef
	LEFT JOIN
	#RefMeasureUnits e ON b.[UnitPallet] = e.IDRef
	WHERE
	NOT (((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR				(a.[1CCode] IS NOT NULL AND b.[_1S_Code] IS NOT NULL AND a.[1CCode] = b.[_1S_Code])) 
	AND ((a.[1CNomenclatureID] IS NULL AND c.[_1S_IDRRef] IS NULL) OR	(a.[1CNomenclatureID] IS NOT NULL AND c.[_1S_IDRRef] IS NOT NULL AND a.[1CNomenclatureID] = c.[_1S_IDRRef]))
	AND ((a.IsActive IS NULL AND b.IsActive IS NULL) OR 				(a.IsActive IS NOT NULL AND b.IsActive IS NOT NULL AND a.IsActive = b.IsActive)) 
	AND ((a.MeasureUnitPackage IS NULL AND d.[_1S_IDRRef] IS NULL) OR 	(a.MeasureUnitPackage IS NOT NULL AND d.[_1S_IDRRef] IS NOT NULL AND a.MeasureUnitPackage = d.[_1S_IDRRef]))
	AND ((a.MeasureUnitPallet IS NULL AND e.[_1S_IDRRef] IS NULL) OR	(a.MeasureUnitPallet IS NOT NULL AND e.[_1S_IDRRef] IS NOT NULL AND a.MeasureUnitPallet = e.[_1S_IDRRef]))
	AND ((a.Name IS NULL AND b.[Description] IS NULL) OR 				(a.Name IS NOT NULL AND b.[Description] IS NOT NULL AND a.Name = b.[Description]))
	AND ((a.PrintName IS NULL AND b.PrintDescription IS NULL) OR		(a.PrintName IS NOT NULL AND b.PrintDescription IS NOT NULL AND a.PrintName = CAST(b.PrintDescription AS varchar(max))))
	AND ((a.[1CDeleted] IS NULL AND b.Marked IS NULL) OR 				(a.[1CDeleted] IS NOT NULL AND b.Marked IS NOT NULL AND a.[1CDeleted] = b.Marked)))

	INSERT INTO [1CCharacteristics] ([1CCharacteristicID],[1CNomenclatureID],[1CCode],
	[MeasureUnitPackage],[MeasureUnitPallet],Name,IsActive, PrintName, [1CDeleted])
	SELECT
	a.[_1S_IDRRef] AS [1CCharacteristicID],b.[_1S_IDRRef] AS [1CNomenclatureID],a.[_1S_Code] AS [1CCode],
	c.[_1S_IDRRef] AS [MeasureUnitPackage],d.[_1S_IDRRef] AS [MeasureUnitPallet],a.Description AS Name, a.IsActive,
	a.PrintDescription, a.Marked
	FROM
	#RefCharNomenkl a
	LEFT JOIN
	#RefNomenkl b ON a.OwnerIDRef = b.IDRef
	LEFT JOIN
	#RefMeasureUnits c ON a.[UnitPackage] = c.IDRef
	LEFT JOIN
	#RefMeasureUnits d ON a.[UnitPallet] = d.IDRef
	WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CCharacteristicID] FROM [1CCharacteristics])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение свойств'
	UPDATE a
	SET a.[1CCode] = b.[_1S_Code], a.Name = b.[Description], a.Marked = b.Marked
	FROM [1CProperties] a
	JOIN
	#RefProperties b ON a.[1CPropertyID] = b.[_1S_IDRRef]
	WHERE
	NOT (((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR	a.[1CCode] = b.[_1S_Code]) 
	AND ((a.Name IS NULL AND b.[Description] IS NULL) OR 	a.Name = b.[Description]) 
	AND ((a.Marked IS NULL AND b.Marked IS NULL) OR			a.Marked = b.Marked))

	INSERT INTO [1CProperties] ([1CPropertyID],[1CCode],Name, Marked)
	SELECT
	a.[_1S_IDRRef],a.[_1S_Code] AS [1CCode],[Description] AS Name, a.Marked
	FROM
	#RefProperties a
	WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CPropertyID] FROM [1CProperties])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение значений свойств'
	UPDATE a
	SET a.[1CCode] = b.[_1S_Code],a.[1CPropertyID] = b.PropertyID,a.ValueType = b.ValueType,
	a.Marked = b.Marked,a.Folder = b.Folder, a.ParentID = b.ParentID,a.Description = b.Description,
	a.PrintDescription = b.PrintDescription, a.ValueNumeric = b.Value_Numeric, a.SortValue = b.SortValue,
	a.NotForName = b.NotForName
	FROM [1CPropertyValues] a
	JOIN
	(
		SELECT
		a.[_1S_IDRRef] AS PropertyValueID,a.[_1S_Code] AS _1S_Code,b.[_1S_IDRRef] AS PropertyID,0 AS ValueType,a.Marked,a.Folder,c.[_1S_IDRRef] AS ParentID,
		a.Description,a.PrintDescription,a.Value_Numeric, a.SortValue, a.NotForName
		FROM
		#RefPropertyValues a
		LEFT JOIN
		#RefProperties b ON a.OwnerIDRef = b.IDRef
		LEFT JOIN
		#RefPropertyValues c ON a.ParentIDRef = c.IDRef
--		WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CPropertyValueID] FROM [1CPropertyValues])
		UNION ALL
		SELECT
		a.[_1S_IDRRef] AS PropertyValueID,a.[_1S_Code],b.[_1S_IDRRef] AS PropertyID,0,a.Marked,a.Folder,c.[_1S_IDRRef] AS ParentID,
		a.Description,a.PrintDescription,a.Value_Numeric, a.SortValue, a.NotForName
		FROM
		#RefPropertyValuesShared a
		LEFT JOIN
		#RefProperties b ON a.OwnerIDRef = b.IDRef
		LEFT JOIN
		#RefPropertyValues c ON a.ParentIDRef = c.IDRef
	) b ON a.[1CPropertyValueID] = b.PropertyValueID
	WHERE
	NOT (((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR				a.[1CCode] = b.[_1S_Code])
	AND ((a.[1CPropertyID] IS NULL AND b.PropertyID IS NULL) OR			a.[1CPropertyID] = b.PropertyID)
	AND ((a.ValueType IS NULL AND b.ValueType IS NULL) OR				a.ValueType = b.ValueType)
	AND ((a.Marked IS NULL AND b.Marked IS NULL) OR						a.Marked = b.Marked)
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR 					a.Folder = b.Folder) 
	AND ((a.ParentID IS NULL AND b.ParentID IS NULL) OR					a.ParentID = b.ParentID)
	AND ((a.Description IS NULL AND b.Description IS NULL) OR			a.Description = b.Description)
	AND ((a.PrintDescription IS NULL AND b.PrintDescription IS NULL) OR	CAST(a.PrintDescription AS nvarchar(max)) = CAST(b.PrintDescription AS nvarchar(max)))
	AND ((a.ValueNumeric IS NULL AND b.Value_Numeric IS NULL) OR 		a.ValueNumeric = b.Value_Numeric) 
	AND ((a.SortValue IS NULL AND b.SortValue IS NULL) OR				a.SortValue = b.SortValue)
	AND ((a.NotForName IS NULL AND b.NotForName IS NULL) OR				a.NotForName = b.NotForName))

	INSERT INTO [1CPropertyValues] ([1CPropertyValueID],[1CCode],[1CPropertyID],ValueType,Marked,Folder,ParentID,[Description],
	PrintDescription,ValueNumeric, SortValue, NotForName)
	SELECT
	a.[_1S_IDRRef],a.[_1S_Code],b.[_1S_IDRRef],0,a.Marked,a.Folder,c.[_1S_IDRRef],
	a.Description,a.PrintDescription,a.Value_Numeric, a.SortValue, a.NotForName
	FROM
	#RefPropertyValues a
	LEFT JOIN
	#RefProperties b ON a.OwnerIDRef = b.IDRef
	LEFT JOIN
	#RefPropertyValues c ON a.ParentIDRef = c.IDRef
	WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CPropertyValueID] FROM [1CPropertyValues])
	UNION ALL
	SELECT
	a.[_1S_IDRRef],a.[_1S_Code],b.[_1S_IDRRef],1,a.Marked,a.Folder,c.[_1S_IDRRef],
	a.Description,a.PrintDescription,a.Value_Numeric, a.SortValue, a.NotForName
	FROM
	#RefPropertyValuesShared a
	LEFT JOIN
	#RefProperties b ON a.OwnerIDRef = b.IDRef
	LEFT JOIN
	#RefPropertyValues c ON a.ParentIDRef = c.IDRef
	WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CPropertyValueID] FROM [1CPropertyValues])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение технологических свойств'
	DELETE a
	FROM
	[1CTechnologicalProperties] a
	LEFT JOIN
	#RefTechnologicalProperties b ON a.[1CTechnologicalPropertyID] = b.[_1S_IDRRef]
	WHERE b.IDRef IS NULL

	UPDATE a SET a.Marked = b.Marked, a.Folder = b.Folder, a.ParentID  = c.[_1S_IDRRef], a.[1CCode] = b.[_1S_Code],
		a.Description = b.Description, a.[1CPropertyID] = d.[_1S_IDRRef]
	FROM
	[1CTechnologicalProperties] a
	JOIN
	#RefTechnologicalProperties b ON a.[1CTechnologicalPropertyID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefTechnologicalProperties c ON b.ParentIDRef = c.IDRef
	LEFT JOIN
	#RefProperties d ON b.IDRef_Property = d.IDRef
	WHERE
	NOT (((a.Marked IS NULL AND b.Marked IS NULL) OR				a.Marked = b.Marked) 
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR 				a.Folder = b.Folder) 
	AND ((a.ParentID  IS NULL AND c.[_1S_IDRRef] IS NULL) OR 		a.ParentID  = c.[_1S_IDRRef]) 
	AND ((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR			a.[1CCode] = b.[_1S_Code])
	AND ((a.Description IS NULL AND b.Description IS NULL) OR 		a.Description = b.Description) 
	AND ((a.[1CPropertyID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR	a.[1CPropertyID] = d.[_1S_IDRRef]))

	INSERT INTO [1CTechnologicalProperties] ([1CTechnologicalPropertyID],[Marked],[Folder],[ParentID],[1CCode],[Description],[1CPropertyID])
	SELECT a.[_1S_IDRRef], a.Marked, a.Folder, b.[_1S_IDRRef], a.[_1S_Code], a.Description, c.[_1S_IDRRef]
	FROM
	#RefTechnologicalProperties a
	LEFT JOIN
	#RefTechnologicalProperties b ON a.ParentIDRef = b.IDRef
	LEFT JOIN
	#RefProperties c ON a.IDRef_Property = c.IDRef
	LEFT JOIN
	[1CTechnologicalProperties] d ON d.[1CTechnologicalPropertyID] = a.[_1S_IDRRef]
	WHERE d.[1CTechnologicalPropertyID] IS NULL

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение свойств номенклатуры'
	DELETE a 
	FROM [1CNomenclatureProperties] a
	WHERE NOT EXISTS 
	(
		SELECT *
		FROM #InfoRgPropertyValues pv
		JOIN
		#RefNomenkl d ON pv.[IDRef_Object] = d.IDRef AND pv.[IDRef_Object_RefType] = 1
		JOIN
		#RefProperties p ON pv.[IDRef_Property] = p.IDRef
		WHERE d.[_1S_IDRRef] = a.[1CNomenclatureID] AND a.[1CPRopertyID] = p.[_1S_IDRRef]
	)

	UPDATE f
	SET f.[1CPropertyValueID] = 
	CASE 
		WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef]
		WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END
	,ValueNumeric = a.[_Value_Numeric], ValueText = a.[_Value_Text]
	FROM [1CNomenclatureProperties] f
	JOIN
	#InfoRgPropertyValues a ON a.[IDRef_Object_RefType] = 1 
	LEFT JOIN
	#RefProperties b ON a.[IDRef_Property] = b.IDRef
	LEFT JOIN
	#RefPropertyValues c ON a.[_Value] = c.IDRef AND a.[_Value_RefType] = 3
	LEFT JOIN 
	#RefPropertyValuesShared e ON a.[_Value] = e.IDRef AND a.[_Value_RefType] = 7
	JOIN
	#RefNomenkl d ON a.[IDRef_Object] = d.IDRef AND d.[_1S_IDRRef] = f.[1CNomenclatureID]
	WHERE b.[_1S_IDRRef] = f.[1CPropertyID]
	AND
	NOT (((f.[1CPropertyValueID] IS NULL AND a.[_Value_RefType] IS NULL) OR f.[1CPropertyValueID] = 
	CASE 
		WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef]
		WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END)
	AND ((ValueNumeric IS NULL AND a.[_Value_Numeric] IS NULL)	OR ValueNumeric = a.[_Value_Numeric])
	AND ((ValueText IS NULL AND a.[_Value_Text] IS NULL)		OR ValueText = CAST(a.[_Value_Text] AS varchar(max))))

	INSERT INTO [1CNomenclatureProperties] ([1CNomenclatureID],[1CPropertyID],[1CPropertyValueID],ValueText,ValueNumeric)
	SELECT
	d.[_1S_IDRRef] AS [1CNomenclatureID],b.[_1S_IDRRef] AS [1CPropertyID],
	CASE WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef] 
	WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END AS [1CPropertyValueID], 
	a.[_Value_Text] AS ValueText, a.[_Value_Numeric] AS ValueNumeric
	FROM
	#InfoRgPropertyValues a
	JOIN
	#RefProperties b ON a.[IDRef_Property] = b.IDRef
	LEFT JOIN
	#RefPropertyValues c ON a.[_Value] = c.IDRef AND a.[_Value_RefType] = 3
	LEFT JOIN 
	#RefPropertyValuesShared e ON a.[_Value] = e.IDRef AND a.[_Value_RefType] = 7
	JOIN
	#RefNomenkl d ON a.[IDRef_Object] = d.IDRef
	WHERE a.[IDRef_Object_RefType] = 1 
	AND NOT EXISTS (SELECT * FROM [1CNomenclatureProperties] WHERE [1CNomenclatureID] = d.[_1S_IDRRef] AND [1CPropertyID] = b.[_1S_IDRRef])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение свойств характеристик'
	DELETE a 
	FROM [1CCharacteristicProperties] a
	WHERE NOT EXISTS
	(
		SELECT *
		FROM #InfoRgPropertyValues pv
		JOIN
		#RefCharNomenkl d ON pv.[IDRef_Object] = d.IDRef AND pv.[IDRef_Object_RefType] = 2
		JOIN
		#RefProperties p ON pv.[IDRef_Property] = p.IDRef
		WHERE d.[_1S_IDRRef] = a.[1CCharacteristicID] AND a.[1CPRopertyID] = p.[_1S_IDRRef] 
	)

	UPDATE f
	SET f.[1CPropertyValueID] = 
	CASE
		WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef]
		WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END
	,ValueNumeric = a.[_Value_Numeric], ValueText = a.[_Value_Text]
	FROM [1CCharacteristicProperties] f
	JOIN
	#InfoRgPropertyValues a ON a.[IDRef_Object_RefType] = 2 
	LEFT JOIN
	#RefProperties b ON a.[IDRef_Property] = b.IDRef
	LEFT JOIN
	#RefPropertyValues c ON a.[_Value] = c.IDRef AND a.[_Value_RefType] = 3
	LEFT JOIN 
	#RefPropertyValuesShared e ON a.[_Value] = e.IDRef AND a.[_Value_RefType] = 7
	JOIN
	#RefCharNomenkl d ON a.[IDRef_Object] = d.IDRef AND d.[_1S_IDRRef] = f.[1CCharacteristicID]
	WHERE b.[_1S_IDRRef] = f.[1CPropertyID]
	AND
	NOT (((f.[1CPropertyValueID] IS NULL AND a.[_Value_RefType] IS NULL) OR f.[1CPropertyValueID] = 
	CASE 
		WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef]
		WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END)
	AND ((ValueNumeric IS NULL AND a.[_Value_Numeric] IS NULL)	OR ValueNumeric = a.[_Value_Numeric])
	AND ((ValueText IS NULL AND a.[_Value_Text] IS NULL)		OR ValueText = CAST(a.[_Value_Text] AS varchar(max))))

	INSERT INTO [1CCharacteristicProperties] ([1CCharacteristicID],[1CPropertyID],[1CPropertyValueID],ValueText,ValueNumeric)
	SELECT
	d.[_1S_IDRRef] AS [1CCharacteristicID],b.[_1S_IDRRef] AS [1CPropertyID],
	CASE WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef] 
	WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END AS [1CPropertyValueID], a.[_Value_Text] AS ValueText, a.[_Value_Numeric] AS ValueNumeric
	FROM
	#InfoRgPropertyValues a
	LEFT JOIN
	#RefProperties b ON a.[IDRef_Property] = b.IDRef
	LEFT JOIN
	#RefPropertyValues c ON a.[_Value] = c.IDRef AND a.[_Value_RefType] = 3
	LEFT JOIN 
	#RefPropertyValuesShared e ON a.[_Value] = e.IDRef AND a.[_Value_RefType] = 7
	JOIN
	#RefCharNomenkl d ON a.[IDRef_Object] = d.IDRef
	WHERE a.[IDRef_Object_RefType] = 2
	AND NOT EXISTS (SELECT * FROM [1CCharacteristicProperties] WHERE [1CCharacteristicID] = d.[_1S_IDRRef] AND [1CPropertyID] = b.[_1S_IDRRef])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение свойств переделов'
	DELETE a 
	FROM [1CPlaceProperties] a
	WHERE NOT EXISTS
	(
		SELECT *
		FROM #InfoRgPropertyValues pv
		JOIN
		#RefUnits d ON pv.[IDRef_Object] = d.IDRef AND pv.[IDRef_Object_RefType] = 6
		JOIN
		#RefProperties p ON pv.[IDRef_Property] = p.IDRef
		WHERE d.[_1S_IDRRef] = a.[1CPlaceID] AND a.[1CPRopertyID] = p.[_1S_IDRRef] 
	)

	UPDATE f
	SET f.[1CPropertyValueID] = 
	CASE
		WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef]
		WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END
	,ValueNumeric = a.[_Value_Numeric], ValueText = a.[_Value_Text]
	FROM [1CPlaceProperties] f
	JOIN
	#InfoRgPropertyValues a ON a.[IDRef_Object_RefType] = 6 
	LEFT JOIN
	#RefProperties b ON a.[IDRef_Property] = b.IDRef
	LEFT JOIN
	#RefPropertyValues c ON a.[_Value] = c.IDRef AND a.[_Value_RefType] = 3
	LEFT JOIN 
	#RefPropertyValuesShared e ON a.[_Value] = e.IDRef AND a.[_Value_RefType] = 7
	JOIN
	#RefUnits d ON a.[IDRef_Object] = d.IDRef AND d.[_1S_IDRRef] = f.[1CPlaceID]
	WHERE b.[_1S_IDRRef] = f.[1CPropertyID]
	AND
		NOT (((f.[1CPropertyValueID] IS NULL AND a.[_Value_RefType] IS NULL) OR f.[1CPropertyValueID] = 
	CASE 
		WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef]
		WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END)
	AND ((ValueNumeric IS NULL AND a.[_Value_Numeric] IS NULL)	OR ValueNumeric = a.[_Value_Numeric])
	AND ((ValueText IS NULL AND a.[_Value_Text] IS NULL)		OR ValueText = CAST(a.[_Value_Text] AS varchar(max))))

	INSERT INTO [1CPlaceProperties] ([1CPlaceID],[1CPropertyID],[1CPropertyValueID],ValueText,ValueNumeric)
	SELECT
	d.[_1S_IDRRef] AS [1CCharacteristicID],b.[_1S_IDRRef] AS [1CPropertyID],
	CASE WHEN a.[_Value_RefType] = 3 THEN c.[_1S_IDRRef] 
	WHEN a.[_Value_RefType] = 7 THEN e.[_1S_IDRRef]
	END AS [1CPropertyValueID], a.[_Value_Text] AS ValueText, a.[_Value_Numeric] AS ValueNumeric
	FROM
	#InfoRgPropertyValues a
	LEFT JOIN
	#RefProperties b ON a.[IDRef_Property] = b.IDRef
	LEFT JOIN
	#RefPropertyValues c ON a.[_Value] = c.IDRef AND a.[_Value_RefType] = 3
	LEFT JOIN 
	#RefPropertyValuesShared e ON a.[_Value] = e.IDRef AND a.[_Value_RefType] = 7
	JOIN
	#RefUnits d ON a.[IDRef_Object] = d.IDRef
	WHERE a.[IDRef_Object_RefType] = 6
	AND NOT EXISTS (SELECT * FROM [1CPlaceProperties] WHERE [1CPlaceID] = d.[_1S_IDRRef] AND [1CPropertyID] = b.[_1S_IDRRef])
	

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение причин отклонения'
	UPDATE a
	SET a.IsFolder = b.Folder, a.IsMarked = b.Marked, a.ParentID = c.[_1S_IDRRef], a.Description = b.Description, a.FullDescription = b.FullDescription
	FROM [1CRejectionReasons] a
	JOIN
	#RefRejectionReasons b ON a.[1CRejectionReasonID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefRejectionReasons c ON b.ParentIDRef = c.IDRef
	WHERE
	NOT (((a.IsFolder IS NULL AND b.Folder IS NULL) OR					a.IsFolder = b.Folder) 
	AND ((a.IsMarked IS NULL AND b.Marked IS NULL) OR 					a.IsMarked = b.Marked) 
	AND ((a.ParentID IS NULL AND c.[_1S_IDRRef] IS NULL) OR 			a.ParentID = c.[_1S_IDRRef]) 
	AND ((a.Description IS NULL AND b.Description IS NULL) OR 			a.Description = b.Description) 
	AND ((a.FullDescription IS NULL AND b.FullDescription IS NULL) OR	CAST(a.FullDescription AS nvarchar(max)) = CAST(b.FullDescription AS nvarchar(max))))

	INSERT INTO [1CRejectionReasons] ([1CRejectionReasonID],[IsMarked],[IsFolder],[ParentID],[Description],[FullDescription])
	SELECT
	a.[_1S_IDRRef], a.Marked, a.Folder, b.[_1S_IDRRef], a.Description, a.FullDescription
	FROM 
	#RefRejectionReasons a
	LEFT JOIN
	#RefRejectionReasons b ON a.ParentIDRef = b.IDRef
	WHERE
	a.[_1S_IDRRef] NOT IN (SELECT [1CRejectionReasonID] FROM [1CRejectionReasons])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получения справочника качества из 1С'
	UPDATE a
	SET a.IsFolder = b.Folder, a.Marked = b.Marked, a.Description = b.Description, a.[1CQualityID] = b.[_1S_IDRRef], a.[1CCode] = b.[_1S_Code]
	FROM [1CQuality] a
	JOIN
	#RefQuality b ON a.[1CQualityID] = b.[_1S_IDRRef]
	WHERE
	NOT (((a.IsFolder IS NULL AND b.Folder IS NULL) OR				a.IsFolder = b.Folder) 
	AND ((a.Marked IS NULL AND b.Marked IS NULL) OR 				a.Marked = b.Marked) 
	AND ((a.Description IS NULL AND b.Description IS NULL) OR 		a.Description = b.Description) 
	AND ((a.[1CQualityID] IS NULL AND b.[_1S_IDRRef] IS NULL) OR 	a.[1CQualityID] = b.[_1S_IDRRef])
	AND ((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR			a.[1CCode] = b.[_1S_Code]))

	INSERT INTO [1CQuality] ([1CQualityID], [Marked], [IsFolder], [Description], [1CCode])
	SELECT a.[_1S_IDRRef], a.Marked, a.Folder, a.Description, a.[_1S_Code]
	FROM
	#RefQuality a
	WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CQualityID] fROM [1CQuality])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение спецификаций'
	UPDATE a
	SET a.Description = b.Description, a.ParentID = c.[_1S_IDRRef], a.Marked = b.Marked, a.Folder = b.Folder,
	a.SpecificationType = b.SpecificationType, a.ValidTill = b.ValidTill
	--SELECT a.*, b.*
	FROM
	[1CSpecifications] a
	JOIN
	#RefSpecification b ON a.[1CSpecificationID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefSpecification c ON b.[ParentIDRef] = c.IDRef
	WHERE 
	NOT (((a.Description IS NULL AND b.Description IS NULL) OR (a.Description IS NOT NULL AND b.Description IS NOT NULL AND a.Description = b.Description) )
	AND ((a.ParentID IS NULL AND c.[_1S_IDRRef] IS NULL) OR (a.ParentID IS NOT NULL AND c.[_1S_IDRRef] IS NOT NULL AND a.ParentID = c.[_1S_IDRRef]))
	AND ((a.Marked IS NULL AND b.Marked IS NULL) OR (a.Marked IS NOT NULL AND b.Marked IS NOT NULL AND a.Marked = b.Marked)) 
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR (a.Folder IS NOT NULL AND b.Folder IS NOT NULL AND a.Folder = b.Folder))
	AND ((a.SpecificationType IS NULL AND b.SpecificationType IS NULL) OR (a.SpecificationType IS NOT NULL AND b.SpecificationType IS NOT NULL AND a.SpecificationType = b.SpecificationType))
	AND ((a.ValidTill IS NULL AND b.ValidTill IS NULL) OR (a.ValidTill IS NOT NULL AND b.ValidTill IS NOT NULL AND a.ValidTill = b.ValidTill)))

	INSERT INTO [1CSpecifications] ([1CSpecificationID], Description, ParentID, Marked, Folder, SpecificationType, ValidTill)
	SELECT a.[_1S_IDRRef] AS [1CSpecificationID], a.Description, b.[_1S_IDRRef] AS ParentID, a.Marked, a.Folder, a.SpecificationType, a.ValidTill
	FROM
	#RefSpecification a
	LEFT JOIN
	#RefSpecification b ON a.ParentIDRef = b.IDRef
	WHERE a.[_1S_IDRRef] NOT IN (SELECT [1CSpecificationID] FROM [1CSpecifications])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение выходной номенклатуры спецификации'
	UPDATE a
	SET a.[1CNomenclatureID] = d.[_1S_IDRRef], a.[1CCharacteristicID] = e.[_1S_IDRRef], a.Amount = c.Amount
	FROM
	[1CSpecificationOutputNomenclature] a
	JOIN
	#RefSpecification b ON a.[1CSpecificationID] = b.[_1S_IDRRef]
	JOIN
	#RefSpecification_T_OutputProducts c ON b.[IDRef] = c.[IDRef] AND c._LineNo = a.LineNumber
	JOIN
	#RefNomenkl d ON c.[IDRef_Nomenkl] = d.[IDRef]
	LEFT JOIN
	#RefCharNomenkl e ON c.[IDRef_CharNomenkl] = e.[IDRef]
	WHERE --a.[1CNomenclatureID] <> d.[_1S_IDRRef] OR a.[1CCharacteristicID] <> e.[_1S_IDRRef] OR a.Amount <> c.Amount
	NOT (((a.[1CNomenclatureID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR (a.[1CNomenclatureID] IS NOT NULL AND d.[_1S_IDRRef] IS NOT NULL AND a.[1CNomenclatureID] = d.[_1S_IDRRef])) 
	AND ((a.[1CCharacteristicID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR (a.[1CCharacteristicID] IS NOT NULL AND e.[_1S_IDRRef] IS NOT NULL AND a.[1CCharacteristicID] = e.[_1S_IDRRef])) 
	AND ((a.Amount IS NULL AND c.Amount IS NULL) OR (a.Amount IS NOT NULL AND c.Amount IS NOT NULL AND a.Amount = c.Amount)))
	
	INSERT INTO [1CSpecificationOutputNomenclature] ([1CSPecificationID], LineNumber, [1CNomenclatureID], [1CCharacteristicID], [Amount])
	SELECT d.[_1S_IDRRef] AS [1CSpecificationID], a._LineNo, b.[_1S_IDRRef] AS [1CNomenclatureID], c.[_1S_IDRRef] AS [1CCharacteristicID],
	a.Amount
	FROM
	#RefSpecification_T_OutputProducts a
	JOIN
	#RefNomenkl b ON a.[IDRef_Nomenkl] = b.[IDRef]
	LEFT JOIN
	#RefCharNomenkl c ON a.[IDRef_CharNomenkl] = c.[IDRef]
	JOIN
	#RefSpecification d ON a.[IDRef] = d.[IDRef]
	WHERE NOT EXISTS
	(SELECT [1CSpecificationID] FROM [1CSpecificationOutputNomenclature] outn 
	WHERE d.[_1S_IDRRef] = outn.[1CSpecificationID] AND
	a._LineNo = outn.LineNumber)

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение входной номенклатуры спецификации'
	DELETE cin
	FROM
	[1CSpecificationInputNomenclature] cin
	WHERE NOT EXISTS
	(
		SELECT *
		FROM
		#RefSpecification rs
		JOIN
		#RefSpecification_T_InputProducts rstip ON rs.IDRef = rstip.IDRef
		WHERE cin.[1CSpecificationID] = rs.[_1S_IDRRef] AND cin.LineNumber = rstip._LineNo
	)

	UPDATE a
	SET a.[1CNomenclatureID] = d.[_1S_IDRRef], a.[1CCharacteristicID] = e.[_1S_IDRRef], a.[1CMeasureUnitID] = f._1S_IDRRef
	,a.Amount = c.Amount, a.WithdrawByFact = c.ByFact, a.LinkKey = c.LinkKey, a.SelectionType = c.SelectionType, a.[1CPropertyID] = rp._1S_IDRRef
	FROM
	[1CSpecificationInputNomenclature] a
	JOIN
	#RefSpecification b ON a.[1CSpecificationID] = b.[_1S_IDRRef]
	JOIN
	#RefSpecification_T_InputProducts c ON b.[IDRef] = c.[IDRef] AND c._LineNo = a.LineNumber
	LEFT JOIN
	#RefNomenkl d ON c.[IDRef_Nomenkl] = d.[IDRef]
	LEFT JOIN
	#RefCharNomenkl e ON c.[IDRef_CharNomenkl] = e.[IDRef]
	LEFT JOIN
	#RefMeasureUnits f ON c.IDRef_Unit = f.IDRef
	LEFT JOIN
	#RefProperties rp ON rp.IDRef = c.IDRef_Property
	WHERE 
	--a.[1CNomenclatureID] <> d.[_1S_IDRRef] OR a.[1CCharacteristicID] <> e.[_1S_IDRRef] OR a.[1CMeasureUnitID] <> f._1S_IDRRef
	-- OR a.Amount <> c.Amount OR  a.WithdrawByFact <> c.ByFact OR  a.LinkKey <> c.LinkKey OR a.SelectionType <> c.SelectionType OR a.[1CPropertyID] <> rp._1S_IDRRef
	NOT (((a.[1CNomenclatureID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR (a.[1CNomenclatureID] IS NOT NULL AND d.[_1S_IDRRef] IS NOT NULL AND a.[1CNomenclatureID] = d.[_1S_IDRRef])) 
	AND ((a.[1CCharacteristicID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR (a.[1CCharacteristicID] IS NOT NULL AND e.[_1S_IDRRef] IS NOT NULL AND a.[1CCharacteristicID] = e.[_1S_IDRRef]))  
	AND ((a.[1CMeasureUnitID] IS NULL AND f._1S_IDRRef IS NULL) OR (a.[1CMeasureUnitID] IS NOT NULL AND f._1S_IDRRef IS NOT NULL AND a.[1CMeasureUnitID] = f._1S_IDRRef))
	AND ((a.Amount IS NULL AND c.Amount IS NULL) OR (a.Amount IS NOT NULL AND c.Amount IS NOT NULL AND a.Amount = c.Amount)) 
	AND ((a.WithdrawByFact IS NULL AND c.ByFact IS NULL) OR (a.WithdrawByFact IS NOT NULL AND c.ByFact IS NOT NULL AND a.WithdrawByFact = c.ByFact)) 
	AND ((a.LinkKey IS NULL AND c.LinkKey IS NULL) OR (a.LinkKey IS NOT NULL AND c.LinkKey IS NOT NULL AND a.LinkKey = c.LinkKey)) 
	AND ((a.SelectionType IS NULL AND c.SelectionType IS NULL) OR (a.SelectionType IS NOT NULL AND c.SelectionType IS NOT NULL AND a.SelectionType = c.SelectionType)) 
	AND ((a.[1CPropertyID] IS NULL AND rp._1S_IDRRef IS NULL) OR (a.[1CPropertyID] IS NOT NULL AND rp._1S_IDRRef IS NOT NULL AND a.[1CPropertyID] = rp._1S_IDRRef)))

	INSERT INTO [1CSpecificationInputNomenclature] ([1CSPecificationID], LineNumber, [1CNomenclatureID], [1CCharacteristicID], [Amount]
		, [WithdrawByFact], [1CMeasureUnitID], LinkKey, SelectionType, [1CPropertyID])
	SELECT d.[_1S_IDRRef] AS [1CSpecificationID], a._LineNo, b.[_1S_IDRRef] AS [1CNomenclatureID], c.[_1S_IDRRef] AS [1CCharacteristicID],
	a.Amount, a.ByFact, f._1S_IDRRef, a.LinkKey, a.SelectionType, rp._1S_IDRRef
	FROM
	#RefSpecification_T_InputProducts a
	LEFT JOIN
	#RefNomenkl b ON a.[IDRef_Nomenkl] = b.[IDRef]
	LEFT JOIN
	#RefCharNomenkl c ON a.[IDRef_CharNomenkl] = c.[IDRef]
	JOIN
	#RefSpecification d ON a.[IDRef] = d.[IDRef]
	LEFT JOIN
	#RefMeasureUnits f ON a.IDRef_Unit = f.IDRef
	LEFT JOIN
	#RefProperties rp ON rp.IDRef = a.IDRef_Property
	WHERE NOT EXISTS
	(SELECT [1CSpecificationID] FROM [1CSpecificationInputNomenclature] outn 
	WHERE d.[_1S_IDRRef] = outn.[1CSpecificationID] AND
	a._LineNo = outn.LineNumber)

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение номенклатуры AutoSelect для спецификации'
	DELETE cnas
	FROM
	[1CSpecificationNomenclatureAutoSelect] cnas
	WHERE NOT EXISTS 
	(
		SELECT * FROM
		#RefSpecification rs
		JOIN
		#RefSpecification_T_NomenklAutoSelect rstnas ON rs.IDRef = rstnas.IDRef
		WHERE rs._1S_IDRRef = cnas.[1CSpecificationID] AND rstnas._LineNo = cnas.[LineNo] AND rstnas.LinkKey = cnas.LinkKey
	)

	UPDATE a SET a.[1CNomenclatureID] = rn._1S_IDRRef, a.[1CMeasureUnitID] = rmu._1S_IDRRef, a.Amount = rstnas.Amount,
	a.[1CPropertyValueID] = 
	CASE
		WHEN rstnas._Value_RefType = 3 THEN rpv._1S_IDRRef
		ELSE rpvs._1S_IDRRef
	END
	FROM
	[1CSpecificationNomenclatureAutoSelect] a
	JOIN
	#RefSpecification rs ON a.[1CSpecificationID] = rs._1S_IDRRef
	JOIN
	#RefSpecification_T_NomenklAutoSelect rstnas ON rs.IDRef = rstnas.IDRef AND rstnas._LineNo = a.[LineNo] 
	AND rstnas.LinkKey = a.LinkKey
	JOIN
	#RefNomenkl rn ON rn.IDRef = rstnas.IDRef_Nomenkl
	JOIN
	#RefMeasureUnits rmu ON rmu.IDRef = rstnas.IDRef_Unit
	LEFT JOIN
	#RefPropertyValues rpv ON rpv.IDRef = rstnas._Value
	LEFT JOIN
	#RefPropertyValuesShared rpvs ON rpvs.IDRef = rstnas._Value
	WHERE 
	--a.[1CNomenclatureID] <> rn._1S_IDRRef OR a.[1CMeasureUnitID] <> rmu._1S_IDRRef OR a.Amount <> rstnas.Amount
	--OR (rstnas._Value_RefType = 3 AND a.[1CPropertyValueID] <> rpv._1S_IDRRef) OR (rstnas._Value_RefType <> 3 AND a.[1CPropertyValueID] <> rpvs._1S_IDRRef)
	NOT (((a.[1CNomenclatureID] IS NULL AND rn._1S_IDRRef IS NULL) OR (a.[1CNomenclatureID] IS NOT NULL AND rn._1S_IDRRef IS NOT NULL AND a.[1CNomenclatureID] = rn._1S_IDRRef)) 
	AND ((a.[1CMeasureUnitID] IS NULL AND rmu._1S_IDRRef IS NULL) OR (a.[1CMeasureUnitID] IS NOT NULL AND rmu._1S_IDRRef IS NOT NULL AND a.[1CMeasureUnitID] = rmu._1S_IDRRef)) 
	AND ((a.Amount IS NULL AND rstnas.Amount IS NULL) OR (a.Amount IS NOT NULL AND rstnas.Amount IS NOT NULL AND a.Amount = rstnas.Amount))
	AND ((a.[1CPropertyValueID] IS NULL AND 
	CASE
		WHEN rstnas._Value_RefType = 3 THEN rpv._1S_IDRRef
		ELSE rpvs._1S_IDRRef
	END IS NULL) 
	OR 
	(a.[1CPropertyValueID] IS NOT NULL AND 
	CASE
		WHEN rstnas._Value_RefType = 3 THEN rpv._1S_IDRRef
		ELSE rpvs._1S_IDRRef
	END IS NOT NULL AND a.[1CPropertyValueID] = 
	CASE
		WHEN rstnas._Value_RefType = 3 THEN rpv._1S_IDRRef
		ELSE rpvs._1S_IDRRef
	END )))


	INSERT INTO [1CSpecificationNomenclatureAutoSelect] ([1CSpecificationID], [LineNo], [1CNomenclatureID], [1CMeasureUnitID]
		, Amount, LinkKey, [1CPropertyValueID])
	SELECT rs._1S_IDRRef, rstnas._LineNo, rn._1S_IDRRef, rmu._1S_IDRRef, rstnas.Amount, rstnas.LinkKey,
	CASE
		WHEN rstnas._Value_RefType = 3 THEN rpv._1S_IDRRef
		ELSE rpvs._1S_IDRRef
	END AS [1CPropertyValueID]
	FROM 
	#RefSpecification_T_NomenklAutoSelect rstnas
	JOIN
	#RefSpecification rs ON rstnas.IDRef = rs.IDRef
	JOIN
	#RefNomenkl rn ON rstnas.IDRef_Nomenkl = rn.IDRef
	JOIN
	#RefMeasureUnits rmu ON rmu.IDRef = rstnas.IDRef_Unit
	LEFT JOIN
	#RefPropertyValues rpv ON rpv.IDRef = rstnas._Value
	LEFT JOIN
	#RefPropertyValuesShared rpvs ON rpvs.IDRef = rstnas._Value
	WHERE NOT EXISTS 
	(
		SELECT * FROM
		[1CSpecificationNomenclatureAutoSelect] cnas
		WHERE rstnas._LineNo = cnas.[LineNo] AND rstnas.LinkKey = cnas.LinkKey
		AND cnas.[1CSpecificationID] = rs.[_1S_IDRRef]
	)

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение отходов по спецификациям '
	DELETE cin
	FROM
	[1CSpecificationWastes] cin
	WHERE NOT EXISTS
	(
		SELECT *
		FROM
		#RefSpecification rs
		JOIN
		#RefSpecification_T_Wastes rstip ON rs.IDRef = rstip.IDRef
		WHERE cin.[1CSpecificationID] = rs.[_1S_IDRRef]
	)

	UPDATE a
	SET a.[1CNomenclatureID] = d.[_1S_IDRRef], a.[1CCharacteristicID] = e.[_1S_IDRRef], a.[1CMeasureUnitID] = f._1S_IDRRef
	,a.Amount = c.Amount, a.LinkKey = c.LinkKey, a.SelectionType = c.SelectionType, a.[1CPropertyID] = rp._1S_IDRRef
	FROM
	[1CSpecificationWastes] a
	JOIN
	#RefSpecification b ON a.[1CSpecificationID] = b.[_1S_IDRRef]
	JOIN
	#RefSpecification_T_Wastes c ON b.[IDRef] = c.[IDRef] AND c._LineNo = a.LineNumber
	LEFT JOIN
	#RefNomenkl d ON c.[IDRef_Nomenkl] = d.[IDRef]
	LEFT JOIN
	#RefCharNomenkl e ON c.[IDRef_CharNomenkl] = e.[IDRef]
	LEFT JOIN
	#RefMeasureUnits f ON c.IDRef_Unit = f.IDRef
	LEFT JOIN
	#RefProperties rp ON rp.IDRef = c.IDRef_Property
	WHERE 
	--a.[1CNomenclatureID] <> d.[_1S_IDRRef] OR a.[1CCharacteristicID] <> e.[_1S_IDRRef] OR a.[1CMeasureUnitID] <> f._1S_IDRRef
	-- OR a.Amount <> c.Amount OR  a.LinkKey <> c.LinkKey OR a.SelectionType <> c.SelectionType OR a.[1CPropertyID] <> rp._1S_IDRRef
	NOT (((a.[1CNomenclatureID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR (a.[1CNomenclatureID] IS NOT NULL AND d.[_1S_IDRRef] IS NOT NULL AND a.[1CNomenclatureID] = d.[_1S_IDRRef]))  
	AND ((a.[1CCharacteristicID] IS NULL AND e.[_1S_IDRRef] IS NULL) OR (a.[1CCharacteristicID] IS NOT NULL AND e.[_1S_IDRRef] IS NOT NULL AND a.[1CCharacteristicID] = e.[_1S_IDRRef])) 
	AND ((a.[1CMeasureUnitID] IS NULL AND f._1S_IDRRef IS NULL) OR (a.[1CMeasureUnitID] IS NOT NULL AND f._1S_IDRRef IS NOT NULL AND a.[1CMeasureUnitID] = f._1S_IDRRef))
	AND ((a.Amount IS NULL AND c.Amount IS NULL) OR (a.Amount IS NOT NULL AND c.Amount IS NOT NULL AND a.Amount = c.Amount)) 
	AND ((a.LinkKey IS NULL AND c.LinkKey IS NULL) OR (a.LinkKey IS NOT NULL AND c.LinkKey IS NOT NULL AND a.LinkKey = c.LinkKey)) 
	AND ((a.SelectionType IS NULL AND c.SelectionType IS NULL) OR (a.SelectionType IS NOT NULL AND c.SelectionType IS NOT NULL AND a.SelectionType = c.SelectionType)) 
	AND ((a.[1CPropertyID] IS NULL AND rp._1S_IDRRef IS NULL) OR (a.[1CPropertyID] IS NOT NULL AND rp._1S_IDRRef IS NOT NULL AND a.[1CPropertyID] = rp._1S_IDRRef)))

	INSERT INTO [1CSpecificationWastes] ([1CSPecificationID], LineNumber, [1CNomenclatureID], [1CCharacteristicID], [Amount]
		, [1CMeasureUnitID], LinkKey, SelectionType, [1CPropertyID])
	SELECT d.[_1S_IDRRef] AS [1CSpecificationID], a._LineNo, b.[_1S_IDRRef] AS [1CNomenclatureID], c.[_1S_IDRRef] AS [1CCharacteristicID],
	a.Amount, f._1S_IDRRef, a.LinkKey, a.SelectionType, rp._1S_IDRRef
	FROM
	#RefSpecification_T_Wastes a
	LEFT JOIN
	#RefNomenkl b ON a.[IDRef_Nomenkl] = b.[IDRef]
	LEFT JOIN
	#RefCharNomenkl c ON a.[IDRef_CharNomenkl] = c.[IDRef]
	JOIN
	#RefSpecification d ON a.[IDRef] = d.[IDRef]
	LEFT JOIN
	#RefMeasureUnits f ON a.IDRef_Unit = f.IDRef
	LEFT JOIN
	#RefProperties rp ON rp.IDRef = a.IDRef_Property
	WHERE NOT EXISTS
	(SELECT [1CSpecificationID] FROM [1CSpecificationWastes] outn 
	WHERE d.[_1S_IDRRef] = outn.[1CSpecificationID] AND
	a._LineNo = outn.LineNumber) AND a._LineNo IS NOT NULL

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение главных спецификаций'
	DELETE a
	FROM
	[1CMainSpecifications] a
	WHERE NOT EXISTS
	(
		SELECT * FROM
		#InfoRgNomenklMainSpecification irnms
		JOIN
		#RefSpecification rs ON rs.IDRef = irnms.IDRef_Specification
		JOIN
		#RefNomenkl rn ON rn.IDRef = irnms.IDRef_Nomenkl
		LEFT JOIN
		#RefCharNomenkl cn ON cn.IDRef = irnms.IDRef_CharNomenkl
		LEFT JOIN
		#RefUnits u ON u.IDRef = irnms.IDRef_Unit
		WHERE irnms._Period = a.Period 
			AND a.[1CNomenclatureID] = rn._1S_IDRRef
			AND (rs._1S_IDRRef = a.[1CSpecificationID] OR (rs._1S_IDRRef IS NULL AND a.[1CSpecificationID] IS NULL))
			AND ((a.[1CCharacteristicID] IS NULL AND irnms.IDRef_CharNomenkl IS NULL) OR a.[1CCharacteristicID] = cn.[_1S_IDRRef])
			AND ((a.[1CPlaceID] IS NULL AND irnms.IDRef_Unit IS NULL) OR a.[1CPlaceID] = u.[_1S_IDRRef])
	)


/*
	UPDATE a
	SET a.[1CSpecificationID] = e.[_1S_IDRRef], a.[1CPlaceID] = f.[_1S_IDRRef]
	FROM
	[1CMainSpecifications] a
	JOIN
	#RefNomenkl b ON a.[1CNomenclatureID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefCharNomenkl c ON a.[1CCharacteristicID] = c.[_1S_IDRRef]
	JOIN
	#InfoRgNomenklMainSpecification d ON b.IDRef = d.IDRef_Nomenkl 
	AND ((c.IDRef IS NULL AND d.IDRef_CharNomenkl IS NULL) OR c.IDRef = d.IDRef_CharNomenkl) AND a.Period = d._Period
	JOIN
	#RefSpecification e ON d.IDRef_Specification = e.IDRef
	JOIN
	#RefUnits f ON f.IDRef = d.IDRef_Unit
*/	 
	INSERT INTO [1CMainSpecifications] (Period, [1CNomenclatureID], [1CCharacteristicID], [1CSpecificationID], [1CPlaceID])
	SELECT a._Period, b.[_1S_IDRRef], c.[_1S_IDRRef], e.[_1S_IDRRef], d.[_1S_IDRRef]
	FROM 
	#InfoRgNomenklMainSpecification a
	JOIN
	#RefNomenkl b ON a.[IDRef_Nomenkl] = b.IDRef
	LEFT JOIN
	#RefCharNomenkl c ON a.[IDRef_CharNomenkl] = c.IDRef
	LEFT JOIN
	#RefUnits d ON a.IDRef_Unit = d.IDRef
	LEFT JOIN
	#RefSpecification e ON a.IDRef_Specification = e.IDRef
	WHERE NOT EXISTS
	(SELECT [1CSpecificationID] FROM
	[1CMainSpecifications] msp WHERE 
		msp.Period = a._Period AND msp.[1CNomenclatureID] = b.[_1S_IDRRef]
		AND (msp.[1CSpecificationID] = e.[_1S_IDRRef] OR (msp.[1CSpecificationID] IS NULL AND e.[_1S_IDRRef] IS NULL ))
		AND (msp.[1CCharacteristicID] = c.[_1S_IDRRef] OR (a.IDRef_CharNomenkl IS NULL AND msp.[1CCharacteristicID] IS NULL))
		AND (msp.[1CPlaceID] = d.[_1S_IDRRef] OR (msp.[1CPlaceID] IS NULL AND a.IDRef_Unit IS NULL)))

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение аналогов номенклатуры	'
	SELECT d.IDRef_Nomenkl ,d.IDRef_CharNomenkl,e.[_1S_IDRRef] AS [1CNomenclatureAnalogID], f.[_1S_IDRRef] AS [1CCharacteristicAnalogID] 
		,g.[_1S_IDRRef] AS [1COutputNomenclatureID], h.[_1S_IDRRef] AS [1COutputCharacteristicID]
		,spec.[_1S_IDRRef] AS [1CSpecificationID], d.Priority
		,mu.[_1S_IDRRef] AS [1CMeasureUnitID], d.Amount
		,muan.[_1S_IDRRef] AS [1CMeasureUnitAnalogID], d.AmountAnalog 
	INTO [#1CNomenclatureAnalogs]
	FROM 
	#InfoRgAnalogs d
	JOIN
	#RefNomenkl e ON d.IDRef_Analog = e.IDRef
	LEFT JOIN
	#RefCharNomenkl f ON d.IDRef_CharAnalog = f.IDRef
	LEFT JOIN
	#RefNomenkl g ON d.IDRef_Product = g.IDRef
	LEFT JOIN
	#RefCharNomenkl h ON h.IDRef = d.IDRef_CharProduct
	LEFT JOIN
	#RefSpecification spec ON spec.IDRef = d.IDRef_Specification
	LEFT JOIN
	#RefMeasureUnits mu ON mu.IDRef = d.IDRef_Unit
	LEFT JOIN
	#RefMeasureUnits muan ON muan.IDRef = d.IDRef_UnitAnalog

	DELETE a
	FROM 
	[1CNomenclatureAnalogs] a
	JOIN
	#RefNomenkl b ON a.[1CNomenclatureID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefCharNomenkl c ON a.[1CCharacteristicID] = c.[_1S_IDRRef]
	WHERE NOT EXISTS
	(
		SELECT *
		FROM
		[#1CNomenclatureAnalogs] d 
		WHERE 
		b.IDRef = d.IDRef_Nomenkl 
		AND ((c.IDRef IS NULL AND d.IDRef_CharNomenkl IS NULL) OR c.IDRef = d.IDRef_CharNomenkl)
		AND ((a.[1CNomenclatureAnalogID] IS NULL AND d.[1CNomenclatureAnalogID] IS NULL) OR a.[1CNomenclatureAnalogID] = d.[1CNomenclatureAnalogID])
		AND ((a.[1CCharacteristicAnalogID] IS NULL AND d.[1CCharacteristicAnalogID] IS NULL) OR a.[1CCharacteristicAnalogID] = d.[1CCharacteristicAnalogID])
		AND ((a.[1COutputNomenclatureID] IS NULL AND d.[1COutputNomenclatureID] IS NULL) OR a.[1COutputNomenclatureID] = d.[1COutputNomenclatureID])
		AND ((a.[1COutputCharacteristicID] IS NULL AND d.[1COutputCharacteristicID] IS NULL) OR a.[1COutputCharacteristicID] = d.[1COutputCharacteristicID])
		AND ((a.[1CSpecificationID] IS NULL AND d.[1CSpecificationID] IS NULL) OR a.[1CSpecificationID] = d.[1CSpecificationID])
		AND ((a.[1CMeasureUnitID] IS NULL AND d.[1CMeasureUnitID] IS NULL) OR a.[1CMeasureUnitID] = d.[1CMeasureUnitID])
		AND ((a.[1CMeasureUnitAnalogID] IS NULL AND d.[1CMeasureUnitAnalogID] IS NULL) OR a.[1CMeasureUnitAnalogID] = d.[1CMeasureUnitAnalogID])
	)

	UPDATE a 
	SET a.Priority = d.Priority, [Amount] = d.Amount, [AmountAnalog] = d.AmountAnalog
	FROM
	[1CNomenclatureAnalogs] a
	JOIN
	#RefNomenkl b ON a.[1CNomenclatureID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefCharNomenkl c ON a.[1CCharacteristicID] = c.[_1S_IDRRef]
	JOIN
	[#1CNomenclatureAnalogs] d ON b.IDRef = d.IDRef_Nomenkl 
		AND ((c.IDRef IS NULL AND d.IDRef_CharNomenkl IS NULL) OR c.IDRef = d.IDRef_CharNomenkl)
		AND ((a.[1CNomenclatureAnalogID] IS NULL AND d.[1CNomenclatureAnalogID] IS NULL) OR a.[1CNomenclatureAnalogID] = d.[1CNomenclatureAnalogID])
		AND ((a.[1CCharacteristicAnalogID] IS NULL AND d.[1CCharacteristicAnalogID] IS NULL) OR a.[1CCharacteristicAnalogID] = d.[1CCharacteristicAnalogID])
		AND ((a.[1COutputNomenclatureID] IS NULL AND d.[1COutputNomenclatureID] IS NULL) OR a.[1COutputNomenclatureID] = d.[1COutputNomenclatureID])
		AND ((a.[1COutputCharacteristicID] IS NULL AND d.[1COutputCharacteristicID] IS NULL) OR a.[1COutputCharacteristicID] = d.[1COutputCharacteristicID])
		AND ((a.[1CSpecificationID] IS NULL AND d.[1CSpecificationID] IS NULL) OR a.[1CSpecificationID] = d.[1CSpecificationID])
		AND ((a.[1CMeasureUnitID] IS NULL AND d.[1CMeasureUnitID] IS NULL) OR a.[1CMeasureUnitID] = d.[1CMeasureUnitID])
		AND ((a.[1CMeasureUnitAnalogID] IS NULL AND d.[1CMeasureUnitAnalogID] IS NULL) OR a.[1CMeasureUnitAnalogID] = d.[1CMeasureUnitAnalogID])
	WHERE
	NOT (((a.Priority IS NULL AND d.Priority IS NULL)			OR a.Priority = d.Priority)
	AND ((a.[Amount] IS NULL AND d.Amount IS NULL)				OR a.[Amount] = d.Amount)
	AND ((a.[AmountAnalog] IS NULL AND d.AmountAnalog IS NULL)	OR a.[AmountAnalog] = d.AmountAnalog))
		--
	INSERT INTO [1CNomenclatureAnalogs] ([1CNomenclatureID], [1CCharacteristicID], [1CNomenclatureAnalogID], [1CCharacteristicAnalogID],
		[1COutputNomenclatureID], [1COutputCharacteristicID], [1CSpecificationID], Priority
		,[1CMeasureUnitID], [Amount], [1CMeasureUnitAnalogID], [AmountAnalog])
	SELECT b.[_1S_IDRRef] AS [1CNomenclatureID], c.[_1S_IDRRef] AS [1CCharacteristicID], 
	d.[1CNomenclatureAnalogID], d.[1CCharacteristicAnalogID],
	d.[1COutputNomenclatureID], d.[1COutputCharacteristicID],
	d.[1CSpecificationID], d.Priority, d.[1CMeasureUnitID], d.Amount, d.[1CMeasureUnitAnalogID], d.AmountAnalog
	FROM
	[#1CNomenclatureAnalogs] d
	JOIN
	#RefNomenkl b ON d.[IDRef_Nomenkl] = b.[IDRef]
	LEFT JOIN
	#RefCharNomenkl c ON d.[IDRef_CharNomenkl] = c.[IDRef]
	WHERE NOT EXISTS
	(
		SELECT a.ID
		FROM 
		[1CNomenclatureAnalogs] a
		WHERE 		
		--b.IDRef = d.IDRef_Nomenkl 
		--AND ((c.IDRef IS NULL AND d.IDRef_CharNomenkl IS NULL) OR c.IDRef = d.IDRef_CharNomenkl)
		b.[_1S_IDRRef] = a.[1CNomenclatureID] 
		AND ((c.[_1S_IDRRef] IS NULL AND a.[1CCharacteristicID] IS NULL) OR c.[_1S_IDRRef] = a.[1CCharacteristicID])
		AND ((a.[1CNomenclatureAnalogID] IS NULL AND d.[1CNomenclatureAnalogID] IS NULL) OR a.[1CNomenclatureAnalogID] = d.[1CNomenclatureAnalogID])
		AND ((a.[1CCharacteristicAnalogID] IS NULL AND d.[1CCharacteristicAnalogID] IS NULL) OR a.[1CCharacteristicAnalogID] = d.[1CCharacteristicAnalogID])
		AND ((a.[1COutputNomenclatureID] IS NULL AND d.[1COutputNomenclatureID] IS NULL) OR a.[1COutputNomenclatureID] = d.[1COutputNomenclatureID])
		AND ((a.[1COutputCharacteristicID] IS NULL AND d.[1COutputCharacteristicID] IS NULL) OR a.[1COutputCharacteristicID] = d.[1COutputCharacteristicID])
		AND ((a.[1CSpecificationID] IS NULL AND d.[1CSpecificationID] IS NULL) OR a.[1CSpecificationID] = d.[1CSpecificationID])
		AND ((a.[1CMeasureUnitID] IS NULL AND d.[1CMeasureUnitID] IS NULL) OR a.[1CMeasureUnitID] = d.[1CMeasureUnitID])
		AND ((a.[1CMeasureUnitAnalogID] IS NULL AND d.[1CMeasureUnitAnalogID] IS NULL) OR a.[1CMeasureUnitAnalogID] = d.[1CMeasureUnitAnalogID])
	)

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение типов штрих-кодов'
	UPDATE a SET a.IsMetadata = b.IsMetadata, a.Marked = b.Marked, a.Folder = b.Folder, a.[1CCode] = b.[_1S_Code],
		a.Description = b.Description, a.ValueType = b.Value_Type
	FROM
	[1CBarcodeTypes] a
	JOIN
	#RefBarcodeTypes b ON a.[1CBarcodeTypeID] = b.[_1S_IDRRef]
	WHERE
	NOT (((a.IsMetadata IS NULL AND b.IsMetadata IS NULL) OR		a.IsMetadata = b.IsMetadata)  
	AND ((a.Marked IS NULL AND b.Marked IS NULL) OR 			a.Marked = b.Marked) 
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR 			a.Folder = b.Folder) 
	AND ((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR		a.[1CCode] = b.[_1S_Code])
	AND ((a.Description IS NULL AND b.Description IS NULL) OR 	a.Description = b.Description)
	AND ((a.ValueType IS NULL AND b.Value_Type IS NULL) OR		a.ValueType = b.Value_Type))

	INSERT INTO [1CBarcodeTypes] ([1CBarcodeTypeID], IsMetadata, Marked, Folder, [1CCode], Description, ValueType)
	SELECT a.[_1S_IDRRef] AS [1CBarcodeTypeID], a.IsMetadata, a.Marked, a.Folder, a.[_1S_Code] AS [1CCode], a.Description, a.Value_Type AS ValueType
	FROM
	#RefBarcodeTypes a
	WHERE NOT EXISTS
	(
		SELECT bt.[1CBarcodeTypeID]
		FROM [1CBarcodeTypes] bt WHERE bt.[1CBarcodeTypeID] = a.[_1S_IDRRef]
	)

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение штрих-кодов'
	UPDATE bar SET bar.[1CBarcodeTypeID] = g.[_1S_IDRRef], bar.Barcode = f.Barcode
	FROM
	[1CBarcodes] bar
	LEFT JOIN
	#RefNomenkl b ON b.[_1S_IDRRef] = bar.[1CNomenclatureID]
	LEFT JOIN
	#RefCharNomenkl c ON c.[_1S_IDRRef] = bar.[1CCharacteristicID]
	LEFT JOIN
	#RefMeasureUnits d ON d.[_1S_IDRRef] = bar.[1CMeasureUnitID]
	LEFT JOIN
	#RefQuality e ON e.[_1S_IDRRef] = bar.[1CQualityID]
	JOIN
	#InfoRgBarcodes f ON
		f.IDRef_Owner = b.IDRef 
		AND
		((f.IDRef_CharNomenkl IS NULL AND c.IDRef IS NULL) OR f.IDRef_CharNomenkl = c.IDRef)
		AND
		((f.IDRef_MeasureUnit IS NULL AND d.IDRef IS NULL) OR f.IDRef_MeasureUnit = d.IDRef)
		AND
		((f.IDRef_Quality IS NULL AND e.IDRef IS NULL) OR f.IDRef_Quality = e.IDRef)
	JOIN
	#RefBarcodeTypes g ON f.IDRef_BarcodeType = g.IDRef
	WHERE
	NOT (((bar.[1CBarcodeTypeID] IS NULL AND g.[_1S_IDRRef] IS NULL) OR bar.[1CBarcodeTypeID] = g.[_1S_IDRRef])
	AND ((bar.Barcode IS NULL AND f.Barcode IS NULL) OR bar.Barcode = f.Barcode))

	INSERT INTO [1CBarcodes] ([1CNomenclatureID], [1CCharacteristicID], [1CMeasureUnitID], [1CQualityID], [1CBarcodeTypeID], Barcode)
	SELECT b.[_1S_IDRRef] AS [1CNomenclatureID], c.[_1S_IDRRef] AS [1CCharacteristicID], d.[_1S_IDRRef] AS [1CMeasureUnitID],
		e.[_1S_IDRRef] AS [1CQualityID], f.[_1S_IDRRef] AS [1CBarcodeTypeID], Barcode
	FROM
	#InfoRgBarcodes a
	LEFT JOIN
	#RefNomenkl b ON a.[IDRef_Owner] = b.IDRef
	LEFT JOIN
	#RefCharNomenkl c ON a.[IDRef_CharNomenkl] = c.IDRef
	LEFT JOIN
	#RefMeasureUnits d ON a.[IDRef_MeasureUnit] = d.IDRef
	LEFT JOIN
	#RefQuality e ON a.IDRef_Quality = e.IDRef
	LEFT JOIN
	#RefBarcodeTypes f ON f.IDRef = a.IDRef_BarcodeType
	WHERE NOT EXISTS
	(
		SELECT *
		FROM
		[1CBarcodes] bar 
		WHERE --bar.Barcode = a.Barcode AND
		bar.[1CNomenclatureID] = b.[_1S_IDRRef] AND
		((bar.[1CCharacteristicID] IS NULL AND a.IDRef_CharNomenkl IS NULL) OR bar.[1CCharacteristicID] = c.[_1S_IDRRef])
		AND
		((bar.[1CMeasureUnitID] IS NULL AND a.IDRef_MeasureUnit IS NULL) OR bar.[1CMeasureUnitID] = d.[_1S_IDRRef])
		AND
		((bar.[1CQualityID] IS NULL AND a.IDRef_Quality IS NULL) OR bar.[1CQualityID] = e.[_1S_IDRRef])
	)


--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение подразделений'
	UPDATE a SET a.IsMetadata = b.IsMetadata, a.Marked = b.Marked, a.Folder = b.Folder
	, a.ParentID = c.[_1S_IDRRef], a.[1CCode] = b.[_1S_Code], a.Description = b.Description
	FROM
	[1CSubdivisions] a
	JOIN
	#RefSubdivisions b ON a.[1CSubdivisionID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefSubdivisions c ON b.ParentIDRef = c.IDRef
	WHERE
	NOT (((a.IsMetadata IS NULL AND b.IsMetadata IS NULL) OR	a.IsMetadata = b.IsMetadata)  
	AND ((a.Marked IS NULL AND b.Marked IS NULL) OR 			a.Marked = b.Marked) 
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR				a.Folder = b.Folder)
	AND ((a.ParentID IS NULL AND c.[_1S_IDRRef] IS NULL) OR 	a.ParentID = c.[_1S_IDRRef]) 
	AND ((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR 		a.[1CCode] = b.[_1S_Code]) 
	AND ((a.Description IS NULL AND b.Description IS NULL) OR	a.Description = b.Description))

	INSERT INTO [1CSubdivisions] ([1CSubdivisionID], IsMetadata, Marked, Folder, ParentID, [1CCode], Description)
	SELECT a.[_1S_IDRref], a.IsMetadata, a.Marked, a.Folder, b.[_1S_IDRRef], a.[_1S_Code], a.Description
	FROM
	#RefSubdivisions a
	LEFT JOIN
	#RefSubdivisions b ON a.ParentIDRef = b.IDRef
	WHERE NOT EXISTS
	(SELECT [1CSubdivisionID] FROM
	[1CSubdivisions] sdiv WHERE a._1S_IDRRef = sdiv.[1CSubdivisionID])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение складов'
	UPDATE a SET a.IsMetadata = b.IsMetadata, a.Marked = b.Marked, a.Folder = b.Folder
	, a.ParentID = c.[_1S_IDRRef], a.[1CCode] = b.[_1S_Code], a.Description = b.Description
	, a.[1CSubdivisionID] = d.[_1S_IDRRef], a.Transportation = b.Transportation, a.Transit = b.Transit
	, a.ResponsibleStorage = b.ResponsibleStorage
	FROM
	[1CWarehouses] a
	JOIN
	#RefWarehouses b ON a.[1CWarehouseID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefWarehouses c ON b.ParentIDRef = c.IDRef
	LEFT JOIN
	#RefSubdivisions d ON b.Subdivision = d.IDRef
	WHERE
	NOT (((a.IsMetadata IS NULL AND b.IsMetadata IS NULL) OR 				a.IsMetadata = b.IsMetadata) 
	AND ((a.Marked IS NULL AND b.Marked IS NULL) OR  						a.Marked = b.Marked) 
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR 						a.Folder = b.Folder)
	AND ((a.ParentID IS NULL AND c.[_1S_IDRRef] IS NULL) OR  				a.ParentID = c.[_1S_IDRRef]) 
	AND ((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR  					a.[1CCode] = b.[_1S_Code]) 
	AND ((a.Description IS NULL AND b.Description IS NULL) OR 				a.Description = b.Description)
	AND ((a.[1CSubdivisionID] IS NULL AND d.[_1S_IDRRef] IS NULL) OR  		a.[1CSubdivisionID] = d.[_1S_IDRRef]) 
	AND ((a.Transportation IS NULL AND b.Transportation IS NULL) OR  		a.Transportation = b.Transportation) 
	AND ((a.Transit IS NULL AND b.Transit IS NULL) OR 						a.Transit = b.Transit)
	AND ((a.ResponsibleStorage IS NULL AND b.ResponsibleStorage IS NULL) OR	a.ResponsibleStorage = b.ResponsibleStorage))

	INSERT INTO [1CWarehouses] ([1CWarehouseID], IsMetadata, Marked, Folder, ParentID, [1CCode], Description,
		[1CSubdivisionID], Transportation, Transit, ResponsibleStorage)
	SELECT a.[_1S_IDRRef], a.IsMetadata, a.Marked, a.Folder, b.[_1S_IDRRef], a.[_1S_Code], a.Description,
	c.[_1S_IDRRef], a.Transportation, a.Transit, a.ResponsibleStorage
	FROM
	#RefWarehouses a
	LEFT JOIN
	#RefWarehouses b ON a.ParentIDRef = b.IDRef
	LEFT JOIN
	#RefSubdivisions c ON a.Subdivision = c.IDRef
	WHERE
	NOT EXISTS
	(SELECT [1CWarehouseID] FROM
	[1CWarehouses] wh WHERE a._1S_IDRRef = wh.[1CWarehouseID])

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение контрагентов'
	UPDATE a SET a.Marked = b.Marked, a.Folder = b.Folder, a.ParentID = c.[_1S_IDRRef]
	, a.[1CCode] = b.[_1S_Code], a.Description = b.Description, a.FullDescription = b.FullDescription
	, a.IsBuyer = b.IsBuyer, a.IsSeller = b.IsSeller, a.IsNonresident = b.IsNonresident, a.INN = b.INN, a.KPP = b.KPP
	FROM
	[1CContractors] a
	JOIN
	#RefContractors b ON a.[1CContractorID] = b.[_1S_IDRRef]
	LEFT JOIN
	#RefContractors c ON b.ParentIDRef = c.IDRef
	WHERE
	NOT (((a.Marked IS NULL AND b.Marked IS NULL) OR					a.Marked = b.Marked) 
	AND ((a.Folder IS NULL AND b.Folder IS NULL) OR 					a.Folder = b.Folder) 
	AND ((a.ParentID IS NULL AND c.[_1S_IDRRef] IS NULL) OR			a.ParentID = c.[_1S_IDRRef])
	AND ((a.[1CCode] IS NULL AND b.[_1S_Code] IS NULL) OR 				a.[1CCode] = b.[_1S_Code]) 
	AND ((a.Description IS NULL AND b.Description IS NULL) OR 			a.Description = b.Description) 
	AND ((a.FullDescription IS NULL AND b.FullDescription IS NULL) OR	CAST(a.FullDescription AS nvarchar(max)) = CAST(b.FullDescription AS nvarchar(max)))
	AND ((a.IsBuyer IS NULL AND b.IsBuyer IS NULL) OR 					a.IsBuyer = b.IsBuyer) 
	AND ((a.IsSeller IS NULL AND b.IsSeller IS NULL) OR 				a.IsSeller = b.IsSeller) 
	AND ((a.IsNonresident IS NULL AND b.IsNonresident IS NULL) OR 		a.IsNonresident = b.IsNonresident) 
	AND ((a.INN IS NULL AND b.INN IS NULL) OR 							a.INN = b.INN) 
	AND ((a.KPP IS NULL AND b.KPP IS NULL) OR							a.KPP = b.KPP))

	INSERT INTO [1CContractors] ([1CContractorID], Marked, Folder, ParentID, [1CCode],
		Description, FullDescription, IsBuyer, IsSeller, IsNonresident, INN, KPP)
	SELECT a.[_1S_IDRRef], a.Marked, a.Folder, b.[_1S_IDRRef], a.[_1S_Code]
		, a.Description, a.FullDescription, a.IsBuyer, a.IsSeller, a.IsNonresident, a.INN, a.KPP
	FROM
	#RefContractors a
	LEFT JOIN
	#RefContractors b ON a.ParentIDRef = b.IDRef
	WHERE NOT EXISTS
	(SELECT [1CContractorID] FROM
	[1CContractors] con WHERE a._1S_IDRRef = con.[1CContractorID])


--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение регионов, транспортных точек и внутренних приказов'
	EXEC dbo.Get1CDocInternalOrders


--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение приказов на отгрузку'
	EXEC dbo.Get1CDocShipmentOrders

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--Получение приказов на изменение спецификации'
	EXEC dbo.Get1CDocComplectations

--PRINT RIGHT(CONVERT(VARCHAR(100),GetDate(),113),12)+'--END'

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[Get1CNomenclature] TO [PalletRepacker]
    AS [dbo];

