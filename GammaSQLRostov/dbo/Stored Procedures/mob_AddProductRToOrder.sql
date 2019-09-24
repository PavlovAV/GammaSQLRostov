



-- =============================================
-- Author:		<Павлов Александр>
-- Create date: <15.11.2017>
-- Description:	<Добавление продукта в приказ по ProductID>
-- =============================================

CREATE PROCEDURE [dbo].[mob_AddProductRToOrder] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID uniqueidentifier,
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier,
		@Quantity int
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @DocId table (DocId uniqueidentifier)
	DECLARE @ProductID table (ProductID uniqueidentifier)
	

	INSERT INTO @ProductID (ProductID)
	SELECT DISTINCT ProductID FROM vProductsInfo WHERE ProductKindID = 3 AND [1CNomenclatureID] = @NomenclatureID AND [1CCharacteristicID] = @CharacteristicID AND [1CQualityID] = @QualityID

	IF NOT EXISTS (SELECT * FROM @ProductID)
	BEGIN
		INSERT INTO Docs (UserId, DocTypeID, Date, ShiftId) OUTPUT Inserted.DocId INTO @DocId
		VALUES (dbo.CurrentUserID(), 0, GetDate(), 0)

		INSERT INTO DocProduction (DocID)
		SELECT docid.DocId
			FROM @DocId docid

		INSERT INTO Products (ProductKindID,StateID) 
		OUTPUT Inserted.ProductID INTO @ProductID
		SELECT 3,StateID
			FROM ProductStates 
			WHERE [1CQualityID] = @QualityID

		INSERT INTO ProductItems (ProductID,[1CNomenclatureID],[1CCharacteristicID])
		SELECT p.ProductID,@NomenclatureID,@CharacteristicID
			FROM @ProductID p

		INSERT INTO DocProductionProducts (DocID, ProductID,[1CNomenclatureID],[1CCharacteristicID])
		SELECT a.DocId, b.ProductID,@NomenclatureID,@CharacteristicID 
			FROM @DocId a CROSS JOIN @ProductID b
	END
	
	UPDATE [pi]
		SET Quantity = ISNULL(Quantity,0) + @Quantity
		FROM ProductItems [pi] JOIN @ProductID p ON [pi].ProductID = p.ProductID

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_AddProductRToOrder] TO [PalletRepacker]
    AS [dbo];

