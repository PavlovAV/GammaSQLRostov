

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
	DECLARE @PlaceGroupID int
	DECLARE @GroupPackProductID uniqueidentifier
			
	SELECT @ProductKindID = ProductKindID FROM Products WHERE ProductID = @ProductID
	SET @Result = ''
	
	IF @ProductKindID IS NOT NULL
	BEGIN 
		SET @DocID = NEWID();

		IF @ShiftID IS NULL
			SELECT @ShiftID = ShiftID FROM Users WHERE UserID = dbo.CurrentUserID();
		IF @PlaceID IS NULL
			SELECT @PlaceID = MIN(PlaceID) FROM UserPlaces WHERE UserID = dbo.CurrentUserID();
		SELECT @PlaceGroupID = PlaceGroupID FROM Places WHERE PlaceID = @PlaceID
		
		if (@PlaceGroupID IN (0,1) AND @ShiftID > 0 AND @PlaceID IS NOT NULL AND exists(SELECT r.ProductID FROM Rests r JOIN Places p ON r.PlaceID = p.PlaceID WHERE ProductID = @ProductID AND p.PlaceGroupID IN (0,1) AND r.PlaceID <> @PlaceID))
			EXEC mob_AddProductIdToMovement 
				NULL,
				@ProductID,
				@PlaceID,
				NULL,
				@ProductKindID, 
				NULL,
				NULL,
				NULL,
				NULL,
				@ShiftID

		--Если в акте тамбур, который упакован в групповую упаковку (БО), то предварительно распаковываем ГУ и утилизируем сам тамбур
		if (@ProductKindID = 0 AND (SELECT COUNT(DISTINCT g.ProductID) FROM dbo.ProductGroupPacks g
				JOIN dbo.Rests r ON r.ProductID = g.ProductID AND r.Quantity > 0
				JOIN dbo.DocProductionProducts pp ON g.ProductID = pp.ProductID
				JOIN dbo.DocProductionWithdrawals w ON pp.DocID = w.DocProductionID
				JOIN dbo.DocWithdrawalProducts wp ON w.DocWithdrawalID = wp.DocID
				JOIN dbo.ProductSpools p ON wp.ProductID = p.ProductID 
				WHERE p.ProductID = @GroupPackProductID) = 1)
		BEGIN
			SELECT @GroupPackProductID = g.ProductID FROM dbo.ProductGroupPacks g
				JOIN dbo.Rests r ON r.ProductID = g.ProductID AND r.Quantity > 0
				JOIN dbo.DocProductionProducts pp ON g.ProductID = pp.ProductID
				JOIN dbo.DocProductionWithdrawals w ON pp.DocID = w.DocProductionID
				JOIN dbo.DocWithdrawalProducts wp ON w.DocWithdrawalID = wp.DocID
				JOIN dbo.ProductSpools p ON wp.ProductID = p.ProductID 
				WHERE p.ProductID = @ProductID
			EXEC [dbo].[UnpackGroupPack] @GroupPackProductID, NULL
		END

		--Если в акте групповая упаковка (БО), то предварительно распаковываем ГУ и утилизируем сам тамбур
		if (@ProductKindID = 2 AND (SELECT COUNT(DISTINCT p.ProductID) FROM dbo.ProductGroupPacks g
				JOIN dbo.Rests r ON r.ProductID = g.ProductID AND r.Quantity > 0
				JOIN dbo.DocProductionProducts pp ON g.ProductID = pp.ProductID
				JOIN dbo.DocProductionWithdrawals w ON pp.DocID = w.DocProductionID
				JOIN dbo.DocWithdrawalProducts wp ON w.DocWithdrawalID = wp.DocID
				JOIN dbo.ProductSpools p ON wp.ProductID = p.ProductID 
				WHERE g.ProductID = @ProductID) = 1)
		BEGIN
			SET @GroupPackProductID = @ProductID
			SELECT @ProductID = p.ProductID, @ProductKindID = 1 FROM dbo.ProductGroupPacks g
				JOIN dbo.Rests r ON r.ProductID = g.ProductID AND r.Quantity > 0
				JOIN dbo.DocProductionProducts pp ON g.ProductID = pp.ProductID
				JOIN dbo.DocProductionWithdrawals w ON pp.DocID = w.DocProductionID
				JOIN dbo.DocWithdrawalProducts wp ON w.DocWithdrawalID = wp.DocID
				JOIN dbo.ProductSpools p ON wp.ProductID = p.ProductID 
				WHERE g.ProductID = @GroupPackProductID
			EXEC [dbo].[UnpackGroupPack] @GroupPackProductID, NULL
		END

		BEGIN TRANSACTION T1;

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
		
		IF @ProductKindID IN (1,3)
			SELECT @Quantity = Quantity, @CompleteWithdrawal = 1
				FROM vProductsBaseInfo
				WHERE ProductID = @ProductID

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

