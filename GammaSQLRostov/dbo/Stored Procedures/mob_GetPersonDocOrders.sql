-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetPersonDocOrders] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID uniqueidentifier,
		@IsOutOrders bit
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT [1COrderID], Number, Consignee, OrderKindID
	FROM
	v1COrders 
	WHERE ((@IsOutOrders = 1 AND OutActivePersonID = @PersonID) OR (@IsOutOrders = 0 AND InActivePersonID = @PersonID))
		AND ((@IsOutOrders = 1 AND IsShipped = 0) OR (@IsOutOrders = 0 AND IsConfirmed = 0))

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetPersonDocOrders] TO [PalletRepacker]
    AS [dbo];

