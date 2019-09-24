
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteSpool]
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
		SET @Result = 'Нельзя удалять подтвержденный тамбур'
	END

	IF EXISTS
	(
		SELECT *
		FROM
		vDocProducts a
		WHERE a.ProductID = @ProductID AND a.DocTypeID > 0
	)
	BEGIN
		SET @Result = 'Нельзя удалять тамбур, с которым уже проводились операции'
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
		SET @Result = 'Нельзя удалять тамбур, занесенный в выработку'
	END

	IF EXISTS 
	(
		SELECT * FROM
		DocCloseShiftRemainders 
		WHERE ProductID = @ProductID
	)
	BEGIN
		SET @Result = 'Нельзя удалить тамбур, который учтен, как переходящий остаток в выработке'
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
		DELETE FROM DocProductionProducts WHERE DocID = @DocID AND ProductID = @ProductID
--		DELETE FROM DocProducts WHERE DocID = @DocID AND ProductID = @ProductID
		DELETE FROM DocProductionWithdrawals WHERE DocProductionID = @DocID
		DELETE FROM DocProduction WHERE DocID = @DocID
		DELETE FROM Docs WHERE DocID = @DocID
		DELETE FROM ProductSpools WHERE ProductID = @ProductID
		DELETE FROM Products WHERE ProductID = @ProductID
	COMMIT TRANSACTION T1;
	END

	SELECT @Result AS Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteSpool] TO [PalletRepacker]
    AS [dbo];

