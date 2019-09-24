
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetMovementBarcodeForPerson] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceIdTo int, --- склад приемки
		@PersonID uniqueidentifier -- пользователь
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT DISTINCT a.Barcode, a.ProductKindID
	FROM
	vDocMovementProducts a
	WHERE (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -14,GETDATE())

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetMovementBarcodeForPerson] TO [PalletRepacker]
    AS [dbo];

