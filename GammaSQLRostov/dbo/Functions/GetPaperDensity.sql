-- =============================================
-- Author:		Matvey Polidanov
-- Create date: 27.01.2017
-- Description:	Расчет плотности бумаги тамбура или ГУ(намотки)
-- =============================================
CREATE FUNCTION [dbo].[GetPaperDensity]
(
	@Weight decimal(15,5),
	@CoreDiameter decimal(15,5), -- Диаметр гильзы в мм
	@Diameter decimal(15,5), -- диаметр внешний в мм
	@Format decimal(15,5) -- формат в мм
)
RETURNS decimal(15,10) -- кг/м3
AS
BEGIN
	DECLARE @Density decimal(15,10), @Volume decimal(15,5)

	SELECT @Volume = dbo.GetSpoolVolume(@CoreDiameter, @Diameter, @Format)

	IF @Volume = 0 SET @Density = 0
	ELSE 
	SELECT @Density = @Weight/@Volume

	RETURN ISNULL(@Density,0)

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetPaperDensity] TO [PalletRepacker]
    AS [dbo];

