CREATE TABLE [dbo].[PlaceWithdrawalMaterialTypes] (
    [PlaceWithdrawalMaterialTypeID] INT          NOT NULL,
    [Name]                          VARCHAR (50) NULL,
    CONSTRAINT [PK_PlaceWithdrawalMaterialTypes] PRIMARY KEY CLUSTERED ([PlaceWithdrawalMaterialTypeID] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Списание материалов по переделу. Служебная таблица. Возможно вшито в программе.', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'PlaceWithdrawalMaterialTypes';

