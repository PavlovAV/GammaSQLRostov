CREATE TABLE [dbo].[Products] (
    [ProductID]     UNIQUEIDENTIFIER CONSTRAINT [DF_Products_ProductID] DEFAULT (newsequentialid()) NOT NULL,
    [Number]        VARCHAR (20)     NULL,
    [BarCode]       VARCHAR (20)     NULL,
    [ProductKindID] TINYINT          NOT NULL,
    [StateID]       TINYINT          NULL,
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID] ASC),
    CONSTRAINT [FK_Products_ProductKinds] FOREIGN KEY ([ProductKindID]) REFERENCES [dbo].[ProductKinds] ([ProductKindID]),
    CONSTRAINT [FK_Products_ProductStates] FOREIGN KEY ([StateID]) REFERENCES [dbo].[ProductStates] ([StateID])
);




GO
CREATE NONCLUSTERED INDEX [indexIDNumber]
    ON [dbo].[Products]([ProductID] ASC)
    INCLUDE([StateID], [ProductKindID], [BarCode], [Number]);


GO
CREATE NONCLUSTERED INDEX [indexProductKindID]
    ON [dbo].[Products]([ProductKindID] ASC)
    INCLUDE([StateID], [BarCode], [Number]);


GO
CREATE NONCLUSTERED INDEX [idxNumber]
    ON [dbo].[Products]([Number] ASC);


GO
CREATE TRIGGER zzdProducts ON dbo.Products
AFTER  DELETE AS 
INSERT INTO zzProducts
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED

GO
CREATE TRIGGER zzuProducts ON dbo.Products
AFTER  UPDATE AS 
INSERT INTO zzProducts
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER zziProducts ON dbo.Products
AFTER  INSERT AS 
INSERT INTO zzProducts
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Products] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Products] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Products] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Products] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Products] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'тип продукции. Указан в приложении', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Products', @level2type = N'COLUMN', @level2name = N'ProductKindID';

