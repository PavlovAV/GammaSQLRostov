
CREATE PROCEDURE [dbo].[MoveSpoolsIntoSyktyvkar] 
 @SpoolNumber varchar(30) AS 

 BEGIN
	DECLARE  @ProductID uniqueidentifier

	select @ProductID = ProductID
	from dbo.Products
	WHERE Number = @SpoolNumber

	INSERT GammaSykt.GammaNew.dbo.Docs (d.DocID, d.IsMarked, d.DocTypeID, d.Number, d.IsConfirmed, d.PrintName, d.PlaceID, d.ShiftID, d.Date, d.Comment, d.IsFromOldGamma, 
	  d.PersonID, d.BranchID, d.PersonGuid)
	SELECT TOP 1 d.DocID, d.IsMarked, d.DocTypeID, d.Number, d.IsConfirmed, d.PrintName, d.PlaceID, d.ShiftID, d.Date, d.Comment, d.IsFromOldGamma, 
	  d.PersonID, d.BranchID, d.PersonGuid
	FROM DocProductionProducts  dpp
	JOIN dbo.Docs d ON d.DocID = dpp.DocID
	WHERE ProductID = @ProductID



	INSERT GammaSykt.GammaNew.dbo.DocProduction (dp.DocID, InPlaceID, HasWarnings, DocOrderId)
	SELECT TOP 1 dp.DocID, InPlaceID, HasWarnings, DocOrderId
	FROM DocProductionProducts  dpp
	JOIN DocProduction dp ON dp.DocID = dpp.DocID
	WHERE ProductID = @ProductID


	INSERT GammaSykt.GammaNew.dbo.Products
	SELECT *
	FROM Products 
	WHERE ProductID = @ProductID


	INSERT GammaSykt.GammaNew.dbo.ProductSpools
	SELECT *
	FROM ProductSpools 
	WHERE ProductID = @ProductID

	INSERT GammaSykt.GammaNew.dbo.DocProductionProducts
	SELECT *
	FROM dbo.DocProductionProducts 
	WHERE ProductID = @ProductID

	SELECT @ProductID
END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsIntoSyktyvkar] TO [PalletRepacker]
    AS [dbo];

