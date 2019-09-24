
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[CalculateSpoolWeightBeforeDate]
(
	@ProductID uniqueidentifier,
	@Date DateTime2
)
RETURNS decimal(15,5)
AS
BEGIN
	DECLARE @Weight Decimal(15,5), @DocID uniqueidentifier, @DocTypeID int
	
	DECLARE QuantityCursor CURSOR 
	FOR
	SELECT DocID, DocTypeID
	FROM
	vDocProducts 
	WHERE ProductID = @ProductID AND Date < @Date
	AND DocTypeID IN (1,6,7)
	ORDER BY Date
	
	OPEN QuantityCursor

	FETCH NEXT FROM QuantityCursor
	INTO @DocID, @DocTypeID

	SELECT @Weight = Quantity
	FROM
	DocProductionProducts 
	WHERE ProductID = @ProductID

	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @DocTypeID = 1
		BEGIN
			IF EXISTS 
			(
				SELECT *
				FROM
				DocWithdrawalProducts WHERE DocID = @DocID AND
				ProductID = @ProductID AND CompleteWithdrawal = 1
			)
			BEGIN
				SET @Weight = 0
			END
			ELSE 
			BEGIN
				SELECT @Weight = @Weight - ISNULL(Quantity,0)
				FROM
				DocWithdrawalProducts
				WHERE DocID = @DocID AND ProductID = @ProductID
			END
		END
		ELSE IF @DocTypeID = 6
		BEGIN
			SELECT @Weight = @Weight + d.Quantity/COUNT(e.ProductID)
			FROM
			DocUnpackProducts a
			JOIN
			DocUnpackWithdrawals b ON a.DocID = b.DocID
			JOIN
			DocWithdrawalProducts c ON b.DocWithdrawalID = c.DocID
			JOIN
			DocProductionProducts d ON c.ProductID = d.ProductID
			JOIN
			vGroupPackSpools e ON e.ProductGroupPackID = d.ProductID
			JOIN
			Docs f ON f.DocID = a.DocID AND f.Date < @Date
			WHERE a.ProductID = @ProductID AND a.DocID = @DocID
			GROUP BY d.Quantity, e.ProductGroupPackID
		END
		ELSE IF @DocTypeID = 7
		BEGIN
			SELECT @Weight = @Weight - SUM(ISNULL(a.Quantity,0))
			FROM
			DocBrokeDecisionProducts a
			WHERE 
			a.ProductID = @ProductID AND a.DocID = @DocID
			AND a.StateID = 2
			GROUP BY a.ProductID
		END

		FETCH NEXT FROM QuantityCursor
		INTO @DocID, @DocTypeID
	END

	CLOSE QuantityCursor

	DEALLOCATE QuantityCursor

	RETURN @Weight
	
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CalculateSpoolWeightBeforeDate] TO [PalletRepacker]
    AS [dbo];

