-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeletPlaceZone]
	-- Add the parameters for the stored procedure here
	(
		@PlaceZoneID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ResultMessage varchar(1000)
	
	IF EXISTS 
	(
		SELECT * FROM DocInProducts WHERE PlaceZoneID = @PlaceZoneID
	)
	OR EXISTS
	(
		SELECT * FROM DocOutProducts WHERE PlaceZoneID = @PlaceZoneID
	)
	OR EXISTS
	(
		SELECT * FROM Rests WHERE PlaceZoneID = @PlaceZoneID
	)
	BEGIN
		SET @ResultMessage = 'Нельзя удалить зону, которая когда-либо использовалась'
	END
	ELSE IF EXISTS
	(
		SELECT * FROM PlaceZones WHERE PlaceZoneParentID = @PlaceZoneID
	)
	BEGIN
		SET @ResultMessage = 'Перед удалением зоны необходимо удалить все дочерние зоны'
	END
	ELSE
	BEGIN
		DELETE PlaceZones
		WHERE PlaceZoneID = @PlaceZoneID
	END
		
	SELECT ISNULL(@ResultMessage,'') AS ResultMessage


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeletPlaceZone] TO [PalletRepacker]
    AS [dbo];

