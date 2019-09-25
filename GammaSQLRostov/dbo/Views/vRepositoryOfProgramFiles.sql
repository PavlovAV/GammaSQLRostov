








CREATE VIEW [dbo].[vRepositoryOfProgramFiles]
AS
SELECT FileID, DirName, [FileName], Title, MD5, [Action], [Image], ProgramName
FROM RepositoryOfProgramFiles 
WHERE IsActivity = 1 AND action IS NOT NULL
AND DATEPART(hour,GETDATE()) BETWEEN 7 AND 16



GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRepositoryOfProgramFiles] TO [tsd]
    AS [dbo];

