-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================

CREATE PROCEDURE [dbo].[CheckProductionTaskSourceSpools]
(
	@PlaceID int,
	@ProductionTaskID uniqueidentifier
)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @SpecificationID uniqueidentifier, @NumNomenkl int, @NumSourceNomenkl int, @ResultMessage varchar(255), @BlockCreation bit = 0, @PlaceGroupID int,
		@NumProductionTaskLayers int, @NumSourceSpoolsLayers int, @NumCorrectNomenclature int, @TempCorrectNum int, @i int = 1,
		@ResultDiameter varchar(255)

	DECLARE @SpecNomenclature TABLE (rn int, [1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier);
	DECLARE @ActiveUnwinderNomenclature TABLE (NumActiveUnwinders int, [1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier);
	DECLARE @IncorrectNomenclature TABLE ([1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier)
	DECLARE @SpecNomenclatureWithAnalogs TABLE (rn int, [1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier, 
		[1CNomenclatureAnalogID] uniqueidentifier, [1CCharacteristicAnalogID] uniqueidentifier)
--	DECLARE @WorkingSpecifications TABLE ([1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier, [1CPlaceID] uniqueidentifier, 
--		[1CSpecificationID] uniqueidentifier, IsAllChars Bit)

	SELECT @PlaceGroupID = PlaceGroupID 
	FROM
	Places 
	WHERE PlaceID = @PlaceID;

--	INSERT INTO @WorkingSpecifications
--	EXEC dbo.GetWorkingSpecifications

	DECLARE specCursor CURSOR
	FOR SELECT DISTINCT ISNULL(eP.[1CSpecificationID], cp.[1CSpecificationID]) AS SpecificationID
				FROM
				ProductionTasks a
				LEFT JOIN
				v1CWorkingSpecifications cP ON a.[1CNomenclatureID] = cP.[1CNomenclatureID] AND a.[1CCharacteristicID] = cp.[1CCharacteristicID]
					AND cp.[1CPlaceID] = (SELECT [1CPlaceID] FROM Places WHERE PlaceID = @PlaceID)
				LEFT JOIN
				ProductionTaskRWCutting d ON a.ProductionTaskID = d.ProductionTaskID
				LEFT JOIN
				[v1CWorkingSpecifications] eP ON d.[1CNomenclatureID] = eP.[1CNomenclatureID] AND d.[1CCharacteristicID] = eP.[1CCharacteristicID]
					AND ep.[1CPlaceID] = (SELECT [1CPlaceID] FROM Places WHERE PlaceID = @PlaceID)
				WHERE a.ProductionTaskID = @ProductionTaskID

	OPEN specCursor;

	FETCH NEXT FROM specCursor 
	INTO
	@SpecificationID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		DELETE @SpecNomenclatureWithAnalogs;
		
		INSERT INTO @SpecNomenclatureWithAnalogs (rn, [1CNomenclatureID], [1CCharacteristicID] , 
				[1CNomenclatureAnalogID], [1CCharacteristicAnalogID])
		SELECT DISTINCT DENSE_RANK() OVER (ORDER BY [1CSpecificationID], LineNumber) AS rn, [1CNomenclatureID], [1CCharacteristicID],
		[1CNomenclatureAnalogID], [1CCharacteristicAnalogID]
		FROM
		(
			SELECT DISTINCT b.[1CSpecificationID], b.[1CNomenclatureID], b.[1CCharacteristicID], b.LineNumber,
			CASE
				WHEN ana.[1CNomenclatureID] IS NOT NULL THEN ana.[1CNomenclatureAnalogID]
				WHEN anb.[1CNomenclatureID] IS NOT NULL THEN anb.[1CNomenclatureAnalogID]
				WHEN anc.[1CNomenclatureID] IS NOT NULL THEN anc.[1CNomenclatureAnalogID]
				WHEN ane.[1CNOmenclatureID] IS NOT NULL THEN ane.[1CNomenclatureAnalogID]
			END AS [1CNomenclatureAnalogID],
			CASE
				WHEN ana.[1CNomenclatureID] IS NOT NULL THEN ana.[1CCharacteristicAnalogID]
				WHEN anb.[1CNomenclatureID] IS NOT NULL THEN anb.[1CCharacteristicAnalogID]
				WHEN anc.[1CNomenclatureID] IS NOT NULL THEN anc.[1CCharacteristicAnalogID]
				WHEN ane.[1CNOmenclatureID] IS NOT NULL THEN ane.[1CCharacteristicAnalogID]
			END AS [1CCharacteristicAnalogID]
			FROM
			[1CSpecificationInputNomenclature] b 
			JOIN
			[1CNomenclature] c ON b.[1CNomenclatureID] = c.[1CNomenclatureID] AND c.[NomenclatureKindID] = 1 
				AND EXISTS (SELECT * FROM PlaceGroup1CNomenclature WHERE PlaceGroupID IN (0,1) AND [1CNomenclatureID] = c.[1CParentID])
			LEFT JOIN
			[1CCharacteristics] d ON b.[1CCharacteristicID] = d.[1CCharacteristicID]
			LEFT JOIN
			[1CNomenclatureAnalogs] ana ON ana.[1CNomenclatureID] = b.[1CNomenclatureID] AND (ana.[1CCharacteristicID] = b.[1CCharacteristicID] OR
								(b.[1CCharacteristicID] IS NULL AND ana.[1CCharacteristicID] IS NULL)) AND
								ana.[1CSpecificationID] = b.[1CSpecificationID]
			LEFT JOIN
			[1CNomenclatureAnalogs] anb ON anb.[1CNomenclatureID] = b.[1CNomenclatureID] AND anb.[1CCharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL AND
								anb.[1CSpecificationID] = b.[1CSpecificationID]
			LEFT JOIN
			[1CNomenclatureAnalogs] anc ON anc.[1CNomenclatureID] = b.[1CNomenclatureID] AND anc.[1CCharacteristicID] = b.[1CCharacteristicID] AND
								anc.[1CSpecificationID] IS NULL
			LEFT JOIN
			[1CNomenclatureAnalogs] ane ON ane.[1CNomenclatureID] = b.[1CNomenclatureID] AND ane.[1CCharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL AND
								ane.[1CSpecificationID] IS NULL
			WHERE b.[1CSpecificationID] = @SpecificationID
		) a
		WHERE a.[1CCharacteristicID] IS NULL OR (a.[1CCharacteristicID] IS NOT NULL AND a.[1CNomenclatureAnalogID] IS NULL)
			OR (a.[1CCharacteristicID] IS NOT NULL AND a.[1CCharacteristicAnalogID] IS NOT NULL)

		IF NOT EXISTS (SELECT * FROM @SpecNomenclature)
		BEGIN
			INSERT INTO @SpecNomenclature   -- Номенклатура спецификации c непустыми номенклатурой и характеристикой
			SELECT DISTINCT rn, [1CNomenclatureID], [1CCharacteristicID]
			FROM
			(
				SELECT DISTINCT rn, a.[1CNomenclatureID], ISNULL(a.[1CCharacteristicID], b.[1CCharacteristicID]) AS [1CCharacteristicID]
				FROM @SpecNomenclatureWithAnalogs a
				LEFT JOIN
				[1CCharacteristics] b ON a.[1CCharacteristicID] IS NULL AND a.[1CNomenclatureID] = b.[1CNomenclatureID]
				UNION ALL
				SELECT rn, [1CNomenclatureAnalogID] AS [1CNomenclatureID], ISNULL([1CCharacteristicAnalogID],b.[1CCharacteristicID]) AS [1CCharacteristicID]
				FROM @SpecNomenclatureWithAnalogs a
				LEFT JOIN
				[1CCharacteristics] b ON a.[1CCharacteristicAnalogID] IS NULL AND a.[1CNomenclatureAnalogID] = b.[1CNomenclatureID]
				WHERE [1CNomenclatureAnalogID] IS NOT NULL
			) a
		END
		ELSE
		BEGIN
			DELETE a
			FROM
			@SpecNomenclature a
			LEFT JOIN
			@SpecNomenclatureWithAnalogs b ON (a.[1CNOmenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID])
				OR (a.[1CNomenclatureID] = b.[1CNomenclatureAnalogID] AND a.[1CCharacteristicID] = b.[1CCharacteristicAnalogID])
			WHERE b.[1CNomenclatureID] IS NULL AND b.[1CNomenclatureAnalogID] IS NULL
		END
		FETCH NEXT FROM specCursor
		INTO @SpecificationID
	END

	CLOSE specCursor;
	DEALLOCATE specCursor

	IF NOT EXISTS (SELECT * FROM @SpecNomenclature)
	BEGIN
		SET @ResultMessage = 'Не найдено спецификации на продукцию для текущего передела!';
		IF @PlaceGroupID = 99  -- затычка от 14.10.2017 (ЛОмунов)
		BEGIN
			SET @BlockCreation = 1;
		END
		ELSE 
		BEGIN
			SET @ResultMessage = @ResultMessage + ' Вы уверены, что хотите продолжить?';
		END
	END

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

	--SELECT * FROM @ActiveUnwinderNomenclature

	SELECT @NumSourceNomenkl = SUM(NumActiveUnwinders) FROM
	@ActiveUnwinderNomenclature
	GROUP BY [1CNomenclatureID]

	SELECT @NumNomenkl = (SELECT COUNT(*) FROM (SELECT DISTINCT rn FROM @SpecNomenclature) a)

	IF @PlaceGroupID = 1
	BEGIN
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
			SET @ResultMessage = 'Количество слоев установленных тамбуров не совпадает с заданием!'-- Вы уверены, что хотите продолжить?';
			SET @BlockCreation = 1;
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
			SET @ResultMessage = 'Цвет исходных тамбуров не совпадает с заданием!';-- Вы уверены, что хотите продолжить?'
			SET @BlockCreation = 1;
		END

	---Проверка по индивидуальному заказу
		IF EXISTS
		(
			SELECT *
			FROM
			ProductionTaskRWCutting a
			JOIN
			vCharacteristicSGBProperties b ON a.[1CCharacteristicID] = b.[1CCharacteristicID]
			WHERE REPLACE(b.Buyer, '<>', '') > '' AND a.ProductionTaskID = @ProductionTaskID  -- 03/12/2016 Ломунов отлов "<>" в характеристике
			AND b.Buyer NOT IN 
			(
				SELECT ISNULL(b.Buyer,'') FROM 
				@ActiveUnwinderNomenclature a 
				JOIN
				vCharacteristicSGBProperties b ON a.[1CCharacteristicID] = b.[1CCharacteristicID]
			)
		)
		BEGIN
			SET @ResultMessage = 'Исходные тамбура не соответствуют данному индивидуальному заказу';
			SET @BlockCreation = 1;
		END

	--- Проверка по диаметру

		SELECT @ResultDiameter = dbo.CheckRWSourceSpoolsDiameter(@PlaceID, @ProductionTaskID)

		IF @ResultDiameter <> ''
		BEGIN
			IF @ResultMessage IS NULL OR @ResultMessage = '' SET @ResultMessage = @ResultDiameter
			ELSE
				SET @ResultMessage = @ResultMessage + CHAR(13) + 'и' + CHAR(13) + @ResultDiameter
		END
	END
	ELSE 
	BEGIN -- проверка конвертингов по свойствам
		-- Проверка по слойности
		SELECT @NumProductionTaskLayers = ISNULL(SUM(dbo.NomenclatureLayerNumber([1CNomenclatureID])),0)
		FROM
		(
			SELECT TOP 1 a.[1CNomenclatureID]
			FROM
			ProductionTasks a
			WHERE a.ProductionTaskID = @ProductionTaskID
		) a

		SELECT @NumSourceSpoolsLayers = ISNULL(SUM(dbo.CharacteristicLayerNumber([1CCharacteristicID])*NumActiveUnwinders),0)
		FROM @ActiveUnwinderNomenclature

		IF @NumProductionTaskLayers <> @NumSourceSpoolsLayers
		BEGIN 
			SET @ResultMessage = 'Количество слоев установленных тамбуров не совпадает с заданием! Вы уверены, что хотите продолжить?';
		END
	END
	
--Проверка по спецификации
	
	IF @NumNomenkl > (SELECT COUNT(*) FROM @ActiveUnwinderNomenclature)
	BEGIN
		SET @ResultMessage = 'По сцефикации на раскатах должны быть установлены тамбура разных номенклатур!';
		IF @PlaceGroupID = 1
		BEGIN
			SET @BlockCreation = 1
		END
		ELSE 
		BEGIN
			SET @ResultMessage = @ResultMessage + ' Вы уверены, что хотите продолжить?'
		END
	END
	ELSE 
	BEGIN
		WHILE @i <= @NumNomenkl
		BEGIN
			IF NOT EXISTS 
			(
				SELECT * FROM
				@ActiveUnwinderNomenclature a
				JOIN
				@SpecNomenclature b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]-- AND a.[1CCharacteristicID] = b.[1CCharacteristicID]
				WHERE b.rn = @i
			)
			BEGIN
				SET @ResultMessage = 'Номенклатура тамбура на раскате ';
				INSERT INTO @IncorrectNomenclature ([1CNomenclatureID], [1CCharacteristicID])
				SELECT a.[1CNomenclatureID], a.[1CCharacteristicID]
				FROM
				@ActiveUnwinderNomenclature a
				WHERE NOT EXISTS (SELECT * FROM @SpecNomenclature WHERE [1CNomenclatureID] = a.[1CNomenclatureID] AND 
					([1CCharacteristicID] IS NULL OR ([1CCharacteristicID] IS NOT NULL AND [1CCharacteristicID] = a.[1CCharacteristicID]))
				)

				IF EXISTS (SELECT * FROM SourceSpools a --- проверка раската 1
						JOIN ProductSpools b ON a.Unwinder1Spool = b.ProductID
						JOIN @IncorrectNomenclature c ON b.[1CNomenclatureID] = c.[1CNomenclatureID] AND b.[1CCharacteristicID] = c.[1CCharacteristicID]
						WHERE a.PlaceID = @PlaceID AND a.Unwinder1Active = 1)
				BEGIN
					SET @ResultMessage = @ResultMessage + '№1 ';
				END
				IF EXISTS (SELECT * FROM SourceSpools a --- проверка раската 2
						JOIN ProductSpools b ON a.Unwinder2Spool = b.ProductID
						JOIN @IncorrectNomenclature c ON b.[1CNomenclatureID] = c.[1CNomenclatureID] AND b.[1CCharacteristicID] = c.[1CCharacteristicID]
						WHERE a.PlaceID = @PlaceID AND a.Unwinder2Active = 1)
				BEGIN
					SET @ResultMessage = @ResultMessage + '№2 ';
				END
				IF EXISTS (SELECT * FROM SourceSpools a --- проверка раската 3
						JOIN ProductSpools b ON a.Unwinder3Spool = b.ProductID
						JOIN @IncorrectNomenclature c ON b.[1CNomenclatureID] = c.[1CNomenclatureID] AND b.[1CCharacteristicID] = c.[1CCharacteristicID]
						WHERE a.PlaceID = @PlaceID AND a.Unwinder3Active = 1)
				BEGIN
					SET @ResultMessage = @ResultMessage + '№3 ';
				END
				SET @ResultMessage = @ResultMessage + 'не совпадает со спецификацией активного задания!';
				IF @PlaceGroupID = 1
				BEGIN
					SET @BlockCreation = 0;
				END
				ELSE
				BEGIN
					SET @ResultMessage = @ResultMessage + ' Вы уверены, что хотите продолжить?';
				END
			END
			SET @i = @i + 1;
		END
	END
	
	SELECT ISNULL(@ResultMessage, '') AS ResultMessage, ISNULL(@BlockCreation,0) AS BlockCreation
	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckProductionTaskSourceSpools] TO [PalletRepacker]
    AS [dbo];

