-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetBatchProducts] 
	-- Add the parameters for the stored procedure here
	(
		@ProductionTaskBatchID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT *
	FROM
	(
	SELECT b.DocID,a.ProductKindID,a.ProductID, a.Number, e.Date, f.Name AS Place, e.PlaceID, e.ShiftID, e.IsConfirmed,
	CASE 
		WHEN a.ProductKindID = 0 THEN sn.Name + ' ' + sc.Name
		WHEN a.ProductKindID IN (1,3) THEN pn.Name + ' ' + pc.Name
	END AS NomenclatureName,
	CASE 
		WHEN a.ProductKindID = 0 THEN spools.[1CNomenclatureID]
		WHEN a.ProductKindID IN (1,3) THEN d.[1CNomenclatureID]
	END AS NomenclatureID,
	CASE 
		WHEN a.ProductKindID = 0 THEN spools.[1CCharacteristicID]
		WHEN a.ProductKindID IN (1,3) THEN d.[1CCharacteristicID]
	END AS CharacteristicID,
	CASE 
		WHEN a.ProductKindID = 0 THEN b.Quantity
		WHEN a.ProductKindID IN (1,3) THEN d.Quantity
	END AS Quantity
	FROM Products a
	JOIN DocProductionProducts b ON a.ProductID = b.ProductID
	JOIN DocProduction c ON b.DocID = c.DocID
	JOIN BatchProductionTasks bp ON bp.ProductionTaskID = c.ProductionTaskID AND bp.ProductionTaskBatchID = @ProductionTaskBatchID
	JOIN Docs e ON b.DocID = e.DocID AND e.DocTypeID = 0
	JOIN Places f ON f.PlaceID = e.PlaceID
	LEFT JOIN
	ProductSpools spools ON a.ProductID = spools.ProductID AND a.ProductKindID = 0
	LEFT JOIN [1CNomenclature] sn ON spools.[1CNomenclatureID] = sn.[1CNomenclatureID]
	LEFT JOIN [1CCharacteristics] sc ON sc.[1CCharacteristicID] = spools.[1CCharacteristicID]
	LEFT JOIN
	ProductPallets pal ON pal.ProductID = a.ProductID AND a.ProductKindID  IN (1,3)
	LEFT JOIN
	ProductItems d ON pal.ProductID = d.ProductID
	LEFT JOIN [1CNomenclature] pn ON pn.[1CNomenclatureID] = d.[1CNomenclatureID]
	LEFT JOIN [1CCharacteristics] pc ON pc.[1CCharacteristicID] = d.[1CCharacteristicID]
	UNION ALL
	SELECT DISTINCT e.DocID, i.ProductKindID, i.ProductID, i.Number, e.Date, k.Name AS Place, e.PlaceID, e.ShiftID, e.IsConfirmed,
	g.Name + ' ' + h.Name AS NomenclatureName, g.[1CNomenclatureID] AS NomenclatureID, h.[1CCharacteristicID] AS CharacteristicID,
	f.Weight AS Quantity
	FROM
	vGroupPackSpools a
	JOIN
	ProductionTasks b ON a.ProductionTaskID = b.ProductionTaskID
	JOIN
	BatchProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID AND c.ProductionTaskBatchID = @ProductionTaskBatchID
	JOIN
	DocProductionProducts d ON a.ProductGroupPackID = d.ProductID
	JOIN
	Docs e ON d.DocID = e.DocID AND e.DocTypeID = 0
	JOIN
	ProductGroupPacks f ON d.ProductID = f.ProductID
	JOIN
	[1CNomenclature] g ON f.[1CNomenclatureID] = g.[1CNomenclatureID]
	JOIN
	[1CCharacteristics] h ON f.[1CCharacteristicID] = h.[1CCharacteristicID]
	JOIN
	Products i ON i.ProductID = f.ProductID
	JOIN
	Places k ON k.PlaceID = e.PlaceID
	) a
	ORDER BY a.Date DESC
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetBatchProducts] TO [PalletRepacker]
    AS [dbo];

