
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetCharacteristicNameForProductionTaskSGB]
(
	@CharacteristicID uniqueidentifier
)
RETURNS varchar(200)
AS
BEGIN
	DECLARE @Result varchar(200)
	DECLARE @Description varchar(50)

	DECLARE Properties CURSOR FOR 
	SELECT a.Description 
	FROM
	(
		SELECT 
		ISNULL(ISNULL(ISNULL(b.Description, CAST(b.ValueNumeric AS varchar(50))), a.ValueText)
			, CAST(a.ValueNumeric AS varchar(50))) AS Description
		FROM
		[1CCharacteristicProperties] a
		LEFT JOIN
		[1CPropertyValues] b ON a.[1CPropertyValueID] = b.[1CPropertyValueID] AND (b.NotForName IS NULL OR b.NotForName = 0)
		WHERE a.[1CCharacteristicID] = @CharacteristicID
		AND a.[1CPropertyID] NOT IN ('0B782685-C3A2-11E3-B873-002590304E93', 'CE8FCC36-C32D-11E0-9D44-0019DB5E4B19')
	) a
	WHERE a.Description <> '<>' AND a.Description IS NOT NULL
	
	OPEN Properties;

	FETCH NEXT FROM Properties
	INTO @Description

	SET @Result = '';

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF (@Result = '')
		BEGIN
			SET @Result = @Description;
		END
		ELSE
		BEGIN
			SET @Result = @Result + ', ' + @Description
		END

		FETCH NEXT FROM Properties
		INTO @Description
	END

	CLOSE Properties;
	DEALLOCATE Properties;

	RETURN @Result
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicNameForProductionTaskSGB] TO [PalletRepacker]
    AS [dbo];

