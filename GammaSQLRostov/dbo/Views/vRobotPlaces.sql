
CREATE VIEW [dbo].[vRobotPlaces]
AS 
SELECT a.*, ISNULL(b.[Name],'') AS PlaceName
FROM
(
	SELECT 251 AS RobotLineID, 102 AS PlaceID -- FabioPerini
	UNION ALL
	SELECT 261 AS RobotLineID, 101 AS PlaceID -- IDEA
	UNION ALL
	SELECT 272 AS RobotLineID, 100 AS PlaceID -- MTC V
	UNION ALL
	SELECT 271 AS RobotLineID, 100 AS PlaceID -- MTC Z
) a 
LEFT JOIN Places b ON a.PlaceID = b.PlaceID

GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vRobotPlaces] TO [PalletRepacker]
    AS [dbo];

