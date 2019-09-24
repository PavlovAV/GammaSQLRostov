CREATE TABLE [dbo].[OrderTypes] (
    [OrderTypeID] TINYINT      NOT NULL,
    [Name]        VARCHAR (50) NULL,
    CONSTRAINT [PK_OrderTypes] PRIMARY KEY CLUSTERED ([OrderTypeID] ASC)
);

