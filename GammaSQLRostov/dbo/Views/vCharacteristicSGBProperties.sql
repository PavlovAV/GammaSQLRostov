











CREATE VIEW [dbo].[vCharacteristicSGBProperties]
--WITH SCHEMABINDING
AS
SELECT a.[1CCharacteristicID], cpcdv.Description AS CoreDiameter, CAST(cpcdv.ValueNumeric AS int) AS CoreDiameterNumeric, 
	cplv.Description AS LayerNumber, CAST(cplv.ValueNumeric AS int) AS LayerNumberNumeric,
	cpdv.Description AS Diameter, cpdestv.Description AS Destination, 
	cpfv.Description AS [Format], CAST(cpfv.ValueNumeric AS int) AS FormatNumeric, 
	cpcv.Description AS Color, cpbv.Description AS Buyer, cptkv.Description AS TypeKind,
	cpttv.Description AS TypeTransition
FROM
[1CCharacteristics] a
--- гильза
JOIN
[1CCharacteristicProperties] cpcd ON a.[1CCharacteristicID] = cpcd.[1CCharacteristicID] AND cpcd.[1CPropertyID] = 'CE8FCC34-C32D-11E0-9D44-0019DB5E4B19'
JOIN
[1CPropertyValues] cpcdv ON cpcd.[1CPropertyValueID] = cpcdv.[1CPropertyValueID]
--- слойность
JOIN
[1CCharacteristicProperties] cpl ON a.[1CCharacteristicID] = cpl.[1CCharacteristicID] AND cpl.[1CPropertyID] = 'CE8FCC35-C32D-11E0-9D44-0019DB5E4B19'
JOIN
[1CPropertyValues] cplv ON cpl.[1CPropertyValueID] = cplv.[1CPropertyValueID]
--- Диаметр
LEFT JOIN
[1CCharacteristicProperties] cpd ON a.[1CCharacteristicID] = cpd.[1CCharacteristicID] AND cpd.[1CPropertyID] = '96CEC7F9-6B45-11E1-8280-002590304E93'
LEFT JOIN
[1CPropertyValues] cpdv ON cpd.[1CPropertyValueID] = cpdv.[1CPropertyValueID]
--- назначение
LEFT JOIN
[1CCharacteristicProperties] cpdest ON a.[1CCharacteristicID] = cpdest.[1CCharacteristicID] AND cpdest.[1CPropertyID] = '97654DB4-8F2D-11E3-B394-002590304E93'
LEFT JOIN
[1CPropertyValues] cpdestv ON cpdest.[1CPropertyValueID] = cpdestv.[1CPropertyValueID]
--- Формат
JOIN
[1CCharacteristicProperties] cpf ON a.[1CCharacteristicID] = cpf.[1CCharacteristicID] AND cpf.[1CPropertyID] = '0B782685-C3A2-11E3-B873-002590304E93'
JOIN
[1CPropertyValues] cpfv ON cpf.[1CPropertyValueID] = cpfv.[1CPropertyValueID]
--- цвет
LEFT JOIN
[1CCharacteristicProperties] cpc ON a.[1CCharacteristicID] = cpc.[1CCharacteristicID] AND cpc.[1CPropertyID] = '13EE192E-AFBC-11E0-9B2F-4061861FE1EF'
LEFT JOIN
[1CPropertyValues] cpcv ON cpc.[1CPropertyValueID] = cpcv.[1CPropertyValueID]
--- инд. заказ
LEFT JOIN
[1CCharacteristicProperties] cpb ON a.[1CCharacteristicID] = cpb.[1CCharacteristicID] AND cpb.[1CPropertyID] = 'DE9CE8F1-3472-11E6-8D0D-002590EBA5B7'
LEFT JOIN
[1CPropertyValues] cpbv ON cpb.[1CPropertyValueID] = cpbv.[1CPropertyValueID]
--- тип бумаги
LEFT JOIN
[1CCharacteristicProperties] cptk ON a.[1CCharacteristicID] = cptk.[1CCharacteristicID] AND cptk.[1CPropertyID] = '8754C487-862C-11E6-905D-002590EBA5B7'
LEFT JOIN
[1CPropertyValues] cptkv ON cptk.[1CPropertyValueID] = cptkv.[1CPropertyValueID]
--- вид перехода
LEFT JOIN
[1CCharacteristicProperties] cptt ON a.[1CCharacteristicID] = cptt.[1CCharacteristicID] AND cptt.[1CPropertyID] = 'E0B7A7B2-1A2C-11E9-A1C5-002590EBA5B7'
LEFT JOIN
[1CPropertyValues] cpttv ON cptt.[1CPropertyValueID] = cpttv.[1CPropertyValueID]
/*
SELECT [1CCharacteristicID], CoreDiameter, LayerNumber, Diameter, Destination, Format, Color, Buyer, TypeKind
, dbo.GetCharSpoolFormat([1CCharacteristicID]) AS FormatNumeric
, dbo.GetCharLayerNumber([1CCharacteristicID]) AS LayerNumberNumeric
, dbo.GetCharSpoolCoreDiameter([1CCharacteristicID]) AS CoreDiameterNumeric FROM
(
SELECT 
a.[1CCharacteristicID],
CASE 
WHEN a.[1CPropertyID] = 'CE8FCC34-C32D-11E0-9D44-0019DB5E4B19' THEN 'CoreDiameter'
WHEN a.[1CPropertyID] = 'CE8FCC35-C32D-11E0-9D44-0019DB5E4B19' THEN 'LayerNumber'
WHEN a.[1CPropertyID] = '96CEC7F9-6B45-11E1-8280-002590304E93' THEN 'Diameter'
WHEN a.[1CPropertyID] = '97654DB4-8F2D-11E3-B394-002590304E93' THEN 'Destination'
WHEN a.[1CPropertyID] = '0B782685-C3A2-11E3-B873-002590304E93' THEN 'Format'
WHEN a.[1CPropertyID] = '13EE192E-AFBC-11E0-9B2F-4061861FE1EF' THEN 'Color'
WHEN a.[1CPropertyID] = 'DE9CE8F1-3472-11E6-8D0D-002590EBA5B7' THEN 'Buyer'
WHEN a.[1CPropertyID] = '8754C487-862C-11E6-905D-002590EBA5B7' THEN 'TypeKind'
END AS ColumnName
, c.Description
FROM
dbo.[1CCharacteristicProperties] a
JOIN
dbo.[1CProperties] b ON a.[1CPropertyID] = b.[1CPropertyID]
JOIN
dbo.[1CPropertyValues] c ON a.[1CPropertyValueID] = c.[1CPropertyValueID]
WHERE
a.[1CPropertyID] IN
('CE8FCC34-C32D-11E0-9D44-0019DB5E4B19',
'CE8FCC35-C32D-11E0-9D44-0019DB5E4B19',
'96CEC7F9-6B45-11E1-8280-002590304E93',
'97654DB4-8F2D-11E3-B394-002590304E93',
'0B782685-C3A2-11E3-B873-002590304E93',
'13EE192E-AFBC-11E0-9B2F-4061861FE1EF',
'DE9CE8F1-3472-11E6-8D0D-002590EBA5B7',
'8754C487-862C-11E6-905D-002590EBA5B7')) a
PIVOT
(MAX(Description) FOR ColumnName IN ([CoreDiameter],[LayerNumber],[Diameter],[Destination],[Format],[Color],[Buyer], [TypeKind])) piv

*/






GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vCharacteristicSGBProperties] TO [PalletRepacker]
    AS [dbo];

