-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[BackupGammaNew](@TypeBackup tinyint, @Path varchar(8000)) 
AS
BEGIN
	
   SET NOCOUNT ON;

   DECLARE @s varchar(8000), @d datetime
   SET @d = GETDATE()
/*
   SET @s = 'BACKUP DATABASE [Gamma] TO DISK = N''' + 
     @Path + 'Gamma_' + CONVERT(varchar(8000), @d, 112) 
     + CAST(DATEPART(hour, @d) as varchar) + CAST(DATEPART(minute, @d) AS varchar)  + '.bak '''+
    ' WITH NOFORMAT, NOINIT, NAME = N''Gamma-Full Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10'
*/   
   SET @s = 'BACKUP ' + CASE WHEN @TypeBackup = 2 THEN 'LOG' ELSE 'DATABASE' END + ' [GammaNew] TO DISK = N''' + 
     @Path + 'GammaNew'+
	 CASE WHEN @TypeBackup = 1 THEN '-dif' WHEN @TypeBackup = 2 THEN '-log' ELSE '' END + '.bak '''+
    ' WITH NOFORMAT, NOINIT, NAME = N''Gamma-'+
	CASE @TypeBackup WHEN 0 THEN 'Full' WHEN 1 THEN 'Differential' WHEN 2 THEN 'Transaction log' ELSE '' END+' Database Backup'', SKIP, NOREWIND, NOUNLOAD,  STATS = 10' +
	CASE WHEN @TypeBackup = 1 THEN ', DIFFERENTIAL' ELSE '' END
   EXEC(@s)
END



GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BackupGammaNew] TO [PalletRepacker]
    AS [dbo];

