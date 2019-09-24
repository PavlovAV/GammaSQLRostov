
-- =============================================
-- Author:		<Matvey Polidanov>
-- Create date: <2015-30-11>
-- Description:	<Получение связей продукта с другими продуктами>
-- =============================================
CREATE PROCEDURE [dbo].[GetProductRelations] 
	-- Add the parameters for the stored procedure here
	(
		@ProductID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT DISTINCT 'Исходное сыръё для: ' AS Description, d.DocID, d.DocTypeID, e.ProductID, e.Number, d.Date, e.ProductKindID
	FROM
	DocWithdrawalProducts a
	JOIN
	DocProductionWithdrawals b ON a.DocID = b.DocWithdrawalID
	JOIN
	DocProductionProducts c ON b.DocProductionID = c.DocID
	JOIN
	Docs d ON c.DocID = d.DocID
	JOIN
	Products e ON c.ProductID = e.ProductID
	WHERE a.ProductID = @ProductID
	UNION ALL
	SELECT DISTINCT 'Изготовлено из: ' AS Description, d.DocID, NULL AS DocTypeID, e.ProductID, e.Number, d.Date, e.ProductKindID
	FROM
	DocProductionProducts a
	JOIN
	DocProductionWithdrawals b ON a.DocID = b.DocProductionID
	JOIN
	DocWithdrawalProducts c ON b.DocWithdrawalID = c.DocID
	JOIN
	Docs d ON c.DocID = d.DocID
	JOIN
	Products e ON c.ProductID = e.ProductID
	WHERE
	a.ProductID = @ProductID
	UNION ALL
	SELECT DISTINCT 'Акты о браке' AS Description, b.DocID, b.DocTypeID, a.ProductID, b.Number, b.Date, NULL AS ProductKindID
	FROM
	DocBrokeProducts a
	JOIN
	Docs b ON a.DocID = b.DocID
	WHERE 
	a.ProductID = @ProductID
	UNION ALL
	SELECT DISTINCT 'Отгружено по приказу' AS Description, b.DocOrderID AS DocID, 5 AS DocTypeID, @ProductID AS ProductID
		, c.Number, ISNULL(b.OutDate, c.Date) AS Date, NULL AS ProductKindID
	FROM
	DocOutProducts a
	JOIN
	DocMovement b ON a.DocID = b.DocID
	JOIN
	v1COrders c ON b.DocOrderID = c.[1COrderID]
	WHERE a.ProductID = @ProductID
	UNION ALL
	SELECT 'Распаковал ' + ISNULL(c.PrintName,'') + ' на ' + d.Name AS Description, b.DocID AS DocID, 6 AS DocTypeID, @ProductID AS ProductID,
		c.Number, c.Date, NULL AS ProductKindID
	FROM
	DocWithdrawalProducts a
	JOIN
	DocUnpackWithdrawals b ON a.DocID = b.DocWithdrawalID
	JOIN
	Docs c ON b.DocID = c.DocID
	JOIN
	Places d ON c.PlaceID = d.PlaceID
	WHERE a.ProductID = @ProductID
	UNION ALL
	SELECT 'Внутренние перемещения' AS Description, a.DocMovementID AS DocID, 2 AS DocTypeID, @ProductID AS ProductID,
		b.Number, b.Date, NULL AS ProductKindID
	FROM
	vDocMovementProducts a
	JOIN
	Docs b ON a.DocMovementID = b.DocID 
	WHERE 
	a.ProductID = @ProductID AND DocOrderID IS NULL
	UNION ALL 
	--списание на сырье и утилизация
	SELECT d.Name AS Description, a.DocID, b.DocTypeID, @ProductID AS ProductID,
		b.Number, b.Date, NULL AS ProductKindID
	FROM
	DocWithdrawalProducts a
	JOIN
	Docs b ON a.DocID = b.DocID
	JOIN
	Places c ON b.PlaceID = c.PlaceID
	JOIN
	DocTypes d ON b.DocTypeID = d.DocTypeID
	WHERE a.ProductID = @ProductID
	UNION ALL
	SELECT DISTINCT 'Скомплектован на переделе ['+ISNULL(f.Description,'')+'] по приказу:' AS Description, d.DocID, d.DocTypeID, @ProductID AS ProductID, e.[1CCode] AS Number, e.Date, NULL AS ProductKindID
	FROM
	DocProductionProducts a
	JOIN
	DocComplectationProductions b ON a.DocID = b.DocProductionID
	JOIN
	DocComplectation c ON b.DocComplectationID = c.DocComplectationID
	JOIN
	Docs d ON c.DocComplectationID = d.DocID
	LEFT JOIN
	[1CDocComplectation] e ON e.[1CDocComplectationID] = c.[1CDocComplectationID]
	LEFT JOIN 
	[1CWarehouses] f ON f.[1CWarehouseID] = e.[1CWarehouseID]
	WHERE
	a.ProductID = @ProductID
	UNION ALL 
	--использованные материалы
	SELECT DISTINCT 'Списание материалов: ' AS Description, d.DocID, d.DocTypeID, a.ProductID, d.Number, d.Date, NULL AS ProductKindID
	FROM
	DocProductionProducts a
	JOIN
	DocProductionWithdrawals b ON a.DocID = b.DocProductionID
	JOIN
	DocWithdrawalMaterials c ON b.DocWithdrawalID = c.DocID
	JOIN
	Docs d ON c.DocID = d.DocID
	LEFT JOIN
	[1CNomenclature] e ON c.[1CNomenclatureID] = e.[1CNomenclatureID]
	LEFT JOIN
	[1CCharacteristics] f ON c.[1CCharacteristicID] = f.[1CCharacteristicID]
	WHERE
	a.ProductID = @ProductID
	GROUP BY d.DocID, d.DocTypeID, a.ProductID, d.Number, d.Date
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductRelations] TO [PalletRepacker]
    AS [dbo];

