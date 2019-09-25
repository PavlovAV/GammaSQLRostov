CREATE TABLE [dbo].[Docs] (
    [DocID]          UNIQUEIDENTIFIER CONSTRAINT [DF_Docs_DocID] DEFAULT (newsequentialid()) NOT NULL,
    [IsMarked]       BIT              CONSTRAINT [DF_Docs_IsMarked] DEFAULT ((0)) NULL,
    [DocTypeID]      INT              NULL,
    [Number]         VARCHAR (50)     NULL,
    [IsConfirmed]    BIT              CONSTRAINT [DF_Docs_IsConfirmed] DEFAULT ((1)) NOT NULL,
    [UserID]         UNIQUEIDENTIFIER NULL,
    [PersonID]       INT              NULL,
    [PrintName]      VARCHAR (255)    NULL,
    [PlaceID]        INT              NULL,
    [ShiftID]        TINYINT          NULL,
    [Date]           DATETIME         CONSTRAINT [DF_Docs_Date] DEFAULT (getdate()) NOT NULL,
    [Comment]        VARCHAR (8000)   NULL,
    [IsFromOldGamma] BIT              CONSTRAINT [DF_Docs_IsFromOldGamma] DEFAULT ((0)) NULL,
    [BranchID]       TINYINT          NULL,
    [PersonGuid]     UNIQUEIDENTIFIER NULL,
    CONSTRAINT [PK_Docs] PRIMARY KEY CLUSTERED ([DocID] ASC),
    CONSTRAINT [FK_Docs_DocTypes] FOREIGN KEY ([DocTypeID]) REFERENCES [dbo].[DocTypes] ([DocTypeID]),
    CONSTRAINT [FK_Docs_Persons] FOREIGN KEY ([PersonGuid]) REFERENCES [dbo].[Persons] ([PersonID]),
    CONSTRAINT [FK_Docs_Places] FOREIGN KEY ([PlaceID]) REFERENCES [dbo].[Places] ([PlaceID]),
    CONSTRAINT [FK_Docs_Users] FOREIGN KEY ([UserID]) REFERENCES [dbo].[Users] ([UserID])
);




GO
CREATE NONCLUSTERED INDEX [IX_FK_Docs_Users]
    ON [dbo].[Docs]([UserID] ASC);


GO
CREATE NONCLUSTERED INDEX [idxDocPlace]
    ON [dbo].[Docs]([PlaceID] ASC)
    INCLUDE([Date], [DocTypeID], [IsConfirmed], [ShiftID]);




GO
CREATE NONCLUSTERED INDEX [idxPlaceShift]
    ON [dbo].[Docs]([PlaceID] ASC, [ShiftID] ASC)
    INCLUDE([PrintName]);




GO
CREATE NONCLUSTERED INDEX [indexDocType]
    ON [dbo].[Docs]([DocTypeID] ASC)
    INCLUDE([DocID], [PlaceID], [ShiftID], [Date]);




GO
CREATE NONCLUSTERED INDEX [IX_Docs_Date]
    ON [dbo].[Docs]([Date] DESC)
    INCLUDE([DocTypeID], [IsConfirmed], [PlaceID], [ShiftID]);




GO
CREATE NONCLUSTERED INDEX [idxNumber]
    ON [dbo].[Docs]([Number] ASC);


GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[SetDocBranchIDAfterInsert]
   ON  [dbo].[Docs]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	UPDATE a SET a.BranchID = (SELECT TOP 1 BranchID FROM LocalSettings)
	FROM
	Docs a
	JOIN
	inserted b ON a.DocID = b.DocID
	WHERE b.BranchID IS NULL 

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================

CREATE TRIGGER [dbo].[SetDocNumberAfterInsert]
   ON  [dbo].[Docs]
   AFTER INSERT
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	DECLARE @Number varchar(100), @PrevNumber varchar(100), @CurrDate datetime,  @PlaceID int, @DocTypeID int,
    @YEAR varchar(10), @Month varchar(10), @Day varchar(10), @Place varchar(50), @ShiftID tinyint, @DocID uniqueidentifier,
	@BranchID int, @BranchUnitID int

	IF EXISTS
	(
		SELECT *
		FROM
		inserted
		WHERE BranchID IS NULL OR BranchID = (SELECT TOP 1 BranchID FROM LocalSettings)
	)
	BEGIN
		SELECT @PlaceID = a.PlaceID, @ShiftID = a.ShiftID, @DocID = a.DocID, @DocTypeID = a.DocTypeID
			,  @BranchID = b.BranchID, @BranchUnitID = ISNULL(b.BranchUnitID,0)
		FROM inserted a
		LEFT JOIN
		Places b ON a.PlaceID = b.PlaceID
		SELECT @CurrDate = GETDATE()

		IF @DocTypeID = 0
		BEGIN
			SELECT TOP 1 @PrevNumber = Number FROM Docs
			WHERE DocID <> @DocID AND PlaceID = @PlaceID AND MONTH(Date) = MONTH(@CurrDate) AND YEAR(Date) = YEAR(@CurrDate) AND DocTypeID = @DocTypeID
			ORDER BY Date DESC
		
			SET @PrevNumber = ISNULL(@PrevNumber, '000000000')
		
		END
		ELSE
		BEGIN
			SELECT TOP 1 @PrevNumber = Number FROM Docs
			WHERE DocID <> @DocID AND DocTypeID = @DocTypeID
			ORDER BY Date DESC
		
			SELECT @Place = Name FROM Places WHERE PlaceID = @PlaceID

			IF @DocTypeID = 3
			BEGIN
				SET @PrevNumber = ISNULL(@PrevNumber, @Place + '/0')
			END
			ELSE
			BEGIN
				SET @PrevNumber = ISNULL(@PrevNumber, '0')
			END
		END
	
	

		SELECT @YEAR = LEFT(CONVERT(varchar, @CurrDate, 12), 2)
		SELECT @MONTH = SUBSTRING(CONVERT(varchar, @CurrDate, 12), 3, 2)
		SELECT @DAY = SUBSTRING(CONVERT(varchar, @CurrDate, 12), 5, 2)

		
		IF @DocTypeID = 0  --Номер для выработки
		BEGIN      
			SELECT @Number = (CAST(RIGHT(@PrevNumber, 5) as int) + 1)
			SELECT @Number = STUFF('00000', 6 - LEN(@Number), LEN(@number), @Number)

			SET @Number = @YEAR + @MONTH + @DAY + CAST(@ShiftID AS varchar) + CAST(@BranchID AS varchar) 
				+ STUFF('00',3 - LEN(@BranchUnitID), LEN(@BranchUnitID), @BranchUnitID) + @Number
		END
	
		IF @DocTypeID = 3 -- Номер для закрытия смены
		BEGIN
			SELECT @Number = (CAST(RIGHT(@PrevNumber, LEN(@PrevNumber) - CHARINDEX('/', @PrevNumber)) as int) + 1)
			SET @Number = @Place + '/' + @Number
		END

		IF @DocTypeID IN (2,7,10, 1, 12) -- номер для перемешения, и акта о браке, и инвентаризации
		BEGIN
			SELECT @Number = CAST(@PrevNumber as int) + 1
		END

	
	

		UPDATE Docs SET Number = @Number
		WHERE DocID = @DocID AND DocTypeID = @DocTypeID AND (IsFromOldGamma = 0 OR IsFromOldGamma IS NULL)

