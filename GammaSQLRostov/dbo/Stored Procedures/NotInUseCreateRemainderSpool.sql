-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NotInUseCreateRemainderSpool] 
	-- Add the parameters for the stored procedure here
	(
		@DocID uniqueidentifier, @ProductID uniqueidentifier, @ParentProductID uniqueidentifier,
		@Quantity int, @PrintName varchar(255)
	)
AS
BEGIN

	DECLARE @UserID uniqueidentifier, @PlaceID int, @ShiftID int, @DocWithdrawalID uniqueidentifier
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
	SELECT TOP 1 @UserID = a.UserID, @PlaceID = b.PlaceID, @ShiftID = a.ShiftID
	FROM Users a
	JOIN
	UserPlaces b ON a.UserID = b.UserID
	WHERE
	a.UserID = dbo.CurrentUserID()

	SELECT TOP 1 @DocWithdrawalID = a.DocID
	FROM Docs a
	JOIN
	DocProducts b ON a.DocID = b.DocID AND b.ProductID = @ParentProductID
	WHERE a.DocTypeID = 1

	IF (@DocWithdrawalID IS NOT NULL)
	BEGIN
		INSERT INTO Docs (DocID, DocTypeID, IsConfirmed, UserID, PrintName, PlaceID, ShiftID, Date, IsFromOldGamma)
		VALUES (@DocID, 0, 1, @UserID, @PrintName, @PlaceID, @ShiftID, getdate(), 0)

		INSERT INTO DocProduction (DocID, InPlaceID) VALUES (@DocID, @PlaceID)

		INSERT INTO DocProductionWithdrawals (DocProductionID, DocWithdrawalID) VALUES (@DocID, @DocWithdrawalID)

		INSERT INTO Products (ProductID, ProductKindID) VALUES (@ProductID, 0)

		INSERT INTO ProductSpools (ProductID, [1CNomenclatureID], [1CCharacteristicID], RealFormat, Diameter, Weight,
			RealBasisWeight)
			SELECT @ProductID AS ProductID, [1CNomenclatureID], [1CCharacteristicID], RealFormat, 0, @Quantity,
				RealBasisWeight
			FROM
			ProductSpools 
			WHERE ProductID = @ParentProductID

		INSERT INTO DocProducts (DocID, ProductID, IsInConfirmed)
		VALUES (@DocID, @ProductID, 1)
	END
	*/
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUseCreateRemainderSpool] TO [PalletRepacker]
    AS [dbo];

