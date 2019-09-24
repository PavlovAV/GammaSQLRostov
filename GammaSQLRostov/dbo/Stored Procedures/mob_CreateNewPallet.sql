
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Создание новой паллеты для комплектации
-- =============================================
CREATE PROCEDURE [dbo].[mob_CreateNewPallet] 
	-- Add the parameters for the stored procedure here
	(
		@ProductId uniqueidentifier,
		@DocOrderId uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @DocId table (DocId uniqueidentifier)

	INSERT INTO Docs (UserId, DocTypeID, Date, PlaceId, ShiftId) OUTPUT Inserted.DocId INTO @DocId
	SELECT dbo.CurrentUserID(), 0, GetDate(), a.OutPlaceID, 0
	FROM
	DocShipmentOrders a
	WHERE a.DocOrderID = @DocOrderId

	INSERT INTO DocProduction (DocID, DocOrderId, InPlaceID)
	SELECT docid.DocId, @DocOrderId, orders.OutPlaceID
	FROM
	DocShipmentOrders orders, @DocId docid WHERE DocOrderID = @DocOrderId

	INSERT INTO Products (ProductId, ProductKindID)
	VALUES (@ProductID, 1)

	INSERT INTO DocProductionProducts (DocID, ProductID)
	SELECT DocId, @ProductId
	FROM
	@DocId

	INSERT INTO ProductPallets (ProductID)
	VALUES (@ProductID)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewPallet] TO [PalletRepacker]
    AS [dbo];

