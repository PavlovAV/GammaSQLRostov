CREATE TABLE [dbo].[Persons] (
    [PersonID]   UNIQUEIDENTIFIER CONSTRAINT [DF_Persons_PersonID] DEFAULT (newsequentialid()) NOT NULL,
    [BranchID]   INT              NULL,
    [PostTypeID] INT              CONSTRAINT [DF_Persons_PostTypeID] DEFAULT ((1)) NULL,
    [Name]       NVARCHAR (255)   NULL,
    [Barcode]    NVARCHAR (20)    NULL,
    [Password]   NVARCHAR (255)   CONSTRAINT [DF_Persons_Password] DEFAULT ((123456)) NULL,
    [PlaceID]    INT              NULL,
    [UserID]     UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_Persons_1] PRIMARY KEY CLUSTERED ([PersonID] ASC),
    CONSTRAINT [FK_Persons_Branches] FOREIGN KEY ([BranchID]) REFERENCES [dbo].[Branches] ([BranchID]),
    CONSTRAINT [FK_Persons_Places] FOREIGN KEY ([PlaceID]) REFERENCES [dbo].[Places] ([PlaceID]),
    CONSTRAINT [FK_Persons_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);


GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[SetPersonBarcodeAfterInsert]
   ON  [dbo].[Persons]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @Barcode varchar(20)

	SELECT @Barcode = MAX(Barcode)
	FROM
	Persons

	UPDATE a SET a.Barcode = STUFF('00000000000000', 15 - LEN(CAST(@Barcode AS int)+1), LEN(CAST(@Barcode AS int)+1), CAST(@Barcode AS int)+1)
	FROM
	Persons a
	JOIN
	inserted b ON a.PersonId = b.PersonId

END

GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Persons] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Persons] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Persons] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Persons] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Persons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Persons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Persons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Persons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [Viewer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Persons] TO [PalletRepacker]
    AS [dbo];

