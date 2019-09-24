

CREATE VIEW [dbo].[vProductsInfo]
 
AS

SELECT b.DocID, a.ProductID, a.ProductKindID, a.Number, c.Date AS Date,a.BarCode, c.PrintName, a.[1CNomenclatureID],a.[1CCharacteristicID],
a.Quantity, k.Name AS BaseMeasureUnit, a.BaseMeasureUnitQuantity, ISNULL(b.Quantity,0) AS ProductionQuantity, a.GrossQuantity, a.BaseMeasureUnitGrossQuantity,
d.Name + ' ' + e.Name AS NomenclatureName, i.ShortNomenclatureName, d.[NomenclatureKindID],
g.Name AS Place,c.PlaceID,g.PlaceGroupID AS PlaceGroupID,c.ShiftID,h.StateID, h.ChangeStateQuantity, h.[1CQualityID],
h.RejectionReason, 
c.IsConfirmed AS IsConfirmed, 
h.IsWrittenOff, h.State, k.[1CMeasureUnitQualifierID] AS BaseMeasureUnitID
FROM
dbo.DocProductionProducts b
JOIN dbo.Docs c ON b.DocID = c.DocID --AND c.DocTypeID = 0
JOIN [dbo].[vProductsBaseInfo] a ON a.ProductID = b.ProductID
JOIN
dbo.[1CNomenclature] d ON a.[1CNomenclatureID] = d.[1CNomenclatureID]
LEFT JOIN
dbo.[1CCharacteristics] e ON e.[1CCharacteristicID] = a.[1CCharacteristicID]
--LEFT JOIN
--dbo.Users f ON c.UserID = f.UserID
--LEFT JOIN
--dbo.UserPlaces m ON m.UserID = f.UserID
LEFT JOIN
dbo.Places g ON g.PlaceID = c.PlaceID
JOIN
dbo.vProductsCurrentStateInfo h ON a.ProductID = h.ProductID
LEFT JOIN
dbo.vShortNomenclatureName i ON i.[1CNomenclatureID] = d.[1CNomenclatureID] AND i.[1CCharacteristicID] = e.[1CCharacteristicID]
LEFT JOIN
dbo.[1CMeasureUnitQualifiers] k ON k.[1CMeasureUnitQualifierID] = d.[1CBaseMeasureUnitQualifier]

GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[vProductsInfo] TO [PalletRepacker]
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
         Begin Table = "DocProduction"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 99
               Right = 202
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "DocProducts"
            Begin Extent = 
               Top = 6
               Left = 240
               Bottom = 114
               Right = 400
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Docs"
            Begin Extent = 
               Top = 6
               Left = 438
               Bottom = 114
               Right = 598
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductPalletItems"
            Begin Extent = 
               Top = 6
               Left = 636
               Bottom = 114
               Right = 812
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductPallets"
            Begin Extent = 
               Top = 6
               Left = 850
               Bottom = 84
               Right = 1010
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Products"
            Begin Extent = 
               Top = 6
               Left = 1048
               Bottom = 114
               Right = 1208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "ProductSpools"
            Begin Extent = 
               Top = 84
               Left = 850
               Bottom = 192
               Right = 1020
            End
    ', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vProductsInfo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPane2', @value = N'        DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
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
', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vProductsInfo';


GO
EXECUTE sp_addextendedproperty @name = N'MS_DiagramPaneCount', @value = 2, @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'VIEW', @level1name = N'vProductsInfo';

