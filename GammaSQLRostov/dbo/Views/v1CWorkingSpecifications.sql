








CREATE VIEW [dbo].[v1CWorkingSpecifications]
AS
--Спецификации действующие
--Можно сделать одним запросом т.е. без UNION, 
--но с UNION работает в разы быстрее
--т.к. первый запрос более простой, и он отабатывет чаще всего
--а второй сложный, но он отабатывает в меньшинстве случаев
SELECT
	v.Period AS Period,
	v.[1CNomenclatureID] AS [1CNomenclatureID],
	v.[1CCharacteristicID] AS [1CCharacteristicID],
	v.[1CPlaceID] AS [1CPlaceID],
	v.[1CSpecificationID],
	v.ValidTill
FROM dbo.v1CActualSpecifications v
WHERE --(v.ValidTill IS NULL OR CAST(v.ValidTill AS DATE) >= CAST(GETDATE() AS DATE)) AND
	v.[1CCharacteristicID] IS NOT NULL
	AND v.[1CSpecificationID] IS NOT NULL --запись с пустой спецификацией является закрывающей. т.е. эквивалентно состоянию "нет спецификации"

UNION
--добавим спецификации с пустой характеристикой
--но только для тех характеристик, для которых не заданы индивидуальные спецификации
SELECT
	v.Period AS Period,
	v.[1CNomenclatureID] AS [1CNomenclatureID],
	c.[1CCharacteristicID] AS [1CCharacteristicID],
	v.[1CPlaceID] AS [1CPlaceID],
	v.[1CSpecificationID] AS [1CSpecificationID],
	v.ValidTill
FROM dbo.v1CActualSpecifications v
INNER JOIN [1CCharacteristics] c ON c.[1CNomenclatureID] = v.[1CNomenclatureID]
LEFT JOIN (
	SELECT
		v.[1CNomenclatureID] AS [1CNomenclatureID],
		v.[1CCharacteristicID] AS [1CCharacteristicID],
		v.[1CPlaceID] AS [1CPlaceID]
	FROM dbo.v1CActualSpecifications v
	WHERE --(v.ValidTill IS NULL OR CAST(v.ValidTill AS DATE) >= CAST(GETDATE() AS DATE)) AND
		v.[1CCharacteristicID] IS NOT NULL
		AND v.[1CSpecificationID] IS NOT NULL
) AS vch ON vch.[1CNomenclatureID] = v.[1CNomenclatureID] AND vch.[1CPlaceID] = v.[1CPlaceID] AND vch.[1CCharacteristicID] = c.[1CCharacteristicID]
WHERE --(v.ValidTill IS NULL OR CAST(v.ValidTill AS DATE) >= CAST(GETDATE() AS DATE)) AND
	v.[1CCharacteristicID] IS NULL
	AND v.[1CSpecificationID] IS NOT NULL --запись с пустой спецификацией является закрывающей. т.е. эквивалентно состоянию "нет спецификации"
	AND vch.[1CNomenclatureID] IS NULL --если есть индивидуальная спецификация, общая (с пустой характеристикой) не действует, даже если общая назначена на дату большую чем индивидуальная



/*
SELECT  a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CPlaceID], a.[1CSpecificationID]
FROM v1CLastMainSpecifications a
JOIN
(
	SELECT MIN(IsAllChars) AS IsAllChars, [1CNOmenclatureID], [1CCharacteristicID], [1CPlaceID]
	FROM v1CLastMainSpecifications 
	GROUP BY
	[1CNomenclatureID], [1CCharacteristicID], [1CPlaceID]
) b ON a.[1CNOmenclatureID] = b.[1CNOmenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID] AND a.[1CPlaceID] = b.[1CPlaceID]
	AND a.IsAllChars = b.IsAllChars
*/

/*
SELECT a.Period, a.[1CNomenclatureID], ISNULL(a.[1CCharacteristicID], b.[1CCharacteristicID]) AS [1CCharacteristicID], a.[1CSpecificationID], a.[1CPlaceID]
FROM
[v1CActualSpecifications] a
--[1CMainSpecifications] a
LEFT JOIN
[1CCharacteristics] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] IS NULL 
AND
NOT EXISTS (SELECT [1CNomenclatureID] FROM v1CActualSpecifications asp WHERE asp.[1CNomenclatureID] = a.[1CNomenclatureID] AND
asp.[1CCharacteristicID] = b.[1CCharacteristicID] AND asp.[1CPlaceID] = a.[1CPlaceID])
WHERE a.[1CCharacteristicID] IS NOT NULL OR b.[1CCharacteristicID] IS NOT NULL
*/



--GO





GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CWorkingSpecifications] TO [PalletRepacker]
    AS [dbo];

