


-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Информация об остатках по зонам
-- =============================================
CREATE PROCEDURE [dbo].[mob_FindDocOrderNomenclatureStoragePlaces] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderId uniqueidentifier,
		@NomenclatureId uniqueidentifier,
		@CharacteristicId uniqueidentifier,
		@QualityId uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @PlaceZoneID uniqueidentifier, @ResultMessage varchar(8000), @Name varchar(255), @Quantity numeric(10,5)

	DECLARE storagePlaces CURSOR
	FOR
	SELECT DISTINCT a.PlaceZoneID, SUM(a.Quantity) AS Quantity
	FROM
	vNomenclatureStoragePlaces a
	JOIN
	(
		SELECT [1CNomenclatureID], [1CCharacteristicID], [1CQualityID]
		FROM
		[1CDocShipmentOrderGoods]
		WHERE [1CDocShipmentOrderID] = @DocOrderID AND [1CNomenclatureID] = @NomenclatureId AND [1CCharacteristicID] = @CharacteristicId AND (([1CQualityID] = @QualityId AND @QualityId IS NOT NULL) OR ([1CQualityID] IS NULL AND @QualityId IS NULL))
		UNION
		SELECT [1CNomenclatureID], [1CCharacteristicID], [1CQualityID]
		FROM
		[1CDocInternalOrderGoods]
		WHERE [1CDocInternalOrderID] = @DocOrderID AND [1CNomenclatureID] = @NomenclatureId AND [1CCharacteristicID] = @CharacteristicId AND (([1CQualityID] = @QualityId AND @QualityId IS NOT NULL) OR ([1CQualityID] IS NULL AND @QualityId IS NULL)) 
	) b
	ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID]
		AND (b.[1CQualityID] IS NULL OR b.[1CQualityID] = a.[1CQualityID])
	JOIN
	DocMovement c ON a.PlaceID = c.OutPlaceID AND c.DocOrderID = @DocOrderID
	GROUP BY 
		a.PlaceZoneID

	OPEN storagePlaces

	FETCH NEXT FROM storagePlaces
	INTO 
	@PlaceZoneID, @Quantity

	IF @@FETCH_STATUS <> 0
	BEGIN
		SET @ResultMessage = 'Продукция с такой номенклатурой и характеристикой не найдена на складе'
	END
	ELSE IF @PlaceZoneID IS NOT NULL
	BEGIN
		SET @ResultMessage = ''
	END
	WHILE @@FETCH_STATUS = 0
	BEGIN
		WHILE @PlaceZoneID IS NOT NULL
		BEGIN
			SELECT @Name = Name, @PlaceZoneID = PlaceZoneParentID FROM PlaceZones WHERE PlaceZoneID = @PlaceZoneID
			SET @ResultMessage = @Name + '('+ISNULL(CAST(CAST(@Quantity AS numeric(10,1)) AS varchar(10)),'')+')'+  '/' + @ResultMessage
		END
		FETCH NEXT FROM storagePlaces
		INTO 
		@PlaceZoneID, @Quantity
		--SET @ResultMessage = @ResultMessage + '|' +Char(10) + char(13)
	END

	CLOSE storagePlaces

	DEALLOCATE storagePlaces

	SELECT ISNULL(@ResultMessage, 'Продукция на складе, но точного расположения не найдено') AS ResultMessage
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderNomenclatureStoragePlaces] TO [PalletRepacker]
    AS [dbo];

