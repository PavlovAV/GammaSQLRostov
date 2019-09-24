-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateGroupPackWithSpool]
	-- Add the parameters for the stored procedure here
	(
		@ProductID uniqueidentifier, @PrintName varchar(255)
	)
AS
BEGIN

	DECLARE @UserID uniqueidentifier, @ShiftID int, @PlaceProductionID int, @Date DateTime
	DECLARE @ProductIds TABLE (ProductId uniqueidentifier)
	DECLARE @DocIds TABLE (DocId uniqueidentifier)
	DECLARE @DocWithdrawalIds TABLE (DocId uniqueidentifier)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF EXISTS (SELECT * FROM Rests WHERE ProductID = @ProductID AND Quantity > 0)
	BEGIN
		SELECT TOP 1 @UserID = a.UserID, @ShiftID = a.ShiftID, @PlaceProductionID = d.PlaceID
		FROM Users a
		JOIN
		UserPlaces b ON a.UserID = b.UserID
		JOIN
		Places c ON b.PlaceID = c.PlaceID
		LEFT JOIN
		Places d ON c.BranchID = d.BranchID AND d.PlaceGroupID = 3
		WHERE
		a.UserID = dbo.CurrentUserID()

		SELECT @Date = GetDate()

		BEGIN TRANSACTION grouppack
			INSERT INTO Docs (DocTypeID, UserID, PrintName, PlaceID, ShiftID, Date)
			OUTPUT Inserted.DocID INTO @DocIds
			SELECT 0, @UserID, @PrintName, @PlaceProductionID, @ShiftID, @Date

			INSERT INTO DocProduction (DocID, InPlaceID)
			SELECT TOP 1 a.DocID, @PlaceProductionID
			FROM
			@DocIds a

			INSERT INTO Products (ProductKindID) 
			OUTPUT INSERTED.ProductID INTO @ProductIds
			VALUES (2)

			INSERT INTO ProductGroupPacks (ProductID, [1CNomenclatureID], [1CCharacteristicID], Weight, GrossWeight, Diameter)
			SELECT TOP 1 (SELECT TOP 1 ProductId FROM @ProductIds) AS ProductID, a.[1CNomenclatureID], a.[1CCharacteristicID],
				0, 0, a.Diameter
			FROM
			ProductSpools a
			WHERE a.ProductID = @ProductID

			INSERT INTO DocProductionProducts (DocID, ProductID, [1CNomenclatureID], [1CCharacteristicID])
			SELECT (SELECT TOP 1 DocID FROM @DocIds), (SELECT TOP 1 ProductID FROM @ProductIds), a.[1CNomenclatureID], a.[1CCharacteristicID]
			FROM
			ProductSpools a
			WHERE a.ProductID = @ProductID 

----	формирование списания
			INSERT INTO Docs (DocTypeID, UserID, PrintName, PlaceID, ShiftID, Date)
			OUTPUT INSERTED.DocID INTO @DocWithdrawalIds
			VALUES (1, @UserID, @PrintName, @PlaceProductionID, @ShiftID, @Date)

			INSERT INTO DocWithdrawal (DocID, OutPlaceID)
			SELECT TOP 1 DocID, @PlaceProductionID
			FROM
			@DocWithdrawalIds

			INSERT INTO DocWithdrawalProducts (DocID, ProductID, Quantity, CompleteWithdrawal)
			SELECT TOP 1 (SELECT TOP 1 DocID FROM @DocWithdrawalIds), @ProductID, a.Weight, 1
			FROM
			ProductSpools a
			WHERE a.ProductID = @ProductID 

			INSERT INTO DocProductionWithdrawals (DocProductionID, DocWithdrawalID)
			SELECT (SELECT TOP 1 DocID FROM @DocIDs), (SELECT TOP 1 DocID FROM @DocWithdrawalIds)				
		COMMIT TRANSACTION broke
	END

	SELECT TOP 1 ProductID FROM @ProductIds
	
	
	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateGroupPackWithSpool] TO [PalletRepacker]
    AS [dbo];

