-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[NomenclatureLayerNumber]
(
	@NomenclatureID uniqueidentifier
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
	[1CNomenclatureProperties] a
	JOIN
	[1CPropertyValues] b ON a.[1CPropertyValueID] = b.[1CPropertyValueID]
	WHERE
	a.[1CNomenclatureID] = @NomenclatureID AND a.[1CPropertyID] = '80DA7C4B-C5EA-11E3-B873-002590304E93' --слойность ID

	-- Return the result of the function
	RETURN @LayerNumber

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NomenclatureLayerNumber] TO [PalletRepacker]
    AS [dbo];

