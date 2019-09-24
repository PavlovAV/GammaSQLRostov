

CREATE PROCEDURE [dbo].[UnpackGroupPack] 
	-- Add the parameters for the stored procedure here
	(
		@ProductID uniqueidentifier,
		@PrintName varchar(255)
	)
AS
BEGIN

	DECLARE @UserID uniqueidentifier, @PlaceID int, @ShiftID int
	DECLARE @DocWithdrawalTbl TABLE (DocID uniqueidentifier)
	DECLARE @DocUnpackTbl TABLE (DocID uniqueidentifier)
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 1 @UserID = a.UserID, @PlaceID = b.PlaceID, @ShiftID = a.ShiftID
	FROM
	Users a
	JOIN
	UserPlaces b ON a.UserID = b.UserID
	WHERE a.UserID = dbo.CurrentUserID()

	IF EXISTS 
	(SELECT * FROM 
		ProductGroupPacks a
		JOIN 
		Rests b ON a.ProductID = b.ProductID 
		WHERE a.ProductID = @ProductID AND b.Quantity > 0)
	BEGIN
		BEGIN TRANSACTION unpack
			
			--- Заполнение приходной части
			INSERT INTO Docs (DocTypeID, IsConfirmed, UserID, PrintName, PlaceID, ShiftID, IsFromOldGamma)
			OUTPUT INSERTED.DocID INTO @DocUnpackTbl
			VALUES (6, 1, @UserID, @PrintName, @PlaceID, @ShiftID, 0)

			INSERT INTO DocUnpackProducts (DocID, ProductID)
			SELECT a.DocID, b.ProductID
			FROM @DocUnpackTbl a,
			(
				SELECT ProductID FROM vGroupPackSpools WHERE ProductGroupPackID = @ProductID
			) b

			--- Восстановление веса рулонов, диаметра и длины
			UPDATE a SET a.DecimalWeight = b.Weight, a.CurrentLength = a.Length*b.WeightCoefficient,
				a.CurrentDiameter = sqrt(b.WeightCoefficient*a.Diameter*a.Diameter 
					+ (1-b.WeightCoefficient)*ISNULL(c.CoreDiameterNumeric,0)*ISNULL(c.CoreDiameterNumeric,0))
			FROM
			ProductSpools a
			JOIN
			(
				SELECT a.ProductID, ISNULL(b.Quantity,dbo.CalculateSpoolWeightBeforeDate(a.ProductID, c.Date)) AS Weight, 
					c.Date, ROW_NUMBER() OVER (PARTITION BY a.ProductID ORDER BY c.DATE DESC) AS ln,
					CASE
						WHEN ISNULL(d.Quantity, ISNULL(b.Quantity,dbo.CalculateSpoolWeightBeforeDate(a.ProductID, c.Date))) > 0
							THEN ISNULL(b.Quantity,dbo.CalculateSpoolWeightBeforeDate(a.ProductID, c.Date))/
								ISNULL(d.Quantity, ISNULL(b.Quantity,dbo.CalculateSpoolWeightBeforeDate(a.ProductID, c.Date)))
						ELSE 1
					END AS WeightCoefficient
				FROM
				vGroupPackSpools a
				JOIN
				DocWithdrawalProducts b ON a.ProductID = b.ProductID
				JOIN
				Docs c ON b.DocID = c.DocID
				JOIN
				DocProductionProducts d ON d.ProductID = b.ProductID
				WHERE a.ProductGroupPackID = @ProductID
			) b ON a.ProductID = b.ProductID AND b.ln = 1
			JOIN
			vCharacteristicSGBProperties c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]
			
			--- Заполнение расходной части
			INSERT INTO Docs (DocTypeID, IsConfirmed, UserID, PrintName, PlaceID, ShiftID, IsFromOldGamma)
			OUTPUT INSERTED.DocID INTO @DocWithdrawalTbl
			VALUES (1, 1, @UserID, @PrintName, @PlaceID, @ShiftID, 0)

			INSERT INTO DocWithdrawal (DocID, OutPlaceID)
			SELECT DocID, @PlaceID
			FROM @DocWithdrawalTbl

			DECLARE @Weight decimal(10,4)
			SELECT @Weight = Weight FROM ProductGroupPacks WHERE ProductID = @ProductID

			INSERT INTO DocWithdrawalProducts (DocID, ProductID, Quantity, CompleteWithdrawal)
			SELECT DocID, @ProductID, @Weight, 1
			FROM @DocWithdrawalTbl 

			--- Связывание документов
			INSERT INTO DocUnpackWithdrawals (DocID, DocWithdrawalID)
			SELECT a.DocID, b.DocID
			FROM @DocUnpackTbl a, @DocWithdrawalTbl b

			--затычка чтобы удалить с остатков распакованную ГУ
			UPDATE Rests SET Quantity = 0 WHERE ProductID = @ProductID AND Quantity > 0

		COMMIT TRANSACTION unpack
	END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UnpackGroupPack] TO [PalletRepacker]
    AS [dbo];

