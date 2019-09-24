CREATE TABLE [dbo].[1CPropertyValues] (
    [1CPropertyValueID] UNIQUEIDENTIFIER NOT NULL,
    [1CCode]            VARCHAR (20)     NULL,
    [1CPropertyID]      UNIQUEIDENTIFIER NULL,
    [ValueType]         TINYINT          NULL,
    [Marked]            BIT              NULL,
    [Folder]            BIT              NULL,
    [ParentID]          UNIQUEIDENTIFIER NULL,
    [Description]       VARCHAR (50)     NULL,
    [PrintDescription]  NTEXT            NULL,
    [ValueNumeric]      DECIMAL (20, 5)  NULL,
    [SortValue]         NVARCHAR (50)    NULL,
    [NotForName]        BIT              CONSTRAINT [DF_1CPropertyValues_NotForName] DEFAULT ((0)) NULL,
    CONSTRAINT [PK_1CPropertyValues_1] PRIMARY KEY CLUSTERED ([1CPropertyValueID] ASC),
    CONSTRAINT [FK_1CPropertyValues_1CProperties] FOREIGN KEY ([1CPropertyID]) REFERENCES [dbo].[1CProperties] ([1CPropertyID])
);


GO
CREATE NONCLUSTERED INDEX [NonClusteredIndex-20160901-171814]
    ON [dbo].[1CPropertyValues]([Description] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[1CPropertyValues] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'0 - PropertyValues, 1 - PropertyValuesShared', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'1CPropertyValues', @level2type = N'COLUMN', @level2name = N'ValueType';

