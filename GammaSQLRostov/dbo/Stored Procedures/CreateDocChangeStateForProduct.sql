-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateDocChangeStateForProduct] 
	-- Add the parameters for the stored procedure here
	(
		@DocID uniqueidentifier, @ProductID uniqueidentifier, @Quantity decimal(18,2) = null, @StateID smallint, 
		@RejectionReasonID uniqueidentifier,
		@PrintName varchar(255)
	)
AS
BEGIN

	DECLARE @UserID uniqueidentifier, @PlaceID int, @ShiftID int
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT TOP 1 @UserID = a.UserID, @PlaceID = b.PlaceID, @ShiftID = a.ShiftID
	FROM Users a
	JOIN
	UserPlaces b ON a.UserID = b.UserID
	WHERE
	a.UserID = dbo.CurrentUserID()


	
	INSERT INTO Docs (DocID, DocTypeID, IsConfirmed, UserID, PrintName, PlaceID, ShiftID, Date, IsFromOldGamma)
	VALUES (@DocID, 4, 1, @UserID, @PrintName, @PlaceID, @ShiftID, getdate(), 0)

	INSERT INTO DocChangeStateProducts (DocID, ProductID, StateID, [1CRejectionReasonID], Quantity)
	VALUES (@DocID, @ProductID, @StateID, @RejectionReasonID, @Quantity)
	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateDocChangeStateForProduct] TO [PalletRepacker]
    AS [dbo];

