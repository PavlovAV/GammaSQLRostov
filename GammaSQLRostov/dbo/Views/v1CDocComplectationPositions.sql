

CREATE VIEW [dbo].[v1CDocComplectationPositions]
AS

SELECT a.[1CDocComplectationID], e.FullName AS Nomenclature, oldc.Name AS OldCharacteristic,
 newc.Name AS NewCharacteristic, b.Quantity AS DocQuantity, d.Withdraw, c.Complected
FROM
[1CDocComplectation] a
JOIN
[1CDocComplectationNomenclature] b ON a.[1CDocComplectationID] = b.[1CDocComplectationID]
LEFT JOIN
(
	SELECT a.[1CDocComplectationID], c.[1CNomenclatureID], c.[1CCharacteristicID], SUM(c.Quantity) AS Complected
	FROM
	DocComplectation a
	JOIN
	DocComplectationProductions b ON a.DocComplectationID = b.DocComplectationID
	JOIN
	DocProductionProducts c ON b.DocProductionID = c.DocID
	GROUP BY a.[1CDocComplectationID], c.[1CNomenclatureID], c.[1CCharacteristicID]
) c ON a.[1CDocComplectationID] = c.[1CDocComplectationID] AND b.[1CNomenclatureID] = c.[1CNomenclatureID] AND b.[1CNewCharacteristicID] = c.[1CCharacteristicID]
LEFT JOIN
(
	SELECT a.[1CDocComplectationID], d.[1CNomenclatureID], d.[1CCharacteristicID], SUM(ISNULL(c.Quantity,0)) AS Withdraw
	FROM
	DocComplectation a
	JOIN
	DocComplectationWithdrawals b ON a.DocComplectationID = b.DocComplectationID
	JOIN
	DocWithdrawalProducts c ON b.DocWithdrawalID = c.DocID
	JOIN
	vProductsBaseInfo d ON c.ProductID = d.ProductID
	GROUP BY a.[1CDocComplectationID], d.[1CNomenclatureID], d.[1CCharacteristicID]
) d ON a.[1CDocComplectationID] = d.[1CDocComplectationID] AND b.[1CNomenclatureID] = c.[1CNomenclatureID] AND b.[1COldCharacteristicID] = c.[1CCharacteristicID]
JOIN
[1CNomenclature] e ON b.[1CNomenclatureID] = e.[1CNomenclatureID]
JOIN
[1CCharacteristics] oldc ON b.[1COldCharacteristicID] = oldc.[1CCharacteristicID]
JOIN
[1CCharacteristics] newc ON b.[1CNewCharacteristicID] = newc.[1CCharacteristicID]





GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CDocComplectationPositions] TO [PalletRepacker]
    AS [dbo];

