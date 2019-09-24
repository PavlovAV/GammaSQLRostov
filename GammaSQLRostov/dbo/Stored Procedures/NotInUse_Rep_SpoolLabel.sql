-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[NotInUse_Rep_SpoolLabel] 
	-- Add the parameters for the stored procedure here
	(
		@ParamID uniqueidentifier   -- DocID
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	/*
DECLARE @NomenclatureID uniqueidentifier, @CharacteristicID uniqueidentifier, @ProductID uniqueidentifier
SELECT TOP 1 @NomenclatureID = [1CNomenclatureID], @CharacteristicID = [1CCharacteristicID], @ProductID = a.ProductID
FROM 
[ProductSpools] a
JOIN
DocProducts b ON a.ProductID = b.ProductID
WHERE b.DocID = @ParamID

SELECT 'Бумага-основа ' + f.Description AS Name, d.ValueNumeric AS BasisWeight, 
RIGHT(e.Description, 2) AS Whiteness, e.Description AS Article, g.Description AS RawMaterial,
a.RealFormat, a.Diameter, a.Weight, a.Length, a.BreakNumber, h.Number, h.Barcode, o.PrintName,
--CASE
--WHEN o.PlaceID IN (1,2) THEN 305
--ELSE 
k.ValueNumeric
--END 
AS CoreDiameter,
--CASE
--WHEN o.PlaceID IN (1,2) THEN 1
--ELSE 
l.ValueNumeric 
--END 
AS LayerNumber,
m.Description AS Color, o.Date, p.Name AS Place,
CASE
	WHEN c.Description LIKE '%товарная%' THEN 'ТОВАРНАЯ'
--	WHEN f.Description LIKE '%салф%' THEN 'НА ПРС'
	WHEN q.Description LIKE '<>' THEN ''
	ELSE q.Description
END AS Destination,
CASE
	WHEN f.Description LIKE '%мног%салф%' THEN 'БОСмн'
	WHEN f.Description LIKE '%салф%' THEN 'БОС'
	WHEN f.Description LIKE '%влаг%полот%' THEN 'БОПвл'
	WHEN f.Description LIKE '%полот%' THEN 'БОП'
	WHEN f.Description LIKE '%туалет%' THEN 'БОТ'
	WHEN f.Description LIKE '%индустр%' THEN 'БИ'
	ELSE ''
END AS PurposeArticle,
vpi.RejectionReason, 
CASE
WHEN vpi.ChangeStateQuantity IS NOT NULL AND vpi.ChangeStateQuantity < a.Weight AND vpi.ChangeStateQuantity > 0 
AND r.StateID > 0 
THEN r.Name + ': ' + CAST(CAST(vpi.ChangeStateQuantity AS int) AS varchar) + ' кг'
WHEN r.StateID > 0 THEN r.Name
ELSE ''
END AS State
FROM
ProductSpools a
LEFT JOIN
[1CNomenclatureProperties] b ON b.[1CNomenclatureID] = @NomenclatureID AND b.[1CPRopertyID] = 'E677C238-CAB1-11E3-AA54-002590304E93' --наименование
LEFT JOIN
[1CPropertyValues] c ON b.[1CPropertyValueID] = c.[1CPropertyValueID]
LEFT JOIN
[1CNomenclatureProperties] bd ON bd.[1CNomenclatureID] = @NomenclatureID AND bd.[1CPropertyID] = '727C0A57-6146-11E1-B1B0-002590304E93' --граммаж
LEFT JOIN
[1CPropertyValues] d ON bd.[1CPropertyValueID] = d.[1CPropertyValueID]
LEFT JOIN
[1CNomenclatureProperties] be ON be.[1CNomenclatureID] = @NomenclatureID AND be.[1CPropertyID] = '0B78267C-C3A2-11E3-B873-002590304E93' --артикул
LEFT JOIN
[1CPropertyValues] e ON be.[1CPropertyValueID] = e.[1CPropertyValueID]
LEFT JOIN
[1CNomenclatureProperties] bf ON bf.[1CNomenclatureID] = @NomenclatureID AND bf.[1CPropertyID] = '0B782681-C3A2-11E3-B873-002590304E93' --назначение
LEFT JOIN
[1CPropertyValues] f ON bf.[1CPropertyValueID] = f.[1CPropertyValueID]
LEFT JOIN
[1CNomenclatureProperties] bg ON bg.[1CNomenclatureID] = @NomenclatureID AND bg.[1CPropertyID] = 'AEC0CBF1-E209-11E2-9775-002590304E93' --сырье
LEFT JOIN
[1CPropertyValues] g ON bg.[1CPropertyValueID] = g.[1CPropertyValueID]
JOIN
Products h ON a.ProductID = h.ProductID
LEFT JOIN
[1CCharacteristicProperties] ik ON ik.[1CCharacteristicID] = @CharacteristicID AND ik.[1CPropertyID] = 'CE8FCC34-C32D-11E0-9D44-0019DB5E4B19' --гильза
LEFT JOIN
[1CPropertyValues] k ON k.[1CPropertyValueID] = ik.[1CPropertyValueID]
LEFT JOIN
[1CCharacteristicProperties] il ON il.[1CCharacteristicID] = @CharacteristicID AND il.[1CPropertyID] = 'CE8FCC35-C32D-11E0-9D44-0019DB5E4B19' --слойность
LEFT JOIN
[1CPropertyValues] l ON l.[1CPropertyValueID] = il.[1CPropertyValueID]
LEFT JOIN
[1CCharacteristicProperties] im ON im.[1CCharacteristicID] = @CharacteristicID AND im.[1CPropertyID] = '13EE192E-AFBC-11E0-9B2F-4061861FE1EF' --цвет
LEFT JOIN
[1CPropertyValues] m ON m.[1CPropertyValueID] = im.[1CPropertyValueID]
JOIN
DocProducts n ON n.ProductID = a.ProductID
JOIN
Docs o ON o.DocID = n.DocID AND o.DocTypeID = 0
JOIN
Places p ON p.PlaceID = o.PlaceID
LEFT JOIN
[1CCharacteristicProperties] iq ON iq.[1CCharacteristicID] = @CharacteristicID AND iq.[1CPropertyID] = '97654DB4-8F2D-11E3-B394-002590304E93' --получатель
LEFT JOIN
[1CPropertyValues] q ON q.[1CPropertyValueID] = iq.[1CPropertyValueID]
LEFT JOIN
vProductsInfo vpi ON vpi.ProductID = a.ProductID
LEFT JOIN
ProductStates r ON r.StateID = vpi.StateID
WHERE a.ProductID = @ProductID
   */  
END

GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[NotInUse_Rep_SpoolLabel] TO [PalletRepacker]
    AS [dbo];

