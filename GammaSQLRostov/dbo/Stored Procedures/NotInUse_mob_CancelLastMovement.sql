-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[NotInUse_mob_CancelLastMovement] 
	-- Add the parameters for the stored procedure here
	(
		@Barcode varchar(20) -- ШК или номер
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
	DECLARE @DocID uniqueidentifier

	SELECT TOP 1 @DocID = a.DocID FROM
	DocMovement a
	JOIN
	Docs b ON a.DocID = b.DocID
	JOIN
	DocProducts c ON b.DocID = c.DocID
	JOIN
	Products d ON c.ProductID = d.ProductID
	WHERE
	d.Barcode = @Barcode OR d.Number = @Barcode
	ORDER BY b.Date DESC

	DELETE DocMovement WHERE DocID = @DocID
	DELETE DocProducts WHERE DocID = @DocID
	DELETE Docs WHERE DocID = @DocID

	SELECT 1 AS Result
	
*/

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_CancelLastMovement] TO [PalletRepacker]
    AS [dbo];

