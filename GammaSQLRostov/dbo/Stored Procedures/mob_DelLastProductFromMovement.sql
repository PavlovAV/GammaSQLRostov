
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[mob_DelLastProductFromMovement] 
	-- Add the parameters for the stored procedure here
	(
		@Barcode varchar(20), -- ШК или номер
		@PlaceIdTo int, --- склад приемки
		@PersonID uniqueidentifier, -- пользователь
		@DocDirection int -- 0 - in, 1 - out, 2 - outin
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	DECLARE @DocMovementID uniqueidentifier

	SELECT TOP 1 @DocMovementID = DocMovementID
	FROM
	vDocMovementProducts a
	WHERE 
	a.BarCode = @Barcode
	AND (a.IsConfirmed IS NULL OR a.IsConfirmed = 0 )
	AND a.InPlaceID = @PlaceIdTo
	AND a.InPersonID = @PersonID
	AND a.OrderTypeID = 3
	AND a.InDate >= DATEADD(hour, -14,GETDATE())
	ORDER BY a.DocDate DESC

	EXEC [dbo].[mob_DelProductFromMovement] @DocMovementID, @Barcode, @DocDirection
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[mob_DelLastProductFromMovement] TO [PalletRepacker]
    AS [dbo];

