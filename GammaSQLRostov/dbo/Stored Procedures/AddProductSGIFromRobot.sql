
--SELECT * FROM Products WHERE Number = '25106128049847'
--  SELECT * FROM ##tmpStoricoPalletForInsertToGamma 

--EXEC AddProductSGIFromRobot
CREATE PROCEDURE [dbo].[AddProductSGIFromRobot] 
AS
BEGIN

DECLARE @Number varchar(20), @DocID uniqueidentifier, @UserID uniqueidentifier, @ProductID uniqueidentifier,
    @EAN varchar(20), @Date datetime, @PlaceID int, @Barcode varchar (40),
	@1CNomenclatureID uniqueidentifier, @1CCharacteristicID uniqueidentifier, @Quantity decimal(10,3)
	,@ProductionTaskID uniqueidentifier, @ErrorInsertedToGamma varchar(500)

  SET NOCOUNT ON

   IF NOT EXISTS(SELECT *
	FROM TempDB.Information_Schema.Tables
	WHERE TABLE_NAME like '##tmpStoricoPalletForInsertToGamma')
	BEGIN
SELECT TOP 0 [InsertDate],[DateInsertedToGamma],[ErrorInsertedToGamma] INTO ##tmpStoricoPalletForInsertToGamma FROM [MSTR1].[RobotActivation].[dbo].[StoricoPalletForInsertToGamma]
				
  DECLARE #RobotPallets CURSOR
  FOR
  SELECT sp.Number,Date, PlaceID, sp.Barcode, 
	[1CNomenclatureID], [1CCharacteristicID], Quantity, ISNULL(ErrorInsertedToGamma,'') AS ErrorInsertedToGamma
  FROM [vRobotPalletsInsertToGamma] sp
  ORDER BY sp.Date
  
  OPEN #RobotPallets

  DECLARE @ErrorTxt VARCHAR(1000), @ErrorTxt1 VARCHAR(1000)
  FETCH NEXT FROM #RobotPallets   
  INTO @Number, @Date, @PlaceID, @Barcode, 
	@1CNomenclatureID, @1CCharacteristicID, @Quantity, @ErrorInsertedToGamma

  WHILE @@FETCH_STATUS = 0
  BEGIN  
	  SET @DocID = NEWID()
	  SET @ProductID = NEWID()
	  SET @UserID = '0075C8A1-ABF5-48E4-BA7E-7B1056B1D52B'
	  --PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' '+ @Number
	  SET @ErrorTxt = ''
		IF --NOT EXISTS (SELECT Number FROM Products WHERE Number = @Number)
			@Number IS NOT NULL AND @Date IS NOT NULL AND @PlaceID IS NOT NULL AND @Barcode IS NOT NULL AND  
			@1CNomenclatureID IS NOT NULL AND @1CCharacteristicID IS NOT NULL AND @Quantity IS NOT NULL 
		BEGIN
			--PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' 1'
			SET @ProductionTaskID = (SELECT a.ProductionTaskID FROM ProductionTasks a JOIN ActiveProductionTasks b ON a.ProductionTaskID = b.ProductionTaskID  WHERE a.PlaceID = @PlaceID AND a.[1CNomenclatureID] = @1CNomenclatureID AND a.[1CCharacteristicID] = @1CCharacteristicID)
			--PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' 2'
			IF @ProductionTaskID IS NULL
				SET @ProductionTaskID = (SELECT TOP 1 a.ProductionTaskID FROM ProductionTasks a 
					JOIN DocProduction b ON a.ProductionTaskID = b.ProductionTaskID 
					JOIN Docs c ON b.DocID = c.DocID
					WHERE a.PlaceID = @PlaceID AND a.[1CNomenclatureID] = @1CNomenclatureID AND a.[1CCharacteristicID] = @1CCharacteristicID
					ORDER BY c.Date DESC)
			--PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' 3'
			BEGIN TRY
			--PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' 4'
			IF EXISTS (SELECT Number FROM Products WHERE Number = @Number)
			BEGIN
				--PRINT 'Продукт с таким номером уже существует'
				SET @ErrorTxt = @ErrorTxt + ';Продукт с таким номером уже существует '
				--Это не ошибка - с робота реально выходят иногда 2 паллеты с одинаковым номером в разное время
			END

			--PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' 5'
			/* Временно отключил, пока не делают задания в Гамме
			IF @ProductionTaskID IS NULL
			BEGIN
				--PRINT 'Привязка к заданию отсутствует'
				SET @ErrorTxt = @ErrorTxt + '; Привязка к заданию отсутствует '
				--Это не ошибка
			END
			*/
			--PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' 6'
			BEGIN TRAN T1
			INSERT Docs (DocID, DocTypeID, Number, UserID, PlaceID, ShiftID, Date, BranchID)
			SELECT @DocID, 0, @Number, @UserID, @PlaceID, NULL, @Date, 2
			
			INSERT DocProduction (DocID, InPlaceID, ProductionTaskID)
			SELECT @DocID, @PlaceID, @ProductionTaskID

			INSERT Products (ProductID, Number, Barcode, ProductKindID, StateID)
			SELECT @ProductID, @Number, @Barcode, 1, 0
			
			INSERT ProductPallets (ProductID)
			SELECT @ProductID

			INSERT ProductItems (ProductID, [1CNomenclatureID], [1CCharacteristicID], Quantity)
			SELECT @ProductID, @1CNomenclatureID, @1CCharacteristicID, @Quantity
			
			INSERT DocProductionProducts (DocID, ProductID, Quantity, [1CNomenclatureID], [1CCharacteristicID])
			SELECT @DocID, @ProductID, @Quantity, @1CNomenclatureID, @1CCharacteristicID			
			COMMIT TRAN T1
			--PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' 7'
			--UPDATE [MSTR1].[RobotActivation].[dbo].[StoricoPalletForInsertToGamma] SET [DateInsertedToGamma] = GETDATE()  WHERE InsertDate = @Date
			INSERT INTO ##tmpStoricoPalletForInsertToGamma([InsertDate],[DateInsertedToGamma])
			SELECT @Date, GETDATE()
			--PRINT CONVERT(VARCHAR(100),GETDATE(),121) + ' 8'
			END TRY
			BEGIN CATCH
			--PRINT CONVERT(varchar(100),GETDATE(),121)+': '+ERROR_MESSAGE()
				SET @ErrorTxt = @ErrorTxt + LEFT(--CONVERT(varchar(100),GETDATE(),121)+
				': '+ERROR_MESSAGE(),800)
				--UPDATE [MSTR1].[RobotActivation].[dbo].[StoricoPalletForInsertToGamma] SET [ErrorInsertedToGamma] = LEFT(CONVERT(varchar(100),GETDATE(),121)+': '+ERROR_MESSAGE(),500) WHERE InsertDate = @Date
			END CATCH

		END
		ELSE
		BEGIN
			SET @ErrorTxt1 =''
			--SET @ErrorTxt = CONVERT(varchar(100),GETDATE(),121)+': '
			BEGIN
				IF @Number IS NULL SET @ErrorTxt1 = 'Number=NULL;' 
				IF @Date IS NULL  SET @ErrorTxt1 = @ErrorTxt1+'Date=NULL;'
				IF @PlaceID IS NULL  SET @ErrorTxt1 = @ErrorTxt1+'PlaceID=NULL;'
				IF @Barcode IS NULL  SET @ErrorTxt1 = @ErrorTxt1+'Barcode=NULL;'
				IF @1CNomenclatureID IS NULL  SET @ErrorTxt1 = @ErrorTxt1+'1CNomenclatureID=NULL;'
				IF @1CCharacteristicID IS NULL  SET @ErrorTxt1 = @ErrorTxt1+'1CCharacteristicID=NULL;'
				IF @Quantity IS NULL  SET @ErrorTxt1 = @ErrorTxt1+'Quantity=NULL;'
			END
			--PRINT @ErrorTxt
			SET @ErrorTxt = @ErrorTxt + @ErrorTxt1
			--UPDATE [MSTR1].[RobotActivation].[dbo].[StoricoPalletForInsertToGamma] SET [ErrorInsertedToGamma] = LEFT(@ErrorTxt,500) WHERE InsertDate = @Date
		END
	IF @ErrorTxt > '' AND @ErrorTxt <> @ErrorInsertedToGamma
		INSERT INTO ErrorInsertedStoricoPalletToGamma ([InsertDate],[ErrorInsertToGamma])
		VALUES (@Date, @ErrorTxt)
	
	IF @ErrorTxt <> @ErrorInsertedToGamma
		--UPDATE [MSTR1].[RobotActivation].[dbo].[StoricoPalletForInsertToGamma] SET ErrorInsertedToGamma = @ErrorTxt  WHERE InsertDate = @Date
		INSERT INTO ##tmpStoricoPalletForInsertToGamma([InsertDate],[ErrorInsertedToGamma])
			SELECT @Date, @ErrorTxt
	FETCH NEXT FROM #RobotPallets   
    INTO @Number, @Date, @PlaceID, @Barcode, 
	  @1CNomenclatureID, @1CCharacteristicID, @Quantity, @ErrorInsertedToGamma
 END   

CLOSE #RobotPallets	
DEALLOCATE #RobotPallets

UPDATE a SET DateInsertedToGamma = b.[DateInsertedToGamma]  
FROM [MSTR1].[RobotActivation].[dbo].[StoricoPalletForInsertToGamma] a JOIN ##tmpStoricoPalletForInsertToGamma b ON a.InsertDate = b.InsertDate
WHERE b.[DateInsertedToGamma] IS NOT NULL

UPDATE a SET ErrorInsertedToGamma = b.[ErrorInsertedToGamma]  
FROM [MSTR1].[RobotActivation].[dbo].[StoricoPalletForInsertToGamma] a JOIN ##tmpStoricoPalletForInsertToGamma b ON a.InsertDate = b.InsertDate
WHERE b.[ErrorInsertedToGamma] IS NOT NULL

DROP TABLE ##tmpStoricoPalletForInsertToGamma

END
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductSGIFromRobot] TO [PalletRepacker]
    AS [dbo];

