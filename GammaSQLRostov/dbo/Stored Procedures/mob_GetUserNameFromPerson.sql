


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetUserNameFromPerson] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

		SELECT b.Login AS UserName FROM Persons a JOIN Users b ON a.UserID = b.UserID WHERE a.PersonID = @PersonID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [PalletRepacker]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO [tsd]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetUserNameFromPerson] TO PUBLIC
    AS [dbo];

