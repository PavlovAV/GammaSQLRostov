
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Создание новой инвентаризации
-- =============================================
CREATE PROCEDURE [dbo].[mob_CreateNewInventarisation]
	-- Add the parameters for the stored procedure here
	(
		@PersonID uniqueidentifier,  -- пользователь
		@PlaceID int, -- склад
		@ShiftID tinyint -- смена
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DocIds TABLE (DocID uniqueidentifier)

	INSERT INTO Docs (DocTypeID, PersonGuid, UserID, Date, PlaceID, IsConfirmed, ShiftID) OUTPUT inserted.DocID INTO @DocIds
	VALUES (10, @PersonID, dbo.CurrentUserID(), getdate(), @PlaceID, 0, @ShiftID)
	
	SELECT a.DocID AS DocInventarisationID, a.Number
	FROM
	Docs a
	JOIN
	@DocIds b ON a.DocID = b.DocID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_CreateNewInventarisation] TO [PalletRepacker]
    AS [dbo];

