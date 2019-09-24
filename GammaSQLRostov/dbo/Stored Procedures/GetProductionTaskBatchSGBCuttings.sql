-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductionTaskBatchSGBCuttings] 
	-- Add the parameters for the stored procedure here
	(
		@ProductionTaskBatchID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
--	DECLARE @PlaceID integer
	 
    -- Insert statements for procedure here
--	SELECT TOP 1 @PlaceID = PlaceID FROM UserPlaces
--	WHERE UserID = [dbo].CurrentUserID()
	
	SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.CutIndex, 
		b.CoreDiameter, b.LayerNumber, b.Diameter, b.Destination,
		b.Format, b.Color, b.FormatNumeric,
		CASE
			WHEN c.[NomenclatureKindID] = 1 THEN 'ПФ'
			ELSE 'ТОВ'
		END AS NomenclatureKind
	FROM
	(
		SELECT a.ProductionTaskID, ISNULL(d.[1CNomenclatureID], a.[1CNomenclatureID]) AS [1CNomenclatureID],
		ISNULL(a.[1CCharacteristicID], d.[1CCharacteristicID]) AS [1CCharacteristicID],
		CASE 
			WHEN a.PlaceGroupID = 0 THEN 0
			WHEN a.PlaceGroupID = 1 THEN d.CutIndex
		END AS CutIndex 
		FROM
		ProductionTasks a
		JOIN
		BatchProductionTasks b ON a.ProductionTaskID = b.ProductionTaskID
		JOIN
		ProductionTaskBatches c ON b.ProductionTaskBatchID = c.ProductionTaskBatchID
		LEFT JOIN
		ProductionTaskRWCutting d ON d.ProductionTaskID = a.ProductionTaskID
		WHERE
		c.ProductionTaskBatchID = @ProductionTaskBatchID AND
		((c.ProcessModelID IN (1,3,4,5) AND a.PlaceGroupID = 1) OR
		(c.ProcessModelID IN (0,2) AND a.PlaceGroupID = 0))
	) a
	JOIN
	vCharacteristicSGBProperties b ON a.[1CCharacteristicID] = b.[1CCharacteristicID]
	JOIN
	[1CNomenclature] c ON a.[1CNomenclatureID] = c.[1CNomenclatureID]

	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchSGBCuttings] TO [PalletRepacker]
    AS [dbo];

