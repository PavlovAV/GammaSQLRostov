
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetDocCloseShiftConvertingPallets] 
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
	SELECT a.ProductID, c.DocID, a.[1CNomenclatureID] AS NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID,
	a.Quantity, d.Number, e.Name + ' ' + f.Name AS NomenclatureName
	FROM 
	ProductItems a
	JOIN
	DocProductionProducts b ON a.ProductID = b.ProductID
	JOIN
	DocCloseShiftDocs c ON b.DocID = c.DocID	
	JOIN
	Products d ON a.ProductID = d.ProductID
	LEFT JOIN
	[1CNomenclature] e ON a.[1CNomenclatureID] = e.[1CNomenclatureID]
	LEFT JOIN
	[1CCharacteristics] f ON f.[1CCharacteristicID] = a.[1CCharacteristicID]
	WHERE c.DocCloseShiftID = @DocID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocCloseShiftConvertingPallets] TO [PalletRepacker]
    AS [dbo];

