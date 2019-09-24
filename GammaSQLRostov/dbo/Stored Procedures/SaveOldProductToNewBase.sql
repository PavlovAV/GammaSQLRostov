-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[SaveOldProductToNewBase] 
	-- Add the parameters for the stored procedure here
	(
		@Id BigInt,
		@ProductKindId int, -- 0-тамбура, 1 - паллеты, 2 - групповые упаковки
		@NomenclatureID uniqueidentifier,
		@CharacteristicID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @SpoolId Bigint

	IF @ProductKindId = 0 AND NOT EXISTS (SELECT * FROM Gamma.dbo.GammaOldToNewSpools WHERE SpoolID = @Id)
		AND NOT EXISTS (SELECT * FROM Gamma.dbo.GammaNewToOldSpools WHERE SpoolID = @Id)
	BEGIN
		INSERT INTO Gamma.dbo.GammaOldToNewSpools (SpoolID, [1CNomenclatureID], [1CCharacteristicID])
			VALUES (@Id, @NomenclatureID, @CharacteristicID)

		IF EXISTS (SELECT * FROM 
			Gamma.dbo.GammaOldSpoolPropertiesToNewNomenclature a
			JOIN
			Gamma.dbo.Spools b ON a.[BasisWeightID] = b.[BasisWeightID] AND a.[FormatID] = b.FormatID AND a.[ColorID] = b.[ColorID]
			AND a.[WhitenessID] = b.[WhitenessID] AND a.[DestinationID] = b.[DestinationID] AND a.[LayerNumber] = b.[LayerNumber]
			AND a.[CoreDiameterID] = b.[CoreDiameterID] AND a.SpoolKindID = b.SpoolKindID
			AND (a.[RawMaterialID] = b.[RawMaterialID] OR (a.[RawMaterialID] IS NULL AND b.[RawMaterialID] IS NULL))
			WHERE b.SpoolID = @Id)
		BEGIN
			UPDATE a SET a.[1CNomenclatureID] = @NomenclatureID, a.[1CCharacteristicID] = @CharacteristicID
			FROM
			Gamma.dbo.GammaOldSpoolPropertiesToNewNomenclature a
			JOIN
			Gamma.dbo.Spools b ON a.[BasisWeightID] = b.[BasisWeightID] AND a.[FormatID] = b.FormatID AND a.[ColorID] = b.[ColorID]
			AND a.[WhitenessID] = b.[WhitenessID] AND a.[DestinationID] = b.[DestinationID] AND a.[LayerNumber] = b.[LayerNumber]
			AND a.[CoreDiameterID] = b.[CoreDiameterID] AND a.SpoolKindID = b.SpoolKindID
			AND (a.[RawMaterialID] = b.[RawMaterialID] OR (a.[RawMaterialID] IS NULL AND b.[RawMaterialID] IS NULL))
			WHERE b.SpoolID = @Id
		END	
		ELSE
		BEGIN
			INSERT INTO Gamma.dbo.GammaOldSpoolPropertiesToNewNomenclature ([1CNomenclatureID], [1CCharacteristicID], [BasisWeightID],
				[FormatID], [ColorID], [WhitenessID], [DestinationID], [LayerNumber], [CoreDiameterID], [SpoolKindID], [RawMaterialID])
			SELECT @NomenclatureID, @CharacteristicID, [BasisWeightID],
				[FormatID], [ColorID], [WhitenessID], [DestinationID], [LayerNumber], [CoreDiameterID], [SpoolKindID], [RawMaterialID]
			FROM
			Gamma.dbo.Spools
			WHERE SpoolID = @Id
		END
			
	END
	ELSE IF @ProductKindId = 2 AND NOT EXISTS (SELECT * FROM Gamma.dbo.GammaOldToNewGroupPacks WHERE GroupPackID = @Id)
		AND NOT EXISTS (SELECT * FROM Gamma.[dbo].[GammaNewGroupPackToOld] WHERE GroupPackID = @Id)
	BEGIN
		DECLARE spoolsCursor CURSOR FOR
			SELECT SpoolId 
			FROM Gamma.dbo.GroupPackSpools a
			WHERE GroupPackID = @Id
			AND NOT EXISTS (SELECT * FROM Gamma.dbo.GammaOldToNewSpools WHERE SpoolID = a.SpoolID)
			AND NOT EXISTS (SELECT * FROM Gamma.dbo.GammaNewToOldSpools WHERE SpoolID = a.SpoolID)

		OPEN spoolsCursor

		FETCH NEXT FROM spoolsCursor
		INTO @SpoolId

		WHILE @@FETCH_STATUS = 0
		BEGIN
			EXEC dbo.SaveOldProductToNewBase @SpoolId, 0, @NomenclatureID, @CharacteristicID

			FETCH NEXT FROM spoolsCursor
			INTO @SpoolId
		END

		CLOSE spoolsCursor

		DEALLOCATE spoolsCursor

		INSERT INTO Gamma.dbo.GammaOldToNewGroupPacks (GroupPackID, [1CNomenclatureID], [1CCharacteristicID])
			VALUES (@Id, @NomenclatureID, @CharacteristicID)
	END

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[SaveOldProductToNewBase] TO [PalletRepacker]
    AS [dbo];

