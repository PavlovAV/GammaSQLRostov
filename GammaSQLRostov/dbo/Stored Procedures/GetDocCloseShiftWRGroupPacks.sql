
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDocCloseShiftWRGroupPacks] 
	-- Add the parameters for the stored procedure here
	(
	@DocID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT a.ProductID,a.[1CNomenclatureID] AS NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID, c.Date,
	g.ProductionQuantity*1000 AS Weight, d.Number, e.Name + ' ' + f.Name AS Nomenclature
	FROM 
	ProductGroupPacks a
	JOIN
	DocProductionProducts b ON a.ProductID = b.ProductID
	JOIN
	Docs c ON b.DocID = c.DocID AND c.DocTypeID = 0
	JOIN
	Products d ON a.ProductID = d.ProductID
	LEFT JOIN
	[1CNomenclature] e ON a.[1CNomenclatureID] = e.[1CNomenclatureID]
	LEFT JOIN
	[1CCharacteristics] f ON f.[1CCharacteristicID] = a.[1CCharacteristicID]
	JOIN
	vProductsInfo g ON a.ProductID = g.ProductID
	JOIN
	DocCloseShiftDocs h ON c.DocID = h.DocID
	WHERE h.DocCloseShiftID = @DocID
--	WHERE c.DocID in (SELECT DocID FROM DocCloseShiftDocs WHERE DocCloseShiftID = @DocID)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftWRGroupPacks] TO [PalletRepacker]
    AS [dbo];

