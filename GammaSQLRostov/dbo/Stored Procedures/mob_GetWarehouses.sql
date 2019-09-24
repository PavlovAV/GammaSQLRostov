

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetWarehouses]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT a.PlaceID AS WarehouseID, a.Name AS WarehouseName
	FROM
	Places a 
	JOIN
	UserPlaces b ON a.PlaceID = b.PlaceID
	WHERE b.UserID = dbo.CurrentUserID()
	--(
	--	SELECT DISTINCT a.BranchID
	--	FROM
	--	Places a
	--	JOIN
	--	UserPlaces b ON a.PlaceID = b.PlaceID
	--	WHERE b.UserID = dbo.CurrentUserID()
	--) b ON a.BranchID = b.BranchID AND IsWarehouse = 1

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetWarehouses] TO [PalletRepacker]
    AS [dbo];

