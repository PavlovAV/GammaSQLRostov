

CREATE VIEW [dbo].[vShortNomenclatureName]
--WITH SCHEMABINDING
AS
SELECT 
	a.[1CNomenclatureID], b.[1CCharacteristicID],
	CASE 
		WHEN EXISTS 
			(
				SELECT a.[1CNomenclatureID] FROM 
				dbo.PlaceGroup1CNomenclature pg
				JOIN
				dbo.[1CNomenclature] b ON pg.[1CNomenclatureID] = b.[1CParentID]
				WHERE b.[1CNomenclatureID] = a.[1CNomenclatureID] AND PlaceGroupID IN (0,1,3)
			) THEN
			c.SortValue + ',' + ISNULL(CONVERT(varchar(1), d.LayerNumberNumeric) + 'сл/','') + c.Composition + '/' 
			+ CONVERT(varchar(20), CONVERT(float, c.BasisWeightNumeric), 128) + 'г/' 
			+ ISNULL(CONVERT(varchar(10),d.FormatNumeric) + '/'	+ d.Color,'')
		WHEN EXISTS
			(
				SELECT a.[1CNomenclatureID] FROM 
				dbo.PlaceGroup1CNomenclature pg
				JOIN
				dbo.[1CNomenclature] b ON pg.[1CNomenclatureID] = b.[1CParentID]
				WHERE b.[1CNomenclatureID] = a.[1CNomenclatureID] AND PlaceGroupID = 2
			) THEN
			ISNULL(e.ShortKind + ' ' + ISNULL(f.Article, e.Aricle) + ' ' + f.Config + ' ' + ISNULL(f.DecorColor, ''), a.Name + ISNULL(' ' + b.Name,''))
			ELSE
			a.Name + ISNULL(' ' + b.Name,'')
	END AS ShortNomenclatureName
	FROM
	dbo.[1CNomenclature] a
	LEFT JOIN
	dbo.[1CCharacteristics] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
	LEFT JOIN	
	dbo.vNomenclatureSGBProperties c ON a.[1CNomenclatureID] = c.[1CNomenclatureID]
	LEFT JOIN
	dbo.vCharacteristicSGBProperties d ON b.[1CCharacteristicID] = d.[1CCharacteristicID]
	LEFT JOIN
	dbo.vNomenclatureSGIProperties e ON a.[1CNomenclatureID] = e.[1CNomenclatureID]
	LEFT JOIN
	dbo.vCharacteristicSGIProperties f ON f.[1CCharacteristicID] = b.[1CCharacteristicID]

GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vShortNomenclatureName] TO [PalletRepacker]
    AS [dbo];

