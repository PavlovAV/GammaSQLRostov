


--exec [dbo].[AddProductToRostovFromSykt] 'E65F6EB1-54D2-E811-9140-902B34CC4BD7'
CREATE PROCEDURE [dbo].[AddProductToRostovFromSykt](@ProductID uniqueidentifier) 
AS
BEGIN
DECLARE @IsDebug bit = 0

IF @IsDebug = 0 SET NOCOUNT ON
DECLARE @n varchar(50), @c int
PRINT ISNULL(CAST(@ProductID AS varchar(100)),'NULL') + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
SELECT  pr.ProductID, pr.Number, pr.BarCode, pr.ProductKindID, pr.StateID
	INTO #tmpAddProduct
	FROM Products pr
	LEFT JOIN [gamma-server-rostov].[GammaNew].[dbo].Products p ON pr.ProductID = p.ProductID
	WHERE p.ProductID IS NULL AND 
	pr.ProductKindID <> 3  
	AND pr.ProductID = @ProductID
IF @IsDebug = 1 SELECT @n = MIN(number), @c = COUNT(*) FROM #tmpAddProduct
IF @IsDebug = 1 PRINT ISNULL(@n,'#')+'('+ISNULL(CAST(@c AS varchar(10)),'')+')' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
IF (SELECT COUNT(*) FROM #tmpAddProduct )> 0
BEGIN

	DECLARE @ProductKindID int
	SELECT @ProductKindID = ProductKindID FROM #tmpAddProduct
	DECLARE @wDocID uniqueidentifier = NULL
	DECLARE @cc int = NULL

	SELECT TOP 0 DocID 
	INTO #tmpIDs
	FROM Docs
	SELECT TOP 0 DocID, ProductID 
	INTO #tmpIDIDs
	FROM DocProducts


	IF @ProductKindID = 2
	BEGIN
IF @IsDebug = 1 		PRINT '2' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
		TRUNCATE TABLE #tmpIDs
		INSERT INTO #tmpIDs(DocID)
		SELECT pp.ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].Products pp
		WHERE pp.ProductId IN 
		(
		SELECT pr.ProductID
			FROM
			#tmpAddProduct p
			JOIN
			DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
			JOIN
			Products pr ON f.ProductID = pr.ProductID
			WHERE p.ProductKindID = 2 AND pr.ProductID NOT IN (SELECT ProductID FROM #tmpAddProduct)
			GROUP BY pr.ProductID
		)

IF @IsDebug = 1 		SET @cc = NULL
IF @IsDebug = 1			SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 		PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')
		
		INSERT INTO #tmpAddProduct(ProductID, Number, BarCode, ProductKindID, StateID)
		SELECT pr.ProductID, pr.Number, pr.BarCode, pr.ProductKindID, pr.StateID
		FROM
		#tmpAddProduct p
		JOIN
		DocProductionProducts a  ON a.ProductID = p.ProductID
		JOIN
		DocProductionWithdrawals d ON a.DocID = d.DocProductionID
		JOIN
		DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
		JOIN
		Products pr ON f.ProductID = pr.ProductID
		WHERE p.ProductKindID = 2 AND pr.ProductID NOT IN (SELECT ProductID FROM #tmpAddProduct)
		AND pr.ProductID NOT IN (SELECT pp.DocID AS ProductID FROM #tmpIDs pp)
		GROUP BY pr.ProductID, pr.Number, pr.BarCode, pr.ProductKindID, pr.StateID
				
		/*INSERT INTO #tmpAddProduct(ProductID, Number, BarCode, ProductKindID, StateID)
		SELECT pr.ProductID, pr.Number, pr.BarCode, pr.ProductKindID, pr.StateID
		FROM
		#tmpAddProduct p
		JOIN
		DocProductionProducts a  ON a.ProductID = p.ProductID
		JOIN
		DocProductionWithdrawals d ON a.DocID = d.DocProductionID
		JOIN
		DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
		JOIN
		Products pr ON f.ProductID = pr.ProductID
		WHERE p.ProductKindID = 2 AND pr.ProductID NOT IN (SELECT ProductID FROM #tmpAddProduct)
		AND pr.ProductID NOT IN (SELECT pp.ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].Products pp)
		GROUP BY pr.ProductID, pr.Number, pr.BarCode, pr.ProductKindID, pr.StateID*/
	END

IF @IsDebug = 1 	PRINT '3' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
	TRUNCATE TABLE #tmpIDs
		INSERT INTO #tmpIDs(DocID)
		SELECT pp.ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].Products pp
		WHERE pp.ProductId IN 
		(
		SELECT p.ProductID
			FROM
			#tmpAddProduct p
			GROUP BY p.ProductID
		)

IF @IsDebug = 1 		SET @cc = NULL
IF @IsDebug = 1 		SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 		PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')
		
	INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].Products(ProductID,Number,BarCode,ProductKindID,StateID)
	SELECT ProductID,Number,BarCode,ProductKindID,StateID FROM #tmpAddProduct t
	WHERE NOT EXISTS (SELECT pp.DocID AS ProductID FROM #tmpIDs pp)

	/*INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].Products(ProductID,Number,BarCode,ProductKindID,StateID)
	SELECT ProductID,Number,BarCode,ProductKindID,StateID FROM #tmpAddProduct t
	WHERE NOT EXISTS (SELECT pp.ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].Products pp WHERE pp.ProductID = t.ProductID)*/
		
IF @IsDebug = 1 	PRINT '4' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
	TRUNCATE TABLE #tmpIDs
	INSERT INTO #tmpIDs(DocID)
	SELECT pp.DocID FROM [gamma-server-rostov].[GammaNew].[dbo].Docs pp
	WHERE pp.DocId IN 
	(
	SELECT a.DocID 
				FROM Docs a
					JOIN DocProduction b ON a.DocID = b.DocID 
					JOIN DocProductionProducts c ON a.DocID = c.DocId
					JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
				GROUP BY a.DocID
	)

IF @IsDebug = 1 	SET @cc = NULL
IF @IsDebug = 1 	SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 	PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

	INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].Docs(DocID, IsMarked, DocTypeID, Number, IsConfirmed, UserID, PersonId, PrintName, PlaceID, ShiftID, Date,  Comment,  IsFromOldGamma, BranchID, PersonGuid)
	SELECT a.DocID, a.IsMarked, a.DocTypeID, a.Number, a.IsConfirmed, u.UserID, a.PersonId, a.PrintName, a.PlaceID, a.ShiftID, a.Date, ISNULL(a. Comment,'') + '#Выгружено из СФ', a. IsFromOldGamma, a.BranchID, a.PersonGuid 
		FROM Docs a
			JOIN DocProduction b ON a.DocID = b.DocID 
			JOIN DocProductionProducts c ON a.DocID = c.DocId
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			LEFT JOIN [gamma-server-rostov].[GammaNew].[dbo].Users u ON u.[Login] = 'sa'
		WHERE a.DocID NOT IN ( SELECT DocId FROM #tmpIDs)
		GROUP BY a.DocID, a.IsMarked, a.DocTypeID, a.Number, a.IsConfirmed, u.UserID, a.PersonId, a.PrintName, a.PlaceID, a.ShiftID, a.Date, a. Comment, a. IsFromOldGamma, a.BranchID, a.PersonGuid

	/*INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].Docs(DocID, IsMarked, DocTypeID, Number, IsConfirmed, UserID, PersonId, PrintName, PlaceID, ShiftID, Date,  Comment,  IsFromOldGamma, BranchID, PersonGuid)
	SELECT a.DocID, a.IsMarked, a.DocTypeID, a.Number, a.IsConfirmed, u.UserID, a.PersonId, a.PrintName, a.PlaceID, a.ShiftID, a.Date, ISNULL(a. Comment,'') + '#Выгружено из СФ', a. IsFromOldGamma, a.BranchID, a.PersonGuid FROM Docs a
	JOIN DocProduction b ON a.DocID = b.DocID 
	JOIN DocProductionProducts c ON a.DocID = c.DocId
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	LEFT JOIN [gamma-server-rostov].[GammaNew].[dbo].Users u ON u.[Login] = 'sa'
	WHERE a.DocID NOT IN (SELECT pp.DocID FROM [gamma-server-rostov].[GammaNew].[dbo].Docs pp)
	GROUP BY a.DocID, a.IsMarked, a.DocTypeID, a.Number, a.IsConfirmed, u.UserID, a.PersonId, a.PrintName, a.PlaceID, a.ShiftID, a.Date, a. Comment, a. IsFromOldGamma, a.BranchID, a.PersonGuid*/

IF @IsDebug = 1 	PRINT '5' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
	TRUNCATE TABLE #tmpIDs
	INSERT INTO #tmpIDs(DocID)
	SELECT pp.DocID FROM [gamma-server-rostov].[GammaNew].[dbo].DocProduction pp
	WHERE pp.DocId IN 
	(
	SELECT b.DocID
	FROM DocProduction b
	JOIN DocProductionProducts c ON b.DocID = c.DocId
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	GROUP BY b.DocID, b.HasWarnings, b.InPlaceID
	)

IF @IsDebug = 1 	SET @cc = NULL
IF @IsDebug = 1 	SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 	PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

	INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].DocProduction(DocID, DocOrderId, HasWarnings, InPlaceID, ProductionTaskID)
	SELECT b.DocID, NULL AS DocOrderId, b.HasWarnings, b.InPlaceID, NULL AS ProductionTaskID
	FROM DocProduction b
	JOIN DocProductionProducts c ON b.DocID = c.DocId
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	WHERE b.DocID NOT IN (SELECT pp.DocID FROM #tmpIDs pp)
	GROUP BY b.DocID, b.HasWarnings, b.InPlaceID

	/*INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].DocProduction(DocID, DocOrderId, HasWarnings, InPlaceID, ProductionTaskID)
	SELECT b.DocID, NULL AS DocOrderId, b.HasWarnings, b.InPlaceID, NULL AS ProductionTaskID
	FROM DocProduction b
	JOIN DocProductionProducts c ON b.DocID = c.DocId
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	WHERE b.DocID NOT IN (SELECT pp.DocID FROM [gamma-server-rostov].[GammaNew].[dbo].DocProduction pp)
	GROUP BY b.DocID, b.HasWarnings, b.InPlaceID*/
 
IF @IsDebug = 1 	PRINT '6' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)

	TRUNCATE TABLE #tmpIDIDs
	INSERT INTO #tmpIDIDs(DocID,ProductID)
	SELECT t.DocID, t.ProductID 
	FROM [gamma-server-rostov].[GammaNew].[dbo].DocProductionProducts t 
	WHERE EXISTS
	(
	SELECT c.DocID, c.ProductID
	FROM DocProductionProducts c
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	WHERE t.DocID = c.DocID AND t.ProductID = c.ProductID
	GROUP BY c.DocID, c.ProductID
	)

IF @IsDebug = 1 	SET @cc = NULL
IF @IsDebug = 1 	SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDIDs a) AS varchar(100))
IF @IsDebug = 1 	PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

	INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].DocProductionProducts(DocID,ProductID,Quantity,[1CNomenclatureID],[1CCharacteristicID])
	SELECT c.DocID, c.ProductID,c.Quantity, c.[1CNomenclatureID],c.[1CCharacteristicID]
	FROM DocProductionProducts c
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	WHERE NOT EXISTS (SELECT 1 FROM #tmpIDIDs t WHERE t.DocID = c.DocID AND t.ProductID = c.ProductID)
	GROUP BY c.DocID, c.ProductID,c.Quantity, c.[1CNomenclatureID],c.[1CCharacteristicID]
	/*INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].DocProductionProducts(DocID,ProductID,Quantity,[1CNomenclatureID],[1CCharacteristicID])
	SELECT c.DocID, c.ProductID,c.Quantity, c.[1CNomenclatureID],c.[1CCharacteristicID]
	FROM DocProductionProducts c
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	WHERE NOT EXISTS (SELECT 1 FROM [gamma-server-rostov].[GammaNew].[dbo].DocProductionProducts t WHERE t.DocID = c.DocID AND t.ProductID = c.ProductID)
	GROUP BY c.DocID, c.ProductID,c.Quantity, c.[1CNomenclatureID],c.[1CCharacteristicID]*/
 
	--Паллеты (россыпь не надо)
	IF (SELECT COUNT(*) FROM #tmpAddProduct p WHERE p.ProductKindID = 1)>0
	BEGIN
IF @IsDebug = 1 	PRINT '7' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
		SELECT TOP 0 c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity
			INTO #tmpProductItems
			FROM ProductItems c
		INSERT INTO #tmpProductItems(ProductItemID, ProductID,[1CNomenclatureID],[1CCharacteristicID],Quantity)
			SELECT ProductItemID, ProductID,[1CNomenclatureID],[1CCharacteristicID],Quantity  FROM [gamma-server-rostov].[GammaNew].[dbo].ProductItems pp
				WHERE EXISTS 
				(
				SELECT c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity
					FROM ProductItems c
					JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
					WHERE p.ProductKindID = 1
					AND (c.ProductItemID = pp.ProductItemID AND c.ProductID = pp.ProductID)
					-- AND c.[1CNomenclatureID] = pp.[1CNomenclatureID] AND c.[1CCharacteristicID] = pp.[1CCharacteristicID]
						--AND ((c.Quantity IS NOT NULL AND pp.Quantity IS NOT NULL AND c.Quantity = pp.Quantity) OR (c.Quantity IS NULL AND pp.Quantity IS NULL)))
					GROUP BY c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity
				)
	
IF @IsDebug = 1 	SET @cc = NULL
IF @IsDebug = 1 	SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDIDs a) AS varchar(100))
IF @IsDebug = 1 	PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

		INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].ProductItems(ProductItemID, ProductID, [1CNomenclatureID],[1CCharacteristicID], Quantity)
			SELECT c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity
			FROM ProductItems c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 1
			AND NOT EXISTS (SELECT 1 AS ProductItemID FROM #tmpProductItems pp WHERE c.ProductItemID = pp.ProductItemID AND c.ProductID = pp.ProductID AND c.[1CNomenclatureID] = pp.[1CNomenclatureID] AND c.[1CCharacteristicID] = pp.[1CCharacteristicID]
						AND ((c.Quantity IS NOT NULL AND pp.Quantity IS NOT NULL AND c.Quantity = pp.Quantity) OR (c.Quantity IS NULL AND pp.Quantity IS NULL)))
			GROUP BY c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity

		/*INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].ProductItems(ProductItemID, ProductID, [1CNomenclatureID],[1CCharacteristicID], Quantity)
			SELECT c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity
			FROM ProductItems c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 1
			AND NOT EXISTS (SELECT pp.ProductItemID FROM [gamma-server-rostov].[GammaNew].[dbo].ProductItems pp WHERE c.ProductID = pp.ProductID AND c.[1CNomenclatureID] = pp.[1CNomenclatureID] AND c.[1CCharacteristicID] = pp.[1CCharacteristicID]
				AND ((c.Quantity IS NOT NULL AND pp.Quantity IS NOT NULL AND c.Quantity = pp.Quantity) OR (c.Quantity IS NULL AND pp.Quantity IS NULL)))
			GROUP BY c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity*/

