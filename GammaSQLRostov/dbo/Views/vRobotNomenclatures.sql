








--Роботы есть тоько в Ростове, в Сыктывкаре должн овозвращать пустую таблицу.
--В Ростове view с данными

CREATE VIEW [dbo].[vRobotNomenclatures]
AS
SELECT * 
	FROM 
	(VALUES
	(CAST(1 as int), CAST('Туалетная бумага VEIRO Floria,сароматом ландыш. Европоддон 32 шт по 48 рулонов' as nvarchar(255)),CAST('14607075791104' as nvarchar(50)), CAST(251 as int), CAST(102 as int), CAST('FABIO PERINI' as varchar(64)), CAST('FABIO PERINI/4С24А2/Туалетная бумага VEIRO Floria,сароматом ландыш. Европоддон 32 шт по 48 рулонов/14607075791104/1' as nvarchar(500)))
	,(CAST(2 as int), CAST('Туалетная бумага многослойная VEIRO Classic.      Европоддон 32 упак. по 48 рулонов.' as nvarchar(255)),CAST('24607075791040' as nvarchar(50)), CAST(251 as int), CAST(102 as int), CAST('FABIO PERINI' as varchar(64)), CAST('FABIO PERINI/5C24/Туалетная бумага многослойная VEIRO Classic.      Европоддон 32 упак. по 48 рулонов./24607075791040/2' as nvarchar(500)))
	,(CAST(3 as int), CAST('Бумага туалетная многослойная VEIRO Floria артикул 4С24А5 Европоддон 32 шт. по 48 рулонов' as nvarchar(255)),CAST('14607075792668' as nvarchar(50)), CAST(251 as int), CAST(102 as int), CAST('FABIO PERINI' as varchar(64)), CAST('FABIO PERINI/4С24А5/Бумага туалетная многослойная VEIRO Floria артикул 4С24А5 Европоддон 32 шт. по 48 рулонов/14607075792668/3' as nvarchar(500)))
	,(CAST(35 as int), CAST('Полотенца бумажные многослойные Veiro артикул 5п22   Европоддон 40 шт. по 24 рулона.  ***' as nvarchar(255)),CAST('14607075791050' as nvarchar(50)), CAST(261 as int), CAST(101 as int), CAST('IDEA' as varchar(64)), CAST('IDEA/5П22/Полотенца бумажные многослойные Veiro артикул 5п22   Европоддон 40 шт. по 24 рулона.  ***/14607075791050/35' as nvarchar(500)))
	,(CAST(36 as int), CAST('Туалетная бумага многослойная, Veiro Luxoria,' as nvarchar(255)),CAST(' ' as nvarchar(50)), CAST(261 as int), CAST(101 as int), CAST('IDEA' as varchar(64)), CAST('IDEA/5С34/Туалетная бумага многослойная, Veiro Luxoria,//36' as nvarchar(500)))
	,(CAST(52 as int), CAST('Туалетная бумага в больших рулонах Veiro Professional Basic европоддон 55шт. по6 рул.' as nvarchar(255)),CAST('54607075796862' as nvarchar(50)), CAST(261 as int), CAST(101 as int), CAST('IDEA' as varchar(64)), CAST('IDEA/T101/Туалетная бумага в больших рулонах Veiro Professional Basic европоддон 55шт. по6 рул./54607075796862/52' as nvarchar(500)))
	,(CAST(54 as int), CAST('Туалетная бумага в рулонах Veiro Professional         Basic. Европоддон 44шт. по 12 рулонов' as nvarchar(255)),CAST('14607075796888' as nvarchar(50)), CAST(261 as int), CAST(101 as int), CAST('IDEA' as varchar(64)), CAST('IDEA/T102/Туалетная бумага в рулонах Veiro Professional         Basic. Европоддон 44шт. по 12 рулонов/14607075796888/54' as nvarchar(500)))
	,(CAST(95 as int), CAST('Туалетная бумага V-сложение Veiro Professional Comfort. Европоддон 16 упак. по 30 пачек' as nvarchar(255)),CAST('14607075796116' as nvarchar(50)), CAST(272 as int), CAST(100 as int), CAST('MTC' as varchar(64)), CAST('MTC/TV201/Туалетная бумага V-сложение Veiro Professional Comfort. Европоддон 16 упак. по 30 пачек/14607075796116/95' as nvarchar(500)))
	,(CAST(96 as int), CAST('Туалетная бумага V-сложение Veiro Professional Comfort. Европоддон 40 упак. по 30 пачек' as nvarchar(255)),CAST('24607075796649' as nvarchar(50)), CAST(272 as int), CAST(100 as int), CAST('MTC' as varchar(64)), CAST('MTC/TV201/Туалетная бумага V-сложение Veiro Professional Comfort. Европоддон 40 упак. по 30 пачек/24607075796649/96' as nvarchar(500)))
	,(CAST(99 as int), CAST('Полотенца для рук Z-сложение, 1 слой, 40 шт. по 21 пачке' as nvarchar(255)),CAST('14670024930749' as nvarchar(50)), CAST(272 as int), CAST(100 as int), CAST('MTC' as varchar(64)), CAST('MTC/Z2-200/Полотенца для рук Z-сложение, 1 слой, 40 шт. по 21 пачке/14670024930749/99' as nvarchar(500)))
	,(CAST(100 as int), CAST('Полотенца для рук V-сложение Veiro Professional Basic. Европоддон 40 упак. по 15 пачек' as nvarchar(255)),CAST('14607075796741' as nvarchar(50)), CAST(272 as int), CAST(100 as int), CAST('MTC' as varchar(64)), CAST('MTC/KV104/Полотенца для рук V-сложение Veiro Professional Basic. Европоддон 40 упак. по 15 пачек/14607075796741/100' as nvarchar(500)))
	) 
  AS sp([ProdNumber], [ProdDescription], [EANFullPallet], [ProductionLine], [PlaceID], [PlaceName], [ProdName]) 

--SELECT [ProdNumber]
--      ,[ProdDescription]
--      ,[EANFullPallet]
--      ,[ProductionLine]
--      ,[PlaceID]
--      ,[PlaceName]
--      ,[ProdName]
--  FROM [gamma-server-rostov].[GammaNew].[dbo].[vRobotNomenclatures]

GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotNomenclatures] TO [PalletRepacker]
    AS [dbo];

