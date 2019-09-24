
-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <30.01.2018>
-- Description:	<Проверка на возможность создать продукт>
-- =============================================

CREATE PROCEDURE [dbo].[CheckPermissionOnCreateNewProduct] 
	-- Add the parameters for the stored procedure here
	(
		@ProductionTaskBatchId uniqueidentifier,
		@UserID uniqueidentifier
	)
AS
BEGIN

	DECLARE @Result bit = 0
	DECLARE @ShiftID int
	DECLARE @PlaceID int
	
	SELECT @ShiftID = ShiftID FROM Users WHERE UserID = @UserID
	IF EXISTS 
	--(SELECT b.ProductionTaskBatchID FROM BatchProductionTasks b JOIN ProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID JOIN UserPlaces d ON c.PlaceID = d.PlaceID WHERE b.ProductionTaskBatchID = @ProductionTaskBatchID AND d.UserID = @UserID)
	(SELECT b.ProductionTaskBatchID FROM BatchProductionTasks b JOIN ProductionTasks c ON b.ProductionTaskID = c.ProductionTaskID JOIN (UserPlaces d JOIN Places p ON d.PlaceID = p.PlaceID LEFT JOIN PlaceGroups pg ON p.PlaceGroupID = pg.PlaceGroupID) ON (c.PlaceID IS NOT NULL AND c.PlaceID = d.PlaceID) OR (c.PlaceID IS NULl AND c.PlaceGroupID = pg.PlaceGroupID) WHERE b.ProductionTaskBatchID = @ProductionTaskBatchID AND d.UserID = @UserID)
		SET @Result = 1
	
	SELECT @Result

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnCreateNewProduct] TO [PalletRepacker]
    AS [dbo];

