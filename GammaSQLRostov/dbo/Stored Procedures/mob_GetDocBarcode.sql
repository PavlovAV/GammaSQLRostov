

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetDocBarcode] 
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
			SELECT b.Barcode, b.ProductKindID 
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
		SELECT b.Barcode, b.ProductKindID 
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
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocBarcode] TO [PalletRepacker]
    AS [dbo];

