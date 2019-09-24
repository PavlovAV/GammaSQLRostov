-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_AddProductToMovement] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID uniqueidentifier,
		@Barcode varchar(20), -- ШК или номер
		@PlaceID int, -- склад, на который перемещают
		@PlaceZoneID uniqueidentifier = NULL
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductID uniqueidentifier, @ResultMessage nvarchar(1000), @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier
		, @Quantity decimal(15,3), @AlreadyAdded bit, @DocMovementID uniqueidentifier, @OutPlaceID int, @OutPlace varchar(50),
		@Date DateTime, @OutPlaceZoneID uniqueidentifier, @PlaceZone varchar(200)

	DECLARE @DocIds table(DocID uniqueidentifier)
	
	SELECT @ProductID = ProductID 
	FROM
	Products a
	WHERE Barcode = @Barcode OR Number = @Barcode

	IF @ProductID IS NULL
	BEGIN
		SET @ResultMessage = 'Продукт с данным шк не найден в базе'
	END
	ELSE IF NOT EXISTS 
			(SELECT * FROM Rests WHERE ProductID = @ProductID AND Quantity > 0) OR
			NOT EXISTS (SELECT * FROM vProductsInfo WHERE ProductID = @ProductID AND Quantity > 0)
	BEGIN
		SET @ResultMessage = 'Данное изделие не числится на остатках'
	END
/*	ELSE IF EXISTS 
		(
			SELECT * FROM DocInProducts a
			JOIN
			DocMovement b ON a.DocID = b.DocID
			JOIN
			Docs c ON b.DocID = c.DocID AND (c.IsConfirmed IS NULL OR c.IsConfirmed = 0) 
			WHERE a.ProductID = @ProductID AND b.InPlaceID = @PlaceID AND (a.IsConfirmed IS NULL OR a.IsConfirmed = 0)
		)
	BEGIN
		SET @AlreadyAdded = 1
	END
*/
	SELECT @OutPlaceID = a.PlaceID, @OutPlace = b.Name, @OutPlaceZoneID = a.PlaceZoneID
			FROM 
			Rests a
			JOIN
			Places b ON a.PlaceID = b.PlaceID
			WHERE ProductID = @ProductID
	
	SELECT @PlaceZone = [name]
		FROM PlaceZones
		WHERE PlaceZoneID = @PlaceZoneID
			

	IF @ResultMessage = '' OR @ResultMessage IS NULL
	BEGIN
		SELECT TOP 1 @DocMovementID = a.DocID
			FROM
			DocMovement a
			JOIN
			Docs b ON a.DocID = b.DocID
			WHERE 
			OutPlaceID = @OutPlaceID AND InPlaceID = @PlaceID
			AND (b.IsConfirmed IS NULL OR b.IsConfirmed = 0)
			AND OrderTypeID = 3 
			AND b.PersonGuid = @PersonID
			--Если смена с 8, то с 8 часов ищем документы позднее 8:00, если смена с 20 - то документы с 20:00
			AND ((DATEPART(hour,GETDATE()) BETWEEN 8 AND 19 AND (CAST(b.Date AS DATE) >= DATETIMEFROMPARTS (year(GETDATE()), month(GETDATE()), day(GETDATE()), 8, 0, 0, 0))) OR (DATEPART(hour,GETDATE()) BETWEEN 20 AND 24 AND (CAST(b.Date AS DATE) >= DATETIMEFROMPARTS (year(GETDATE()), month(GETDATE()), day(GETDATE()), 20, 0, 0, 0))) OR (DATEPART(hour,GETDATE()) BETWEEN 0 AND 7 AND (CAST(b.Date AS DATE) >= DATETIMEFROMPARTS (year(DATEADD(DAY,-1,GETDATE())), month(DATEADD(DAY,-1,GETDATE())), day(DATEADD(DAY,-1,GETDATE())), 20, 0, 0, 0))))
			ORDER BY b.Date DESC
		IF @AlreadyAdded <> 1 OR @AlreadyAdded IS NULL
		BEGIN		
			SELECT @Date = getdate();
	
				BEGIN TRANSACTION trans
					IF @DocMovementID IS NULL 
					BEGIN
						INSERT INTO Docs (DocTypeID, Date, UserID, IsConfirmed, PersonGuid)
						OUTPUT INSERTED.DocID INTO @DocIds
						VALUES (2, @Date, dbo.CurrentUserID(), 
							CASE
								WHEN @OutPlaceID = @PlaceID THEN 1
								ELSE 0
							END,
							@PersonID)

						SELECT TOP 1 @DocMovementID = DocID FROM @DocIds

						INSERT INTO DocMovement (DocID, OutDate, OutPlaceID, InDate, InPlaceID,OrderTypeID)
						VALUES (@DocMovementID, @Date, @OutPlaceID, @Date, @PlaceID,3)
					END

					INSERT INTO DocOutProducts (DocID, ProductID, Date, PlaceZoneID, PersonID)
					VALUES (@DocMovementID, @ProductID, @Date, @OutPlaceZoneID,@PersonID)

					INSERT INTO DocInProducts (DocID, ProductID, Date, PlaceZoneID, PersonID)
					VALUES (@DocMovementID, @ProductID, @Date, @PlaceZoneID,@PersonID)
				COMMIT TRANSACTION trans
			END
			
			SELECT a.NomenclatureID, a.CharacteristicID, a.Quantity, a.ResultMessage, a.AlreadyAdded, a.OutPlace, a.DocMovementID,
				b.ShortNomenclatureName AS NomenclatureName, a.Number, @Date AS Date, NumberAndInPlaceZone 
			FROM
			(
				SELECT	CASE
					WHEN a.ProductKindID = 0 THEN d.[1CNomenclatureID]
					WHEN a.ProductKindID = 1 THEN c.[1CNomenclatureID]
					WHEN a.ProductKindID = 2 THEN b.[1CNomenclatureID]
				END AS NomenclatureID,
				CASE
					WHEN a.ProductKindID = 0 THEN d.[1CCharacteristicID]
					WHEN a.ProductKindID = 1 THEN c.[1CCharacteristicID]
					WHEN a.ProductKindID = 2 THEN b.[1CCharacteristicID]
				END AS CharacteristicID,
				CASE
					WHEN a.ProductKindID = 0 THEN dbo.CalculateSpoolWeightBeforeDate(a.ProductID, @Date)
					WHEN a.ProductKindID = 1 THEN c.Quantity
					WHEN a.ProductKindID = 2 THEN b.Weight
				END AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded, @OutPlace AS OutPlace, @DocMovementID AS DocMovementID,
				a.Number ,Number + ISNULL('/n/b'+@PlaceZone,'') AS NumberAndInPlaceZone 
				FROM
				Products a
				LEFT JOIN
				ProductGroupPacks b ON a.ProductID = b.ProductID
				LEFT JOIN
				ProductItems c ON a.ProductID = c.ProductID		
				LEFT JOIN
				ProductSpools d ON a.ProductID = d.ProductID
				WHERE a.ProductID = @ProductID
			) a
			JOIN
			vShortNomenclatureName b ON a.[NomenclatureID] = b.[1CNomenclatureID] AND a.[CharacteristicID] = b.[1CCharacteristicID]

	END
	ELSE
	BEGIN
		SELECT NULL AS NomenclatureID, NULL AS CharacteristicID, NULL AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded,
			@OutPlace AS OutPlace, @DocMovementID AS DocMovementID, '' AS NomenclatureName, '' AS Number, @Date AS Date, '' AS NumberAndInPlaceZone
	END


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductToMovement] TO [PalletRepacker]
    AS [dbo];

