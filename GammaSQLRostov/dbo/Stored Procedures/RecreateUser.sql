-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[RecreateUser] @UserID uniqueidentifier, @Password varchar(50)
AS
BEGIN
  DECLARE @S varchar(1024), @Login varchar(50), @Role varchar(255)
  SELECT @Login = Login, @Role = b.Name FROM Users a 
  JOIN 
  Roles b ON a.RoleID = b.RoleID
  WHERE UserID = @UserID
  
  SET @S = 
  'IF EXISTS(SELECT * FROM sys.database_principals WHERE name = ''' + @Login +''' ) DROP USER ' + @Login +
  
  ' IF EXISTS(SELECT * FROM sys.sql_logins WHERE name = ''' + @Login +
  ''' ) DROP LOGIN ' + @Login +
  
  ' CREATE LOGIN ' + @Login  +
  ' WITH PASSWORD=N''' + @PassWord + 
  ''', DEFAULT_DATABASE=[GammaNew], ' +
  ' CHECK_EXPIRATION=OFF, ' + 
  ' CHECK_POLICY=OFF ' + 
  
  ' CREATE USER ' + @Login  +
  ' FOR LOGIN ' +  @Login 

  exec (@s)  
  exec sp_addrolemember @Role, @Login
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[RecreateUser] TO [PalletRepacker]
    AS [dbo];

