
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Заполнение табличной части отходов закрытия смены конвертингов
-- =============================================

CREATE PROCEDURE [dbo].[FillDocCloseShiftConvertingWastes] 
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

    INSERT INTO @ProductionNomenclature
		SELECT NomenclatureID, CharacteristicID, @PlaceID AS PlaceID, COUNT(*) AS Num
		FROM @Pallets
		GROUP BY NomenclatureID, CharacteristicID
	
	SELECT DISTINCT a.NomenclatureID, ISNULL(a.[1CCharacteristicID], ch.[1CCharacteristicID]) AS CharacteristicID, a.[1CMeasureUnitID] AS MeasureUnitID,
		cu.Name AS MeasureUnit, c1.Name + ISNULL(' ' + ch.Name, '') AS NomenclatureName,
		CAST(0 AS DECIMAL(18,5)) AS Quantity
	FROM
	(
		SELECT cin.[1CNomenclatureID] AS NomenclatureID, cin.[1CCharacteristicID]
				, ISNULL((SELECT TOP 1 mu.[1CMeasureUnitID] FROM [1CMeasureUnits] mu WHERE mu.[1CNomenclatureID] = cin.[1CNomenclatureID] AND mu.[1CMeasureUnitID] <> cin.[1CMeasureUnitID] AND mu.[Name] = 'кг'), cin.[1CMeasureUnitID]) AS [1CMeasureUnitID], a.Num,
				cin.Amount AS Amount, a.Coefficient
		FROM
			(
			SELECT *
			FROM
			(
				SELECT a.*, ISNULL(c.[1CSpecificationID], b.[1CSpecificationID]) AS [1CSpecificationID], ISNULL(c.Period, b.Period) AS Period,
					cu.Coefficient, ROW_NUMBER() OVER (PARTITION BY a.NomenclatureID, a.CharacteristicID ORDER BY ISNULL(c.Period, b.Period) DESC) 
					AS RowNumber
				FROM
				@ProductionNomenclature a
				LEFT JOIN 
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
			WHERE a.RowNumber = 1
		) a
		JOIN
		[1CSpecificationWastes] cin ON cin.[1CSpecificationID] = a.[1CSpecificationID]
		JOIN
		[1CCharacteristics] c ON c.[1CCharacteristicID] = a.CharacteristicID
		LEFT JOIN
		[1CCharacteristicProperties] cp ON cp.[1CCharacteristicID] = c.[1CCharacteristicID] AND cin.[1CPropertyID] = cp.[1CPropertyID]
	) a
	JOIN
	[1CNomenclature] c1 ON c1.[1CNomenclatureID] = a.NomenclatureID AND c1.NomenclatureKindID = 2
	JOIN
	[1CMeasureUnits] cu ON a.[1CMeasureUnitID] = cu.[1CMeasureUnitID]
	JOIN
	[1CMeasureUnitQualifiers] cuq ON cu.[1CMeasureUnitQualifierID] = cuq.[1CMeasureUnitQualifierID]
	LEFT JOIN
	[1CCharacteristics] ch ON ch.[1CCharacteristicID] = a.[1CCharacteristicID] OR 
		(a.[1CCharacteristicID] IS NULL AND a.[NomenclatureID] = ch.[1CNomenclatureID])
	GROUP BY a.NomenclatureID, a.[1CCharacteristicID], ch.[1CCharacteristicID], a.[1CMeasureUnitID], cu.Name, cuq.IsInteger,
		c1.Name, ch.Name
	

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[FillDocCloseShiftConvertingWastes] TO [PalletRepacker]
    AS [dbo];