IF @IsDebug = 1 	PRINT '8' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
		TRUNCATE TABLE #tmpIDs
		INSERT INTO #tmpIDs(DocID)
		SELECT pp.ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].ProductPallets pp
		WHERE pp.ProductID IN 
		(
		SELECT c.ProductID
				FROM ProductPallets c
				JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
				WHERE p.ProductKindID = 1
				GROUP BY c.ProductID
		)

IF @IsDebug = 1 		SET @cc = NULL
IF @IsDebug = 1 		SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 		PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

		INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].ProductPallets(ProductID, IndexNumber)
			SELECT c.ProductID, c.IndexNumber
			FROM ProductPallets c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 1
			AND c.ProductID NOT IN (SELECT pp.DocID AS ProductID FROM #tmpIDs pp)
			GROUP BY c.ProductID, c.IndexNumber
	END 

	--Тамбура
	IF (SELECT COUNT(*) FROM #tmpAddProduct p WHERE p.ProductKindID = 0)>0
	BEGIN
IF @IsDebug = 1 	PRINT '9' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
		TRUNCATE TABLE #tmpIDs
		INSERT INTO #tmpIDs(DocID)
		SELECT pp.ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].ProductSpools pp
		WHERE pp.ProductID IN 
		(
		SELECT c.ProductID
				FROM ProductSpools c
				JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
				WHERE p.ProductKindID = 0
				GROUP BY c.ProductID
		)

IF @IsDebug = 1 		SET @cc = NULL
IF @IsDebug = 1 		SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 		PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

		INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].ProductSpools(ProductID, [1CCharacteristicID], [1CNomenclatureID], BreakNumber, CurrentDiameter, CurrentLength, DecimalWeight, Diameter, Length, RealBasisWeight,RealFormat,ToughnessKindID,Weight)
			SELECT c.ProductID, c.[1CCharacteristicID], c.[1CNomenclatureID], c.BreakNumber, c.CurrentDiameter, c.CurrentLength, c.DecimalWeight, c.Diameter, c.Length, c.RealBasisWeight,c.RealFormat,c.ToughnessKindID,c.Weight
			FROM ProductSpools c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 0
			AND c.ProductID NOT IN (SELECT pp.DocID AS ProductID FROM #tmpIDs pp)
			GROUP BY c.ProductID, c.[1CCharacteristicID], c.[1CNomenclatureID], c.BreakNumber, c.CurrentDiameter, c.CurrentLength, c.DecimalWeight, c.Diameter, c.Length, c.RealBasisWeight,c.RealFormat,c.ToughnessKindID,c.Weight
	END 

	--Групповые упаковки
	IF (SELECT COUNT(*) FROM #tmpAddProduct p WHERE p.ProductKindID = 2)>0
	BEGIN
IF @IsDebug = 1 	PRINT '10' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
		TRUNCATE TABLE #tmpIDs
		INSERT INTO #tmpIDs(DocID)
		SELECT pp.ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].ProductGroupPacks pp
		WHERE pp.ProductID IN 
		(
		SELECT c.ProductID
				FROM ProductGroupPacks c
				JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
				WHERE p.ProductKindID = 2
				GROUP BY c.ProductID
		)

IF @IsDebug = 1 		SET @cc = NULL
IF @IsDebug = 1 		SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 		PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

		INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].ProductGroupPacks(ProductID, [1CCharacteristicID], [1CNomenclatureID], Diameter, GrossWeight, ManualWeightInput, Weight)
			SELECT c.ProductID, c.[1CCharacteristicID], c.[1CNomenclatureID], c.Diameter, c.GrossWeight, c.ManualWeightInput, c.Weight
			FROM ProductGroupPacks c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 2
			AND c.ProductID NOT IN (SELECT pp.DocID AS ProductID FROM #tmpIDs pp)
			GROUP BY c.ProductID, c.[1CCharacteristicID], c.[1CNomenclatureID], c.Diameter, c.GrossWeight, c.ManualWeightInput, c.Weight
 
IF @IsDebug = 1 		PRINT '11' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)

		TRUNCATE TABLE #tmpIDs
		INSERT INTO #tmpIDs(DocID)
			SELECT pp.DocID FROM [gamma-server-rostov].[GammaNew].[dbo].Docs pp
				WHERE pp.DocId IN 
				(
				SELECT w.DocID 
					FROM 
						#tmpAddProduct p
						JOIN
						DocProductionProducts a  ON a.ProductID = p.ProductID
						JOIN
						DocProductionWithdrawals d ON a.DocID = d.DocProductionID
						JOIN
						Docs w ON w.DocID = d.DocWithdrawalID
					WHERE p.ProductKindID = 2
					GROUP BY w.DocID
				)

