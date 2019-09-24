-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CharacteristicLayerNumber]
(
	@CharacteristicID uniqueidentifier
)
RETURNS int
AS
BEGIN
	-- Declare the return variable here
	DECLARE @LayerNumber int

	-- Add the T-SQL statements to compute the return value here
	SELECT @LayerNumber = 
	CASE
		WHEN b.ValueNumeric IS NULL OR b.ValueNumeric = 0 THEN 1
		ELSE b.ValueNumeric
	END
	FROM
	[1CCharacteristicProperties] a
	JOIN
	[1CPropertyValues] b ON a.[1CPropertyValueID] = b.[1CPropertyValueID]
	WHERE
	a.[1CCharacteristicID] = @CharacteristicID AND a.[1CPropertyID] = 'CE8FCC35-C32D-11E0-9D44-0019DB5E4B19' --слойность ID

	-- Return the result of the function
	RETURN @LayerNumber

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CharacteristicLayerNumber] TO [PalletRepacker]
    AS [dbo];

