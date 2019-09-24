

CREATE PROCEDURE [dbo].[AddZZTable] (@TableName varchar(8000))
AS
BEGIN
  DECLARE @s varchar(8000), @cr varchar(10)
  SET @cr = CHAR(13) + CHAR(10)

-- 0 - insert, 1 - update, 2 - delete !


  IF (SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'zz' + @tableName) IS NOT NULL 
	  exec ('DROP TABLE [zz'+ @tableName+']')
	  exec ('IF EXISTS (  SELECT * FROM sys.triggers WHERE name = ''zzi' + @tableName + ''') DROP TRIGGER zzi'+ @tableName)
	  exec ('IF EXISTS (  SELECT * FROM sys.triggers WHERE name = ''zzu' + @tableName + ''') DROP TRIGGER zzu'+ @tableName)
	  exec ('IF EXISTS (  SELECT * FROM sys.triggers WHERE name = ''zzd' + @tableName + ''') DROP TRIGGER zzd'+ @tableName)
	  exec ('SELECT TOP 0 * INTO zz' + @tableName + ' FROM [' + @tableName+']')
	  exec ('GRANT INSERT, SELECT ON zz' + @tableName + ' TO public')
	  exec ('ALTER TABLE zz' + @tableName + ' ADD zzTransactionType tinyint, zzDate datetime, zzUserID varchar(100)')

	  SET @s = @cr +  'CREATE TRIGGER zzi' + @tableName + ' ON [' + @tableName +']'+ @cr + 
			   'AFTER  INSERT AS ' + @cr + 
			   'INSERT INTO zz' + @tableName + @cr + ' SELECT *, 0, GETDATE(),  SYSTEM_USER' + @cr + ' FROM INSERTED'
		  
	  exec (@s)
	  -- Update
	  SET @s = @cr +  'CREATE TRIGGER zzu' + @tableName + ' ON [' + @tableName +']'+ @cr + 
			   'AFTER  UPDATE AS ' + @cr + 
			   'INSERT INTO zz' + @tableName + @cr + ' SELECT *, 1, GETDATE(),  SYSTEM_USER' + @cr + ' FROM INSERTED'
	  exec (@s)
	  -- Delete
	  SET @s = @cr +  'CREATE TRIGGER zzd' + @tableName + ' ON [' + @tableName +']'+ @cr + 
			   'AFTER  DELETE AS ' + @cr + 
			   'INSERT INTO zz' + @tableName + @cr + ' SELECT *, 2, GETDATE(),  SYSTEM_USER' + @cr + ' FROM DELETED'
		  
	  exec (@s)
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddZZTable] TO [PalletRepacker]
    AS [dbo];

