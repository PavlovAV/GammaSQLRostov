
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FillDocCloseShiftConvertingMaterials] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @ShiftID int, @CloseDate DateTime
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Pallets TABLE (NomenclatureID uniqueidentifier, CharacteristicID uniqueidentifier, Quantity int, 
	ProductID uniqueidentifier, DocID uniqueidentifier, 
	NomenclatureName varchar(400), Number varchar(50))

	DECLARE @ProductionNomenclature TABLE (NomenclatureID uniqueidentifier, CharacteristicID uniqueidentifier, PlaceID int, Num int)

	INSERT INTO @Pallets exec dbo.FillDocCloseShiftConvertingPallets @PlaceID, @ShiftID, @CloseDate

	--SELECT * FROM @Pallets

    INSERT INTO @ProductionNomenclature
		SELECT NomenclatureID, CharacteristicID, @PlaceID AS PlaceID, COUNT(*) AS Num
		FROM @Pallets
		GROUP BY NomenclatureID, CharacteristicID

	SELECT a.NomenclatureID, a.[1CCharacteristicID] AS CharacteristicID, a.WithdrawByFact, a.[1CMeasureUnitID] AS MeasureUnitID,
		cu.Name AS MeasureUnit, 
--		CASE 
--		WHEN a.WithdrawByFact = 1 THEN SUM(0)
--		WHEN cuq.IsInteger = 1 THEN CAST(CEILING(SUM(a.Num*a.Amount*a.Coefficient/1000)) AS DECIMAL(15,5))
--		ELSE SUM(a.Num*a.Amount*a.Coefficient/1000)
--		END 
		CAST(0 AS DECIMAL(18,5)) AS Quantity
	FROM
	(
		SELECT ISNULL(cin.[1CNomenclatureID],cnas.[1CNomenclatureID]) AS NomenclatureID, cin.[1CCharacteristicID]
				, cin.WithdrawByFact,
				ISNULL(cin.[1CMeasureUnitID], cnas.[1CMeasureUnitID]) AS [1CMeasureUnitID], a.Num,
				CASE 
					WHEN cin.[1CNomenclatureID] IS NULL THEN cnas.Amount
					ELSE cin.Amount
				END AS Amount, a.Coefficient
		FROM
			(
				SELECT b.[1CSpecificationID], a.CharacteristicID, a.NomenclatureID, e.Coefficient, b.Period, a.Num
				FROM
				@ProductionNomenclature a
				JOIN
				v1CWorkingSpecifications b ON a.NomenclatureID = b.[1CNomenclatureID] AND a.CharacteristicID = b.[1CCharacteristicID]
				JOIN
				Places c ON b.[1CPlaceID] = c.[1CPlaceID] AND c.PlaceID = @PlaceID
				JOIN
				[1CCharacteristics] d ON a.CharacteristicID = d.[1CCharacteristicID]
				JOIN
				[1CMeasureUnits] e ON d.MeasureUnitPallet = e.[1CMeasureUnitID]

/*
			SELECT *
			FROM
			(
				SELECT a.*, ISNULL(c.[1CSpecificationID], b.[1CSpecificationID]) AS [1CSpecificationID], ISNULL(c.Period, b.Period) AS Period,
					cu.Coefficient, ROW_NUMBER() OVER (PARTITION BY a.NomenclatureID, a.CharacteristicID ORDER BY ISNULL(c.Period, b.Period) DESC) 
					AS RowNumber
				FROM
				@ProductionNomenclature a
				JOIN 
				[1CMainSpecifications] b ON a.[NomenclatureID] = b.[1CNomenclatureID] AND b.[1CCharacteristicID] IS NULL
					AND b.[1CPlaceID] = (SELECT [1CPlaceID] FROM Places WHERE PlaceID = @PlaceID)
				LEFT JOIN
				[1CMainSpecifications] c ON a.[NomenclatureID] = c.[1CNomenclatureID] AND c.[1CCharacteristicID] = a.CharacteristicID
					AND c.[1CPlaceID] = (SELECT [1CPlaceID] FROM Places WHERE PlaceID = @PlaceID)
				JOIN
				[1CCharacteristics] c1 ON c1.[1CCharacteristicID] = a.CharacteristicID
				JOIN
				[1CMeasureUnits] cu ON c1.MeasureUnitPallet = cu.[1CMeasureUnitID]
			) a
			WHERE a.RowNumber = 1*/
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
	[1CNomenclature] c1 ON c1.[1CNomenclatureID] = a.NomenclatureID AND c1.NomenclatureKindID = 2
	JOIN
	[1CMeasureUnits] cu ON a.[1CMeasureUnitID] = cu.[1CMeasureUnitID]
	JOIN
	[1CMeasureUnitQualifiers] cuq ON cu.[1CMeasureUnitQualifierID] = cuq.[1CMeasureUnitQualifierID]
	GROUP BY a.NomenclatureID, a.[1CCharacteristicID], a.WithdrawByFact, a.[1CMeasureUnitID], cu.Name, cuq.IsInteger
	

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingMaterials] TO [PalletRepacker]
    AS [dbo];

