

-- =============================================
-- Author:		<Alexandr Pavlov	>
-- Create date: <30.10.2018>
-- Description:	<Получение перемещений продукции грузчиком по закрытию смены>
-- =============================================
CREATE PROCEDURE [dbo].[GetDocCloseShiftWarehouseMovements] 
	-- Add the parameters for the stored procedure here
	(
	@DocID uniqueidentifier,
	@PersonGuid uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	/*SELECT a.ProductID,a.[1CNomenclatureID] AS NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID,
	a.Quantity AS Weight, a.Number, a.NomenclatureName AS Nomenclature, a.ProductKindName, a.OrderTypeName,
	a.InPlace, a.InPlaceZone, a.OutPlace, a.OutPlaceZone
	FROM 
	vDocMovementProducts a JOIN Docs b ON b.DocID = @DocID AND (a.InPersonID = b.PersonGuid OR a.OutPersonID = b.PersonGuid)
	WHERE a.DocMovementID in (SELECT DocID FROM DocCloseShiftDocs WHERE DocCloseShiftID = @DocID)
	*/
	SELECT a.ProductID,a.NomenclatureID, a.CharacteristicID,
	a.Weight, a.Number, a.Nomenclature, a.ProductKindName, a.OrderTypeName,
	a.InPlace, a.InPlaceZone, a.OutPlace, a.OutPlaceZone, a.[Date]
	FROM [dbo].[GetDocCloseShiftWarehouseMovement](@DocID, @PersonGuid) a
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWarehouseMovements] TO [PalletRepacker]
    AS [dbo];

