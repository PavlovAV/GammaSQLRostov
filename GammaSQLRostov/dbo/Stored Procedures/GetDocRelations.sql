-- =============================================
-- Author:		<Matvey Polidanov>
-- Create date: <2016-08-09>
-- Description:	<Получение связей документа с другими документами>
-- =============================================
CREATE PROCEDURE [dbo].[GetDocRelations] 
	-- Add the parameters for the stored procedure here
	(
		@DocID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT 'Изготовлено из: ' AS Description, e.DocID, e.DocTypeID, c.ProductID, c.Number, e.Date, c.ProductKindID
	FROM
	DocProductionWithdrawals a
	JOIN
	DocWithdrawalProducts b ON a.DocWithdrawalID = b.DocID
	JOIN
	Products c ON b.ProductID = c.ProductID
	JOIN
	DocProductionProducts d ON c.ProductID = d.ProductID
	JOIN
	Docs e ON d.DocID = e.DocID
	WHERE
	a.DocProductionID = @DocID
	UNION ALL
	SELECT 'Исходное сыръё для: ' AS Description, d.DocID, d.DocTypeID, c.ProductID, c.Number, d.Date, c.ProductKindID
	FROM
	DocProductionWithdrawals a
	JOIN
	DocProductionProducts b ON a.DocProductionID = b.DocID
	JOIN
	Products c ON b.ProductID = c.ProductID
	JOIN
	Docs d On b.DocID = d.DocID
	WHERE
	a.DocWithdrawalID = @DocID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocRelations] TO [PalletRepacker]
    AS [dbo];

