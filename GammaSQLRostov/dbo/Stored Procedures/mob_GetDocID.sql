-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_GetDocID] 
	-- Add the parameters for the stored procedure here
	(
		@PersonID int,
		@DocShipmentOrderID uniqueidentifier -- ID Документа 1С
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @DocID uniqueidentifier
	DECLARE @DocIds table (DocID uniqueidentifier)

	SELECT @DocID = DocID FROM
	DocShipments
	WHERE 
	[1CDocShipmentOrderID] = @DocShipmentOrderID AND PersonID = @PersonID

	IF @DocID IS NULL
	BEGIN
	SET @DocID = newid();

		BEGIN TRANSACTION doc	
			INSERT INTO Docs (DocID, DocTypeID, UserID, PrintName, Date)
				OUTPUT INSERTED.DocID INTO @DocIds
					SELECT @DocID, 5 AS DocTypeID, dbo.CurrentUserID() AS UserID, Name AS PrintName, Getdate() AS Date
					FROM
					Persons WHERE PersonID = @PersonID
					
					INSERT INTO DocShipments ([1CDocShipmentOrderID], DocID, PersonID)
					SELECT TOP 1 @DocShipmentOrderID, @DocID, @PersonID
					FROM @DocIds				
		COMMIT TRANSACTION doc
	END

	SELECT TOP 1 @DocID = DocID FROM @DocIds
	
	SELECT @DocID AS DocID	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_GetDocID] TO [PalletRepacker]
    AS [dbo];

