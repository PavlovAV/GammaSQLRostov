CREATE TABLE [dbo].[1CContractors] (
    [1CContractorID]  UNIQUEIDENTIFIER NOT NULL,
    [Marked]          BIT              NOT NULL,
    [Folder]          BIT              NOT NULL,
    [ParentID]        UNIQUEIDENTIFIER NULL,
    [1CCode]          CHAR (9)         NULL,
    [Description]     NVARCHAR (100)   NOT NULL,
    [FullDescription] NTEXT            NULL,
    [IsBuyer]         BIT              NULL,
    [IsSeller]        BIT              NULL,
    [IsNonresident]   BIT              NULL,
    [INN]             NVARCHAR (12)    NULL,
    [KPP]             NVARCHAR (9)     NULL,
    CONSTRAINT [PK_1CContractors] PRIMARY KEY CLUSTERED ([1CContractorID] ASC)
);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CContractors] TO [PalletRepacker]
    AS [dbo];

