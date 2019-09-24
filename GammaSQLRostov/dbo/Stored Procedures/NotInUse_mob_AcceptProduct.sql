-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Приемка продукта на склад
-- =============================================
CREATE PROCEDURE [dbo].[NotInUse_mob_AcceptProduct] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID int,
		@Barcode varchar(20), -- ШК или номер
		@PlaceID int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
	DECLARE @ProductID uniqueidentifier, @ResultMessage nvarchar(1000), @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier
		, @Quantity decimal(15,3), @DocID uniqueidentifier, @AlreadyAdded bit, @SourcePlace varchar(100)
	DECLARE @DocIds table(DocID uniqueidentifier)
	
	SELECT @ProductID = a.ProductID, @SourcePlace = d.Name
	FROM
	Products a
	JOIN
	DocProductionProducts b ON a.ProductID = b.ProductID
	JOIN
	Docs c ON b.DocID = c.DocID AND c.DocTypeID = 0
	JOIN
	Places d ON c.PlaceID = d.PlaceID
	WHERE a.Barcode = @Barcode OR a.Number = @Barcode

	IF @ProductID IS NULL
	BEGIN
		SET @ResultMessage = 'Продукт с данным шк не найден в базе'
	END
	ELSE
	BEGIN
		IF NOT EXISTS (SELECT * FROM Rests WHERE ProductID = @ProductID AND Quantity > 0)
		BEGIN
			SET @ResultMessage = 'Данное изделие не числится на остатках'
		END
		ELSE IF EXISTS (SELECT * FROM Rests WHERE ProductID = @ProductID AND PlaceID = 8)
		BEGIN
			SET @ResultMessage = 'Данный продукт уже принят на склад';
			SET @AlreadyAdded = 1;
		END
		ELSE 
		BEGIN
			BEGIN TRANSACTION mov
				INSERT INTO Docs (DocTypeID, IsConfirmed, UserID, PrintName)
				OUTPUT INSERTED.DocID INTO @DocIds
				SELECT 2, 1, dbo.CurrentUserID(), Name
				FROM
				Persons 

				INSERT INTO DocMovement (DocID, InPlaceID, OutPlaceID)
				SELECT id.DocID, @PlaceID, a.InPlaceID
				FROM
				@DocIds id, 
				DocProduction a
				JOIN
				DocProducts b ON a.DocID = b.DocID AND b.ProductID = @ProductID

				INSERT INTO DocProducts (DocID, ProductID)
				SELECT TOP 1 a.DocID, @ProductID
				FROM
				@DocIds a
			COMMIT TRANSACTION mov
		END
	END

	IF @ResultMessage = '' OR @ResultMessage IS NULL
	BEGIN
		SELECT a.Number, dbo.GetNomenclatureShortName(a.NomenclatureID, a.[CharacteristicID]) AS NomenclatureName, a.Quantity
			, a.ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAccepted,
			ISNULL(@SourcePlace, '') AS SourcePlace
		FROM
		(
			
			SELECT a.Number,
			CASE
				WHEN a.ProductKindID = 1 THEN c.[1CNomenclatureID]
				WHEN a.ProductKindID = 2 THEN b.[1CNomenclatureID]
			END AS NomenclatureID,
			CASE
				WHEN a.ProductKindID = 1 THEN c.[1CCharacteristicID]
				WHEN a.ProductKindID = 2 THEN b.[1CCharacteristicID]
			END AS CharacteristicID,
			CASE
				WHEN a.ProductKindID = 1 THEN c.Quantity
				WHEN a.ProductKindID = 2 THEN b.Weight
			END AS Quantity, @ResultMessage AS ResultMessage
			FROM
			Products a
			LEFT JOIN
			ProductGroupPacks b ON a.ProductID = b.ProductID
			LEFT JOIN
			ProductPalletItems c ON a.ProductID = c.ProductID
			WHERE a.ProductID = @ProductID
		) a
		JOIN
		[1CNomenclature] b ON a.[NomenclatureID] = b.[1CNomenclatureID]
		JOIN
		[1CCharacteristics] c ON a.[CharacteristicID] = c.[1CCharacteristicID]
	END
	ELSE
	BEGIN
		SELECT NULL AS Number, NULL AS NomenclatureName, NULL AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded, 0) AS AlreadyAccepted,
			ISNULL(@SourcePlace, '') AS SourcePlace
	END
*/

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AcceptProduct] TO [PalletRepacker]
    AS [dbo];

