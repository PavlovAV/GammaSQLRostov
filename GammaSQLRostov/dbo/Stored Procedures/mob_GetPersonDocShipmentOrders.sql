-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetPersonDocShipmentOrders] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT a.[1CDocShipmentOrderID] AS DocShipmentOrderID, b.[1CNumber] AS Number, c.Description AS Buyer FROM
                                DocShipmentOrderInfo a
                                JOIN [1CDocShipmentOrder] b ON a.[1CDocShipmentOrderID] = b.[1CDocShipmentOrderID]
                                JOIN [1CContractors] c ON b.[1CConsigneeID] = c.[1CContractorID]
                                WHERE a.[ActivePersonID] = @PersonID 
								AND (a.IsShipped = 0 OR a.IsShipped IS NULL)

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocShipmentOrders] TO [PalletRepacker]
    AS [dbo];

