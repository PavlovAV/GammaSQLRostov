-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetWorkingSpecifications] 
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @allSpecs TABLE ([1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier, [1CPlaceID] uniqueidentifier, 
		[1CSpecificationID] uniqueidentifier, IsAllChars Bit)

	DECLARE @minSpecs TABLE ([1CNomenclatureID] uniqueidentifier, [1CCharacteristicID] uniqueidentifier, [1CPlaceID] uniqueidentifier
		, IsAllChars Bit)
	
	INSERT INTO @allSpecs ([1CNomenclatureID] , [1CCharacteristicID] ,  
		[1CSpecificationID] , [1CPlaceID], IsAllChars )
	SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CSpecificationID], a.[1CPlaceID], a.IsAllChars
	FROM
	v1CLastMainSpecifications a

	INSERT INTO @minSpecs (IsAllChars, [1CNomenclatureID], [1CCharacteristicID], [1CPlaceID])
	SELECT MIN(IsAllChars) AS IsAllChars, [1CNomenclatureID], [1CCharacteristicID], [1CPLaceID]
		FROM
		v1CLastMainSpecifications a
		GROUP BY [1CNOmenclatureID], [1CCharacteristicID], [1CPlaceID]

	SELECT a.*
	FROM 
	@allSpecs a
	JOIN
	@minSpecs b ON a.[1CNOmenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID] 
		AND a.[1CPlaceID] = b.[1CPlaceID] AND a.IsAllChars = b.IsAllChars


END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetWorkingSpecifications] TO [PalletRepacker]
    AS [dbo];

