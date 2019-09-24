










CREATE VIEW [dbo].[vPlacePropertiesValues]
AS
SELECT a.PlaceID, a.Name AS Place, pvf.ValueNumeric AS Format, pvcd.ValueNumeric AS CoreDiameter
FROM
Places a
--- получение формата
LEFT JOIN
[1CPlaceProperties] ppf ON a.[1CPlaceID] = ppf.[1CPlaceID] AND ppf.[1CPropertyID] = 'D5BADFD1-734A-11E5-9529-002590EBA5B7'
LEFT JOIN
[1CPropertyValues] pvf ON pvf.[1CPropertyValueID] = ppf.[1CPropertyValueID]
--- получение гильзы
LEFT JOIN
[1CPlaceProperties] ppcd ON a.[1CPlaceID] = ppcd.[1CPlaceID] AND ppcd.[1CPropertyID] = 'B3A549D0-734A-11E5-9529-002590EBA5B7'
LEFT JOIN
[1CPropertyValues] pvcd ON pvcd.[1CPropertyValueID] = ppcd.[1CPropertyValueID]


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vPlacePropertiesValues] TO [PalletRepacker]
    AS [dbo];

