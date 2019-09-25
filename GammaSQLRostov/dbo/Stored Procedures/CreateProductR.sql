
-- =============================================
-- Author:		<Павлов Александр>
-- Create date: <15.11.2017>
-- Description:	<Добавление продукта в приказ по ProductID>
-- =============================================
--exec dbo.[mob_AddProductIdToMovement] @PersonID='94874554-68A6-E611-A7A3-00241DC986EB',@ProductID='00000000-0000-0000-0000-000000000000',@PlaceID=8,@PlaceZoneID='3650B3A7-0584-E711-9F9B-00241DC986EB',@ProductKindID=3,@NomenclatureID='21DEA56A-E5ED-11E5-A7AC-002590EBA5B7',@CharacteristicID='4425F87B-E5EE-11E5-A7AC-002590EBA5B7',@QualityID='D05404A0-6BCE-449B-A798-41EBE5E5B977',@QuantityRos=1000

CREATE PROCEDURE [dbo].[CreateProductR] 
	-- Add the parameters for the stored procedure here
	(
		@DocOrderId uniqueidentifier,
		@ShiftId tinyint, 
		@PlaceID int,
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier,
		@QualityID uniqueidentifier,
		@Quantity int,
		@ProductID uniqueidentifier OUTPUT,
		@ProductItemID uniqueidentifier OUTPUT
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @Product table (ProductID uniqueidentifier)
	DECLARE @ProductItem table (ProductItemID uniqueidentifier)
						
	DECLARE @Doc table (DocID uniqueidentifier, PlaceID int)
	DECLARE @Number varchar(100)

	INSERT INTO Docs (UserId, DocTypeID, Date, ShiftId, PlaceID) 
	OUTPUT Inserted.DocId, Inserted.PlaceID INTO @Doc
	VALUES (dbo.CurrentUserID(), 0, GetDate(), @ShiftId, @PlaceID)
	SELECT @Number = d.Number FROM Docs d JOIN @Doc dd ON d.DocID = dd.DocId
--PRINT CAST(@Number AS varchar(100)) 
	INSERT INTO DocProduction (DocID, InPlaceID, DocOrderId)
	SELECT docid.DocID, docId.PlaceID ,@DocOrderId
		FROM @Doc docid

	INSERT INTO Products (Number,ProductKindID,StateID) 
	OUTPUT Inserted.ProductID INTO @Product
	SELECT @Number, 3, ps.StateID
		FROM ProductStates ps
		WHERE ps.[1CQualityID] = @QualityID
								
	SELECT @ProductID = ProductID FROM @Product
--PRINT 'ProductID '+ISNULL(CAST(@ProductID AS varchar(100)),'NULL')	
--PRINT CAST(@ProductID AS varchar(100))
	INSERT INTO DocProductionProducts (DocID, ProductID,[1CNomenclatureID],[1CCharacteristicID],Quantity)
	SELECT a.DocId, @ProductID,@NomenclatureID,@CharacteristicID,@Quantity
		FROM @Doc a
							
	INSERT INTO ProductItems (ProductID,[1CNomenclatureID],[1CCharacteristicID])
	OUTPUT Inserted.ProductItemID  INTO @ProductItem
	VALUES(@ProductID,@NomenclatureID,@CharacteristicID)
	--SELECT p.ProductID,@NomenclatureID,@CharacteristicID
	--	FROM @Product p
	SELECT @ProductItemID = ProductItemID FROM @ProductItem

	IF @Quantity > 0 
		UPDATE [pi]
		SET Quantity = ISNULL(Quantity,0) + @Quantity*ISNULL(f.Coefficient,1)
		FROM ProductItems [pi] 
			JOIN [1CNomenclature] n ON [pi].[1CNomenclatureID] = n.[1CNomenclatureID]
			LEFT JOIN [1CCharacteristics] c ON [pi].[1CCharacteristicID] = c.[1CCharacteristicID]
			LEFT JOIN [1CMeasureUnits] f ON ISNULL(c.[MeasureUnitPackage], n.[1CMeasureUnitSet]) = f.[1CMeasureUnitID]
		WHERE [pi].ProductItemID = @ProductItemID
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateProductR] TO [PalletRepacker]
    AS [dbo];

