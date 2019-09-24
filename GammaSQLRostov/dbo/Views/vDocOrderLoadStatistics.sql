
CREATE VIEW [dbo].[vDocOrderLoadStatistics]
AS
---- Плотность, вес и объем отгруженной бумаги-основы
SELECT a.DocOrderID, a.ProductID, a.[1CNomenclatureID], a.[1CCharacteristicID], dbo.GetPaperDensity(a.Weight*1000, 
	a.CoreDiameter, a.Diameter, a.Format*a.NumSpools) AS Density, a.Weight, dbo.GetSpoolVolume(0, a.Diameter, a.Format*a.NumSpools) AS Volume
FROM
(
	SELECT a.DocOrderID, a.ProductID, c.[1CNomenclatureID], c.[1CCharacteristicID], c.Diameter, c.Weight, ISNULL(d.CoreDiameterNumeric,0) AS CoreDiameter,
		d.FormatNumeric AS [Format], COUNT(b.ProductID) AS NumSpools
	FROM
	vDocMovementProducts a
	JOIN
	vGroupPackSpools b ON a.ProductID = b.ProductGroupPackID
	JOIN
	ProductGroupPacks c ON a.ProductID = c.ProductID
	JOIN
	vCharacteristicSGBProperties d ON c.[1CCharacteristicID] = d.[1CCharacteristicID]
	WHERE a.DocOrderID IS NOT NULL
	GROUP BY a.DocOrderID, a.ProductID, c.[1CNomenclatureID], c.[1CCharacteristicID], c.Diameter, c.Weight, d.CoreDiameterNumeric, d.FormatNumeric
) a



GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocOrderLoadStatistics] TO [PalletRepacker]
    AS [dbo];

