

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================

CREATE PROCEDURE [dbo].[mob_GetDocCountProductSpools] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderID uniqueidentifier,
		@IsWithBreak bit,
		@IsInDoc bit
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF @IsInDoc = 1
	BEGIN
			SELECT ISNULL(SUM(CASE WHEN @IsWithBreak = 1 THEN dbo.GetSpoolsFieldsForProduct(a.ProductID,3) ELSE dbo.GetSpoolsFieldsForProduct(a.ProductID,2) END),0) AS CountProductSpools
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
		SELECT ISNULL(SUM(CASE WHEN @IsWithBreak = 1 THEN dbo.GetSpoolsFieldsForProduct(a.ProductID,3) ELSE dbo.GetSpoolsFieldsForProduct(a.ProductID,2) END),0) AS CountProductSpools
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
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocCountProductSpools] TO [PalletRepacker]
    AS [dbo];

