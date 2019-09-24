


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization]
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
	
	DECLARE @ProductKindID int, @DocID uniqueidentifier, @CurrentQuantity decimal(15,5), @CompleteWithdrawal bit
	DECLARE @Doc table (DocID uniqueidentifier, PlaceID int, Number varchar(100))

	SELECT @ProductKindID = ProductKindID FROM Products WHERE ProductID = @ProductID
	SET @Result = ''
	
	IF @ProductKindID IS NOT NULL
	BEGIN 
		SET @DocID = NEWID();
		
		BEGIN TRANSACTION T1;
		
		IF @ShiftID IS NULL
			SELECT @ShiftID = ShiftID FROM Users WHERE UserID = dbo.CurrentUserID();
		IF @PlaceID IS NULL
			SELECT @PlaceID = MIN(PlaceID) FROM UserPlaces WHERE UserID = dbo.CurrentUserID();

		INSERT INTO Docs (DocID, UserId, DocTypeID, Date, ShiftId, PlaceID) 
			--OUTPUT Inserted.DocId, Inserted.PlaceID, Inserted.Number INTO @Doc
			VALUES (@DocID, dbo.CurrentUserID(), 12, GetDate(), @ShiftId, @PlaceID)
		
		INSERT INTO DocWithdrawal(DocID, OutPlaceID)
			VALUES(@DocID,@PlaceID)
			--SELECT docid.DocID, docId.PlaceID FROM @Doc docid
/*
		SET @CurrentQuantity = (SELECT Quantity FROM vProductsInfo WHERE ProductID = @ProductID)
		
		IF @CurrentQuantity = @Quantity OR @CurrentQuantity IS NULL
			SET @CompleteWithdrawal = 1
			ELSE
			SET @CompleteWithdrawal = 0
			*/
		INSERT INTO DocWithdrawalProducts(DocID,ProductID,Quantity,CompleteWithdrawal)
			VALUES(@DocID, @ProductID, @Quantity, @CompleteWithdrawal)
			--SELECT docid.DocID, @ProductID, @Quantity, @CompleteWithdrawal FROM @Doc docid

		INSERT INTO DocBrokeDecisionProductWithdrawalProducts([DocWithdrawalID],[DocID],[ProductID],[StateID])
			VALUES(@DocID, @DocBrokeID, @ProductID, @StateID)
			--SELECT docid.DocID, @DocBrokeID, @ProductID, @StateID FROM @Doc docid

		COMMIT TRANSACTION T1;
	END
	SET @Result = @CompleteWithdrawal

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UpdateWithdrawalInInsertBrokeDecisionUtilization] TO [PalletRepacker]
    AS [dbo];

