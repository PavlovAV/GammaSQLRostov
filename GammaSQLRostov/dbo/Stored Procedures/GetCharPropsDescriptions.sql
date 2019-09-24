-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetCharPropsDescriptions] 
	-- Add the parameters for the stored procedure here
	(
		@CharacteristicID uniqueidentifier
	)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	SELECT * FROM
(
SELECT 
a.[1CCharacteristicID],
CASE 
WHEN a.[1CPropertyID] = 'CE8FCC34-C32D-11E0-9D44-0019DB5E4B19' THEN 'CoreDiameter'
WHEN a.[1CPropertyID] = 'CE8FCC35-C32D-11E0-9D44-0019DB5E4B19' THEN 'LayerNumber'
WHEN a.[1CPropertyID] = '96CEC7F9-6B45-11E1-8280-002590304E93' THEN 'Diameter'
WHEN a.[1CPropertyID] = '97654DB4-8F2D-11E3-B394-002590304E93' THEN 'Destination'
WHEN a.[1CPropertyID] = '0B782685-C3A2-11E3-B873-002590304E93' THEN 'Format'
WHEN a.[1CPropertyID] = '13EE192E-AFBC-11E0-9B2F-4061861FE1EF' THEN 'Color'
END AS ColumnName
, c.Description
FROM
[1CCharacteristicProperties] a
JOIN
[1CProperties] b ON a.[1CPropertyID] = b.[1CPropertyID]
JOIN
[1CPropertyValues] c ON a.[1CPropertyValueID] = c.[1CPropertyValueID]
WHERE a.[1CCharacteristicID] = @CharacteristicID AND
a.[1CPropertyID] IN
('CE8FCC34-C32D-11E0-9D44-0019DB5E4B19',
'CE8FCC35-C32D-11E0-9D44-0019DB5E4B19',
'96CEC7F9-6B45-11E1-8280-002590304E93',
'97654DB4-8F2D-11E3-B394-002590304E93',
'0B782685-C3A2-11E3-B873-002590304E93',
'13EE192E-AFBC-11E0-9B2F-4061861FE1EF')) a
PIVOT
(MAX(Description) FOR ColumnName IN ([CoreDiameter],[LayerNumber],[Diameter],[Destination],[Format],[Color])) piv
     
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetCharPropsDescriptions] TO [PalletRepacker]
    AS [dbo];