IF @IsDebug = 1 	SET @cc = NULL
IF @IsDebug = 1 	SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 	PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

	INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].Docs(DocID, IsMarked, DocTypeID, Number, IsConfirmed, UserID, PersonId, PrintName, PlaceID, ShiftID, Date,  Comment,  IsFromOldGamma, BranchID, PersonGuid)
		SELECT w.DocID, w.IsMarked, w.DocTypeID, w.Number, w.IsConfirmed, u.UserID, w.PersonId, w.PrintName, w.PlaceID, w.ShiftID, w.Date, w. Comment, w. IsFromOldGamma, w.BranchID, w.PersonGuid 
			FROM 
				#tmpAddProduct p
				JOIN
				DocProductionProducts a  ON a.ProductID = p.ProductID
				JOIN
				DocProductionWithdrawals d ON a.DocID = d.DocProductionID
				JOIN
				Docs w ON w.DocID = d.DocWithdrawalID
				LEFT JOIN [gamma-server-rostov].[GammaNew].[dbo].Users u ON u.[Login] = 'sa'
			WHERE p.ProductKindID = 2
			AND w.DocID NOT IN ( SELECT DocId FROM #tmpIDs)
			GROUP BY w.DocID, w.IsMarked, w.DocTypeID, w.Number, w.IsConfirmed, u.UserID, w.PersonId, w.PrintName, w.PlaceID, w.ShiftID, w.Date, w. Comment, w. IsFromOldGamma, w.BranchID, w.PersonGuid

		/*INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].Docs(DocID, IsMarked, DocTypeID, Number, IsConfirmed, UserID, PersonId, PrintName, PlaceID, ShiftID, Date,  Comment,  IsFromOldGamma, BranchID, PersonGuid)
			SELECT w.DocID, w.IsMarked, w.DocTypeID, w.Number, w.IsConfirmed, u.UserID, w.PersonId, w.PrintName, w.PlaceID, w.ShiftID, w.Date, w. Comment, w. IsFromOldGamma, w.BranchID, w.PersonGuid FROM 
			#tmpAddProduct p
			JOIN
			DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			Docs w ON w.DocID = d.DocWithdrawalID
			LEFT JOIN [gamma-server-rostov].[GammaNew].[dbo].Users u ON u.[Login] = 'sa'
			WHERE p.ProductKindID = 2
			AND w.DocID NOT IN (SELECT pp.DocID FROM [gamma-server-rostov].[GammaNew].[dbo].Docs pp)
			GROUP BY w.DocID, w.IsMarked, w.DocTypeID, w.Number, w.IsConfirmed, u.UserID, w.PersonId, w.PrintName, w.PlaceID, w.ShiftID, w.Date, w. Comment, w. IsFromOldGamma, w.BranchID, w.PersonGuid
		*/ 
IF @IsDebug = 1 		PRINT '12' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
		TRUNCATE TABLE #tmpIDs
		INSERT INTO #tmpIDs(DocID)
			SELECT pp.DocID FROM [gamma-server-rostov].[GammaNew].[dbo].DocWithdrawal pp
				WHERE pp.DocId IN 
				(
				SELECT w.DocID
				FROM
				#tmpAddProduct p
				JOIN
				DocProductionProducts a  ON a.ProductID = p.ProductID
				JOIN
				DocProductionWithdrawals d ON a.DocID = d.DocProductionID
				JOIN
				DocWithdrawal w ON w.DocID = d.DocWithdrawalID
				WHERE p.ProductKindID = 2
				GROUP BY w.DocID
				)

IF @IsDebug = 1 	SET @cc = NULL
IF @IsDebug = 1 	SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDs a) AS varchar(100))
IF @IsDebug = 1 	PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')


		INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].DocWithdrawal(DocID,OutPlaceID)
			SELECT w.DocID,w.OutPlaceID
			FROM
			#tmpAddProduct p
			JOIN
			DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			DocWithdrawal w ON w.DocID = d.DocWithdrawalID
			WHERE p.ProductKindID = 2
			AND w.DocID NOT IN (SELECT pp.DocID FROM #tmpIDs pp)
			GROUP BY w.DocID,w.OutPlaceID
 
IF @IsDebug = 1 		PRINT '13' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)

		TRUNCATE TABLE #tmpIDIDs
		INSERT INTO #tmpIDIDs(DocID,ProductID)
			SELECT DocWithdrawalID, DocProductionID FROM [gamma-server-rostov].[GammaNew].[dbo].DocProductionWithdrawals pp
				WHERE EXISTS
				(
				SELECT d.DocWithdrawalID, d.DocProductionID
					FROM
					#tmpAddProduct p
					JOIN
					DocProductionProducts a  ON a.ProductID = p.ProductID
					JOIN
					DocProductionWithdrawals d ON a.DocID = d.DocProductionID
					JOIN
					DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
					JOIN
					Products pr ON f.ProductID = pr.ProductID
					WHERE p.ProductKindID = 2
					AND pp.DocProductionID = d.DocProductionID AND pp.DocWithdrawalID = d.DocWithdrawalID
					GROUP BY d.DocWithdrawalID, d.DocProductionID
				)

