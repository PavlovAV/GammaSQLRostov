-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[mob_FindDocOrderItemStoragePlaces] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderId uniqueidentifier,
		@LineNumber int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @PlaceZoneID uniqueidentifier, @ResultMessage varchar(8000), @Name varchar(255)

	DECLARE storagePlaces CURSOR
	FOR
	SELECT DISTINCT a.PlaceZoneID
	FROM
	vNomenclatureStoragePlaces a
	JOIN
	(
		SELECT [1CNomenclatureID], [1CCharacteristicID], [1CQualityID]
		FROM
		[1CDocShipmentOrderGoods]
		WHERE [1CDocShipmentOrderID] = @DocOrderID --AND [LineNo] = @LineNumber
		UNION
		SELECT [1CNomenclatureID], [1CCharacteristicID], [1CQualityID]
		FROM
		[1CDocInternalOrderGoods]
		WHERE [1CDocInternalOrderID] = @DocOrderID --AND [LineNo] = @LineNumber
	) b
	ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID]
		AND (b.[1CQualityID] IS NULL OR b.[1CQualityID] = a.[1CQualityID])
	JOIN
	DocMovement c ON a.PlaceID = c.OutPlaceID AND c.DocOrderID = @DocOrderID

	OPEN storagePlaces

	FETCH NEXT FROM storagePlaces
	INTO 
	@PlaceZoneID

	IF @@FETCH_STATUS <> 0
	BEGIN
		SET @ResultMessage = 'Продукция с такой номенклатурой и качеством не найдена на складе'
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
			SET @ResultMessage = @Name + '/' + @ResultMessage
		END
		FETCH NEXT FROM storagePlaces
		INTO 
		@PlaceZoneID
		SET @ResultMessage = @ResultMessage + Char(10) + char(13)
	END

	CLOSE storagePlaces

	DEALLOCATE storagePlaces

	SELECT ISNULL(@ResultMessage, 'Продукция на складе, но точного расположения не найдено') AS ResultMessage
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_FindDocOrderItemStoragePlaces] TO [PalletRepacker]
    AS [dbo];

