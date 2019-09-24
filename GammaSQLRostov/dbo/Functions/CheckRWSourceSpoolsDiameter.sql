
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CheckRWSourceSpoolsDiameter]
(
	@PlaceID int,
	@ProductionTaskID uniqueidentifier
)
RETURNS varchar(255)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ActiveSourceSpools TABLE (ProductID uniqueidentifier)
	DECLARE @SourceProductID uniqueidentifier, @SourceDiameter int
		,@SourceLayerNumber int, @Production float, @Result varchar(255), @Number varchar(255)

	SET @Result = ''

	INSERT INTO @ActiveSourceSpools
	SELECT a.SpoolID FROM
	(
		SELECT Unwinder1Spool AS SpoolID, Unwinder1Active AS IsActive
		FROM SourceSpools
		WHERE PlaceID = @PlaceID
		UNION ALL
		SELECT Unwinder2Spool AS SpoolID, Unwinder2Active AS IsActive
		FROM SourceSpools
		WHERE PlaceID = @PlaceID
		UNION ALL
		SELECT Unwinder3Spool AS SpoolID, Unwinder3Active AS IsActive
		FROM SourceSpools
		WHERE PlaceID = @PlaceID
	) a
	WHERE a.IsActive = 1

	DECLARE SourceSpools_Cursor CURSOR
	FOR
	SELECT * FROM @ActiveSourceSpools

	OPEN SourceSpools_Cursor

	FETCH NEXT FROM SourceSpools_Cursor
	INTO 
	@SourceProductID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SELECT @SourceDiameter = Diameter, @SourceLayerNumber = dbo.CharacteristicLayerNumber(a.[1CCharacteristicID])
		,@Number = b.Number
		FROM
		ProductSpools a
		JOIN
		Products b ON a.ProductId = b.ProductID
		WHERE 
		a.ProductID = @SourceProductID

		IF @SourceDiameter > 0 AND @SourceLayerNumber > 0
		BEGIN
			SELECT @Production = SUM(@SourceLayerNumber*Diameter*Diameter/LayerNumber)
			FROM
			(
				SELECT ROW_NUMBER() OVER(PARTITION BY b.DocID ORDER BY b.DocID) AS rn, a.Diameter
				, dbo.CharacteristicLayerNumber(a.[1CCharacteristicID]) AS LayerNumber
				FROM
				ProductSpools a
				JOIN
				DocProductionProducts b ON a.ProductID = b.ProductID
				JOIN
				DocProduction c ON b.DocID = c.DocID
				JOIN
				DocProductionWithdrawals d ON c.DocID = d.DocProductionID
				JOIN
				DocWithdrawalProducts e ON d.DocWithdrawalID = e.DocID
				WHERE
				e.ProductID = @SourceProductID
			) a
			WHERE rn = 1

			SELECT TOP 1 
			@Production = @Production + (@SourceLayerNumber*POWER(b.Diameter+b.DiameterPlus, 2)/dbo.CharacteristicLayerNumber(a.[1CCharacteristicID]))
			FROM
			ProductionTaskRWCutting a
			JOIN
			ProductionTaskSGB b ON a.ProductionTaskID = b.ProductionTaskID
			WHERE a.ProductionTaskID = @ProductionTaskID

			IF @Production > POWER(@SourceDiameter,2)
			BEGIN
				SET @Result = @Result + 'Тамбур № ' + @Number + ' слишком мал для выработки' + CHAR(13)
			END
		END

		FETCH NEXT FROM SourceSpools_Cursor
		INTO 
		@SourceProductID
	END

	CLOSE SourceSpools_Cursor
	DEALLOCATE SourceSpools_Cursor

	IF @Result <> '' SET @Result = @Result + 'Вы уверены, что хотите продолжить?'

	RETURN @Result
	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckRWSourceSpoolsDiameter] TO [PalletRepacker]
    AS [dbo];

