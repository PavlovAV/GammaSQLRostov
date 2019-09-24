-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Получение списка шк инвентаризации
-- =============================================
CREATE PROCEDURE dbo.mob_GetInventarisationBarcodes
	-- Add the parameters for the stored procedure here
	(
		@DocInventarisationID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SELECT Barcode
	FROM
	DocInventarisationProducts 
	WHERE 
	DocID = @DocInventarisationID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetInventarisationBarcodes] TO [PalletRepacker]
    AS [dbo];

