






CREATE VIEW [dbo].[vProductionMaterials]
AS
  WITH Materials_CTE
  AS
  (
  SELECT a.NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID, a.WithdrawByFact, a.[1CMeasureUnitID] AS MeasureUnitID,
		cu.Name AS MeasureUnit, 
		CAST(0 AS DECIMAL(18,5)) AS Quantity, a.ProductNomenclatureID, a.ProductCharacteristicID, a.ProductPlaceID
		,pn.[Name] + ISNULL(' '+pc.[Name],'') AS ProductNomenclatureName, c1.[Name] + ISNULL(' '+a.CharacteristicName,'') AS NomenclatureName, c1.NomenclatureKindID, a.ProductPlaceGroupID
	FROM
	(
		SELECT ISNULL(cin.[1CNomenclatureID],cnas.[1CNomenclatureID]) AS NomenclatureID, cin.[1CCharacteristicID], c.[Name] AS CharacteristicName
				, cin.WithdrawByFact,
				ISNULL(cin.[1CMeasureUnitID], cnas.[1CMeasureUnitID]) AS [1CMeasureUnitID],
				CASE 
					WHEN cin.[1CNomenclatureID] IS NULL THEN cnas.Amount
					ELSE cin.Amount
				END AS Amount, a.Coefficient, a.NomenclatureID AS ProductNomenclatureID, a.CharacteristicID AS ProductCharacteristicID, a.PlaceID AS ProductPlaceID, a.PlaceGroupID  AS ProductPlaceGroupID
		FROM
			(
				SELECT b.[1CSpecificationID], b.[1CCharacteristicID] AS CharacteristicID, b.[1CNomenclatureID] AS NomenclatureID, 1 AS Coefficient, b.Period, c.PlaceID, c.PlaceGroupID
				FROM
				--@ProductionNomenclature a
				--JOIN
				v1CWorkingSpecifications b --ON a.NomenclatureID = b.[1CNomenclatureID] AND a.CharacteristicID = b.[1CCharacteristicID]
				JOIN
				Places c ON b.[1CPlaceID] = c.[1CPlaceID] --AND c.PlaceID = a.PlaceID
				--JOIN
				--[1CNomenclature] d ON a.NomenclatureID = d.[1CNomenclatureID]
				--JOIN
				--[1CMeasureUnits] e ON d.[1CBaseMeasureUnitQualifier] = e.[1CMeasureUnitID]
		) a
		JOIN
		[1CSpecificationInputNomenclature] cin ON cin.[1CSpecificationID] = a.[1CSpecificationID]
		JOIN
		[1CCharacteristics] c ON c.[1CCharacteristicID] = a.CharacteristicID
		LEFT JOIN
		[1CCharacteristicProperties] cp ON cp.[1CCharacteristicID] = c.[1CCharacteristicID] AND cin.[1CPropertyID] = cp.[1CPropertyID]
		LEFT JOIN
		[1CSpecificationNomenclatureAutoSelect] cnas ON cin.[1CSpecificationID] = cnas.[1CSpecificationID] 
			AND cin.LinkKey = cnas.LinkKey AND cnas.[1CPropertyValueID] = cp.[1CPropertyValueID]
	) a
	JOIN
	[1CNomenclature] c1 ON c1.[1CNomenclatureID] = a.NomenclatureID 
	JOIN
	[1CMeasureUnits] cu ON a.[1CMeasureUnitID] = cu.[1CMeasureUnitID]
	JOIN
	[1CMeasureUnitQualifiers] cuq ON cu.[1CMeasureUnitQualifierID] = cuq.[1CMeasureUnitQualifierID]
	LEFT JOIN
	[1CNomenclature] pn ON pn.[1CNomenclatureID] = a.ProductNomenclatureID
	LEFT JOIN 
	[1CCharacteristics] pc ON pc.[1CCharacteristicID] = a.ProductCharacteristicID
-- 	GROUP BY a.NomenclatureID, a.[1CCharacteristicID], a.WithdrawByFact, a.[1CMeasureUnitID], cu.Name, cuq.IsInteger, a.ProductNomenclatureID, a.ProductCharacteristicID, a.ProductPlaceID,pn.[Name],pc.[Name], c1.[Name], a.CharacteristicName
  )
  SELECT a.NomenclatureID, a.CharacteristicID, a.WithdrawByFact, a.MeasureUnitID, MeasureUnit, a.ProductNomenclatureID, a.ProductCharacteristicID, a.ProductPlaceID, a.ProductNomenclatureName, a.NomenclatureName, a.Quantity 
  FROM 
	(
	SELECT *
		FROM Materials_CTE c1
		WHERE c1.NomenclatureKindID = 2
	UNION ALL
	SELECT *
		FROM Materials_CTE c1
		WHERE c1.NomenclatureKindID = 1 AND c1.ProductPlaceGroupID IN (0,2)
	) a 
	GROUP BY a.NomenclatureID, a.CharacteristicID, a.WithdrawByFact, a.MeasureUnitID, MeasureUnit, a.ProductNomenclatureID, a.ProductCharacteristicID, a.ProductPlaceID, a.ProductNomenclatureName, a.NomenclatureName, a.Quantity

GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductionMaterials] TO [PalletRepacker]
    AS [dbo];

