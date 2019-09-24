
-- =============================================
-- Author:		<Matvey Polidanov>
-- Create date: <2015-30-11>
-- Description:	<Выгрузка сменного рапорта для 1С>
-- =============================================

--exec UploadDocCloseShiftReportTo1C '58FB5B5F-ED20-E811-976E-00167653FD09'
CREATE PROCEDURE [dbo].[UploadDocCloseShiftReportTo1C] 
	-- Add the parameters for the stored procedure here
	(
		@DocID uniqueidentifier
		, @IsPreviousDocClose bit = 0
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @PlaceGroupID int
	DECLARE @WithdrawalIds TABLE (DocID uniqueidentifier)
	DECLARE @IsFinal bit = 1
	
	SELECT @PlaceGroupID = b.PlaceGroupID
	FROM
	Docs a
	JOIN
	Places b ON a.PlaceID = b.PlaceID
	WHERE a.DocTypeID = 3 AND a.DocID = @DocID

	IF @PlaceGroupID IN (0,2,1) -- БМ, конвертинги, ПРС
	BEGIN
		IF NOT EXISTS (SELECT * FROM server1c.gamma.dbo.GammaDocShiftReport WHERE DocID = @DocID)
		BEGIN
			------- Заполнение шапки
			INSERT INTO server1c.gamma.dbo.GammaDocShiftReport (DocID, _1S_IDRRef_Unit, _1S_IDRRef_Shift, GammaDate, DocVersion, DocDate)
			SELECT a.DocID, b.[1CPlaceID], c.[1CShiftID], dbo.GetShiftBeginTime(DATEADD(hour, -1, a.Date)), newid(), a.[Date]
			FROM
			Docs a
			JOIN
			Places b ON a.PlaceID = b.PlaceID
			JOIN
			Shifts c ON a.ShiftID = c.ShiftID			
			WHERE DocID = @DocID
		END
		ELSE 
		BEGIN
			UPDATE SERVER1C.gamma.dbo.GammaDocShiftReport SET DocVersion = NEWID()
			WHERE DocID = @DocID
		END

		IF @PlaceGroupID = 1 
			SELECT @IsFinal = CASE WHEN COUNT(*)>0 THEN 0 ELSE 1 END 
				FROM 
					DocCloseShiftDocs a
					JOIN
					DocProductionProducts b ON a.DocID = b.DocID
				WHERE a.DocCloseShiftID = @DocID AND b.Quantity < 0.01
		
		UPDATE SERVER1C.gamma.dbo.GammaDocShiftReport SET IsFinal = @IsFinal
			WHERE DocID = @DocID

		---- заполнение приходной табличной части
		DELETE server1c.gamma.dbo.GammaDocShiftReportProduction WHERE DocID = @DocID;

		WITH NomenclatureQuantity ([1CNomenclatureID], [1CCharacteristicID], Quantity, BrokeQuantity, IsSample)
		AS 
		(
			--SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.Quantity + ISNULL(b.Quantity,0) AS Quantity, a.BrokeQuantity, a.IsSample
			--FROM
			--(
				SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], SUM(a.Quantity) AS Quantity, SUM(a.BrokeQuantity) AS BrokeQuantity, 0 AS IsSample
				FROM
				(
					SELECT b.[1CNomenclatureID], b.[1CCharacteristicID], SUM(a.Quantity) AS Quantity, SUM(a.BrokeQuantity) AS BrokeQuantity
					FROM
					(
						SELECT a.ProductID, a.ProductionQuantity - SUM(ISNULL(b.Quantity,0)) AS Quantity, SUM(ISNULL(b.Quantity,0)) AS BrokeQuantity
						FROM
						(
							SELECT b.ProductID, b.Quantity AS ProductionQuantity, ROW_NUMBER() OVER (PARTITION BY b.ProductID ORDER BY b.ProductID, c.Date DESC) AS Row, 
							c.DocID AS DocBrokeID
							FROM
							DocCloseShiftDocs a
							JOIN
							DocProductionProducts b ON a.DocID = b.DocID
							LEFT JOIN
							vDocProducts c ON b.ProductID = c.ProductID AND c.DocTypeID = 7 AND c.Date < (SELECT Date FROM Docs WHERE DocID = @DocID)
							WHERE a.DocCloseShiftID = @DocID
						) a
						LEFT JOIN
						DocBrokeDecisionProducts b ON a.DocBrokeID = b.DocID AND b.StateID > 0 AND a.ProductID = b.ProductID
						WHERE
						a.Row = 1
						GROUP BY a.ProductID, a.ProductionQuantity
					) a
					JOIN
					vProductsInfo b ON a.ProductID = b.ProductID
					GROUP BY b.[1CNomenclatureID], b.[1CCharacteristicID]

					UNION ALL

					--- Остаток с предыдущей смены 
					SELECT c.[1CNomenclatureID], c.[1CCharacteristicID], 
						CASE
							WHEN @PlaceGroupID = 0 THEN -b.Quantity/1000
							ELSE -b.Quantity
						END AS Quantity, 0 AS BrokeQuantity
					FROM
					(
						SELECT TOP 1 b.ProductID
						FROM
						DocCloseShiftDocs a
						JOIN
						DocProductionProducts b ON a.DocID = b.DocID
						JOIN
						Docs c ON a.DocID = c.DocID
						WHERE a.DocCloseShiftID = @DocID --AND @PlaceGroupID = 0 -- БДМ
						ORDER BY c.Date
					) a
					JOIN
					DocCloseShiftRemainders b ON a.ProductID = b.ProductID AND (b.IsSourceProduct IS NULL OR b.IsSourceProduct = 0) AND ISNULL(b.RemainderTypeID,0) = 0
					JOIN
					vProductsInfo c ON a.ProductID = c.ProductID

					UNION ALL

					--- Переходящий остаток (передано следующей смене)
					SELECT b.[1CNomenclatureID], b.[1CCharacteristicID], 
						CASE
							WHEN @PlaceGroupID = 0 THEN a.Quantity/1000
							ELSE a.Quantity
						END AS Quantity
						, 0 AS BrokeQuantity
					FROM 
					DocCloseShiftRemainders a
					JOIN
					vProductsInfo b ON b.ProductID = a.ProductID
					JOIN
					[1CCharacteristics] c ON b.[1CCharacteristicID] = c.[1CCharacteristicID]			
					WHERE a.DocID = @DocID  -- AND @PlaceGroupID = 0 -- БДМ
					AND (a.IsSourceProduct IS NULL OR a.IsSourceProduct = 0)
					AND ISNULL(a.RemainderTypeID,0) = 0
					UNION ALL
					--- Остатки от переходов (конвертинги)
					SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.Quantity, 0 AS BrokeQuantity
					FROM
					DocCloseShiftNomenclatureRests a					
					WHERE a.DocID = @DocID
				) a
				GROUP BY a.[1CNomenclatureID], a.[1CCharacteristicID]
				UNION ALL
				--- Отобраные образцы
				SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], SUM(a.Quantity*b.Coefficient) AS Quantity, 0 AS BrokeQuantity, 1 AS IsSample
				FROM
				DocCloseShiftSamples a
				JOIN
				[1CMeasureUnits] b ON a.[1CMeasureUnitID] = b.[1CMeasureUnitID]
				WHERE a.DocID = @DocID
				GROUP BY a.[1CNomenclatureID], a.[1CCharacteristicID]
			--) a
			--LEFT JOIN
			--(
			--	SELECT a.[1CNomenclatureID], a.[1CCharacteristicID], a.Quantity
			--	FROM
			--	DocCloseShiftNomenclatureRests a
			--	WHERE a.DocID = @DocID
			--) b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID] AND a.IsSample  = 0
		) 
		
		INSERT INTO server1c.gamma.dbo.GammaDocShiftReportProduction (DocID, _1S_IDRRef_Nomenkl, _1S_IDRRef_CharNomenkl, Amount, _1S_IDRRef_Quality, IsSample)
		SELECT @DocID AS DocID, [1CNomenclatureID], [1CCharacteristicID], Quantity AS Amount
		, 'D05404A0-6BCE-449B-A798-41EBE5E5B977' AS Quality --- Годная
		, IsSample
		FROM
		NomenclatureQuantity WHERE Quantity IS NOT NULL AND Quantity > 0

		UNION ALL

		SELECT @DocID AS DocID, [1CNomenclatureID], [1CCharacteristicID], BrokeQuantity AS Amount
		, '4B4E7DD3-DDB4-437D-BB0D-37A31217AF4B' AS Quality --- Требует решения
		, IsSample
		FROM
		NomenclatureQuantity WHERE BrokeQuantity IS NOT NULL AND BrokeQuantity > 0

		---- заполнение расходной табличной части
		
		DELETE server1c.gamma.dbo.GammaDocShiftReportWithdrawal WHERE DocID = @DocID

		INSERT INTO @WithdrawalIds (DocID)
				SELECT DocID 
				FROM
				DocCloseShiftDocs
				WHERE DocCloseShiftID = @DocID
				UNION
				SELECT DocWithdrawalID AS DocID
				FROM
				DocCloseShiftWithdrawals 
				WHERE DocCloseShiftID = @DocID
				UNION
				SELECT DocWithdrawalID AS DocID
				FROM
				DocCloseShiftRemainders 
				WHERE DocID = @DocID 
					AND IsSourceProduct = 1
					AND DocWithdrawalID IS NOT NULL

		
		INSERT INTO server1c.gamma.dbo.GammaDocShiftReportWithdrawal (DocID, [_1S_IDRRef_Nomenkl], [_1S_IDRRef_CharNomenkl], Amount)
		SELECT @DocID AS DocID, a.[1CNomenclatureID], a.[1CCharacteristicID], SUM(Quantity) AS Amount
		FROM
		(
			SELECT c.[1CNomenclatureID], c.[1CCharacteristicID], ISNULL(b.Quantity,0) AS Quantity
			FROM
			@WithdrawalIds a
			JOIN
			DocWithdrawalProducts b ON a.DocID = b.DocID
			JOIN
			vProductsInfo c ON b.ProductID = c.ProductID
			WHERE b.Quantity > 0
			UNION ALL
			SELECT b.[1CNomenclatureID], b.[1CCharacteristicID], b.Quantity
			FROM
			@WithdrawalIds a
			JOIN
			DocWithdrawalMaterials b ON a.DocID = b.DocID
			WHERE b.Quantity > 0
		) a
		GROUP BY a.[1CNomenclatureID], a.[1CCharacteristicID]
		
		---- заполнение табличной части отходов
		
		DELETE server1c.gamma.dbo.GammaDocShiftReportWastest WHERE DocID = @DocID

		INSERT INTO server1c.gamma.dbo.GammaDocShiftReportWastest (DocID, [_1S_IDRRef_Nomenkl], [_1S_IDRRef_CharNomenkl], Amount, [_1S_IDRRef_MeasureUnits])
			SELECT a.DocID, a.[1CNomenclatureID], a.[1CCharacteristicID], SUM(a.Quantity) AS Quantity, a.[1CMeasureUnitID]
				FROM DocCloseShiftWastes a
				WHERE a.DocID = @DocID AND a.Quantity > 0
				GROUP BY a.DocID, a.[1CNomenclatureID], a.[1CCharacteristicID], a.[1CMeasureUnitID]
		
		IF @PlaceGroupID = 1 AND @IsPreviousDocClose = 0
		BEGIN
			DECLARE @DocCloseIsFinalID uniqueidentifier
			DECLARE DocClose_cursor CURSOR FOR
				SELECT a.DocID 
				FROM Docs a JOIN Places p ON a.PlaceID = p.PlaceID
					JOIN Docs b ON a.DocTypeID = 3 AND P.PlaceGroupID = 3 AND a.IsConfirmed = 1 AND b.DocID = @DocID AND a.Date BETWEEN [dbo].[GetShiftBeginTime](b.Date) AND [dbo].[GetShiftEndTime](b.Date)
					JOIN DocCloseShiftDocs c ON a.DocID = c.DocCloseShiftID
					JOIN Docs cd ON c.DocID = cd.DocID AND cd.DocTypeID = 0
					JOIN DocProductionProducts d ON d.DocID = cd.DocID
					JOIN DocProductionWithdrawals e ON e.DocProductionID = d.DocID
					JOIN DocWithdrawalProducts f ON f.DocID = e.DocWithdrawalID
					JOIN ProductSpools g ON f.ProductID = g.ProductID
					JOIN DocCloseShiftProducts h ON g.ProductID = h.ProductID 
					JOIN Docs i ON i.DocID = h.DocID AND i.Date < [dbo].[GetShiftBeginTime](b.Date)
					JOIN Places j ON i.PlaceID = j.PlaceID AND j.PlaceGroupID = 1
					JOIN SERVER1C.gamma.dbo.GammaDocShiftReport k ON i.DocID = k.DocID AND k.IsFinal = 0
			
			OPEN DocClose_cursor  

			FETCH NEXT FROM DocClose_cursor   
			INTO @DocCloseIsFinalID  

			WHILE @@FETCH_STATUS = 0  
			BEGIN  
				EXEC [UploadDocCloseShiftReportTo1C] @DocCloseIsFinalID, 1
			    FETCH NEXT FROM DocClose_cursor   
				INTO @DocCloseIsFinalID  
			END   
			CLOSE DocClose_cursor;  
			DEALLOCATE DocClose_cursor;  
		
		
		END
	END

END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[UploadDocCloseShiftReportTo1C] TO [PalletRepacker]
    AS [dbo];

