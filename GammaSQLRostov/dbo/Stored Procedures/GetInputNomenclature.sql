-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetInputNomenclature] 
	-- Add the parameters for the stored procedure here
	(
		@NomenclatureID uniqueidentifier, @PlaceGroupID int = null
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @WorkingSpecifications TABLE ([1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier, [1CPlaceID] uniqueidentifier, 
		[1CSpecificationID] uniqueidentifier, IsAllChars Bit)

	INSERT INTO @WorkingSpecifications
	EXEC dbo.GetWorkingSpecifications;

    -- Insert statements for procedure here
	WITH InputNomenclature ([1CNomenclatureID], Name, [1CCharacteristicID])
	AS
	(
		SELECT DISTINCT b.[1CNomenclatureID], c.Name, b.[1CCharacteristicID]
		FROM
	--	v1CWorkingSpecifications a
	--	JOIN
	--	[1CMainSpecifications] a
		@WorkingSpecifications a
		JOIN
		[1CSpecificationInputNomenclature] b ON a.[1CSpecificationID] = b.[1CSpecificationID]
		JOIN
		[1CNomenclature] c ON b.[1CNomenclatureID] = c.[1CNomenclatureID] AND c.[NomenclatureKindID] = 1
		JOIN
		PlaceGroup1CNomenclature d ON @PlaceGroupID IS NULL OR (d.PlaceGroupID = @PlaceGroupID AND d.[1CNomenclatureID] = c.[1CParentID])
		WHERE a.[1CNomenclatureID] = @NomenclatureID
	)

	SELECT DISTINCT * FROM
	(
		SELECT [1CNomenclatureID], Name
		FROM 
		InputNomenclature
		UNION ALL
		SELECT b.[1CNomenclatureAnalogID] AS [1CNomenclatureID], c.Name
		FROM InputNomenclature a
		JOIN
		[1CNomenclatureAnalogs] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND
			((a.[1CCharacteristicID] IS NULL AND b.[1CCharacteristicID] IS NULL) OR (a.[1CCharacteristicID] = b.[1CCharacteristicID]))
		JOIN
		[1CNomenclature] c ON b.[1CNomenclatureAnalogID] = c.[1CNomenclatureID] 
	) a

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetInputNomenclature] TO [PalletRepacker]
    AS [dbo];

