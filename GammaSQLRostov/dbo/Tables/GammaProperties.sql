CREATE TABLE [dbo].[GammaProperties] (
    [GammaPropertyID] UNIQUEIDENTIFIER CONSTRAINT [DF_GammaProperties_GammaPropertyID] DEFAULT (newsequentialid()) NOT NULL,
    [Name]            VARCHAR (50)     NOT NULL,
    CONSTRAINT [PK_GammaProperties] PRIMARY KEY CLUSTERED ([GammaPropertyID] ASC)
);

