





CREATE VIEW [dbo].[vNomenclatureSGBProperties]
--WITH SCHEMABINDING
AS
SELECT a.[1CNomenclatureID], npkv.Description AS Kind, npbwv.Description AS BasisWeight, 
	npbwv.ValueNumeric AS BasisWeightNumeric, npcgv.Description AS ColorGroup, 
	npcompv.Description AS Composition, npdv.Description AS Purpose, 
	nprmv.Description AS RawMaterial, npsv.SortValue
FROM
[1CNomenclature] a
--- вид бумаги
JOIN
[1CNomenclatureProperties] npk ON npk.[1CNomenclatureID] = a.[1CNomenclatureID] AND npk.[1CPropertyID] = 'E677C238-CAB1-11E3-AA54-002590304E93'
JOIN
[1CPropertyValues] npkv ON npkv.[1CPropertyValueID] = npk.[1CPropertyValueID]
--- грамаж
JOIN
[1CNomenclatureProperties] npbw ON npbw.[1CNomenclatureID] = a.[1CNomenclatureID] AND npbw.[1CPropertyID] = '727C0A57-6146-11E1-B1B0-002590304E93'
JOIN
[1CPropertyValues] npbwv ON npbwv.[1CPropertyValueID] = npbw.[1CPropertyValueID]
--- группа цвета 
LEFT JOIN
[1CNomenclatureProperties] npcg ON npcg.[1CNomenclatureID] = a.[1CNomenclatureID] AND npcg.[1CPropertyID] = '0B782677-C3A2-11E3-B873-002590304E93'
LEFT JOIN
[1CPropertyValues] npcgv ON npcgv.[1CPropertyValueID] = npcg.[1CPropertyValueID]
--- композиция 
LEFT JOIN
[1CNomenclatureProperties] npcomp ON npcomp.[1CNomenclatureID] = a.[1CNomenclatureID] AND npcomp.[1CPropertyID] = '0B78267C-C3A2-11E3-B873-002590304E93'
LEFT JOIN
[1CPropertyValues] npcompv ON npcompv.[1CPropertyValueID] = npcomp.[1CPropertyValueID]
--- назначение
LEFT JOIN
[1CNomenclatureProperties] npd ON npd.[1CNomenclatureID] = a.[1CNomenclatureID] AND npd.[1CPropertyID] = '0B782681-C3A2-11E3-B873-002590304E93'
LEFT JOIN
[1CPropertyValues] npdv ON npdv.[1CPropertyValueID] = npd.[1CPropertyValueID]
--- сырье
LEFT JOIN
[1CNomenclatureProperties] nprm ON nprm.[1CNomenclatureID] = a.[1CNomenclatureID] AND nprm.[1CPropertyID] = 'AEC0CBF1-E209-11E2-9775-002590304E93'
LEFT JOIN
[1CPropertyValues] nprmv ON nprmv.[1CPropertyValueID] = nprm.[1CPropertyValueID]
--- короткое имя типа бумаги
LEFT JOIN
[1CNomenclatureProperties] nps ON nps.[1CNomenclatureID] = a.[1CNomenclatureID] AND nps.[1CPropertyID] = '0B782681-C3A2-11E3-B873-002590304E93'
LEFT JOIN
[1CPropertyValues] npsv ON npsv.[1CPropertyValueID] = nps.[1CPropertyValueID]
/*
SELECT a.[1CNomenclatureID], Kind, BasisWeight, e.ValueNumeric AS BasisWeightNumeric, ColorGroup, Composition, Purpose, RawMaterial, c.SortValue
FROM
(
SELECT [1CNomenclatureID], Kind, BasisWeight, ColorGroup, Composition, Purpose, RawMaterial FROM
(
SELECT 
a.[1CNomenclatureID],
CASE 
WHEN a.[1CPropertyID] = 'E677C238-CAB1-11E3-AA54-002590304E93' THEN 'Kind'
WHEN a.[1CPropertyID] = '727C0A57-6146-11E1-B1B0-002590304E93' THEN 'BasisWeight'
WHEN a.[1CPropertyID] = '0B782677-C3A2-11E3-B873-002590304E93' THEN 'ColorGroup'
WHEN a.[1CPropertyID] = '0B78267C-C3A2-11E3-B873-002590304E93' THEN 'Composition'
WHEN a.[1CPropertyID] = '0B782681-C3A2-11E3-B873-002590304E93' THEN 'Purpose'
WHEN a.[1CPropertyID] = 'AEC0CBF1-E209-11E2-9775-002590304E93' THEN 'RawMaterial'
END AS ColumnName
, c.Description
FROM
dbo.[1CNomenclatureProperties] a
JOIN
dbo.[1CProperties] b ON a.[1CPropertyID] = b.[1CPropertyID]
JOIN
dbo.[1CPropertyValues] c ON a.[1CPropertyValueID] = c.[1CPropertyValueID]
WHERE
a.[1CPropertyID] IN
('E677C238-CAB1-11E3-AA54-002590304E93',
'727C0A57-6146-11E1-B1B0-002590304E93',
'0B782677-C3A2-11E3-B873-002590304E93',
'0B78267C-C3A2-11E3-B873-002590304E93',
'0B782681-C3A2-11E3-B873-002590304E93',
'AEC0CBF1-E209-11E2-9775-002590304E93')) a
PIVOT
(MAX(Description) FOR ColumnName IN ([Kind],[BasisWeight],[ColorGroup],[Composition],[Purpose],[RawMaterial])) piv
) a
LEFT JOIN
dbo.[1CNomenclatureProperties] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND b.[1CPropertyID] = '0B782681-C3A2-11E3-B873-002590304E93'
LEFT JOIN
dbo.[1CPropertyValues] c ON b.[1CPropertyValueID] = c.[1CPropertyValueID]
LEFT JOIN
dbo.[1CNomenclatureProperties] d ON a.[1CNomenclatureID] = d.[1CNomenclatureID] AND d.[1CPropertyID] = '727C0A57-6146-11E1-B1B0-002590304E93'
LEFT JOIN
dbo.[1CPropertyValues] e ON d.[1CPropertyValueID] = e.[1CPropertyValueID]
*/










GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGBProperties] TO [PalletRepacker]
    AS [dbo];

