-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CheckSourceSpools]
(
	@PlaceID int,
	@ProductionTaskID uniqueidentifier
)
RETURNS varchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @SpecificationID uniqueidentifier, @NumNomenkl int, @NumSourceNomenkl int, @Result varchar(255),
		@NumProductionTaskLayers int, @NumSourceSpoolsLayers int, @NumCorrectNomenclature int, @TempCorrectNum int,
		@ResultDiameter varchar(255)

--	DROP TABLE @SpecNomenclature
--	DROP TABLE @ActiveUnwinderNomenclature

	DECLARE @SpecNomenclature TABLE (rn int, [1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier);
	DECLARE @ActiveUnwinderNomenclature TABLE (NumActiveUnwinders int, [1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier);
		
	WITH SpecNomenclatureWithAnalogs (rn, [1CNomenclatureID], [1CCharacteristicID], [1CNomenclatureAnalogID], [1CCharacteristicAnalogID])
	AS
	(
		SELECT ROW_NUMBER() OVER(PARTITION BY [1CSpecificationID] ORDER BY [1CSpecificationID]) AS rn, [1CNomenclatureID], [1CCharacteristicID],
		[1CNomenclatureAnalogID], [1CNomenclatureCharacteristicID]
		FROM
	(
	SELECT DISTINCT b.[1CSpecificationID], b.[1CNomenclatureID], b.[1CCharacteristicID],
	CASE
		WHEN ana.[1CNomenclatureID] IS NOT NULL THEN ana.[1CNomenclatureID]
		WHEN anb.[1CNomenclatureID] IS NOT NULL THEN anb.[1CNomenclatureID]
		WHEN anc.[1CNomenclatureID] IS NOT NULL THEN anc.[1CNomenclatureID]
		WHEN ane.[1CNOmenclatureID] IS NOT NULL THEN ane.[1CNomenclatureID]
	END AS [1CNomenclatureAnalogID],
	CASE
		WHEN ana.[1CNomenclatureID] IS NOT NULL THEN ana.[1CCharacteristicID]
		WHEN anb.[1CNomenclatureID] IS NOT NULL THEN anb.[1CCharacteristicID]
		WHEN anc.[1CNomenclatureID] IS NOT NULL THEN anc.[1CCharacteristicID]
		WHEN ane.[1CNOmenclatureID] IS NOT NULL THEN ane.[1CCharacteristicID]
	END AS [1CNomenclatureCharacteristicID]
	FROM
	(
	SELECT DISTINCT ISNULL(cP.[1CSpecificationID], bN.[1CSpecificationID]) AS SpecificationID
	FROM
	ProductionTasks a
	JOIN
	[v1CWorkingSpecifications] bN ON a.[1CNomenclatureID] = bN.[1CNomenclatureID] --AND a.[1CCharacteristicID] = bN.[1CCharacteristicID]
	LEFT JOIN
	[v1CWorkingSpecifications] cP ON a.[1CNomenclatureID] = cP.[1CNomenclatureID] --AND a.[1CCharacteristicID] = cp.[1CCharacteristicID] AND
		AND cp.[1CPlaceID] = (SELECT [1CPlaceID] FROM Places WHERE PlaceID = @PlaceID)
	WHERE a.ProductionTaskID = @ProductionTaskID
	) a
	JOIN
	[1CSpecificationInputNomenclature] b ON a.SpecificationID = b.[1CSpecificationID]
	JOIN
	[1CNomenclature] c ON b.[1CNomenclatureID] = c.[1CNomenclatureID] AND c.[NomenclatureKindID] = 1
	LEFT JOIN
	[1CCharacteristics] d ON b.[1CCharacteristicID] = d.[1CCharacteristicID]
	LEFT JOIN
	[1CNomenclatureAnalogs] ana ON ana.[1CNomenclatureID] = b.[1CNomenclatureID] AND ana.[1CCharacteristicID] = b.[1CCharacteristicID] AND
						ana.[1CSpecificationID] = b.[1CSpecificationID]
	LEFT JOIN
	[1CNomenclatureAnalogs] anb ON anb.[1CNomenclatureID] = b.[1CNomenclatureID] AND anb.[1CCharacteristicID] IS NULL AND
						anb.[1CSpecificationID] = b.[1CSpecificationID]
	LEFT JOIN
	[1CNomenclatureAnalogs] anc ON anc.[1CNomenclatureID] = b.[1CNomenclatureID] AND anc.[1CCharacteristicID] = b.[1CCharacteristicID] AND
						anc.[1CSpecificationID] IS NULL
	LEFT JOIN
	[1CNomenclatureAnalogs] ane ON ane.[1CNomenclatureID] = b.[1CNomenclatureID] AND ane.[1CCharacteristicID] IS NULL AND
						ane.[1CSpecificationID] IS NULL
) a	)

--	SELECT * FROM SpecNomenclatureWithAnalogs

	INSERT INTO @SpecNomenclature   -- Номенклатура спецификации
	SELECT DISTINCT rn, [1CNomenclatureID], [1CCharacteristicID]
	FROM SpecNomenclatureWithAnalogs
	UNION ALL
	SELECT rn, [1CNomenclatureAnalogID] AS [1CNomenclatureID], [1CCharacteristicAnalogID] AS [1CCharacteristicID]
	FROM SpecNomenclatureWithAnalogs
	WHERE [1CNomenclatureAnalogID] IS NOT NULL

	INSERT INTO @ActiveUnwinderNomenclature
	SELECT COUNT(*) AS NumActiveUnwinders, b.[1CNomenclatureID], b.[1CCharacteristicID]
	FROM
	(
	SELECT Unwinder1Spool AS ProductID FROM SourceSpools WHERE Unwinder1Active = 1 AND PlaceID = @PlaceID
	UNION ALL
	SELECT Unwinder2Spool AS ProductID FROM SourceSpools WHERE Unwinder2Active = 1 AND PlaceID = @PlaceID
	UNION ALL
	SELECT Unwinder3Spool AS ProductID FROM SourceSpools WHERE Unwinder3Active = 1 AND PlaceID = @PlaceID
	) a
	JOIN
	ProductSpools b ON a.ProductID = b.ProductID
	GROUP BY b.[1CNomenclatureID], b.[1CCharacteristicID]

	SELECT @NumSourceNomenkl = SUM(NumActiveUnwinders) FROM
	@ActiveUnwinderNomenclature
	GROUP BY [1CNomenclatureID]

	SELECT @NumNomenkl = MAX(rn) FROM @SpecNomenclature

-- Проверка по слойности
	SELECT @NumProductionTaskLayers = ISNULL(SUM(dbo.CharacteristicLayerNumber([1CCharacteristicID])),0)
	FROM
	(
	SELECT TOP 1 ISNULL(b.[1CCharacteristicID], a.[1CCharacteristicID]) AS [1CCharacteristicID]
	FROM
	ProductionTasks a
	LEFT JOIN
	ProductionTaskRWCutting b ON a.ProductionTaskID = b.ProductionTaskID
	WHERE a.ProductionTaskID = @ProductionTaskID
	) a

	SELECT @NumSourceSpoolsLayers = ISNULL(SUM(dbo.CharacteristicLayerNumber([1CCharacteristicID])*NumActiveUnwinders),0)
	FROM @ActiveUnwinderNomenclature

	IF @NumProductionTaskLayers <> @NumSourceSpoolsLayers
	BEGIN 
		SET @Result = 'Количество слоев установленных тамбуров не совпадает с заданием! Вы уверены, что хотите продолжить?';
	END

--Проверка по цвету
	IF EXISTS
	(
		SELECT *
		FROM
		@ActiveUnwinderNomenclature a
		JOIN
		[1CCharacteristicProperties] b ON a.[1CCharacteristicID] = b.[1CCharacteristicID] AND b.[1CPropertyID] = '13EE192E-AFBC-11E0-9B2F-4061861FE1EF'
		WHERE
		b.[1CPropertyValueID] NOT IN
		(
			SELECT TOP 1 c.[1CPropertyValueID]
			FROM
			ProductionTasks a
			JOIN
			ProductionTaskRWCutting b ON a.ProductionTaskID = b.ProductionTaskID
			JOIN
			[1CCharacteristicProperties] c ON c.[1CCharacteristicID] = b.[1CCharacteristicID] AND c.[1CPropertyID] = '13EE192E-AFBC-11E0-9B2F-4061861FE1EF'
			WHERE a.ProductionTaskID = @ProductionTaskID
		)
	)
	BEGIN
		SET @Result = 'Цвет исходных тамбуров не совпадает с заданием! Вы уверены, что хотите продолжить?'
	END
	
	
--Проверка по спецификации

	IF @NumNomenkl = 1
	BEGIN
		IF EXISTS
		(
			SELECT * FROM @ActiveUnwinderNomenclature 
			WHERE [1CNomenclatureID] NOT IN
			(
				SELECT DISTINCT [1CNomenclatureID] FROM @SpecNomenclature
			)
		)
		BEGIN
			SET @Result = 'Номенклатура установленных тамбуров не соответствует спецификации на выпускаемую продукцию! Вы уверены, что хотите продолжить?';
		END
	END

	SET @NumCorrectNomenclature = 0;
	IF @NumNomenkl = 2
	BEGIN
		SELECT @TempCorrectNum = ISNULL(SUM(b.NumActiveUnwinders),0)
		FROM
		@SpecNomenclature a
		JOIN
		@ActiveUnwinderNomenclature b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID]
		WHERE a.rn = 1
		
		IF @TempCorrectNum = 0
		BEGIN
			SET @Result = 0;
		END
		ELSE
		BEGIN
			SET @NumCorrectNomenclature = @NumCorrectNomenclature + @TempCorrectNum;
		END

		IF @Result = 1
		BEGIN
			SELECT @TempCorrectNum = ISNULL(SUM(b.NumActiveUnwinders),0)
			FROM
			@SpecNomenclature a
			JOIN
			@ActiveUnwinderNomenclature b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID]
			WHERE a.rn = 2
		
			IF @TempCorrectNum = 0
			BEGIN
				SET @Result = 0;
			END
			ELSE
			BEGIN
				SET @NumCorrectNomenclature = @NumCorrectNomenclature + @TempCorrectNum;
			END
			
			IF @NumCorrectNomenclature <> @NumSourceNomenkl
			BEGIN
				SET @Result = 'Номенклатура установленных тамбуров не соответствует спецификации на выпускаемую продукцию! Вы уверены, что хотите продолжить?';
			END
		END
	END

	SELECT @ResultDiameter = dbo.CheckRWSourceSpoolsDiameter(@PlaceID, @ProductionTaskID)

	IF @ResultDiameter <> ''
	BEGIN
		IF @Result IS NULL OR @Result = '' SET @Result = @ResultDiameter
		ELSE
			SET @Result = @Result + CHAR(13) + 'и' + CHAR(13) + @ResultDiameter
	END

	RETURN ISNULL(@Result, '')
	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckSourceSpools] TO [PalletRepacker]
    AS [dbo];

