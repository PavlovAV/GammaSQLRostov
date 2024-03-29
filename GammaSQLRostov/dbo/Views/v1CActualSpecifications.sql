﻿












CREATE VIEW [dbo].[v1CActualSpecifications]
AS
--ОсновныеСпецификацииНоменклатуры Срез последних
SELECT 
	MS.Period,
	MS.[1CNomenclatureID],
	MS.[1CCharacteristicID],
	MS.[1CPlaceID],
	MS.[1CSpecificationID],
	S.ValidTill
FROM [1CMainSpecifications] AS MS
INNER JOIN (SELECT 
	MAX(i.Period) AS Period,
	i.[1CNomenclatureID],
	i.[1CCharacteristicID],
	i.[1CPlaceID]
FROM [1CMainSpecifications] i
GROUP BY i.[1CNomenclatureID], i.[1CCharacteristicID], i.[1CPlaceID]) AS MP 
ON 
	MP.Period = MS.Period 
	AND MP.[1CNomenclatureID] = MS.[1CNomenclatureID]
	AND (MP.[1CCharacteristicID] = MS.[1CCharacteristicID] OR (MP.[1CCharacteristicID] IS NULL AND MS.[1CCharacteristicID] IS NULL))
	AND (MP.[1CPlaceID] = MS.[1CPlaceID] OR (MP.[1CPlaceID] IS NULL AND MS.[1CPlaceID] IS NULL))
LEFT JOIN
	(Places e JOIN LocalSettings f ON e.BranchID = f.BranchID) ON MS.[1CPlaceID] = e.[1CPlaceID]
LEFT JOIN 
	[1CSpecifications] s ON MS.[1CSpecificationID] = s.[1CSpecificationID]
WHERE --MS.[1CSpecificationID] IS NULL
	MS.[1CPlaceID] IS NULL OR 
	e.[1CPlaceID] IS NOT NULL
/*
SELECT DISTINCT Period, [1CNomenclatureID], [1CCharacteristicID], [1CSpecificationID], [1CPlaceID]
FROM 
(
	SELECT a.Period, a.[1CNomenclatureID], ISNULL(a.[1CCharacteristicID], b.[1CCharacteristicID]) AS [1CCharacteristicID], [1CPlaceID],
		a.[1CSpecificationID]
	FROM
	dbo.[1CMainSpecifications] a
	LEFT JOIN
	[1CCharacteristics] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] IS NULL
	WHERE 
	[1CPlaceID] IS NOT NULL
) AS a
WHERE a.Period = 
(SELECT MAX(Period) FROM 
(
	SELECT a.Period, a.[1CNomenclatureID], ISNULL(a.[1CCharacteristicID], b.[1CCharacteristicID]) AS [1CCharacteristicID], [1CPlaceID]
	FROM
	dbo.[1CMainSpecifications] a
	LEFT JOIN
	[1CCharacteristics] b ON a.[1CNomenclatureID] = b.[1CNomenclatureID] AND a.[1CCharacteristicID] IS NULL
	WHERE 
	[1CPlaceID] IS NOT NULL
) AS msp
WHERE [1CNomenclatureID] = a.[1CNomenclatureID] AND [1CPlaceID] = a.[1CPlaceID] AND [1CCharacteristicID] = a.[1CCharacteristicID])
*/









GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[v1CActualSpecifications] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane1', @value = N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "a"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 136
               Right = 228
            End
            DisplayFlags = 280
            TopColumn = 1
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 3420
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v1CActualSpecifications';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 1, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'v1CActualSpecifications';

