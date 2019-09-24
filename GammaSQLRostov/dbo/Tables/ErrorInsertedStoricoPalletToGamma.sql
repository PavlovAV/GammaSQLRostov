CREATE TABLE [dbo].[ErrorInsertedStoricoPalletToGamma] (
    [InsertDate]         DATETIME      NOT NULL,
    [ErrorInsertToGamma] VARCHAR (500) NULL,
    [DateAdd]            DATETIME      CONSTRAINT [DF_ErrorInsertedStoricoPalletToGamma_DateAdd] DEFAULT (getdate()) NULL
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20180711-171632]
    ON [dbo].[ErrorInsertedStoricoPalletToGamma]([InsertDate] ASC);

