
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetLastMovementProductsForPerson] 
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
	
	SELECT DISTINCT Number, Barcode, ShortNomenclatureName, Quantity, DocMovementID, a.DocDate AS Date
		,Number + ISNULL('/n/b'+a.InPlaceZone,'') AS NumberAndInPlaceZone 
	FROM
	vDocMovementProducts a
	WHERE (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -13,GETDATE())
	ORDER BY a.DocDate DESC



END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetLastMovementProductsForPerson] TO [PalletRepacker]
    AS [dbo];

