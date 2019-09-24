-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetCharSpoolCoreDiameter]
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
	a.[1CPropertyID] = 'CE8FCC34-C32D-11E0-9D44-0019DB5E4B19'


	RETURN @Result

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolCoreDiameter] TO [PalletRepacker]
    AS [dbo];

