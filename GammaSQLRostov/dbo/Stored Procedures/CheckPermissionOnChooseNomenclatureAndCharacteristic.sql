


-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <30.01.2018>
-- Description:	<Проверка на возможность изменения номенклатуры и характеристики в продукте>
-- =============================================
CREATE PROCEDURE [dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] 
	-- Add the parameters for the stored procedure here
	(
		@ProductKindID int,
		@PlaceID int,
		@UserID uniqueidentifier
	)
AS
BEGIN

	DECLARE @Result bit = 0
	DECLARE @ShiftID int
	DECLARE @Login varchar(100)

	
	SELECT @ShiftID = ShiftID, @Login = [Login] FROM Users WHERE UserID = @UserID
	IF @ProductKindID <> 0 OR (@ProductKindID = 0 AND (@ShiftID = 0 OR (@Login = 'VPM' AND @PlaceID = 30)))
		SET @Result = 1
	
	SELECT @Result

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO PUBLIC
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckPermissionOnChooseNomenclatureAndCharacteristic] TO [PalletRepacker]
    AS [dbo];

