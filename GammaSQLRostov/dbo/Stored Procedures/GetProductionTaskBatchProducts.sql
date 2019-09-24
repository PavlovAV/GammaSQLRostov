-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductionTaskBatchProducts] 
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
	SELECT b.DocID,a.ProductKindID,a.ProductID, a.Number, e.Date, f.Name AS Place, e.IsConfirmed,
	CASE 
		WHEN a.ProductKindID = 0 THEN sn.Name + ' ' + sc.Name
		WHEN a.ProductKindID = 1 THEN pn.Name + ' ' + pc.Name
	END AS NomenclatureName,
	CASE 
		WHEN a.ProductKindID = 0 THEN spools.[1CNomenclatureID]
		WHEN a.ProductKindID = 1 THEN d.[1CNomenclatureID]
	END AS NomenclatureID,
	CASE 
		WHEN a.ProductKindID = 0 THEN spools.[1CCharacteristicID]
		WHEN a.ProductKindID = 1 THEN d.[1CCharacteristicID]
	END AS CharacteristicID,
	CASE 
		WHEN a.ProductKindID = 0 THEN spools.DecimalWeight
		WHEN a.ProductKindID = 1 THEN d.Quantity
	END AS Quantity
	FROM Products a
	JOIN DocProductionProducts b ON a.ProductID = b.ProductID
	JOIN DocProduction c ON b.DocID = c.DocID
	JOIN BatchProductionTasks bp ON bp.ProductionTaskID = c.ProductionTaskID AND bp.ProductionTaskBatchID = @ProductionTaskBatchID
	JOIN Docs e ON b.DocID = e.DocID
	JOIN Places f ON f.PlaceID = e.PlaceID
	LEFT JOIN
	ProductSpools spools ON a.ProductID = spools.ProductID AND a.ProductKindID = 0
	LEFT JOIN [1CNomenclature] sn ON spools.[1CNomenclatureID] = sn.[1CNomenclatureID]
	LEFT JOIN [1CCharacteristics] sc ON sc.[1CCharacteristicID] = spools.[1CCharacteristicID]
	LEFT JOIN
	ProductPallets pal ON pal.ProductID = a.ProductID AND a.ProductKindID = 1
	LEFT JOIN
	ProductItems d ON pal.ProductID = d.ProductID
	LEFT JOIN [1CNomenclature] pn ON pn.[1CNomenclatureID] = d.[1CNomenclatureID]
	LEFT JOIN [1CCharacteristics] pc ON pc.[1CCharacteristicID] = d.[1CCharacteristicID]
	WHERE e.DocTypeID = 0
	ORDER BY e.Date DESC
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductionTaskBatchProducts] TO [PalletRepacker]
    AS [dbo];

