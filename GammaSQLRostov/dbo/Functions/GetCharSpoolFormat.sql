-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetCharSpoolFormat]
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
	a.[1CPropertyID] = '0B782685-C3A2-11E3-B873-002590304E93'


	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharSpoolFormat] TO [PalletRepacker]
    AS [dbo];

