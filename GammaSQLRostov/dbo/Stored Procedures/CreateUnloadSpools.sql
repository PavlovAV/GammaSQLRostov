-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateUnloadSpools] 
	-- Add the parameters for the stored procedure here
	(
		@DocID uniqueidentifier, @ProductionTaskID uniqueidentifier, @Diameter int, @BreakNumber int,
		@Length decimal(4,1) = 0
	)
AS
BEGIN

	DECLARE @Products TABLE (ProductID uniqueidentifier, NomenclatureID uniqueidentifier, CharacteristicID uniqueidentifier)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	SET @BreakNumber = ISNULL(@BreakNumber, 0)

	IF EXISTS (SELECT * FROM DocProductionProducts WHERE DocID = @DocID)
	BEGIN
		BEGIN TRANSACTION p
			DECLARE @deletedProductIds TABLE (productID uniqueidentifier)
		
			DELETE FROM DocProductionProducts OUTPUT deleted.ProductID INTO @deletedProductIds
			WHERE DocID = @DocID

--			DELETE FROM DocProducts WHERE DocID = @DocID

			DELETE a
			FROM ProductSpools a
			JOIN
			@deletedProductIds b ON a.ProductID = b.ProductID

			DELETE a
			FROM Products a
			JOIN
			@deletedProductIds b ON a.ProductID = b.ProductID

		COMMIT TRANSACTION p
	END

	INSERT INTO @Products
	SELECT newid() AS ProductID, b.[1CNomenclatureID], b.[1CCharacteristicID]
	FROM
	ProductionTasks a
	JOIN
	ProductionTaskRWCutting b ON a.ProductionTaskID = b.ProductionTaskID
	WHERE a.ProductionTaskID = @ProductionTaskID

	BEGIN TRANSACTION ip
		INSERT INTO Products (ProductID, ProductKindID)
		SELECT ProductID, 0 AS ProductKindID
		FROM @Products

--		INSERT INTO DocProducts (DocID, ProductID)
--		SELECT @DocID AS DocID, ProductID
--		FROM @Products

		INSERT INTO DocProductionProducts (DocID, ProductID, [1CNomenclatureID], [1CCharacteristicID], Quantity)
		SELECT @DocID AS DocID, ProductID, NomenclatureID, CharacteristicID, 0.001 AS Quantity
		FROM
		@Products

		INSERT INTO ProductSpools (ProductID, [1CNomenclatureID], [1CCharacteristicID], RealFormat, Diameter, 
				Weight, DecimalWeight, BreakNumber, [Length])
		SELECT ProductID, NomenclatureID, CharacteristicID, dbo.GetCharSpoolFormat(CharacteristicID) AS RealFormat,
			@Diameter, 1, 0.001, @BreakNumber, @Length
		FROM @Products

	COMMIT TRANSACTION ip
	
	SELECT @DocID AS DocID, a.ProductID, b.Number, c.Name + ' ' + d.Name AS NomenclatureName
	FROM
	@Products a
	JOIN
	Products b ON a.ProductID = b.ProductID
	JOIN
	[1CNomenclature] c ON a.NomenclatureID = c.[1CNomenclatureID]
	JOIN
	[1CCharacteristics] d ON a.[CharacteristicID] = d.[1CCharacteristicID]
	

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CreateUnloadSpools] TO [PalletRepacker]
    AS [dbo];

