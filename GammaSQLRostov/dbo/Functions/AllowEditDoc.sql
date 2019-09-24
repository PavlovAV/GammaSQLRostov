

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[AllowEditDoc]
(
	@DocID uniqueidentifier
)
RETURNS bit
AS
BEGIN
	-- Declare the return variable here
	DECLARE @Result bit, @DocTypeID int, @Date DateTime

	SET @Result = 1

	SELECT @DocTypeID = DocTypeID, @Date = Date FROM Docs WHERE DocID = @DocID

	IF @DocTypeID = 0  --- проверка для выработки 
	BEGIN
		IF EXISTS 
			(
				SELECT * FROM DocCloseShiftDocs WHERE DocID = @DocID
			)
			OR EXISTS 
			(
				SELECT *
				FROM
				DocProductionProducts a
				JOIN
				DocBrokeProducts b ON a.ProductID = b.ProductID
				JOIN
				Docs c ON b.DocID = c.DocID AND c.Date > @Date
				WHERE
				a.DocID = @DocID
			)
			OR EXISTS 
			(
				SELECT *
				FROM
				DocProductionProducts a
				JOIN
				DocWithdrawalProducts b ON a.ProductID = b.ProductID
				WHERE a.DocID = @DocID
			)
		BEGIN
			SET @Result = 0
		END
	END

	IF @DocTypeID = 1  --- проверка для списания
	BEGIN
		IF EXISTS 
			(
				SELECT * FROM
				DocWithdrawalProducts a
				JOIN
				DocWithdrawalProducts b ON a.ProductID = b.ProductID
				JOIN
				Docs c ON b.DocID = c.DocID AND c.Date > @Date
				WHERE a.DocID = @DocID
			) 
			OR EXISTS 
			(
				SELECT * FROM DocCloseShiftDocs a
				WHERE DocID = @DocID
				AND NOT EXISTS 
				(SELECT * FROM DocCloseShiftRemainders WHERE DocID = a.DocID AND DocWithdrawalID = @DocID)
			)
			OR EXISTS 
			(
				SELECT *
				FROM
				DocWithdrawalProducts a
				JOIN
				DocBrokeProducts b ON a.ProductID = b.ProductID
				JOIN
				Docs c ON b.DocID = c.DocID AND c.Date > @Date
				WHERE
				a.DocID = @DocID
			)
		BEGIN
			SET @Result = 0
		END
	END

	IF @DocTypeID = 7 --- Проверка для акта о браке
	BEGIN
		IF  EXISTS --- Если уже отгружена продукция, то нельзя
			(
				SELECT *
				FROM
				DocBrokeProducts a
				JOIN
				DocOutProducts b ON a.ProductID = b.ProductID
				JOIN
				DocMovement c ON b.DocID = c.DocID AND c.DocOrderID IS NOT NULL
				JOIN
				Docs d ON c.DocID = d.DocID AND d.Date > @Date
				WHERE
				a.DocID = @DocID
			)
		BEGIN
			SET @Result = 0;
		END
	END

	RETURN @Result
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[AllowEditDoc] TO [PalletRepacker]
    AS [dbo];

