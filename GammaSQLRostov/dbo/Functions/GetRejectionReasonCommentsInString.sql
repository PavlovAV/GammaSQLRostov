-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetRejectionReasonCommentsInString]
(
	@DocID uniqueidentifier, 
	@ProductID uniqueidentifier
)
RETURNS varchar(8000)
AS
BEGIN
	DECLARE @Result varchar(8000), @Reason varchar(1000)

	SET @Result = ''

	DECLARE comments CURSOR
	FOR
	SELECT a.Comment
	FROM
	DocBrokeProductRejectionReasons a
	WHERE
	a.DocID = @DocID AND a.ProductID = @ProductID

	OPEN comments

	FETCH NEXT FROM comments INTO @Reason

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @Reason IS NOT NULL
		BEGIN
			SET @Result = @Result + @Reason
		END

		FETCH NEXT FROM comments INTO @Reason
		IF @Reason IS NOT NULL
		BEGIN
			SET @Reason = CHAR(10) + CHAR(13) + @Reason
		END
	END

	CLOSE comments

	DEALLOCATE comments

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonCommentsInString] TO [PalletRepacker]
    AS [dbo];

