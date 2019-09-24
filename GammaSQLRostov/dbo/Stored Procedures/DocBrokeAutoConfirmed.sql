
-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <20.12.2017>
-- Description:	<Автоподтверждение всех актов о браке (кроме администрации) за предыдущую смену>
-- =============================================
CREATE PROCEDURE [dbo].[DocBrokeAutoConfirmed] 
	-- Add the parameters for the stored procedure here
AS
BEGIN

	DECLARE @UserID uniqueidentifier, @PlaceID int, @ShiftID int
	DECLARE @DocWithdrawalTbl TABLE (DocID uniqueidentifier)
	DECLARE @DocUnpackTbl TABLE (DocID uniqueidentifier)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	UPDATE d SET IsConfirmed = 1
	FROM Docs d
	JOIN DocBroke db ON d.DocID = db.DocID
	WHERE
	ISNULL(d.IsConfirmed,0) = 0 
	AND d.ShiftID > 0
	AND d.Date >= DATEADD(HOUR,-13,GETDATE()) 
	AND d.Date < CAST(DATEADD(MINUTE,-DATEPART(MINUTE, GETDATE()),GETDATE()) AS smalldatetime)
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[DocBrokeAutoConfirmed] TO [PalletRepacker]
    AS [dbo];

