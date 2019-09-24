-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetDiameter]
(
	@CharacteristicID uniqueidentifier
)
RETURNS int
AS
BEGIN
	DECLARE @Result int
	
	SELECT @Result = CAST(c.ValueNumeric as int) 
	FROM
	[1CCharacteristicProperties] a
	JOIN
	[1CPropertyValues] c ON a.[1CPropertyValueID] = c.[1CPropertyValueID]
	WHERE a.[1CCharacteristicID] = @CharacteristicID AND
	a.[1CPropertyID] = '96CEC7F9-6B45-11E1-8280-002590304E93'

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDiameter] TO [PalletRepacker]
    AS [dbo];

