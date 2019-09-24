
-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <25.12.2017>
-- Description:	<Проверка на создание нового акта или добавление в текущий>
-- =============================================

CREATE PROCEDURE [dbo].[GetDocBrokeID]
(
 @PlaceID int,
 @UserID uniqueidentifier,
 @ShiftID int,
 @docProductionPlaceID int,
 @IsProductionPlace bit
)
AS		
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT d.DocID
		FROM Docs d 
			JOIN DocBroke db ON d.DocID = db.DocID
		WHERE 
			ISNULL(d.IsConfirmed,0) = 0
			AND d.PlaceID = @PlaceID
			AND d.UserID = @UserID
			AND d.ShiftID = @ShiftID
			AND (@ShiftID = 0 OR (@ShiftID > 0 AND d.Date >= DATEADD(HOUR,-13,GETDATE())))
			AND	(((ISNULL(db.IsInFuturePeriod,0) = 1) AND (@docProductionPlaceID <> @PlaceID))
                 OR ((ISNULL(CASE WHEN db.IsInFuturePeriod = 1 THEN 0 WHEN db.IsInFuturePeriod = 0 THEN 1 ELSE NULL END,1) = 1) AND (@docProductionPlaceID = @PlaceID))
                 OR @IsProductionPlace = 0
                )

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeID] TO [PalletRepacker]
    AS [dbo];

