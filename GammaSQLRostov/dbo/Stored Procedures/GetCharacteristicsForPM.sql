
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCharacteristicsForPM] 
	-- Add the parameters for the stored procedure here
	(
		@NomenclatureID uniqueidentifier,
		@Color nvarchar(100),
		@PlaceID int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT a.[1CCharacteristicID], a.Name AS CharacteristicName
	FROM
	[1CCharacteristics] a
	JOIN
	vCharacteristicSGBProperties b ON a.[1CCharacteristicID] = b.[1CCharacteristicID]
	WHERE a.[1CNomenclatureID] = @NomenclatureID 
	AND (b.Color = @Color OR @Color IS NULL OR @Color = '')
	AND
	( 
		(@PlaceID IN (1,2, 21) AND b.FormatNumeric >= 1300 AND b.LayerNumberNumeric = 1 AND b.CoreDiameterNumeric IN (302, 305))
	)
	AND a.IsActive = 1

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForPM] TO [PalletRepacker]
    AS [dbo];

