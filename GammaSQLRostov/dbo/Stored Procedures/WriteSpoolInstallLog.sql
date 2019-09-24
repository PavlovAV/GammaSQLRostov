-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE PROCEDURE [dbo].[WriteSpoolInstallLog]
(
	@ProductID uniqueidentifier, @PlaceID int, @ShiftID int, @UnwinderID tinyint
)
AS
BEGIN
	
	INSERT INTO SpoolInstallLog (PlaceID, ShiftID, UnwinderID, ProductID, Date)
	VALUES (@PlaceID, @ShiftID, @UnwinderID, @ProductID, GetDate())

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[WriteSpoolInstallLog] TO [PalletRepacker]
    AS [dbo];

