


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_AddProgramFileIntoRepository] 
	-- Add the parameters for the stored procedure here
	(
		 @Program nvarchar (50),
		 @DirName nvarchar (255),
		 @FileName nvarchar (255),
         @Title nvarchar (255),
         @ImageData image,
         @MD5 nvarchar(50),
         @Action bit,
         @IsActivity bit
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	IF NOT EXISTS (SELECT FileID FROM RepositoryOfProgramFiles WHERE ProgramName = @Program AND DirName = @DirName AND [FileName] = @FileName AND MD5 = @MD5 AND IsActivity = @IsActivity AND @IsActivity = 1)
	BEGIN
		INSERT INTO RepositoryOfProgramFiles(ProgramName, DirName, [FileName], Title, Image, MD5, Action, IsActivity) 
		VALUES (@Program, @DirName, @FileName, @Title, @ImageData, @MD5, @Action, @IsActivity)
		SELECT SCOPE_IDENTITY();
	END
	ELSE 
		SELECT -1;

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProgramFileIntoRepository] TO [PalletRepacker]
    AS [dbo];