IF @IsDebug = 1 	SET @cc = NULL
IF @IsDebug = 1 	SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDIDs a) AS varchar(100))
IF @IsDebug = 1 	PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

		INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].DocProductionWithdrawals(DocWithdrawalID, DocProductionID)
			SELECT d.DocWithdrawalID, d.DocProductionID
			FROM
			#tmpAddProduct p
			JOIN
			DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
			JOIN
			Products pr ON f.ProductID = pr.ProductID
			WHERE p.ProductKindID = 2
			AND NOT EXISTS (SELECT 1 FROM #tmpIDIDs pp WHERE pp.DocID = d.DocProductionID AND pp.ProductID = d.DocWithdrawalID)
			GROUP BY d.DocWithdrawalID, d.DocProductionID
 
IF @IsDebug = 1 		PRINT '14' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)

		--SELECT TOP 0 DocID, ProductID, Quantity, CompleteWithdrawal INTO #tmpDocWithdrawalProducts FROM DocWithdrawalProducts
		--INSERT INTO #tmpDocWithdrawalProducts(DocID, ProductID, Quantity, CompleteWithdrawal)
		TRUNCATE TABLE #tmpIDIDs
		INSERT INTO #tmpIDIDs(DocID,ProductID)
			SELECT DocID, ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].DocWithdrawalProducts pp
				WHERE EXISTS 
				(
				SELECT f.DocID, f.ProductID, f.Quantity, f.CompleteWithdrawal
					FROM
					#tmpAddProduct p
					JOIN
					DocProductionProducts a  ON a.ProductID = p.ProductID
					JOIN
					DocProductionWithdrawals d ON a.DocID = d.DocProductionID
					JOIN
					DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
					JOIN
					Products pr ON f.ProductID = pr.ProductID
					WHERE p.ProductKindID = 2
					AND (f.DocID = pp.DocID AND f.ProductID = pp.DocID 
						AND ((f.Quantity IS NOT NULL AND pp.Quantity IS NOT NULL AND f.Quantity = pp.Quantity) OR (f.Quantity IS NULL AND pp.Quantity IS NULL))
						AND ((f.CompleteWithdrawal IS NOT NULL AND pp.CompleteWithdrawal IS NOT NULL AND f.CompleteWithdrawal = pp.CompleteWithdrawal) OR (f.CompleteWithdrawal IS NULL AND pp.CompleteWithdrawal IS NULL)))
					GROUP BY f.DocID, f.ProductID, f.Quantity, f.CompleteWithdrawal
				)

