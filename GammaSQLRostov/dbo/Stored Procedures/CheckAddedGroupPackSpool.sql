-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CheckAddedGroupPackSpool] 
	-- Add the parameters for the stored procedure here
	(
		@AddedProductId uniqueidentifier,
		@BaseProductId uniqueidentifier
	)
AS
BEGIN

	DECLARE @Result varchar(2000)

	SET @Result = ''

	IF NOT EXISTS 
	(
		SELECT *
		FROM
		ProductSpools a
		JOIN
		ProductSpools b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] = b.[1CCharacteristicID]
			AND b.ProductID = @AddedProductId
		WHERE a.ProductID = @BaseProductID
	)
	BEGIN
		SET @Result = @Result + CHAR(10) + CHAR(13) + 'Номенклатура добавляемого рулона не совпадает с другими'
	END

	IF NOT EXISTS
	(
		SELECT *
		FROM
		Products a
		JOIN
		Products b ON ((a.StateID IS NULL AND b.StateID IS NULL) OR a.StateID = b.StateID) AND b.ProductID = @AddedProductId
		WHERE a.ProductID = @BaseProductID
	)
	BEGIN
		SET @Result = @Result + CHAR(10) + CHAR(13) + 'Нельзя смешивать в упаковке рулоны с разным назначением (например годные и огр. партия)'
	END

	IF EXISTS 
	(
		SELECT * FROM Products WHERE ProductID = @AddedProductID AND StateID IN (1,2)
	)
	BEGIN
		SET @Result = @Result + CHAR(10) + CHAR(13) + 'Вы пытаетесь запаковать рулон требующий решения'
	END

	SELECT @Result

END
GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[CheckAddedGroupPackSpool] TO [PalletRepacker]
    AS [dbo];

