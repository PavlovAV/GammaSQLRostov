
CREATE PROCEDURE [dbo].[GetLastDayNomenclatureProductFromRobot] 
AS
BEGIN
  SELECT a.ProdNumber, a.ProductDescription, a.ArticleCode, n.Marking, b.NomenclatureName, b.[1CNomenclatureID], [1CCharacteristicID], COUNT(DISTINCT a.STGCode) AS CountSTGCode, COUNT(DISTINCT b.Number) AS CountNumber, MIN(a.InsertDate) AS FirstDate, MAX(a.InsertDate) AS LastDate,'' AS Result 
  FROM [MSTR1].[RobotActivation].[dbo].[StoricoPallet] a JOIN vProductsInfo b ON a.STGCode COLLATE Cyrillic_General_CI_AS = b.Number 
	JOIN [1CNomenclature] n ON b.[1CNomenclatureID] = n.[1CNomenclatureID]
  WHERE CAST(a.InsertDate AS DATE) >= DATEADD(day,-1,CAST(GETDATE()  AS DATE))
  GROUP BY a.ProdNumber, a.ProductDescription, a.ArticleCode, n.Marking, b.NomenclatureName, b.[1CNomenclatureID], [1CCharacteristicID]
  ORDER BY 11
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastDayNomenclatureProductFromRobot] TO [PalletRepacker]
    AS [dbo];

