









CREATE VIEW [dbo].[v1CLastMainSpecifications]
AS
--SELECT *
--FROM
--(
	SELECT DISTINCT a.[1CNomenclatureID], ISNULL(a.[1CCharacteristicID], b.[1CCharacteristicID]) AS [1CCharacteristicID],
			a.[1CPlaceID], 
			a.[1CSpecificationID],
			CASE 
				WHEN a.[1CCharacteristicID] IS NULL THEN 1
				ELSE 0
			END AS IsAllChars
	FROM
	[1CMainSpecifications] a 
	JOIN
	(
		SELECT MAX(Period) AS Period, [1CNomenclatureID], [1CCharacteristicID], [1CPlaceID]
		FROM
		(
			SELECT DISTINCT
			a.Period, a.[1CNomenclatureID], ISNULL(a.[1CCharacteristicID], b.[1CCharacteristicID]) AS [1CCharacteristicID], a.[1CPlaceID]
			FROM
			[1CMainSpecifications] a
			LEFT JOIN
			[1CCharacteristics] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] IS NULL
			WHERE a.[1CPlaceID] IS NOT NULL 
--			AND a.[1CNomenclatureID] = 'F8DE029D-E8A6-11E3-B85D-002590304E93'
--			AND (a.[1CCharacteristicID] = '11375D58-0DB7-11E5-854F-002590EBA5B7' OR b.[1CCharacteristicID] = '11375D58-0DB7-11E5-854F-002590EBA5B7')
--			AND a.[1CPlaceID] = '5B55273B-0C5D-11E1-B246-1C6F6521EF1C'
		) a
		GROUP BY [1CNomenclatureID], [1CCharacteristicID], [1CPlaceID]
	) b ON a.Period = b.Period AND a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CPlaceID] = b.[1CPlaceID]
		AND (a.[1CCharacteristicID] = b.[1CCharacteristicID] OR a.[1CCharacteristicID] IS NULL)
	WHERE a.[1CPlaceID] IS NOT NULL
/*) a
JOIN
[1CPlaces] b ON a.[1CPlaceID] = b.[1CPlaceID]
	WHERE --a.[1CSpecificationID] = 'AB2D2680-8ABD-11E6-905D-002590EBA5B7'
		[1CNomenclatureID] = 'F8DE029D-E8A6-11E3-B85D-002590304E93'
		AND [1CCharacteristicID] = '11375D58-0DB7-11E5-854F-002590EBA5B7'*/











GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecifications] TO [PalletRepacker]
    AS [dbo];

