










CREATE VIEW [dbo].[vCharacteristicSGIProperties]
AS
SELECT DISTINCT a.[1CCharacteristicID], c.Description AS Article,
	CASE WHEN ISNULL(LEFT(hh.Description, CHARINDEX(' ',hh.Description)),'') > '' THEN LEFT(hh.Description, CHARINDEX(' ',hh.Description)) ELSE 
	CAST(CAST(d.Coefficient as int) as varchar) + '*' + CAST(CAST(e.Coefficient/d.Coefficient AS int) AS varchar) END
	+
	'*' + CAST(CAST(f.Coefficient/e.Coefficient AS int) AS varchar) + 'рул' AS  Config,
	ISNULL(gv.Description,gp.ValueText) AS DecorColor
FROM
[PlaceGroup1CNomenclature] pgn 
JOIN
[1CNomenclature] nom ON pgn.[1CNomenclatureID] = nom.[1CParentID]
JOIN
[1CCharacteristics] a ON nom.[1CNomenclatureID] = a.[1CNomenclatureID]
LEFT JOIN
[1CCharacteristicProperties] b ON a.[1CCharacteristicID] = b.[1CCharacteristicID] AND b.[1CPropertyID] = '1D5AAB94-D48F-11E1-B776-002590304E93'
LEFT JOIN
[1CPropertyValues] c ON b.[1CPropertyValueID] = c.[1CPropertyValueID] AND c.Description <> '<>'
JOIN
[1CMeasureUnits] d ON d.[1CMeasureUnitID] = nom.[1CMeasureUnitSet]
JOIN
[1CMeasureUnits] e ON a.MeasureUnitPackage = e.[1CMeasureUnitID]
JOIN
[1CMeasureUnits] f ON a.MeasureUnitPallet = f.[1CMeasureUnitID]
LEFT JOIN
[1CCharacteristicProperties] gp ON gp.[1CCharacteristicID] = a.[1CCharacteristicID] AND gp.[1CPropertyID] = '698D6FCA-C4F0-11E0-BA98-0019DB5E4B19'
LEFT JOIN
[1CPropertyValues] gv ON gp.[1CPropertyValueID] = gv.[1CPropertyValueID] AND gv.Description <> '<>'
LEFT JOIN 
[1CCharacteristicProperties] h ON h.[1CCharacteristicID] = a.[1CCharacteristicID] AND h.[1CPropertyID] IN ('0B782682-C3A2-11E3-B873-002590304E93','BEA721D7-D4E0-11E3-AA54-002590304E93')
LEFT JOIN 
[1CPropertyValues] hh ON h.[1CPropertyValueID] = hh.[1CPropertyValueID] AND hh.Description > ''


















GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGIProperties] TO [PalletRepacker]
    AS [dbo];

