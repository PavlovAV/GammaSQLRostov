-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDocCloseShiftPMSpools] 
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
	SELECT a.ProductID,a.[1CNomenclatureID] AS NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID,
	b.Quantity*1000 AS Weight, d.Number, e.Name + ' ' + f.Name AS Nomenclature
	FROM 
	ProductSpools a
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
	WHERE c.DocID in (SELECT DocID FROM DocCloseShiftDocs WHERE DocCloseShiftID = @DocID)

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftPMSpools] TO [PalletRepacker]
    AS [dbo];

