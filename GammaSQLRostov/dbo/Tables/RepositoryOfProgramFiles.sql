CREATE TABLE [dbo].[RepositoryOfProgramFiles] (
    [FileID]      INT            IDENTITY (1, 1) NOT NULL,
    [FileName]    VARCHAR (255)  NOT NULL,
    [Title]       VARCHAR (255)  NOT NULL,
    [Image]       IMAGE          NOT NULL,
    [MD5]         VARCHAR (50)   NOT NULL,
    [Action]      BIT            NULL,
    [IsActivity]  BIT            CONSTRAINT [DF_RepositoryOfProgramFiles_IsActivity] DEFAULT ((1)) NOT NULL,
    [DCreate]     DATETIME       CONSTRAINT [DF_RepositoryOfProgramFiles_DCreate] DEFAULT (getdate()) NOT NULL,
    [ProgramName] NVARCHAR (50)  NULL,
    [DirName]     NVARCHAR (255) NULL,
    CONSTRAINT [PK_RepositoryOfProgramFiles] PRIMARY KEY CLUSTERED ([FileID] ASC)
);


GO



-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	
-- =============================================
CREATE TRIGGER [dbo].[InsertFile]
   ON  [dbo].[RepositoryOfProgramFiles]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	UPDATE c
	SET [Action] = NULL
	FROM
	RepositoryOfProgramFiles a
	JOIN
	inserted b ON a.ProgramName = b.ProgramName AND a.DirName = b.DirName AND a.[FileName] = b.[FileName] AND a.FileID <> b.FileID
	JOIN
	RepositoryOfProgramFiles c ON c.FileID = b.FileID
	WHERE a.IsActivity = 1 AND a.[Action] IS NULL

	UPDATE a
	SET IsActivity = 0
	FROM
	RepositoryOfProgramFiles a
	JOIN
	inserted b ON a.ProgramName = b.ProgramName AND a.DirName = b.DirName AND a.[FileName] = b.[FileName] AND a.FileID <> b.FileID
	WHERE a.IsActivity = 1

END

GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[RepositoryOfProgramFiles] TO [PalletRepacker]
    AS [dbo];

