CREATE TABLE [dbo].[DocCloseShiftMovementProducts] (
    [DocCloseShiftMovementProductID] UNIQUEIDENTIFIER CONSTRAINT [DF_DocCloseShiftMovementProducts_DocCloseShiftMovementProductID] DEFAULT (newsequentialid()) NOT NULL,
    [DocID]                          UNIQUEIDENTIFIER NOT NULL,
    [DocMovementID]                  UNIQUEIDENTIFIER NOT NULL,
    [ProductID]                      UNIQUEIDENTIFIER NOT NULL,
    [Quantity]                       DECIMAL (20, 5)  NULL,
    [MovementPlaceName]              VARCHAR (250)    NULL,
    [MovementPlaceZoneName]          VARCHAR (250)    NULL,
    [DateMovement]                   DATETIME         NULL,
    [IsMovementIn]                   BIT              NULL,
    CONSTRAINT [PK_DocCloseShiftMovementProducts] PRIMARY KEY CLUSTERED ([DocCloseShiftMovementProductID] ASC),
    CONSTRAINT [FK_DocCloseShiftMovementProducts_DocMovement] FOREIGN KEY ([DocMovementID]) REFERENCES [dbo].[DocMovement] ([DocID]),
    CONSTRAINT [FK_DocCloseShiftMovementProducts_Docs] FOREIGN KEY ([DocID]) REFERENCES [dbo].[Docs] ([DocID]),
    CONSTRAINT [FK_DocCloseShiftMovementProducts_Products] FOREIGN KEY ([ProductID]) REFERENCES [dbo].[Products] ([ProductID])
);




GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Утилизированная продукция на смене', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocCloseShiftMovementProducts';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0 при отдаче, 1 при получении', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'DocCloseShiftMovementProducts', @level2type = N'COLUMN', @level2name = N'IsMovementIn';


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[DocCloseShiftMovementProducts] TO [Dispetcher]
    AS [dbo];

