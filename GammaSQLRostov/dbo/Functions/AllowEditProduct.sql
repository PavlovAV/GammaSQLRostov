-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[AllowEditProduct]
(
	@ProductID uniqueidentifier
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bit

	SET @Result = 1;

	IF --EXISTS (SELECT * FROM DocProducts a JOIN Docs b ON a.DocID = b.DocID WHERE a.ProductID = @ProductID AND b.DocTypeID > 0)
	--OR
	EXISTS (SELECT * FROM DocBrokeProducts WHERE ProductID = @ProductID)
	OR
	EXISTS (SELECT * FROM DocBrokeDecisionProducts WHERE ProductID = @ProductID)
	OR
	EXISTS (SELECT * FROM DocOutProducts WHERE ProductID = @ProductID)
	OR 
	EXISTS (SELECT * FROM DocInProducts WHERE ProductID = @ProductID)
	BEGIN
		SET @Result = 0;
	END

	RETURN @Result;
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditProduct] TO [PalletRepacker]
    AS [dbo];

