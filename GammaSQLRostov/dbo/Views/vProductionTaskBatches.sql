







CREATE VIEW [dbo].[vProductionTaskBatches]
AS
		SELECT ProductionTaskBatchID, MAX(EnumColor) AS EnumColor
		FROM
		(
			SELECT DISTINCT a.ProductionTaskBatchID,
			CASE 
				WHEN ISNULL(pmc.[1CPropertyValueID],rwc.[1CPropertyValueID]) 
					IN ('97654DB6-8F2D-11E3-B394-002590304E93','97654DB7-8F2D-11E3-B394-002590304E93') THEN 1  -- СН Сыктывкар (Зеленый)
				WHEN ISNULL(pmc.[1CPropertyValueID],rwc.[1CPropertyValueID]) 
					IN ('97654DB5-8F2D-11E3-B394-002590304E93') THEN 2 -- СН Семибратово (Желтый)
				WHEN ISNULL(csprw.Buyer, csppm.Buyer) IS NOT NULL AND
					ISNULL(csprw.Buyer, csppm.Buyer) <> '<>' THEN 3 -- индивидуальный заказ (Розовый)
				ELSE 0
			END AS EnumColor
			FROM
			ProductionTaskBatches a
			JOIN
			BatchProductionTasks b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID
			JOIN
			ProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID AND
			((a.ProcessModelID IN (1,3,4,5) AND c.PlaceGroupID = 1) OR (a.ProcessModelID IN (0,2) AND c.PlaceGroupID = 0))
			LEFT JOIN
			ProductionTaskRWCutting d ON c.ProductionTaskID = d.ProductionTaskID
			LEFT JOIN
			[1CCharacteristicProperties] pmc ON pmc.[1CCharacteristicID] = c.[1CCharacteristicID] AND pmc.[1CPropertyID] = '97654DB4-8F2D-11E3-B394-002590304E93'
			LEFT JOIN
			[1CCharacteristicProperties] rwc ON rwc.[1CCharacteristicID] = d.[1CCharacteristicID] AND rwc.[1CPropertyID] = '97654DB4-8F2D-11E3-B394-002590304E93'
			LEFT JOIN
			[vCharacteristicSGBProperties] csprw ON csprw.[1CCharacteristicID] = d.[1CCharacteristicID]
			LEFT JOIN
			[vCharacteristicSGBProperties] csppm ON csppm.[1CCharacteristicID] = c.[1CCharacteristicID]
			UNION
			SELECT DISTINCT a.ProductionTaskBatchID, 3 AS EnumColor
			FROM
			ProductionTaskBatches a
			JOIN
			BatchProductionTasks b ON a.ProductionTaskBatchID = b.ProductionTaskBatchID
			JOIN
			ProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID
			JOIN
			Places d ON d.PlaceID = c.PlaceID
			JOIN
			ActiveProductionTasks e ON d.PlaceID = e.PlaceID AND c.ProductionTaskID = e.ProductionTaskID
			WHERE d.PlaceGroupID = 2
		) a
		GROUP BY a.ProductionTaskBatchID





GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionTaskBatches] TO [PalletRepacker]
    AS [dbo];

