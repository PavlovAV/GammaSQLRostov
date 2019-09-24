
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteUnload]
(
	@DocID uniqueidentifier
)
AS
BEGIN
	DECLARE @Result varchar(255)

	SET @Result = ''

	IF EXISTS
	(
		SELECT *
		FROM Docs
		WHERE DocID = @DocID AND IsConfirmed = 1
	)
	BEGIN
		SET @Result = 'Нельзя удалять подтвержденный съем'
	END

	IF EXISTS
	(
		SELECT *
		FROM
		Docs a
		JOIN
		DocProductionProducts b ON a.DocID = b.DocID
		JOIN
		vDocProducts c ON b.ProductID = c.ProductID
		JOIN
		Docs d ON c.DocID = d.DocID AND d.DocTypeID > 0
		WHERE a.DocID = @DocID
	)
	BEGIN
		SET @Result = 'Нельзя удалять съем с тамбурами, с которыми уже проводились другие операции'
	END

	IF EXISTS
	(
		SELECT * FROM
		Docs b
		JOIN
		DocCloseShiftDocs c ON c.DocID = b.DocID
		WHERE b.DocID = @DocID
	)
	BEGIN
		SET @Result = 'Нельзя удалять съем, занесенный в выработку'
	END

	IF @Result = ''
	BEGIN
	BEGIN TRANSACTION T1
		DECLARE @deletedProductIds table (productID uniqueidentifier)
/*
		DELETE DocProducts output deleted.ProductID into @deletedProductIds
		WHERE DocID = @DocID
*/
		DELETE a
		FROM
		DocProductionProducts a
		JOIN
		@deletedProductIds b ON a.ProductID = b.ProductID

		DELETE DocProductionWithdrawals WHERE DocProductionID = @DocID
		DELETE DocProduction WHERE DocID = @DocID
		DELETE Docs WHERE DocID = @DocID
		
		DELETE a
		FROM
		ProductSpools a
		JOIN
		@deletedProductIds b ON a.ProductID = b.ProductID

		DELETE a
		FROM
		Products a
		JOIN
		@deletedProductIds b ON a.ProductID = b.ProductID 

	COMMIT TRANSACTION T1
	END

	SELECT @Result AS Result

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DeleteUnload] TO [PalletRepacker]
    AS [dbo];

