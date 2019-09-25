CREATE TABLE [dbo].[Places] (
    [PlaceID]                       INT              NOT NULL,
    [PlaceGuid]                     UNIQUEIDENTIFIER CONSTRAINT [DF_Places_PlaceGuid] DEFAULT (newsequentialid()) NULL,
    [BranchID]                      INT              NOT NULL,
    [BranchUnitID]                  INT              NULL,
    [Name]                          VARCHAR (64)     NULL,
    [NameEng]                       VARCHAR (16)     NULL,
    [DepartmentID]                  SMALLINT         NOT NULL,
    [PlaceGroupID]                  SMALLINT         NOT NULL,
    [IsProductionPlace]             BIT              CONSTRAINT [DF_Places_IsProductionPlace] DEFAULT ((1)) NULL,
    [IsWarehouse]                   BIT              CONSTRAINT [DF_Places_IsWarehouse] DEFAULT ((0)) NULL,
    [IsTransitWarehouse]            BIT              CONSTRAINT [DF_Places_IsTransitWarehouse] DEFAULT ((0)) NULL,
    [IsShipmentWarehouse]           BIT              CONSTRAINT [DF_Places_IsShipmentWarehouse] DEFAULT ((0)) NULL,
    [1CPlaceID]                     UNIQUEIDENTIFIER NULL,
    [UnwindersCount]                INT              CONSTRAINT [DF_Places_UnwindersCount] DEFAULT ((0)) NULL,
    [IsRemotePrinting]              BIT              CONSTRAINT [DF_Places_IsRemotePrinting] DEFAULT ((0)) NULL,
    [UseApplicator]                 BIT              CONSTRAINT [DF_Places_UseApplicator] DEFAULT ((0)) NULL,
    [ApplicatorLabelPath]           NVARCHAR (500)   NULL,
    [IsRobot]                       BIT              CONSTRAINT [DF_Places_IsRobot] DEFAULT ((0)) NULL,
    [IsWithdrawalMaterial]          BIT              CONSTRAINT [DF_Places_IsWhithdrawalMaterial] DEFAULT ((0)) NOT NULL,
    [PlaceWithdrawalMaterialTypeID] INT              CONSTRAINT [DF_Places_PlaceWithdrawalMaterialTypeID] DEFAULT ((0)) NOT NULL,
    CONSTRAINT [PK_Places] PRIMARY KEY CLUSTERED ([PlaceID] ASC),
    CONSTRAINT [FK_Places_1CPlaces] FOREIGN KEY ([1CPlaceID]) REFERENCES [dbo].[1CPlaces] ([1CPlaceID]),
    CONSTRAINT [FK_Places_Branches] FOREIGN KEY ([BranchID]) REFERENCES [dbo].[Branches] ([BranchID]),
    CONSTRAINT [FK_Places_Departments] FOREIGN KEY ([DepartmentID]) REFERENCES [dbo].[Departments] ([DepartmentID]),
    CONSTRAINT [FK_Places_PlaceGroups1] FOREIGN KEY ([PlaceGroupID]) REFERENCES [dbo].[PlaceGroups] ([PlaceGroupID]),
    CONSTRAINT [FK_Places_PlaceWithdrawalMaterialTypes] FOREIGN KEY ([PlaceWithdrawalMaterialTypeID]) REFERENCES [dbo].[PlaceWithdrawalMaterialTypes] ([PlaceWithdrawalMaterialTypeID])
);




GO
CREATE NONCLUSTERED INDEX [idxPlaceGroupId]
    ON [dbo].[Places]([PlaceGroupID] ASC);


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Places] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Номер передела в филиале', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Places', @level2type = N'COLUMN', @level2name = N'BranchUnitID';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Номер передела в филиале', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Places', @level2type = N'COLUMN', @level2name = N'Name';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Количество раскатов (времянка до введения конфигурации оборудования)', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Places', @level2type = N'COLUMN', @level2name = N'UnwindersCount';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Признка того, что печать  амбалажа происходит далеко от компьютера', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Places', @level2type = N'COLUMN', @level2name = N'IsRemotePrinting';

