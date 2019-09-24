-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetProductionTaskBatchGroupPacksWeight]
(
	@ProductionTaskBatchID uniqueidentifier
)
RETURNS varchar(255)
AS
BEGIN
	DECLARE @Result varchar(255), @Weight decimal(18,5), @DocJobWeight decimal(18,5), @ProductionTaskWeight decimal(18,5)
/*
	SELECT @DocJobWeight = ISNULL(Gamma.dbo.GetDocJobProduction(3, a.DocJobID),0)
	FROM
	(
		SELECT DISTINCT d.DocJobID
		FROM
		ProductionTaskBatches a
		JOIN
		BatchProductionTasks b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID
		JOIN
		ProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID
		JOIN
		Gamma.dbo.GammaNewToOldDocJobs d ON c.ProductionTaskID = d.ProductionTaskID
		WHERE a.ProductionTaskBatchID = @ProductionTaskBatchID
	) a
*/
	SELECT @ProductionTaskWeight =SUM(ISNULL(pgp.Weight,0))
	FROM
		(
			SELECT DISTINCT a.ProductionTaskBatchID, gps.ProductGroupPackID
			FROM
			ProductionTaskBatches a
			JOIN
			BatchProductionTasks b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID
			JOIN
			vGroupPackSpools gps ON b.ProductionTaskID = gps.ProductionTaskID
			WHERE a.ProductionTaskBatchID = @ProductionTaskBatchID
		) a
		JOIN
		ProductGroupPacks pgp ON pgp.ProductID = a.ProductGroupPackID
	GROUP BY ProductionTaskBatchID

	IF @DocJobWeight > 0 OR @ProductionTaskWeight > 0
	BEGIN
		SELECT @Result = 'Упак: ' + CAST(CONVERT(DECIMAL(10,2),ISNULL(@ProductionTaskWeight,0)) AS varchar)
	END

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchGroupPacksWeight] TO [PalletRepacker]
    AS [dbo];

