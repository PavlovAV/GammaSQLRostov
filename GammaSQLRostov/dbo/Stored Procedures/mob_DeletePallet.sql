-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Удаление скомплектованной паллеты
-- =============================================
CREATE PROCEDURE [dbo].[mob_DeletePallet] 
	-- Add the parameters for the stored procedure here
	(
		@ProductId UniqueIdentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Result varchar(255);
	DECLARE @DocIds TABLE (DocID uniqueidentifier)

	SET @Result = '';

	IF (dbo.AllowEditProduct(@ProductId) = 1)
	BEGIN
		BEGIN TRANSACTION Del	
			DELETE DocProductionProducts OUTPUT Deleted.DocId INTO @DocIds
			WHERE ProductID = @ProductId

			DELETE ProductItems WHERE ProductID = @ProductId
			DELETE ProductPallets WHERE ProductId = @ProductId;

			DELETE Products WHERE ProductId = @ProductId

			DELETE a
			FROM
			DocProduction a
			JOIN
			@DocIds b ON a.DocID = b.DocID

			DELETE a
			FROM
			Docs a
			JOIN
			@DocIds b ON a.DocID = b.DocId
		COMMIT 
	END
	ELSE 
	BEGIN
		SET @Result = 'Паллета уже отгружена или с ней связаны другие документы. Удаление запрещено' 
	END

	SELECT @Result AS Result
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DeletePallet] TO [PalletRepacker]
    AS [dbo];

