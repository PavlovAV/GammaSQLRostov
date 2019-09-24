

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GenerateNewNumbersForDoc] 
	-- Add the parameters for the stored procedure here
	(
		@DocID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	
	DECLARE @Number varchar(100), @PrevNumber varchar(100), @CurrDate datetime,  @PlaceID int, @BranchID int, @BranchUnitID int,
    @YEAR varchar(10), @Month varchar(10), @Day varchar(10), @Place varchar(10), @ShiftID tinyint, @ProductID uniqueidentifier

	SELECT @PlaceID = a.PlaceID, @ShiftID = a.ShiftID, @BranchID = b.BranchID, @BranchUnitID = b.BranchUnitID
	FROM 
	Docs a
	LEFT JOIN
	Places b ON a.PlaceID = b.PlaceID
	WHERE DocID = @DocID
	SELECT @CurrDate = GETDATE()

	SELECT TOP 1 @PrevNumber = Number FROM Docs
	WHERE DocID <> @DocID AND PlaceID = @PlaceID AND MONTH(Date) = MONTH(@CurrDate) AND YEAR(Date) = YEAR(@CurrDate) AND DocTypeID = 0
	AND Number IS NOT NULL
	ORDER BY Date DESC
	
	SET @PrevNumber = ISNULL(@PrevNumber, '000000000')

	SELECT @Number = (CAST(RIGHT(@PrevNumber, 5) as int) + 1)
	SELECT @Number = STUFF('00000', 6 - LEN(@Number), LEN(@number), @Number)
	

	SELECT @YEAR = LEFT(CONVERT(varchar, @CurrDate, 12), 2)
    SELECT @MONTH = SUBSTRING(CONVERT(varchar, @CurrDate, 12), 3, 2)
	SELECT @DAY = SUBSTRING(CONVERT(varchar, @CurrDate, 12), 5, 2)

	SET @Number = @YEAR + @MONTH + @DAY + CAST(@ShiftID AS varchar) + CAST(@BranchID AS varchar) 
			+ STUFF('00',3 - LEN(@BranchUnitID), LEN(@BranchUnitID), @BranchUnitID) + @Number
	

	UPDATE Docs SET Number = @Number
	WHERE DocID = @DocID AND DocTypeID = 0

	--Установка номера для продукции
	IF EXISTS 
	(SELECT * 
	FROM DocProductionProducts a
	JOIN
	Docs b ON a.DocID = b.DocID AND b.DocTypeID = 0 AND b.DocID = @DocID)
	BEGIN
		DECLARE docProducts_cursor CURSOR
		FOR
		SELECT a.DocID, ProductID, b.PlaceID, b.Date, c.BranchID, c.BranchUnitID, b.ShiftID
		FROM 
		DocProductionProducts a
		JOIN
		Docs b ON a.DocID = b.DocID AND b.DocTypeID = 0 AND b.DocID = @DocID
		JOIN
		Places c ON b.PlaceID = c.PlaceID
		WHERE a.DocID = @DocID
			
		OPEN docProducts_cursor

		FETCH NEXT FROM docProducts_cursor
		INTO @DocID, @ProductID, @PlaceID, @CurrDate, @BranchID, @BranchUnitID, @ShiftID

		WHILE @@FETCH_STATUS = 0
		BEGIN
			SELECT TOP 1 @PrevNumber = c.Number
			FROM
			Docs a
			JOIN
			DocProductionProducts b ON a.DocID = b.DocID
			JOIN
			Products c ON b.ProductID = c.ProductID
			WHERE a.DocTypeID = 0 AND a.PlaceID = @PlaceID 
			AND YEAR(a.Date) = YEAR(@CurrDate) AND MONTH(a.Date) = MONTH(@CurrDate)
			AND c.Number IS NOT NULL
			ORDER BY a.Date DESC, c.Number DESC

			SET @PrevNumber = ISNULL(@PrevNumber, '000000000')
		
			SELECT @YEAR = LEFT(CONVERT(varchar, @CurrDate, 12), 2)
		    SELECT @MONTH = SUBSTRING(CONVERT(varchar, @CurrDate, 12), 3, 2)
			SELECT @DAY = SUBSTRING(CONVERT(varchar, @CurrDate, 12), 5, 2)

			SELECT @Number = (CAST(RIGHT(@PrevNumber, 5) as int) + 1)
			SELECT @Number = STUFF('00000', 6 - LEN(@Number), LEN(@number), @Number)
	
			SET @Number = @YEAR + @MONTH + @DAY + CAST(@ShiftID AS varchar) + CAST(@BranchID AS varchar) 
			+ STUFF('00',3 - LEN(@BranchUnitID), LEN(@BranchUnitID), @BranchUnitID) + @Number

			UPDATE Products SET Number = @Number, BarCode = '2' + @Number
			WHERE ProductID = @ProductID

			FETCH NEXT FROM docProducts_cursor
			INTO @DocID, @ProductID, @PlaceID, @CurrDate, @BranchID, @BranchUnitID, @ShiftID
		END

		CLOSE docProducts_cursor
		DEALLOCATE docProducts_cursor
	END
	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GenerateNewNumbersForDoc] TO [PalletRepacker]
    AS [dbo];

