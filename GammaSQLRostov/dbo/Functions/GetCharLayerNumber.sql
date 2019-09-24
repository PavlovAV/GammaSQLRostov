-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetCharLayerNumber]
(
	@CharacteristicID uniqueidentifier
)
RETURNS int
WITH SCHEMABINDING
AS
BEGIN
	DECLARE @Result int
	
	SELECT @Result = CAST(c.ValueNumeric as int)
	FROM
	dbo.[1CCharacteristicProperties] a
	JOIN
	dbo.[1CPropertyValues] c ON a.[1CPropertyValueID] = c.[1CPropertyValueID]
	WHERE a.[1CCharacteristicID] = @CharacteristicID AND
	a.[1CPropertyID] = 'CE8FCC35-C32D-11E0-9D44-0019DB5E4B19'


	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharLayerNumber] TO [PalletRepacker]
    AS [dbo];

