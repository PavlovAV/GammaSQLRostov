
-- =============================================
-- Author:		<Matvey Polidanov>
-- Create date: <2015-30-11>
-- Description:	<Получение связей продукта с другими продуктами>
-- =============================================
CREATE PROCEDURE [dbo].[ProductRelations] 
	-- Add the parameters for the stored procedure here
	(
		@ProductID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	
		SELECT 
		'Изготовлено из' AS RelationKind, 'Тамбур' AS ProductKind,
		d.Number, g.Date, g.DocID, d.ProductID, d.ProductKindID
		FROM 
		DocProductionWithdrawals a
		JOIN
		DocWithdrawal b ON a.DocWithdrawalID = b.DocID
		JOIN
		DocWithdrawalProducts c ON b.DocID = c.DocID
		JOIN
		Products d ON c.ProductID = d.ProductID
		JOIN
		ProductSpools e ON d.ProductID = e.ProductID
		JOIN
		DocProductionProducts f ON f.ProductID = c.ProductID
		JOIN
		Docs g ON g.DocID = f.DocID AND g.DocTypeID = 0
		JOIN
		DocProductionProducts h ON a.DocProductionID = h.DocID
		WHERE h.ProductID = @ProductID
		UNION ALL
		SELECT
		'Исходное сырье для' AS RelationKind,
		CASE
		WHEN g.ProductKindID = 0 THEN 'Тамбур'
		WHEN g.ProductKindID = 1 THEN 'Паллета'
		WHEN g.ProductKindID = 2 THEN 'Групповая упаковка'
		END AS ProductKind, g.Number, h.Date, h.DocID, g.ProductID, g.ProductKindID
		FROM
		Docs a
		JOIN
		DocProductionProducts b ON a.DocID = b.DocID
		JOIN
		DocWithdrawalProducts c ON c.ProductID = b.ProductID
		JOIN
		Docs d ON d.DocID = c.DocID AND d.DocTypeID = 1
		JOIN
		DocProductionWithdrawals e ON d.DocID = e.DocWithdrawalID
		JOIN
		DocWithdrawalProducts f ON e.DocProductionID = f.DocID
		JOIN
		Products g ON g.ProductID = f.ProductID
		JOIN
		Docs h ON f.DocID = h.DocID
		WHERE a.DocTypeID = 0 AND b.ProductID = @ProductID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[ProductRelations] TO [PalletRepacker]
    AS [dbo];

