-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetOldProductInfo] 
	-- Add the parameters for the stored procedure here
	(
		@Number varchar(255),
		@ProductKindId int -- 0-тамбура, 1 - паллеты, 2 - групповые упаковки
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @ProductID uniqueidentifier, @ProductNumber varchar(255), @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier,
		@OldNomenclature varchar(255), @OldProductId Bigint

    -- Insert statements for procedure here
	IF @ProductKindId = 0 -- Поиск сопоставления для тамбура
	BEGIN 
		SELECT TOP 1 @OldProductId = a.SpoolId, @ProductId = b.ProductID, @ProductNumber = e.Number, @NomenclatureID = ISNULL(c.[1CNomenclatureID], d.[1CNomenclatureID]),
			@CharacteristicID = ISNULL(c.[1CCharacteristicID], d.[1CCharacteristicID]), 
			@OldNomenclature = f.Article + '-' + CAST(f.BasisWeight AS varchar(10))+ ',' + f.Color + ',' + CAST(h.Value AS varchar) + ' мм' +
			', ' + ISNULL(i.Name, '')  + '-' + CAST(f.Whiteness AS varchar) +  ', ' +
			CAST(f.Format AS varchar) + ',' + CAST(a.LayerNumber AS varchar) + ' сл. ' + ', ' + 
			g.Name
		FROM
		Gamma.dbo.Spools a
		JOIN
		Gamma.dbo.vSpools f ON a.SpoolID = f.SpoolID
		LEFT JOIN
		Gamma.dbo.Destinations g ON a.DestinationID = g.DestinationID
		LEFT JOIN
		Gamma.dbo.GammaOldToNewSpools b ON a.SpoolID = b.SpoolId
		LEFT JOIN
		ProductSpools c ON b.ProductID = c.ProductID
		LEFT JOIN
		Products e ON c.ProductID = e.ProductID
		LEFT JOIN
		Gamma.[dbo].[GammaOldSpoolPropertiesToNewNomenclature] d ON 
			a.BasisWeightID = d.BasisWeightID AND a.FormatID = d.FormatID AND a.ColorID = d.ColorID AND
			a.WhitenessID = d.WhitenessID AND a.DestinationID = d.DestinationID AND a.LayerNumber = d.LayerNumber AND a.CoreDiameterID = d.CoreDiameterID
			AND a.SpoolKindID = d.SpoolKindID AND (a.RawMaterialID = d.RawMaterialID OR (a.RawMaterialID IS NULL AND d.RawMaterialID IS NULL))
		LEFT JOIN
		Gamma.dbo.CoreDiameters h ON h.CoreDiameterID = a.CoreDiameterID
		LEFT JOIN
		Gamma.dbo.RawMaterials i ON i.RawMaterialID = a.RawMaterialID
		WHERE a.Number = @Number
	END
--	ELSE IF @ProductKindId = 1
--	BEGIN
--	END
	ELSE IF @ProductKindID = 2
	BEGIN
		SELECT TOP 1 @OldProductId = gp.GroupPackID, @ProductId = b.ProductID, @ProductNumber = e.Number, @NomenclatureID = ISNULL(c.[1CNomenclatureID], d.[1CNomenclatureID]),
			@CharacteristicID = ISNULL(c.[1CCharacteristicID], d.[1CCharacteristicID]), 
			@OldNomenclature = f.Article + '-' + CAST(f.BasisWeight AS varchar(10))+ ',' + f.Color + ',' + CAST(h.Value AS varchar) + ' мм' +
			', ' + ISNULL(i.Name, '')  + '-' + CAST(f.Whiteness AS varchar) +  ', ' +
			CAST(f.Format AS varchar) + ',' + CAST(a.LayerNumber AS varchar) + ' сл. ' + ', ' + 
			g.Name
		FROM
		Gamma.dbo.GroupPacks gp
		JOIN
		Gamma.dbo.GroupPackSpools gps ON gp.GroupPackID = gps.GroupPackID
		JOIN
		Gamma.dbo.Spools a ON a.SpoolID = gps.SpoolID
		JOIN
		Gamma.dbo.vSpools f ON a.SpoolID = f.SpoolID
		LEFT JOIN
		Gamma.dbo.Destinations g ON a.DestinationID = g.DestinationID
		LEFT JOIN
		Gamma.dbo.GammaOldToNewGroupPacks b ON gp.GroupPackID = b.GroupPackID
		LEFT JOIN
		ProductGroupPacks c ON b.ProductID = c.ProductID
		LEFT JOIN
		Products e ON c.ProductID = e.ProductID
		LEFT JOIN
		Gamma.[dbo].[GammaOldSpoolPropertiesToNewNomenclature] d ON 
			a.BasisWeightID = d.BasisWeightID AND a.FormatID = d.FormatID AND a.ColorID = d.ColorID AND
			a.WhitenessID = d.WhitenessID AND a.DestinationID = d.DestinationID AND a.LayerNumber = d.LayerNumber AND a.CoreDiameterID = d.CoreDiameterID
			AND a.SpoolKindID = d.SpoolKindID AND (a.RawMaterialID = d.RawMaterialID OR (a.RawMaterialID IS NULL AND d.RawMaterialID IS NULL)) 
		LEFT JOIN
		Gamma.dbo.CoreDiameters h ON h.CoreDiameterID = a.CoreDiameterID
		LEFT JOIN
		Gamma.dbo.RawMaterials i ON i.RawMaterialID = a.RawMaterialID
		WHERE gp.Number = @Number
	END

	SELECT @ProductID AS ProductId, @ProductNumber AS ProductNumber, @NomenclatureID AS NomenclatureId
	, @CharacteristicId AS CharacteristicId, @OldNomenclature AS OldNomenclature, @OldProductId AS OldProductId

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetOldProductInfo] TO [PalletRepacker]
    AS [dbo];

