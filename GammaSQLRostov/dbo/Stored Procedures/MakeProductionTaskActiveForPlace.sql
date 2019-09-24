-- =============================================
-- Author:		<Matvey Polidanov>
-- Create date: <2015-30-11>
-- Description:	<Получение связей продукта с другими продуктами>
-- =============================================
CREATE PROCEDURE [dbo].[MakeProductionTaskActiveForPlace] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int,
		@ProductionTaskBatchID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @ProductionTaskID uniqueidentifier

	SELECT @ProductionTaskID = b.ProductionTaskID
	FROM
	ProductionTaskBatches a
	JOIN
	BatchProductionTasks b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID
	JOIN
	ProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID AND
		(c.PlaceID = @PlaceID OR (c.PlaceID IS NULL AND c.PlaceGroupID = (SELECT PlaceGroupID FROM Places WHERE PlaceID = @PlaceID)))
	WHERE a.ProductionTaskBatchID = @ProductionTaskBatchID

	IF @ProductionTaskID IS NOT NULL
	BEGIN
		IF EXISTS (SELECT * FROM ActiveProductionTasks WHERE PlaceID = @PlaceID)
		BEGIN
			UPDATE ActiveProductionTasks SET ProductionTaskID = @ProductionTaskID				
			WHERE PlaceID = @PlaceID 
		END
		ELSE 
		BEGIN
			INSERT INTO ActiveProductionTasks (PlaceID, ProductionTaskID)
			VALUES (@PlaceID, @ProductionTaskID)
		END
	END
	

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MakeProductionTaskActiveForPlace] TO [PalletRepacker]
    AS [dbo];

