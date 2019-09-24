
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateNewNumbersForProduct] 
	-- Add the parameters for the stored procedure here
	(
		@ProductID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Number varchar(100), @PrevNumber varchar(100), @CurrDate datetime,  @PlaceID int, @BranchID int, @BranchUnitID int, @sCurrDate char(6),
    @YEAR varchar(10), @Month varchar(10), @Day varchar(10), @Place varchar(10), @ShiftID tinyint, @DocID uniqueidentifier, @DocTypeID tinyint

		DECLARE GenerateNewNumberForProducts_cursor CURSOR
		FOR
		SELECT a.DocID, b.PlaceID, b.Date, c.BranchID, c.BranchUnitID, b.ShiftID, b.DocTypeID
		FROM 
		DocProductionProducts a
		JOIN
		Docs b ON a.DocID = b.DocID AND b.DocTypeID = 0
		JOIN
		Places c ON b.PlaceID = c.PlaceID
		JOIN
		Products d ON a.ProductID = d.ProductID
		WHERE (b.IsFromOldGamma = 0 OR b.IsFromOldGamma IS NULL)
			AND a.ProductID = @ProductID 
			AND d.Number IS NULL
			
		OPEN GenerateNewNumberForProducts_cursor

		FETCH NEXT FROM GenerateNewNumberForProducts_cursor
		INTO @DocID, @PlaceID, @CurrDate, @BranchID, @BranchUnitID, @ShiftID, @DocTypeID
		
		WHILE @@FETCH_STATUS = 0
		BEGIN
			SET @CurrDate = GETDATE()
			SET @sCurrDate = CONVERT(char(6),@CurrDate,12)
			SELECT TOP 1 @PrevNumber = c.Number
			FROM
			Docs a
			JOIN
			DocProductionProducts b ON a.DocID = b.DocID
			JOIN
			Products c ON b.ProductID = c.ProductID
			WHERE a.DocTypeID = @DocTypeID AND a.PlaceID = @PlaceID
			AND LEFT(c.Number,4) = LEFT(@sCurrDate,4)
			AND c.ProductID <> @ProductID AND c.Number IS NOT NULL
			AND LEN(c.Number)=15
			ORDER BY LEFT(c.Number,6) DESC, c.Number DESC

			SET @PrevNumber = ISNULL(@PrevNumber, '000000000')
		
			SELECT @YEAR = LEFT(@sCurrDate, 2)
		    SELECT @MONTH = SUBSTRING(@sCurrDate, 3, 2)
			SELECT @DAY = SUBSTRING(@sCurrDate, 5, 2)

			SELECT @Number = (CAST(RIGHT(@PrevNumber, 5) as int) + 1)
			SELECT @Number = STUFF('00000', 6 - LEN(@Number), LEN(@number), @Number)
	
			SET @Number = @YEAR + @MONTH + @DAY + CAST(@ShiftID AS varchar) + CAST(@BranchID AS varchar) 
			+ STUFF('00',3 - LEN(@BranchUnitID), LEN(@BranchUnitID), @BranchUnitID) + @Number

			UPDATE Products SET Number = @Number, BarCode = '2' + @Number
			WHERE ProductID = @ProductID AND Number IS NULL

			FETCH NEXT FROM GenerateNewNumberForProducts_cursor
			INTO @DocID, @PlaceID, @CurrDate, @BranchID, @BranchUnitID, @ShiftID, @DocTypeID
		END

		CLOSE GenerateNewNumberForProducts_cursor
		DEALLOCATE GenerateNewNumberForProducts_cursor
	
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForProduct] TO [PalletRepacker]
    AS [dbo];

