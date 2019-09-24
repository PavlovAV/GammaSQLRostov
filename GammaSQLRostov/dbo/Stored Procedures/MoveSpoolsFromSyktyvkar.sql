CREATE PROCEDURE dbo.MoveSpoolsFromSyktyvkar 
 @SpoolNumber varchar(30) AS 

 BEGIN
	DECLARE  @ProductID uniqueidentifier

	select @ProductID = ProductID
	from GammaSykt.GammaNew.dbo.Products
	WHERE Number = @SpoolNumber

	INSERT Docs (d.DocID, d.IsMarked, d.DocTypeID, d.Number, d.IsConfirmed, d.PrintName, d.PlaceID, d.ShiftID, d.Date, d.Comment, d.IsFromOldGamma, 
	  d.PersonID, d.BranchID, d.PersonGuid)
	SELECT TOP 1 d.DocID, d.IsMarked, d.DocTypeID, d.Number, d.IsConfirmed, d.PrintName, d.PlaceID, d.ShiftID, d.Date, d.Comment, d.IsFromOldGamma, 
	  d.PersonID, d.BranchID, d.PersonGuid
	FROM GammaSykt.GammaNew.dbo.DocProductionProducts  dpp
	JOIN GammaSykt.GammaNew.dbo.Docs d ON d.DocID = dpp.DocID
	WHERE ProductID = @ProductID



	INSERT DocProduction (dp.DocID, InPlaceID, HasWarnings, DocOrderId)
	SELECT TOP 1 dp.DocID, InPlaceID, HasWarnings, DocOrderId
	FROM GammaSykt.GammaNew.dbo.DocProductionProducts  dpp
	JOIN GammaSykt.GammaNew.dbo.DocProduction dp ON dp.DocID = dpp.DocID
	WHERE ProductID = @ProductID


	INSERT Products
	SELECT *
	FROM GammaSykt.GammaNew.dbo.Products 
	WHERE ProductID = @ProductID


	INSERT ProductSpools
	SELECT *
	FROM GammaSykt.GammaNew.dbo.ProductSpools 
	WHERE ProductID = @ProductID

	INSERT DocProductionProducts
	SELECT *
	FROM GammaSykt.GammaNew.dbo.DocProductionProducts 
	WHERE ProductID = @ProductID


END





GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[MoveSpoolsFromSyktyvkar] TO [PalletRepacker]
    AS [dbo];

