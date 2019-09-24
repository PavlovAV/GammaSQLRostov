



CREATE PROCEDURE [dbo].[AddProductToRostovFromSykt](@ProductID uniqueidentifier) 
AS
BEGIN

SET NOCOUNT ON
DECLARE @n varchar(50), @c int
PRINT ISNULL(CAST(@ProductID AS varchar(100)),'NULL')
SELECT  pr.ProductID, pr.Number, pr.BarCode, pr.ProductKindID, pr.StateID
	INTO #tmpAddProduct
	FROM [gamma-server-syktyvkar].[GammaNew].[dbo].Products pr
	LEFT JOIN Products p ON pr.ProductID = p.ProductID
	WHERE p.ProductID IS NULL AND pr.ProductKindID <> 3  
	AND pr.ProductID = @ProductID
SELECT @n = MIN(number), @c = COUNT(*) FROM #tmpAddProduct
PRINT ISNULL(@n,'#')+'('+ISNULL(CAST(@c AS varchar(10)),'')+')'
IF (SELECT COUNT(*) FROM #tmpAddProduct )> 0
BEGIN

	DECLARE @ProductKindID int
	SELECT @ProductKindID = ProductKindID FROM #tmpAddProduct

	IF @ProductKindID = 2
	BEGIN
		PRINT '2'
		INSERT INTO #tmpAddProduct(ProductID, Number, BarCode, ProductKindID, StateID)
		SELECT pr.ProductID, pr.Number, pr.BarCode, pr.ProductKindID, pr.StateID
		FROM
		#tmpAddProduct p
		JOIN
		[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionProducts a  ON a.ProductID = p.ProductID
		JOIN
		[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionWithdrawals d ON a.DocID = d.DocProductionID
		JOIN
		[gamma-server-syktyvkar].[GammaNew].[dbo].DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
		JOIN
		[gamma-server-syktyvkar].[GammaNew].[dbo].Products pr ON f.ProductID = pr.ProductID
		WHERE p.ProductKindID = 2 AND pr.ProductID NOT IN (SELECT ProductID FROM #tmpAddProduct)
		AND pr.ProductID NOT IN (SELECT pp.ProductID FROM Products pp)
		GROUP BY pr.ProductID, pr.Number, pr.BarCode, pr.ProductKindID, pr.StateID
	END

	PRINT '3'
	INSERT INTO Products(ProductID,Number,BarCode,ProductKindID,StateID)
	SELECT ProductID,Number,BarCode,ProductKindID,StateID FROM #tmpAddProduct

	PRINT '4'
	INSERT INTO Docs(DocID, IsMarked, DocTypeID, Number, IsConfirmed, UserID, PersonId, PrintName, PlaceID, ShiftID, Date,  Comment,  IsFromOldGamma, BranchID, PersonGuid)
	SELECT a.DocID, a.IsMarked, a.DocTypeID, a.Number, a.IsConfirmed, u.UserID, a.PersonId, a.PrintName, a.PlaceID, a.ShiftID, a.Date, ISNULL(a. Comment,'') + '#Выгружено из СФ', a. IsFromOldGamma, a.BranchID, a.PersonGuid 
	FROM [gamma-server-syktyvkar].[GammaNew].[dbo].Docs a
	JOIN [gamma-server-syktyvkar].[GammaNew].[dbo].DocProduction b ON a.DocID = b.DocID 
	JOIN [gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionProducts c ON a.DocID = c.DocId
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	LEFT JOIN Users u ON u.[Login] = 'sa'
	WHERE a.DocID NOT IN (SELECT pp.DocID FROM Docs pp)
	GROUP BY a.DocID, a.IsMarked, a.DocTypeID, a.Number, a.IsConfirmed, u.UserID, a.PersonId, a.PrintName, a.PlaceID, a.ShiftID, a.Date, a. Comment, a. IsFromOldGamma, a.BranchID, a.PersonGuid

	PRINT '5'
	INSERT INTO DocProduction(DocID, DocOrderId, HasWarnings, InPlaceID, ProductionTaskID)
	SELECT b.DocID, NULL AS DocOrderId, b.HasWarnings, b.InPlaceID, NULL AS ProductionTaskID
	FROM [gamma-server-syktyvkar].[GammaNew].[dbo].DocProduction b
	JOIN [gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionProducts c ON b.DocID = c.DocId
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	WHERE b.DocID NOT IN (SELECT pp.DocID FROM DocProduction pp)
	GROUP BY b.DocID, b.HasWarnings, b.InPlaceID
 
	PRINT '6'
	INSERT INTO DocProductionProducts(DocID,ProductID,Quantity,[1CNomenclatureID],[1CCharacteristicID])
	SELECT c.DocID, c.ProductID,c.Quantity, c.[1CNomenclatureID],c.[1CCharacteristicID]
	FROM [gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionProducts c
	JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
	GROUP BY c.DocID, c.ProductID,c.Quantity, c.[1CNomenclatureID],c.[1CCharacteristicID]
 
	--Паллеты (россыпь не надо)
	IF (SELECT COUNT(*) FROM #tmpAddProduct p WHERE p.ProductKindID = 1)>0
	BEGIN
	PRINT '9'
		INSERT INTO ProductItems(ProductItemID, ProductID, [1CNomenclatureID],[1CCharacteristicID], Quantity)
			SELECT c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity
			FROM [gamma-server-syktyvkar].[GammaNew].[dbo].ProductItems c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 1
			AND NOT EXISTS (SELECT pp.ProductItemID FROM ProductItems pp WHERE c.ProductID = pp.ProductID AND c.[1CNomenclatureID] = pp.[1CNomenclatureID] AND c.[1CCharacteristicID] = pp.[1CCharacteristicID]
				AND ((c.Quantity IS NOT NULL AND pp.Quantity IS NOT NULL AND c.Quantity = pp.Quantity) OR (c.Quantity IS NULL AND pp.Quantity IS NULL)))
			GROUP BY c.ProductItemID, c.ProductID, c.[1CNomenclatureID],c.[1CCharacteristicID], c.Quantity

	PRINT '8'
		INSERT INTO ProductPallets(ProductID, IndexNumber)
			SELECT c.ProductID, c.IndexNumber
			FROM [gamma-server-syktyvkar].[GammaNew].[dbo].ProductPallets c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 1
			AND c.ProductID NOT IN (SELECT pp.ProductID FROM ProductPallets pp)
			GROUP BY c.ProductID, c.IndexNumber
	END 

	--Тамбура
	IF (SELECT COUNT(*) FROM #tmpAddProduct p WHERE p.ProductKindID = 0)>0
	BEGIN
	PRINT '9'
		INSERT INTO ProductSpools(ProductID, [1CCharacteristicID], [1CNomenclatureID], BreakNumber, CurrentDiameter, CurrentLength, DecimalWeight, Diameter, Length, RealBasisWeight,RealFormat,ToughnessKindID,Weight)
			SELECT c.ProductID, c.[1CCharacteristicID], c.[1CNomenclatureID], c.BreakNumber, c.CurrentDiameter, c.CurrentLength, c.DecimalWeight, c.Diameter, c.Length, c.RealBasisWeight,c.RealFormat,c.ToughnessKindID,c.Weight
			FROM [gamma-server-syktyvkar].[GammaNew].[dbo].ProductSpools c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 0
			AND c.ProductID NOT IN (SELECT pp.ProductID FROM ProductSpools pp)
			GROUP BY c.ProductID, c.[1CCharacteristicID], c.[1CNomenclatureID], c.BreakNumber, c.CurrentDiameter, c.CurrentLength, c.DecimalWeight, c.Diameter, c.Length, c.RealBasisWeight,c.RealFormat,c.ToughnessKindID,c.Weight
	END 

	--Групповые упаковки
	IF (SELECT COUNT(*) FROM #tmpAddProduct p WHERE p.ProductKindID = 2)>0
	BEGIN
	PRINT '10'
		INSERT INTO ProductGroupPacks(ProductID, [1CCharacteristicID], [1CNomenclatureID], Diameter, GrossWeight, ManualWeightInput, Weight)
			SELECT c.ProductID, c.[1CCharacteristicID], c.[1CNomenclatureID], c.Diameter, c.GrossWeight, c.ManualWeightInput, c.Weight
			FROM [gamma-server-syktyvkar].[GammaNew].[dbo].ProductGroupPacks c
			JOIN #tmpAddProduct p ON c.ProductID = p.ProductID
			WHERE p.ProductKindID = 2
			AND c.ProductID NOT IN (SELECT pp.ProductID FROM ProductGroupPacks pp)
			GROUP BY c.ProductID, c.[1CCharacteristicID], c.[1CNomenclatureID], c.Diameter, c.GrossWeight, c.ManualWeightInput, c.Weight
 
		PRINT '11'

		INSERT INTO Docs(DocID, IsMarked, DocTypeID, Number, IsConfirmed, UserID, PersonId, PrintName, PlaceID, ShiftID, Date,  Comment,  IsFromOldGamma, BranchID, PersonGuid)
			SELECT w.DocID, w.IsMarked, w.DocTypeID, w.Number, w.IsConfirmed, u.UserID, w.PersonId, w.PrintName, w.PlaceID, w.ShiftID, w.Date, w. Comment, w. IsFromOldGamma, w.BranchID, w.PersonGuid FROM 
			#tmpAddProduct p
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].Docs w ON w.DocID = d.DocWithdrawalID
			LEFT JOIN Users u ON u.[Login] = 'sa'
			WHERE p.ProductKindID = 2
			AND w.DocID NOT IN (SELECT pp.DocID FROM Docs pp)
			GROUP BY w.DocID, w.IsMarked, w.DocTypeID, w.Number, w.IsConfirmed, u.UserID, w.PersonId, w.PrintName, w.PlaceID, w.ShiftID, w.Date, w. Comment, w. IsFromOldGamma, w.BranchID, w.PersonGuid
 
		PRINT '12'

		INSERT INTO DocWithdrawal(DocID,OutPlaceID)
			SELECT w.DocID,w.OutPlaceID
			FROM
			#tmpAddProduct p
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocWithdrawal w ON w.DocID = d.DocWithdrawalID
			WHERE p.ProductKindID = 2
			AND w.DocID NOT IN (SELECT pp.DocID FROM DocWithdrawal pp)
			GROUP BY w.DocID,w.OutPlaceID
 
		PRINT '13'

		INSERT INTO DocProductionWithdrawals(DocWithdrawalID, DocProductionID)
			SELECT d.DocWithdrawalID, d.DocProductionID
			FROM
			#tmpAddProduct p
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].Products pr ON f.ProductID = pr.ProductID
			WHERE p.ProductKindID = 2
			AND NOT EXISTS (SELECT pp.DocWithdrawalID FROM DocProductionWithdrawals pp WHERE pp.DocProductionID = d.DocProductionID AND pp.DocWithdrawalID = d.DocWithdrawalID)
			GROUP BY d.DocWithdrawalID, d.DocProductionID
 
		PRINT '14'

		INSERT INTO DocWithdrawalProducts(DocID, ProductID, Quantity, CompleteWithdrawal)
			SELECT f.DocID, f.ProductID, f.Quantity, f.CompleteWithdrawal
			FROM
			#tmpAddProduct p
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionProducts a  ON a.ProductID = p.ProductID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocProductionWithdrawals d ON a.DocID = d.DocProductionID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].DocWithdrawalProducts f ON f.DocID = d.DocWithdrawalID
			JOIN
			[gamma-server-syktyvkar].[GammaNew].[dbo].Products pr ON f.ProductID = pr.ProductID
			WHERE p.ProductKindID = 2
			AND NOT EXISTS (SELECT pp.ProductID FROM DocWithdrawalProducts pp WHERE f.DocID = pp.DocID AND f.ProductID = pp.DocID 
				AND ((f.Quantity IS NOT NULL AND pp.Quantity IS NOT NULL AND f.Quantity = pp.Quantity) OR (f.Quantity IS NULL AND pp.Quantity IS NULL))
				AND ((f.CompleteWithdrawal IS NOT NULL AND pp.CompleteWithdrawal IS NOT NULL AND f.CompleteWithdrawal = pp.CompleteWithdrawal) OR (f.CompleteWithdrawal IS NULL AND pp.CompleteWithdrawal IS NULL)))
			GROUP BY f.DocID, f.ProductID, f.Quantity, f.CompleteWithdrawal
	END 
	PRINT '15'
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

