CREATE VIEW [dbo].[v1CLastMainSpecificationsTruncated]
AS
	SELECT MIN(IsAllChars) AS IsAllChars, [1CNomenclatureID], [1CCharacteristicID], [1CPLaceID]
		FROM v1CLastMainSpecifications
		GROUP BY [1CNOmenclatureID], [1CCharacteristicID], [1CPlaceID]

GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CLastMainSpecificationsTruncated] TO [PalletRepacker]
    AS [dbo];

