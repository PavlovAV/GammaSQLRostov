CREATE TABLE [dbo].[1CPropertyValueGammaPropertyValue] (
    [1CPropertyValueID] UNIQUEIDENTIFIER NOT NULL,
    [GammaPropertyID]   UNIQUEIDENTIFIER NOT NULL,
    [ValueNumeric]      DECIMAL (18, 5)  NULL,
    CONSTRAINT [PK_1CPropertyValueGammaPropertyValue_1] PRIMARY KEY CLUSTERED ([1CPropertyValueID] ASC, [GammaPropertyID] ASC),
    CONSTRAINT [FK_1CPropertyValueGammaPropertyValue_1CPropertyValues] FOREIGN KEY ([1CPropertyValueID]) REFERENCES [dbo].[1CPropertyValues] ([1CPropertyValueID]),
    CONSTRAINT [FK_1CPropertyValueGammaPropertyValue_GammaProperties] FOREIGN KEY ([GammaPropertyID]) REFERENCES [dbo].[GammaProperties] ([GammaPropertyID])
);

