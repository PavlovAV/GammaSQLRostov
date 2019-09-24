-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetProductionTaskBatchMadeQuantity]
(
	@ProductionTaskBatchID uniqueidentifier
)
RETURNS varchar(8000)
AS
BEGIN
	DECLARE @Result varchar(8000), @Place varchar(50), @MadeQuantity decimal(18,5)
	
	DECLARE string_cursor CURSOR FOR
		SELECT d.Name AS Place, 
--			CASE
--				WHEN c.ProductKindID = 0 THEN SUM(ISNULL(c.Quantity,0))
--				WHEN c.ProductKindID = 1 THEN SUM(ISNULL(c.Quantity,0))
--				WHEN c.ProductKindID = 2 THEN CAST(SUM(ISNULL(CAST(c.Quantity as decimal(10,2)),0))/1000 as decimal(10,2))
--			END 
			SUM(ISNULL(c.Quantity,0)) AS MadeQuantity
		FROM
		ProductionTaskBatches a
		JOIN
		BatchProductionTasks b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID
		JOIN
		vProductionTaskProducts c ON b.ProductionTaskID = c.ProductionTaskID
		JOIN
		Places d ON c.PlaceID = d.PlaceID
		WHERE a.ProductionTaskBatchID = @ProductionTaskBatchID 
		GROUP BY a.ProductionTaskBatchID, d.Name --, c.ProductKindID
		ORDER BY d.Name
	
	OPEN string_cursor

	FETCH NEXT FROM string_cursor
	INTO @Place, @MadeQuantity
	SET @Result = ''

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Result = @Result + @Place + ': '+ CONVERT(varchar, CONVERT(decimal(10,2), @MadeQuantity)) + char(13)

		FETCH NEXT FROM string_cursor
		INTO @Place, @MadeQuantity
	END

	CLOSE string_cursor;
	DEALLOCATE string_cursor;

	SELECT @Result = @Result + ISNULL(dbo.[GetProductionTaskBatchGroupPacksWeight](@ProductionTaskBatchID), '')

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchMadeQuantity] TO [PalletRepacker]
    AS [dbo];

