-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	Получение входной номенклатуры по спецификации на бумагу ПРС для БДМ
-- =============================================
--3П22 выпускается на х5, но нет на гамбини

CREATE PROCEDURE [dbo].[GetSpecificationNomenclatureOnPlace] 
	-- Add the parameters for the stored procedure here
	(
		@PlaceID int, @Date datetime = null
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	
    -- Insert statements for procedure here
	SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], b.Name AS NomenclatureName, c.Name AS CharacteristicName , a.Period, a.ValidTill, p.PlaceID, p.Name AS PlaceName
		FROM
		v1CWorkingSpecifications a
		JOIN [1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
		LEFT JOIN [1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
		JOIN Places p ON a.[1CPlaceID] = p.[1CPlaceID]
		WHERE b.NomenclatureKindID = 3
			AND (@PlaceID IS NULL OR p.PlaceID = @PlaceID)

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpecificationNomenclatureOnPlace] TO PUBLIC
    AS [dbo];

