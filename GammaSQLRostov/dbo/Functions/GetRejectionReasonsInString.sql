-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetRejectionReasonsInString]
(
	@DocID uniqueidentifier, 
	@ProductID uniqueidentifier
)
RETURNS varchar(8000)
AS
BEGIN
	DECLARE @Result varchar(8000), @Reason varchar(1000)

	SET @Result = ''

	DECLARE reasons CURSOR
	FOR
	SELECT 
	b.Description AS Reason
	FROM
	DocBrokeProductRejectionReasons a
	JOIN
	[1CRejectionReasons] b ON a.[1CRejectionReasonID] = b.[1CRejectionReasonID]
	WHERE
	a.DocID = @DocID AND a.ProductID = @ProductID

	OPEN reasons

	FETCH NEXT FROM reasons INTO @Reason

	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Result = @Result + @Reason

		FETCH NEXT FROM reasons INTO @Reason
		SET @Reason = CHAR(10) + CHAR(13) + @Reason 
	END

	CLOSE reasons

	DEALLOCATE reasons

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetRejectionReasonsInString] TO [PalletRepacker]
    AS [dbo];

