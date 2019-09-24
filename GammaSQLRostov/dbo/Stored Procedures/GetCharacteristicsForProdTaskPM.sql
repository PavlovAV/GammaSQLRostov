-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCharacteristicsForProdTaskPM] 
	-- Add the parameters for the stored procedure here
	(
		@NomenclatureID uniqueidentifier,
		@Color nvarchar(100),
		@Buyer nvarchar(100),
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
	AND (b.Buyer = @Buyer OR @Buyer IS NULL OR @Buyer = '' OR @Buyer = '<>')
	AND
	( 
		(@PlaceID IN (1,2, 21) AND b.FormatNumeric >= 1350 AND b.LayerNumberNumeric = 1 AND b.CoreDiameterNumeric IN (302, 305))
	)
	AND a.IsActive = 1

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharacteristicsForProdTaskPM] TO [PalletRepacker]
    AS [dbo];

