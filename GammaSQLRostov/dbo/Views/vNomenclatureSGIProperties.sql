








CREATE VIEW [dbo].[vNomenclatureSGIProperties]
AS
SELECT a.[1CNomenclatureID], bv.Description AS Kind, a.Marking /*cv.Description*/ AS Aricle,
	CASE 
		WHEN bv.Description LIKE '%туалет%' THEN 'ТБ'
		WHEN bv.Description LIKE '%полотенца%' THEN 'ПОЛ'
		WHEN bv.Description LIKE '%салфет%' THEN 'САЛФ'
		ELSE bv.Description
	END AS ShortKind
FROM
[1CNomenclature] a --ON a.[1CNomenclatureID] = pgn.[1CNomenclatureID]
JOIN
[1CNomenclatureProperties] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND b.[1CPropertyID] = 'E677C238-CAB1-11E3-AA54-002590304E93' -- Вид
JOIN
[1CPropertyValues] bv ON b.[1CPropertyValueID] = bv.[1CPropertyValueID]
--JOIN
--[1CNomenclatureProperties] c ON a.[1CNomenclatureID] = c.[1CNomenclatureID] AND c.[1CPropertyID] = '35137470-7237-11E5-9529-002590EBA5B7' -- Артикул ти-трейд
--JOIN
--[1CPropertyValues] cv ON cv.[1CPropertyValueID] = c.[1CPropertyValueID]




GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vNomenclatureSGIProperties] TO [PalletRepacker]
    AS [dbo];

