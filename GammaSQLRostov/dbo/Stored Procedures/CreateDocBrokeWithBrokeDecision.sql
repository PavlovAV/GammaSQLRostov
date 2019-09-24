-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateDocBrokeWithBrokeDecision] 
	-- Add the parameters for the stored procedure here
	(
		@DocID uniqueidentifier, @ProductID uniqueidentifier, @BrokeQuantity decimal(18,2) = null, 
		@RejectionReasonID uniqueidentifier,
		@PrintName varchar(255),
		@PlaceID int
	)
AS
BEGIN

	DECLARE @UserID uniqueidentifier, @ShiftID int, @Quantity decimal(15,5);
	DECLARE @DocWithdrawalIds TABLE (DocId uniqueidentifier);
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TOP 1 @UserID = a.UserID, @ShiftID = a.ShiftID
	FROM Users a
	WHERE
	a.UserID = dbo.CurrentUserID()

	
BEGIN TRANSACTION broke

	-- Годная списывается
	UPDATE DocWithdrawalProducts SET Quantity = a.Quantity - @BrokeQuantity, CompleteWithdrawal = 0 
	OUTPUT Inserted.DocId INTO @DocWithdrawalIds
	FROM vProductsInfo a
	WHERE DocWithdrawalProducts.ProductID = a.ProductID
	AND 
	(
	DocWithdrawalProducts.ProductID = @ProductID AND DocWithdrawalProducts.Quantity IS NULL
	AND (CompleteWithdrawal IS NULL OR CompleteWithdrawal = 0)
	)

	UPDATE a SET IsConfirmed = 1
	FROM
	Docs a
	JOIN
	@DocWithdrawalIds  b ON a.DocID = b.DocID
	
	INSERT INTO Docs (DocID, DocTypeID, IsConfirmed, UserID, PrintName, PlaceID, ShiftID, Date, IsFromOldGamma)
	VALUES (@DocID, 7, 0, @UserID, @PrintName, @PlaceID, @ShiftID, getdate(), 0)

	INSERT INTO DocBroke (DocID, PlaceDiscoverID, PlaceStoreID)
	SELECT @DocID AS DocID, PlaceGuid AS PlaceDiscoverID, PlaceGuid AS PlaceStoreID
	FROM
	Places
	WHERE PlaceID = @PlaceID

	SELECT @Quantity = BaseMeasureUnitQuantity
	FROM
	vProductsInfo a
	WHERE a.ProductID = @ProductID

	INSERT INTO DocBrokeProducts (DocID, ProductID, Quantity)
	VALUES(@DocID, @ProductID, @Quantity)
	
	INSERT INTO DocBrokeProductRejectionReasons (DocID, ProductID, [1CRejectionReasonID])
	VALUES (@DocID, @ProductID, @RejectionReasonID)

	-- Добавляем запись "требует решения"
	INSERT INTO DocBrokeDecisionProducts (DocID, ProductID, StateID, Quantity)
	VALUES (@DocID, @ProductID, 1, @BrokeQuantity)
	
	-- Если в требует решения только часть, то остальное считаем годной
	IF @Quantity - @BrokeQuantity > 0
	BEGIN
		INSERT INTO DocBrokeDecisionProducts (DocID, ProductID, StateID, Quantity)
		VALUES (@DocID, @ProductID, 0, @Quantity - @BrokeQuantity)
	END
		
COMMIT TRANSACTION broke
	
	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocBrokeWithBrokeDecision] TO [PalletRepacker]
    AS [dbo];

