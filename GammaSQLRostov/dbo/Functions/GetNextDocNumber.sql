-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetNextDocNumber]
(
	@DocTypeID INT, @PlaceID INT, @ShiftID INT
	
)
RETURNS VARCHAR(40)
AS
BEGIN
	DECLARE @Number VARCHAR(40)
	
	SELECT TOP 1 @Number = CAST(ISNULL(RIGHT(d.Number,6),'0') AS INT) + 1 FROM Docs d
	WHERE d.DocTypeID = @DocTypeID

	RETURN ISNULL(@Number,'1')
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetNextDocNumber] TO [PalletRepacker]
    AS [dbo];

