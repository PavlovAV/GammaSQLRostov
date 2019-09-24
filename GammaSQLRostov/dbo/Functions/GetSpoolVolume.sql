-- =============================================
-- Author:		Matvey Polidanov
-- Create date: 27.01.2017
-- Description:	Получение объема бумаги тамбура
-- =============================================
CREATE FUNCTION [dbo].[GetSpoolVolume]
(
	@CoreDiameter decimal(15,5), -- Диаметр гильзы в мм
	@Diameter decimal(15,5), -- диаметр внешний в мм
	@Format decimal(15,5) -- формат в мм
)
RETURNS decimal(15,10) -- возвращает в м3 
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Volume decimal(15,10) 
	
	SELECT @Volume = PI()*@Format*(@Diameter*@Diameter - @CoreDiameter*@CoreDiameter)/4000000000 
	
	RETURN ISNULL(@Volume, 0)

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolVolume] TO [PalletRepacker]
    AS [dbo];

