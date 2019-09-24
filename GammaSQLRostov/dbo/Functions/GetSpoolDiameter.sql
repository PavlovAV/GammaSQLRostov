-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSpoolDiameter]
(
	@ProductID uniqueidentifier
)
RETURNS smallint
AS
BEGIN
	DECLARE @Result smallint,@CharacteristicID uniqueidentifier, @RealDiameter int
	
	SELECT @CharacteristicID = [1CCharacteristicID], @RealDiameter = 
		CASE
			WHEN CurrentDiameter > 0 THEN CurrentDiameter
			WHEN Diameter > 0 THEN Diameter
			ELSE NULL
		END
	FROM ProductSpools WHERE ProductID = @ProductID

	SELECT @Result = ISNULL(@RealDiameter, dbo.GetDiameter(@CharacteristicID));

	RETURN ISNULL(@Result,0)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolDiameter] TO [PalletRepacker]
    AS [dbo];

