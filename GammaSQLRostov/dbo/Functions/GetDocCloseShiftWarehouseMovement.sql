


-- =============================================
-- Author:		<Alexandr Pavlov	>
-- Create date: <30.10.2018>
-- Description:	<Получение перемещений продукции грузчиком по закрытию смены>
-- =============================================
CREATE FUNCTION [dbo].[GetDocCloseShiftWarehouseMovement] 
	-- Add the parameters for the stored procedure here
	(
	@DocID uniqueidentifier,
	@PersonGuid uniqueidentifier
	)
RETURNS TABLE
AS
RETURN
(

    -- Insert statements for procedure here
	SELECT a.ProductID,a.[1CNomenclatureID] AS NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID,
	a.Quantity AS Weight, a.Number, a.NomenclatureName AS Nomenclature, a.ProductKindName, a.OrderTypeName,
	a.InPlace, a.InPlaceZone, a.OutPlace, a.OutPlaceZone, CASE WHEN a.OutPersonID = b.PersonGuid THEN a.OutDate ELSE CASE WHEN a.InPersonID = b.PersonGuid THEN a.InDate ELSE NULL END END AS [Date], a.InDate, a.OutDate, CASE WHEN ISNULL(c.StateID,0) = 0 THEN 'Годен' ELSE 'Актирован' END AS [State]
	FROM 
	vDocMovementProducts a JOIN Docs b ON b.DocID = @DocID AND (a.InPersonID = b.PersonGuid OR a.OutPersonID = b.PersonGuid)
	LEFT JOIN Products c ON a.ProductID = c.ProductID
	WHERE a.DocMovementID in (SELECT DocID FROM DocCloseShiftDocs WHERE DocCloseShiftID = @DocID)

)

GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovement] TO [PalletRepacker]
    AS [dbo];

