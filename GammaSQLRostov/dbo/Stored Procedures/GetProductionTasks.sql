-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
--EXEC [dbo].[GetProductionTasks] 0
CREATE PROCEDURE [dbo].[GetProductionTasks] 
	-- Add the parameters for the stored procedure here
	(
		@BatchKindID integer
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @PlaceID integer, @PlaceGroupID integer, @PlaceName varchar(255)
	 
    -- Insert statements for procedure here
	SELECT TOP 1 @PlaceID = b.PlaceID, @PlaceGroupID = b.PlaceGroupID, @PlaceName = b.Name
	FROM 
	Users a
	JOIN
	UserPlaces c ON a.UserID = c.UserID
	JOIN
	Places b ON c.PlaceID = b.PlaceID
	WHERE a.UserID = [dbo].CurrentUserID()
		AND b.PlaceGroupID <= 4 --только имеющие доступ к заданиям
/*	
	SELECT DISTINCT c.DateBegin, a.ProductionTaskBatchID, a.Number, c.Quantity, d.Name AS Nomenclature, e.Name AS Characteristic, i.EnumColor, 
	ISNULL(g.Name, h.Name) AS Place, 
	CASE
		WHEN @BatchKindId = 0 THEN dbo.GetProductionTaskBatchMadeQuantity(a.ProductionTaskBatchID) 
		WHEN @BatchKindId = 1 THEN CAST(dbo.GetProductionTaskSGIMadeQuantity(a.ProductionTaskBatchID) as varchar(800))
	END AS MadeQuantity
	*/
	SELECT DISTINCT c.DateBegin, a.ProductionTaskBatchID, a.Number + ISNULL(n.Suffix, '') AS Number, c.Quantity, 
	ISNULL([dbo].[GetNomenclatureNameForSGB](ISNULL(k.[1CNomenclatureID], c.[1CNomenclatureID]), null),d.Name) + ' ' +
		+ ISNULL(ISNULL(l.TypeKind,m.TypeKind), '') AS Nomenclature, 
	e.Name AS Characteristic, i.EnumColor, 
	ISNULL(g.Name, h.Name) AS Place, 
	CASE
		WHEN @BatchKindId = 0 THEN 
			(
				SELECT d.Name + ': ' + CONVERT(varchar(100), SUM(StateQuantity)) + '/' + CONVERT(varchar(100), SUM(Quantity)) + ' ('+CAST(SUM(ISNULL(e.BreakNumber,0)) AS varchar(10))+' обр)' + char(13)
				FROM 
					( 
					SELECT
						 CONVERT(decimal(10,2), SUM(CASE WHEN ISNULL(c.StateID,0) = 0 AND f.ProductID IS NULL THEN ISNULL(c.Quantity,0) WHEN ISNULL(c.StateID,0) = 0 AND f.ProductID IS NOT NULL THEN ISNULL(f.Quantity,0) ELSE 0 END)) AS StateQuantity
						,CONVERT(decimal(10,2), SUM(ISNULL(c.Quantity,0))) AS Quantity
						,d.Name, c.DocProductionID
					FROM
						BatchProductionTasks b
						JOIN
						vProductionTaskProducts c ON b.ProductionTaskID = c.ProductionTaskID 
						JOIN
						Places d ON c.PlaceID = d.PlaceID
						LEFT JOIN 
						(SELECT f.ProductID, MIN(f.Quantity) AS Quantity FROM DocBrokeDecisionProducts f JOIN Docs g ON f.DocID = g.DocID AND g.IsConfirmed = 1 AND f.StateID = 0 JOIN (SELECT f.ProductID, MAX(g.Date) AS Date FROM DocBrokeDecisionProducts f JOIN Docs g ON f.DocID = g.DocID AND g.IsConfirmed = 1 AND f.StateID = 0 GROUP BY f.ProductID) ff ON f.ProductID = ff.ProductID AND g.Date = ff.Date GROUP BY f.ProductID) f ON c.ProductID = f.ProductID
					WHERE b.ProductionTaskBatchID = a.ProductionTaskBatchID
					GROUP BY d.Name, c.DocProductionID
					) d
					LEFT JOIN
					(SELECT b.DocID, MAX(c.BreakNumber) AS BreakNumber FROM DocProductionProducts b 
					JOIN ProductSpools c ON b.ProductID = c.ProductID GROUP BY b.DocID) e ON d.DocProductionID = e.DocID
				GROUP BY d.Name
				ORDER BY d.Name
			FOR XML PATH(''), TYPE).value('(./text())[1]', 'NVARCHAR(MAX)')
			+ISNULL((
				SELECT CASE WHEN SUM(ISNULL(pgp.Weight,0))>0 THEN 'Упак: ' + CONVERT(varchar(100), CONVERT(decimal(10,2), SUM(CASE WHEN ISNULL(p.StateID,0) = 0 AND f.ProductID IS NULL THEN ISNULL(pgp.Weight,0) WHEN ISNULL(p.StateID,0) = 0 AND f.ProductID IS NOT NULL THEN ISNULL(f.Quantity,0) ELSE 0 END))) + '/' + CAST(CONVERT(DECIMAL(10,2),SUM(ISNULL(pgp.Weight,0))) AS varchar(12)) ELSE '' END --+ ' ('+CAST(SUM(ISNULL(a.BreakNumber,0)) AS varchar(10))+' обр)' 
				FROM
				(
					SELECT b.ProductionTaskBatchID, gps.ProductGroupPackID, SUM(ISNULL(e.BreakNumber,0)) AS BreakNumber
					FROM
					BatchProductionTasks b
					JOIN
					vGroupPackSpools gps ON b.ProductionTaskID = gps.ProductionTaskID
					LEFT JOIN
					ProductSpools e ON gps.ProductID = e.ProductID
					WHERE b.ProductionTaskBatchID = a.ProductionTaskBatchID
					GROUP BY b.ProductionTaskBatchID, gps.ProductGroupPackID
				) a
				JOIN
				ProductGroupPacks pgp ON pgp.ProductID = a.ProductGroupPackID
				JOIN 
				Products p ON pgp.ProductID = p.ProductID
				LEFT JOIN 
				(SELECT f.ProductID, MIN(f.Quantity) AS Quantity FROM DocBrokeDecisionProducts f JOIN Docs g ON f.DocID = g.DocID AND g.IsConfirmed = 1 AND f.StateID = 0 JOIN (SELECT f.ProductID, MAX(g.Date) AS Date FROM DocBrokeDecisionProducts f JOIN Docs g ON f.DocID = g.DocID AND g.IsConfirmed = 1 AND f.StateID = 0 GROUP BY f.ProductID) ff ON f.ProductID = ff.ProductID AND g.Date = ff.Date GROUP BY f.ProductID) f ON a.ProductGroupPackID = f.ProductID
				),'') 
		WHEN @BatchKindId = 1 THEN CAST(dbo.GetProductionTaskSGIMadeQuantity(a.ProductionTaskBatchID) as varchar(800))
	END AS MadeQuantity
	FROM
	ProductionTaskBatches a
	JOIN
	BatchProductionTasks b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID
	JOIN
	ProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID
	AND 
	(
	(@PlaceGroupID = 4 AND (((a.ProcessModelID IN (1,3,4,5) AND c.PlaceGroupID = 1) OR (a.ProcessModelID IN (0,2) AND c.PlaceGroupID = 0))) 
		OR (a.BatchKindID = 1 AND @PlaceGroupID = 4))  -- Отображение заданий для администрации
	OR
	(@PlaceGroupID = 3 AND ((a.ProcessModelID IN (3,5) AND c.PlaceGroupID = 1) OR (a.ProcessModelID = 2 AND c.PlaceGroupID = 0))) -- отображение заданий для упаковки
	OR
	(@PlaceGroupID = 2 AND c.PlaceID = @PlaceID) -- отображение заданий для конвертингов
	OR
	((c.PlaceID IS NULL AND c.PlaceGroupID = @PlaceGroupID) OR (c.PlaceID IS NOT NULL AND c.PlaceID = @PlaceID)) -- отображение заданий для ПРС и БДМ
	)
	LEFT JOIN
	vProductionTaskBatches i ON i.ProductionTaskBatchID = a.ProductionTaskBatchID
	LEFT JOIN
	[1CNomenclature] d ON c.[1CNomenclatureID] = d.[1CNomenclatureID]
	LEFT JOIN
	[1CCharacteristics] e ON e.[1CCharacteristicID] = c.[1CCharacteristicID]
	JOIN
	ProductionTaskStates f ON a.ProductionTaskStateID = f.ProductionTaskStateID
	LEFT JOIN
	Places g ON g.PlaceID = c.PlaceID
	JOIN
	PlaceGroups h ON h.PlaceGroupID = c.PlaceGroupID
	LEFT JOIN
	(
		SELECT [1CNomenclatureID], [1CCharacteristicID], ProductionTaskID
		FROM
		ProductionTaskRWCutting
	) k ON c.ProductionTaskID = k.ProductionTaskID
	LEFT JOIN
	vCharacteristicSGBProperties l ON l.[1CCharacteristicID] = k.[1CCharacteristicID]
	LEFT JOIN
	vCharacteristicSGBProperties m ON m.[1CCharacteristicID] = c.[1CCharacteristicID]
	LEFT JOIN
	(
		SELECT c.ProductionTaskID, '(A)' AS Suffix
		FROM
		Docs a
		JOIN
		Places b ON a.PlaceID = b.PlaceID
		JOIN
		DocProduction c ON a.DocID = c.DocID
		WHERE a.DocTypeId = 0 AND b.PlaceGroupID = 0 AND
		a.Date = (SELECT MAX(date) FROM Docs WHERE PlaceId = a.PlaceID)
	) n ON c.ProductionTaskID = n.ProductionTaskID
	WHERE a.BatchKindID = @BatchKindID AND f.IsActual = 1
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTasks] TO [PalletRepacker]
    AS [dbo];

