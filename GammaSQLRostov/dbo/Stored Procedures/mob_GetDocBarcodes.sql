-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetDocBarcodes] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderID uniqueidentifier,
		@IsInDoc bit
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @IsInDoc = 1
	BEGIN
			SELECT b.Barcode 
			FROM 
			DocInProducts a
			JOIN 
			Products b ON a.ProductID = b.ProductID
			JOIN
			DocMovement c ON a.DocID = c.DocID
			WHERE c.DocOrderID = @DocOrderID
	END
	ELSE
	BEGIN
		SELECT b.Barcode 
		FROM 
		DocOutProducts a
		JOIN 
		Products b ON a.ProductID = b.ProductID
		JOIN
		DocMovement c ON a.DocID = c.DocID
		WHERE c.DocOrderID = @DocOrderID
	END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcodes] TO [PalletRepacker]
    AS [dbo];

