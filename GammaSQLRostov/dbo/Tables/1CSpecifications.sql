CREATE TABLE [dbo].[1CSpecifications] (
    [1CSpecificationID] UNIQUEIDENTIFIER NOT NULL,
    [Description]       NVARCHAR (100)   NULL,
    [ParentID]          UNIQUEIDENTIFIER NULL,
    [Marked]            BIT              NULL,
    [Folder]            BIT              NULL,
    [SpecificationType] TINYINT          NULL,
    [ValidTill]         DATETIME         NULL,
    CONSTRAINT [PK_1CSpecifications_1] PRIMARY KEY CLUSTERED ([1CSpecificationID] ASC)
);



