-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetProductNomenclatureNameBeforeDate]
(
	@ProductID uniqueidentifier,
	@Date DateTime2
)
RETURNS VARCHAR(1000)
AS
BEGIN
	DECLARE @NomenclatureName VARCHAR(1000)
	
	SELECT @NomenclatureName = b.Name + ' ' + c.Name
	FROM
	(
		SELECT ISNULL(b.[1CNomenclatureID], c.[1CNomenclatureID]) AS [1CNomenclatureID],
			ISNULL(b.[1CCharacteristicID], c.[1CCharacteristicID]) AS [1CCharacteristicID]
		FROM 
		vProductsInfo pi
		LEFT JOIN
		(
			SELECT TOP 1 dbdp.ProductID, dbdp.[1CNomenclatureID], dbdp.[1CCharacteristicID]
			FROM
			DocBrokeDecisionProducts dbdp
			JOIN
			Docs d ON dbdp.DocID = d.DocID AND d.Date < @Date
			WHERE dbdp.ProductID = @ProductID AND dbdp.[1CNomenclatureID] IS NOT NULL
			ORDER BY d.Date DESC
		) b ON pi.ProductID = b.ProductID
		JOIN
		DocProductionProducts c ON pi.ProductID = c.ProductID
		WHERE pi.ProductID = @ProductID
	) a
	JOIN
	[1CNomenclature] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID]
	JOIN
	[1CCharacteristics] c ON a.[1CCharacteristicID] = c.[1CCharacteristicID]

	RETURN @NomenclatureName

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetProductNomenclatureNameBeforeDate] TO [PalletRepacker]
    AS [dbo];

