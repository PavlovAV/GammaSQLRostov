-- =============================================
-- Author:		<Павлов Александр>
-- Create date: <15.11.2017>
-- Description:	<Проверка возможности установки на раскат тамбура>
-- =============================================
CREATE PROCEDURE [dbo].[CheckInstallProductionTaskSourceSpools]
(
	@PlaceID int,
	@ProductID uniqueidentifier
)
AS
BEGIN
	-- Declare the return variable here
	DECLARE @ResultMessage varchar(255) = '', @BlockCreation bit = 0, @PlaceGroupID int, @StateID int
	DECLARE @Place VARCHAR(200)

	SELECT TOP 1 @PlaceGroupID = PlaceGroupID
		FROM Places 
		WHERE PlaceID = @PlaceID

	SELECT TOP 1 @StateID = StateID FROM vProductsInfo WHERE ProductID = @ProductID-- AND StateID = 0
	--IF NOT EXISTS (SELECT ProductID FROM vProductsInfo WHERE ProductID = @ProductID AND StateID = 0) 
	
	IF @PlaceGroupID = 2 AND NOT EXISTS (SELECT * FROM Rests WHERE Quantity >0 AND ProductID = @ProductID AND PlaceID = @PlaceID)
	BEGIN
		--SET @ResultMessage = @ResultMessage + 'Внимание, данный тамбур не перемещен на передел!' + Char(13);
		SET @Place = (SELECT TOP 1 b.Name FROM Places b WHERE b.PlaceID = @PlaceID)
		INSERT CriticalLogs([Log]) VALUES('Внимание, данный тамбур ('+CAST(@ProductID AS varchar(100))+') не перемещен на передел ' + @Place + '!')
		SET @Place = NULL
	END 
	
	IF @StateID <> 0
		BEGIN
			IF @StateID = 3
				SET @ResultMessage = @ResultMessage + 'Внимание, данный тамбур Ограниченно годный!' + Char(13);
			ELSE
				SET @ResultMessage = @ResultMessage +  'Внимание, данный тамбур не является Годным!' + Char(13);
			----IF @PlaceGroupID = 1
			----BEGIN
			----	SET @BlockCreation = 0;
			----END
			----ELSE 
			--BEGIN
			--	SET @ResultMessage = @ResultMessage + Char(13)+' Установить тамбур на раскат?';
			--END
		END
	
	IF EXISTS(SELECT * FROM SourceSpools WHERE (Unwinder1Spool = @ProductID OR Unwinder2Spool = @ProductID OR Unwinder3Spool = @ProductID))
		BEGIN
			
			SET @Place = (SELECT TOP 1 b.Name FROM SourceSpools a JOIN Places b ON a.PlaceID = b.PlaceID WHERE (Unwinder1Spool = @ProductID OR Unwinder2Spool = @ProductID OR Unwinder3Spool = @ProductID OR Unwinder4Spool = @ProductID))
			SET @ResultMessage = @ResultMessage + 'Данный тамбур уже установлен на раскат на переделе '+ ISNULL(@Place,'') + '!' + Char(13);
			SET @BlockCreation = 1
		END
	
	IF ISNULL(@BlockCreation,0) = 0 AND @ResultMessage>''
		SET @ResultMessage = @ResultMessage + ' Установить тамбур на раскат?';
	IF @ResultMessage > ''
		INSERT CriticalLogs([Log]) VALUES(CAST(@ResultMessage + ' (Продукт: ' + (SELECT TOP 1 Number FROM Products WHERE ProductID = @ProductID)+') Передел: ' + ISNULL(@Place,'') + ')' AS varchar(500)))

	SELECT ISNULL(@ResultMessage, '') AS ResultMessage, ISNULL(@BlockCreation,0) AS BlockCreation
	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckInstallProductionTaskSourceSpools] TO [PalletRepacker]
    AS [dbo];

