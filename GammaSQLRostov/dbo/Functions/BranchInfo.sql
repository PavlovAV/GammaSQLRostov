-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[BranchInfo]
(
	@BranchID int
)
RETURNS varchar(8000)
AS
BEGIN
	DECLARE @Result varchar(8000)

	SELECT @Result = a.Address + '; ' + CHAR(13) + a.Phones + ' ' + a.WebInfo + ' ' + CHAR(13) + 'По вопросам качества обращаться: ' + b.QualityContacts
	FROM
	Branches a
	LEFT JOIN
	Enterprises b ON a.EnterpriseID = b.EnterpriseID
	WHERE BranchID = @BranchID

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[BranchInfo] TO [PalletRepacker]
    AS [dbo];

