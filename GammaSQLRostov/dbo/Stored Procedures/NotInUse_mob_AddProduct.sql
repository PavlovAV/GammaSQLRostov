
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NotInUse_mob_AddProduct] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID int,
		@Barcode varchar(20), -- ШК или номер
		@DocShipmentOrderID uniqueidentifier -- ID Документа 1С
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
/*
	DECLARE @ProductID uniqueidentifier, @ResultMessage nvarchar(1000), @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier
		, @Quantity decimal(15,3), @DocID uniqueidentifier, @AlreadyAdded bit
	DECLARE @DocIds table(DocID uniqueidentifier)
	
	SELECT @ProductID = ProductID 
	FROM
	Products a
	WHERE Barcode = @Barcode OR Number = @Barcode

	SELECT @DocID = DocID FROM DocShipments WHERE [1CDocShipmentOrderID] = @DocShipmentOrderID AND PersonID = @PersonID

	IF @ProductID IS NULL
	BEGIN
		SET @ResultMessage = 'Продукт с данным шк не найден в базе'
	END
	ELSE
	BEGIN
		IF EXISTS (SELECT * FROM DocProducts WHERE DocID = @DocID AND ProductID = @ProductID)
		BEGIN
			SET @AlreadyAdded = 1;	
		END
		ELSE IF NOT EXISTS 
			(SELECT * FROM Rests WHERE ProductID = @ProductID AND Quantity > 0) OR
			NOT EXISTS (SELECT * FROM vProductsInfo WHERE ProductID = @ProductID AND Quantity > 0)
		BEGIN
			SET @ResultMessage = 'Данное изделие не числится на остатках'
		END
		ELSE IF NOT EXISTS 
		(
			SELECT * 
			FROM 
			[1CDocShipmentOrderGoods] a 
			JOIN
			vProductsInfo b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID]
			WHERE a.[1CDocShipmentOrderID] = @DocShipmentOrderID AND b.ProductID = @ProductID
		)
		BEGIN
			SET @ResultMessage = 'Данной номенклатуры нет в приказе'
		END
		ELSE IF NOT EXISTS
		(
			SELECT * 
			FROM
			[1CDocShipmentOrderGoods] a
			JOIN
			vProductsInfo b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID]
			JOIN
			ProductStates c ON b.StateID = c.StateID AND a.[1CQualityID] = c.[1CQualityID]
			WHERE a.[1CDocShipmentOrderID] = @DocShipmentOrderID AND b.ProductID = @ProductID
		)
		BEGIN
			SET @ResultMessage = 'Качество данной продукции не соответствует приказу'
		END
		ELSE 
		BEGIN
			SELECT @DocID = DocID FROM DocShipments WHERE [1CDocShipmentOrderID] = @DocShipmentOrderID AND PersonID = @PersonID

			IF @DocID IS NULL
			BEGIN
				BEGIN TRANSACTION doc
					INSERT INTO Docs (DocTypeID, UserID, PrintName, Date)
					OUTPUT INSERTED.DocID INTO @DocIds
					SELECT 5 AS DocTypeID, dbo.CurrentUserID() AS UserID, Name AS PrintName, Getdate() AS Date
					FROM
					Persons WHERE PersonID = @PersonID
					

					INSERT INTO DocShipments ([1CDocShipmentOrderID], DocID, PersonID)
					SELECT TOP 1 @DocShipmentOrderID, DocID, @PersonID
					FROM @DocIds

					INSERT INTO DocProducts (DocID, ProductID)
					SELECT DocID, @ProductID
					FROM
					@DocIds
				COMMIT TRANSACTION doc
			END
			ELSE
			BEGIN
				IF NOT EXISTS (SELECT * FROM DocProducts WHERE DocID = @DocID AND ProductID = @ProductID)
				BEGIN
					INSERT INTO DocProducts (DocID, ProductID)
						SELECT @DocID, @ProductID
				END
			END
		END
	END

	IF @ResultMessage = '' OR @ResultMessage IS NULL
	BEGIN
	SELECT	CASE
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
			END AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded
			FROM
			Products a
			LEFT JOIN
			ProductGroupPacks b ON a.ProductID = b.ProductID
			LEFT JOIN
			ProductPalletItems c ON a.ProductID = c.ProductID
			WHERE a.ProductID = @ProductID
	END
	ELSE
	BEGIN
		SELECT NULL AS NomenclatureID, NULL AS CharacteristicID, NULL AS Quantity, @ResultMessage AS ResultMessage, ISNULL(@AlreadyAdded,0) AS AlreadyAdded
	END
*/

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_mob_AddProduct] TO [PalletRepacker]
    AS [dbo];

