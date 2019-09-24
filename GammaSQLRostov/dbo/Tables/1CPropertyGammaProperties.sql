CREATE TABLE [dbo].[1CPropertyGammaProperties] (
    [1CPropertyID]    UNIQUEIDENTIFIER NOT NULL,
    [GammaPropertyID] UNIQUEIDENTIFIER NOT NULL,
    CONSTRAINT [PK_1CPropertyGammaProperties] PRIMARY KEY CLUSTERED ([1CPropertyID] ASC, [GammaPropertyID] ASC),
    CONSTRAINT [FK_1CPropertyGammaProperties_1CProperties] FOREIGN KEY ([1CPropertyID]) REFERENCES [dbo].[1CProperties] ([1CPropertyID]),
    CONSTRAINT [FK_1CPropertyGammaProperties_GammaProperties] FOREIGN KEY ([GammaPropertyID]) REFERENCES [dbo].[GammaProperties] ([GammaPropertyID])
);

