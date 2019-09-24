-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetShiftBeginTime]
(
	@Date datetime2
)
RETURNS datetime
AS
BEGIN
	DECLARE @ResultVar DATETIME, @Hour varchar(3)
	
	SELECT @Hour = CASE 
      WHEN DATEPART(Hour, @Date) BETWEEN 8 AND 19 THEN '08'
      WHEN DATEPART(Hour, @Date) BETWEEN 20 AND 23 THEN '20'
      WHEN DATEPART(Hour, @Date) BETWEEN 0 AND 7 THEN '-20'
	END
	
  	IF (@Hour = '08') OR (@Hour = '20')
	BEGIN 
	  SELECT @ResultVar = CONVERT(datetime, LEFT(CONVERT(varchar(100), @Date, 120), 10) + ' ' + @Hour + ':00:00', 120)
    END
	IF (@Hour = '-20')
	BEGIN 
	  SELECT @ResultVar = DATEADD(day, -1, CONVERT(datetime, LEFT(CONVERT(varchar(100), @Date, 120), 10) + ' ' + '20' + ':00:00', 120))
    END

	RETURN @ResultVar

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetShiftBeginTime] TO [PalletRepacker]
    AS [dbo];

