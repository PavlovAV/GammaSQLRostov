
CREATE PROCEDURE [dbo].[GetLastErrorInsertedStoricoPalletToGamma] 
AS
BEGIN
  SELECT a.ErrorInsertToGamma AS Result, p.*
  FROM [GammaNew].[dbo].[ErrorInsertedStoricoPalletToGamma] a JOIN [MSTR1].[RobotActivation].[dbo].[StoricoPalletForInsertToGamma] p ON a.InsertDate = p.InsertDate
  WHERE CAST(a.DateAdd AS DATE) >= DATEADD(day,-1,CAST(GETDATE()  AS DATE))
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetLastErrorInsertedStoricoPalletToGamma] TO [PalletRepacker]
    AS [dbo];

