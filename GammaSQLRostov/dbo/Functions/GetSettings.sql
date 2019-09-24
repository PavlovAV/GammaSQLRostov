-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <2017/09/11>
-- Description:	<Получение параметров>
-- =============================================
CREATE FUNCTION [dbo].[GetSettings]
(
	@Setting varchar(MAX)
)
RETURNS varchar(MAX)
AS
BEGIN
DECLARE @Result varchar(MAX)

IF @Setting = 'MaxAllowedPercentBreakInDocOrder'
	RETURN '8'
ELSE IF @Setting = 'MaxAllowedWeightDifferenceBetweenPMandWR'
	RETURN '50'
ELSE
	RETURN NULL

RETURN @Result
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSettings] TO [PalletRepacker]
    AS [dbo];

