
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteGroupPack]
(
	@ProductID uniqueidentifier
)

AS
BEGIN
	DECLARE @Result varchar(255), @DocID uniqueidentifier

	SET @Result = ''
	
	IF EXISTS
	(
		SELECT *
		FROM
		DocProductionProducts a
		JOIN
		Docs b ON a.DocID = b.DocID AND b.DocTypeID = 0 AND b.IsConfirmed = 1
		WHERE
		a.ProductID = @ProductID
	)
	BEGIN
		SET @Result = 'Нельзя удалять подтвержденную групповую упаковку'
	END

	IF EXISTS
	(
		SELECT *
		FROM
		DocProductionProducts a
		JOIN
		Docs b ON a.DocID = b.DocID AND b.DocTypeID > 0
		WHERE a.ProductID = @ProductID
	)
	BEGIN
		SET @Result = 'Нельзя удалять групповую упаковку, с которой уже проводились операции'
	END

	IF EXISTS
	(
		SELECT * FROM
		DocProductionProducts a
		JOIN
		Docs b ON a.DocID = b.DocID AND b.DocTypeID = 0
		JOIN
		DocCloseShiftDocs c ON c.DocID = b.DocID
		WHERE a.ProductID = @ProductID
	)
	BEGIN
		SET @Result = 'Нельзя удалять упаковку, занесенную в выработку'
	END

	IF @Result = ''
	BEGIN
		SELECT @DocID = a.DocID
		FROM
		Docs a
		JOIN
		DocProductionProducts b ON a.DocID = b.DocID AND b.ProductID = @ProductID
		WHERE a.DocTypeID = 0

	BEGIN TRANSACTION T1;
		DECLARE @deletedDocWithdrawalsID TABLE (docID uniqueidentifier)
		DELETE FROM DocProductionProducts WHERE ProductID = @ProductID
--		DELETE FROM DocProducts WHERE DocID = @DocID AND ProductID = @ProductID

		DELETE FROM DocProductionWithdrawals OUTPUT deleted.DocWithdrawalID INTO @deletedDocWithdrawalsID
		WHERE DocProductionID = @DocID 
/*		
		DELETE a
		FROM
		DocProducts a
		JOIN
		@deletedDocWithdrawalsID b ON a.DocID = b.DocID
*/
		
		DELETE a
		FROM
		DocWithdrawalProducts a
		JOIN
		@deletedDocWithdrawalsID b ON a.DocID = b.DocID

		DELETE a
		FROM
		DocWithdrawal a
		JOIN
		@deletedDocWithdrawalsID b ON a.DocID = b.DocID

		DELETE a
		FROM
		Docs a
		JOIN
		@deletedDocWithdrawalsID b ON a.DocID = b.DocID

		DELETE FROM DocProduction WHERE DocID = @DocID
		DELETE FROM Docs WHERE DocID = @DocID
		DELETE FROM ProductGroupPacks WHERE ProductID = @ProductID
		DELETE FROM Products WHERE ProductID = @ProductID

	COMMIT TRANSACTION T1;
	END

	SELECT @Result AS Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteGroupPack] TO [PalletRepacker]
    AS [dbo];

