
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mxp_RecreateRolePermits]
	-- Add the parameters for the stored procedure here
	(
	@RoleID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @RoleName varchar(50), @TableName varchar(200), @a tinyint, @e bit
    SELECT @RoleName = Name FROM Roles WHERE RoleID = @RoleID

	CREATE TABLE #p (name varchar(255), func bit)
	INSERT INTO #p
	SELECT 
      so.[Name] AS 'Name',
	  CASE WHEN so.type IN ('FN','P') THEN 1 ELSE 0 END AS func
	FROM [sys].[database_permissions] dbp LEFT JOIN [sys].[objects] so
    ON dbp.[major_id] = so.[object_id] LEFT JOIN [sys].[database_principals] p
    ON dbp.[grantee_principal_id] = p.[principal_id]
	WHERE p.[name] = @RoleName 
		AND so.type = 'U' --так как в самом приложении указываем разрешение только для таблиц

	DECLARE #ACursor CURSOR FAST_FORWARD FOR
    SELECT * FROM #p
	OPEN #ACursor
	WHILE @@ERROR = 0
	BEGIN
    FETCH NEXT FROM #ACursor INTO @TableName, @e
    IF @@FETCH_STATUS<>0 BREAK

	if @e = 0
    BEGIN
      exec('REVOKE DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [' + @TableName + '] TO ' + @RoleName)
    END
	else
	BEGIN
	  exec('REVOKE EXECUTE ON [' + @TableName + '] TO ' + @RoleName)
	END
  END

  CLOSE #ACursor
  DEALLOCATE #ACursor
  DROP TABLE #p

	CREATE TABLE #gp (n varchar(200), a tinyint, e bit)

	INSERT INTO #gp (n, a, e)
	SELECT c.Name, a.Mark, 0
	FROM RolePermits a
	JOIN Permits b ON a.PermitID = b.PermitID
	JOIN PermitTables c ON b.PermitID = c.PermitID
	WHERE a.RoleID = @RoleID

	INSERT INTO #gp (n,a,e) SELECT name,1,0 FROM sys.sysobjects WHERE xtype = 'V'
	INSERT INTO #gp (n,a,e) SELECT name,1,1 FROM sys.sysobjects WHERE xtype IN ('P','FN') AND LEFT(name,2) NOT IN ('sp','fn')

	DECLARE #ACursor CURSOR FAST_FORWARD FOR
    SELECT * FROM #gp
	OPEN #ACursor
	WHILE @@ERROR = 0
	BEGIN
    FETCH NEXT FROM #ACursor INTO @TableName, @a, @e
    IF @@FETCH_STATUS<>0 BREAK

	IF @e = 0
    BEGIN
      if @a = 2 exec('GRANT DELETE, INSERT, REFERENCES, SELECT, UPDATE ON [' + @TableName + '] TO ' + @RoleName)
      else if @a = 1 exec('GRANT SELECT ON [' + @TableName + '] TO ' + @RoleName)
--      else if @a = 3 exec('GRANT INSERT ON ' + @TableName + ' TO ' + @RoleName)
    END
    ELSE
    BEGIN
      exec('GRANT EXECUTE ON ' + @TableName + ' TO ' + @RoleName)
    END
  END
  CLOSE #ACursor
  DEALLOCATE #ACursor
  DROP TABLE #gp
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mxp_RecreateRolePermits] TO [PalletRepacker]
    AS [dbo];