/*
		-------------------- Для переноса съема в старую гамму
		IF @PlaceID IN (3,4) --- Для ПРС1,2
		BEGIN
			INSERT INTO Gamma.dbo.GammaNewDocUnloadToOld (DocID, Date, Number, PlaceID, ShiftID, IsConfirmed, Product1ID, Product2ID, Product3ID)
			SELECT TOP 1 a.DocID, a.Date, @Number AS Number, a.PlaceID, a.ShiftID, a.IsConfirmed, 
			CASE
				WHEN Unwinder1Active = 1 THEN b.Unwinder1Spool 
			END AS Product1ID,
			CASE
				WHEN Unwinder2Active = 1 THEN b.Unwinder2Spool 
			END AS Product2ID,
			CASE
				WHEN Unwinder3Active = 1 THEN b.Unwinder3Spool 
			END AS Product3ID
			FROM
			inserted a
			JOIN
			SourceSpools b ON a.PlaceID = b.PlaceID
			WHERE a.DocTypeID = 0
		END
*/
	END

END

GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	вставляет запись о месте создания рулона
-- =============================================
CREATE TRIGGER [dbo].[DeleteOldUnloads]
   ON  dbo.Docs
   AFTER DELETE
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
  
	/*DELETE a
	FROM
	Gamma.Dbo.GammaNewDocUnloadToOld a
	JOIN
	deleted b ON a.DocID = b.DocID	
	*/
END


GO
DISABLE TRIGGER [dbo].[DeleteOldUnloads]
    ON [dbo].[Docs];


GO
CREATE TRIGGER zziDocs ON dbo.Docs
AFTER  INSERT AS 
INSERT INTO zzDocs
 SELECT *, 0, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER zzuDocs ON dbo.Docs
AFTER  UPDATE AS 
INSERT INTO zzDocs
 SELECT *, 1, GETDATE(),  SYSTEM_USER
 FROM INSERTED

GO
CREATE TRIGGER zzdDocs ON dbo.Docs
AFTER  DELETE AS 
INSERT INTO zzDocs
 SELECT *, 2, GETDATE(),  SYSTEM_USER
 FROM DELETED

GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [Wrapper]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [Wrapper]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [Wrapper]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [Wrapper]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [Wrapper]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [OperatorRW]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [OperatorRW]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [OperatorRW]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [OperatorRW]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [OperatorRW]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [OperatorBDM]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [OperatorBDM]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [OperatorBDM]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [OperatorBDM]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [OperatorBDM]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [TechnologSGB]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [TechnologSGB]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [TechnologSGB]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [TechnologSGB]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [TechnologSGB]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [Engineer]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [Engineer]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [Engineer]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [Engineer]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [Engineer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [Dispetcher]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [Dispetcher]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [Dispetcher]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [Dispetcher]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [Dispetcher]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [QualityInspector]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [QualityInspector]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [QualityInspector]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [QualityInspector]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [QualityInspector]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [OperatorConverting]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [OperatorConverting]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [OperatorConverting]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [OperatorConverting]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [OperatorConverting]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [TechnologSGI]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [TechnologSGI]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [TechnologSGI]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [TechnologSGI]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [TechnologSGI]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [Loader]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [Loader]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [Loader]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [Loader]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [Loader]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [Baler]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [Baler]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [Baler]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [Baler]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [Viewer]
    AS [dbo];


GO
GRANT DELETE
    ON OBJECT::[dbo].[Docs] TO [PalletRepacker]
    AS [dbo];


GO
GRANT INSERT
    ON OBJECT::[dbo].[Docs] TO [PalletRepacker]
    AS [dbo];


GO
GRANT REFERENCES
    ON OBJECT::[dbo].[Docs] TO [PalletRepacker]
    AS [dbo];


GO
GRANT SELECT
    ON OBJECT::[dbo].[Docs] TO [PalletRepacker]
    AS [dbo];


GO
GRANT UPDATE
    ON OBJECT::[dbo].[Docs] TO [PalletRepacker]
    AS [dbo];


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Пометка на удаление', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'Docs', @level2type = N'COLUMN', @level2name = N'IsMarked';

