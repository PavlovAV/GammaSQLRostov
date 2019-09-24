



CREATE VIEW [dbo].[vRobotNomenclatures]
AS
SELECT 
	sp.ProdNumber, sp.ProdDescription, sp.EANFullPallet, sp.ProductionLine, rp.PlaceID, rp.PlaceName
	, ISNULL(rp.[PlaceName],'') + '/' + ISNULL(sp.ArticleCode COLLATE Cyrillic_General_CI_AS,'')+'/'+ISNULL(sp.ProdDescription COLLATE Cyrillic_General_CI_AS,'') + '/' +ISNULL(sp.EANFullPallet COLLATE Cyrillic_General_CI_AS,'') + '/' + ISNULL(CAST(sp.ProdNumber AS varchar(100)),'') AS ProdName
FROM MSTR1.RobotActivation.dbo.Pallet sp
JOIN [dbo].[vRobotPlaces] rp ON rp.RobotLineID = ProductionLine
WHERE ProdDescription <> ''

GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [PalletRepacker]
    AS [dbo];

