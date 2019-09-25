

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization]
(
	 @ProductID uniqueidentifier
	,@DocBrokeID uniqueidentifier
	,@StateID int
	,@Quantity decimal(15,5)
	,@ShiftID int
	,@PlaceID int
	,@Result bit OUTPUT
)

AS
BEGIN
	
	DECLARE @DocWithdrawalID uniqueidentifier
	BEGIN TRANSACTION TR1;
	SELECT @DocWithdrawalID = DocWithdrawalID FROM DocBrokeDecisionProductWithdrawalProducts WHERE DocID = @DocBrokeID AND ProductID = @ProductID AND StateID = @StateID
	IF @DocWithdrawalID IS NULL --если в акте на утилизацию групповая упаковка (БО), то в списании по утилизации будет тамбур БО (так как ГУ предварительно будет распакована автоматически)
		SELECT @DocWithdrawalID = DocWithdrawalID, @ProductID = ProductID FROM DocBrokeDecisionProductWithdrawalProducts WHERE DocID = @DocBrokeID AND ProductID IN (SELECT c.ProductID FROM DocWithdrawalProducts a JOIN DocUnpackWithdrawals b ON a.DocID = b.DocWithdrawalID JOIN DocUnpackProducts c ON b.DocID = c.DocID WHERE a.ProductID = @ProductID) AND StateID = @StateID
	DELETE DocBrokeDecisionProductWithdrawalProducts WHERE DocID = @DocBrokeID AND ProductID = @ProductID AND StateID = @StateID
	DELETE DocWithdrawalProducts WHERE DocID = @DocWithdrawalID AND ProductID = @ProductID
	DELETE DocWithdrawal 
		WHERE DocID = @DocWithdrawalID 
			AND NOT EXISTS (SELECT a.DocID FROM DocWithdrawalProducts a WHERE DocWithdrawal.DocID = a.DocID)
			AND NOT EXISTS (SELECT a.DocID FROM DocWithdrawalMaterials a WHERE DocWithdrawal.DocID = a.DocID)
	DELETE Docs WHERE  DocID = @DocWithdrawalID 
			AND NOT EXISTS (SELECT a.DocID FROM DocWithdrawal a WHERE Docs.DocID = a.DocID)
	COMMIT TRANSACTION TR1
	SET @Result = 1

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInDeleteBrokeDecisionUtilization] TO [PalletRepacker]
    AS [dbo];

