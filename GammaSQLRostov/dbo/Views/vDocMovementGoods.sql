



CREATE VIEW [dbo].[vDocMovementGoods]
AS
SELECT DocMovementID, DocOrderID, [1CNomenclatureID], [1CCharacteristicID], [1CQualityID], NomenclatureName, 
	CASE
		WHEN IsShipped = 1 THEN SUM(ISNULL(Quantity,0))
	END AS OutQuantity,
	CASE 
		WHEN IsAccepted = 1 THEN SUM(ISNULL(Quantity,0))
	END AS InQuantity,
	CASE 
		WHEN IsConfirmed = 1 THEN SUM(ISNULL(Quantity,0))
	END AS AcceptedQuantity
	, NULL AS BreakNumber --SUM([dbo].[GetSpoolsFieldsForProduct](ProductID, 1)) AS BreakNumber
	, NULL AS CountProduct --COUNT(*) AS CountProduct
	,SUM(ISNULL(b.CountProductSpools,0)) AS CountProductSpools
	--,SUM([dbo].[GetSpoolsFieldsForProduct](a.ProductID, 2)) AS CountProductSpools
	,SUM(ISNULL(b.CountProductSpoolsWithBreak,0)) AS CountProductSpoolsWithBreak
	--,SUM([dbo].[GetSpoolsFieldsForProduct](a.ProductID, 3)) AS CountProductSpoolsWithBreak
FROM
vDocMovementProducts a
LEFT JOIN vSpoolsForProduct b ON a.ProductID = b.ProductID
GROUP BY DocMovementID, DocOrderID, [1CNOmenclatureID], [1CCharacteristicID], [1CQualityID], NomenclatureName, IsShipped, IsAccepted, IsConfirmed



GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vDocMovementGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[vDocMovementGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[vDocMovementGoods] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vDocMovementGoods] TO [PalletRepacker]
    AS [dbo];

