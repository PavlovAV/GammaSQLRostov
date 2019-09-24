-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetCoreWeight]
(
	@CharacteristicID uniqueidentifier
)
RETURNS decimal(18,5)
AS
BEGIN
	DECLARE @Result decimal(18,5)
	
	SELECT @Result = ISNULL(a.ValueNumeric,-1)
	FROM
	[1CPropertyValueGammaPropertyValue] a
	JOIN
	[1CCharacteristicProperties] c ON c.[1CPropertyValueID] = a.[1CPropertyValueID]
	WHERE c.[1CCharacteristicID] = @CharacteristicID AND
	a.GammaPropertyID = 'a82e5dcf-6a9e-e511-8079-446d57900a76'

	RETURN ISNULL(@Result,0)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCoreWeight] TO [PalletRepacker]
    AS [dbo];

