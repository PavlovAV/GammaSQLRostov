CREATE TABLE [dbo].[SourceSpools] (
    [PlaceID]         INT              NOT NULL,
    [Unwinder1Spool]  UNIQUEIDENTIFIER NULL,
    [Unwinder1Active] BIT              NULL,
    [Unwinder2Spool]  UNIQUEIDENTIFIER NULL,
    [Unwinder2Active] BIT              NULL,
    [Unwinder3Spool]  UNIQUEIDENTIFIER NULL,
    [Unwinder3Active] BIT              NULL,
    [Unwinder4Spool]  UNIQUEIDENTIFIER NULL,
    [Unwinder4Active] BIT              NULL,
    CONSTRAINT [PK_SourceSpools] PRIMARY KEY CLUSTERED ([PlaceID] ASC),
    CONSTRAINT [FK_SourceSpools_Places] FOREIGN KEY ([PlaceID]) REFERENCES [dbo].[Places] ([PlaceID]),
    CONSTRAINT [FK_SourceSpools_ProductSpools] FOREIGN KEY ([Unwinder1Spool]) REFERENCES [dbo].[ProductSpools] ([ProductID]),
    CONSTRAINT [FK_SourceSpools_ProductSpools1] FOREIGN KEY ([Unwinder2Spool]) REFERENCES [dbo].[ProductSpools] ([ProductID]),
    CONSTRAINT [FK_SourceSpools_ProductSpools2] FOREIGN KEY ([Unwinder3Spool]) REFERENCES [dbo].[ProductSpools] ([ProductID]),
    CONSTRAINT [FK_SourceSpools_ProductSpools3] FOREIGN KEY ([Unwinder4Spool]) REFERENCES [dbo].[ProductSpools] ([ProductID])
);


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[SourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[SourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[SourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[SourceSpools] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[SourceSpools] TO [PalletRepacker]
    AS [dbo];

