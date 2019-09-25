
-- =============================================
-- Author:		<Alexandr Pavlov>
-- Create date: <25.12.2017>
-- Description:	<Проверка разрешения на изменение акта о браке>
-- =============================================

CREATE PROCEDURE [dbo].[GetDocBrokeEditable]
(
 @docDate datetime,
 @docUserID uniqueidentifier,
 @docShiftID int,
 @docIsConfirmed bit,
 @UserID uniqueidentifier,
 @ShiftID int,
 @DocID uniqueidentifier
)
AS		
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	SELECT CASE WHEN 
			(--свой неподвержденный акт и (или дневной персонал; или сменный, но тогда только текущей смены)
				(@docIsConfirmed = 0 AND @docUserID = @UserID AND @docShiftID = @ShiftID) 
				AND (@ShiftID = 0 OR (@ShiftID > 0 AND @docDate >= DATEADD(HOUR,-13,GETDATE()))) )
			OR--специалист по качеству
				EXISTS(SELECT u.UserID FROM Users u JOIN Roles r ON u.RoleID = r.RoleID WHERE u.UserID = @UserID AND r.Name = 'QualityInspector')
			OR--Машинистом БДМ или Специалистом по учету акт с утилизацией без галочки Срезан в брак 
				(EXISTS(SELECT a.ProductID FROM DocBrokeDecisionProducts a WHERE a.DocID = @DocID AND a.StateID = 2 AND ISNULL(a.DecisionApplied, NULL) = 0) AND EXISTS(SELECT u.UserID FROM Users u JOIN Roles r ON u.RoleID = r.RoleID WHERE u.UserID = @UserID AND r.Name IN ('OperatorBDM','Dispetcher')))
	THEN CAST(1 AS bit)
	ELSE CAST(0 AS bit)
	END AS IsEditable--, 1 as Ret
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetDocBrokeEditable] TO [PalletRepacker]
    AS [dbo];