IF @IsDebug = 1 	SET @cc = NULL
IF @IsDebug = 1 	SELECT @cc =  CAST((SELECT COUNT(DISTINCT a.DocID) FROM #tmpIDIDs a) AS varchar(100))
IF @IsDebug = 1 	PRINT ISNULL(CAST(@cc AS varchar(100)),'NULL')

	INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].DocWithdrawalProducts(DocID, ProductID, Quantity, CompleteWithdrawal)
			SELECT f.DocID, f.ProductID, f.Quantity, f.CompleteWithdrawal
			FROM
			#tmpAddProduct p
			JOIN
			DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
			JOIN
			Products pr ON f.ProductID = pr.ProductID
			WHERE p.ProductKindID = 2
			AND NOT EXISTS (SELECT 1 FROM #tmpIDIDs pp WHERE f.DocID = pp.DocID AND f.ProductID = pp.DocID)
			GROUP BY f.DocID, f.ProductID, f.Quantity, f.CompleteWithdrawal
		/*INSERT INTO [gamma-server-rostov].[GammaNew].[dbo].DocWithdrawalProducts(DocID, ProductID, Quantity, CompleteWithdrawal)
			SELECT f.DocID, f.ProductID, f.Quantity, f.CompleteWithdrawal
			FROM
			#tmpAddProduct p
			JOIN
			DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
			JOIN
			Products pr ON f.ProductID = pr.ProductID
			WHERE p.ProductKindID = 2
			AND NOT EXISTS (SELECT pp.ProductID FROM [gamma-server-rostov].[GammaNew].[dbo].DocWithdrawalProducts pp WHERE f.DocID = pp.DocID AND f.ProductID = pp.DocID 
				AND ((f.Quantity IS NOT NULL AND pp.Quantity IS NOT NULL AND f.Quantity = pp.Quantity) OR (f.Quantity IS NULL AND pp.Quantity IS NULL))
				AND ((f.CompleteWithdrawal IS NOT NULL AND pp.CompleteWithdrawal IS NOT NULL AND f.CompleteWithdrawal = pp.CompleteWithdrawal) OR (f.CompleteWithdrawal IS NULL AND pp.CompleteWithdrawal IS NULL)))
			GROUP BY f.DocID, f.ProductID, f.Quantity, f.CompleteWithdrawal*/
	END 
IF @IsDebug = 1 	PRINT '15' + ' ' + CONVERT (VARCHAR(20),GETDATE(),114)
END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AddProductToRostovFromSykt] TO [PalletRepacker]
    AS [dbo];

