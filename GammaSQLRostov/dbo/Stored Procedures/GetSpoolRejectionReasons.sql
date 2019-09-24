-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetSpoolRejectionReasons]
	-- Add the parameters for the stored procedure here
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	WITH RejectReasons (RejectionReasonID, Description, FullDescription)
AS
(
	SELECT [1CRejectionReasonID] AS RejectionReasonID, Description, FullDescription
	FROM [1CRejectionReasons]
	WHERE [ParentID] IN ('77716f76-bbb1-11e2-80e4-002590304e93','11a207c7-3ca1-11e3-84ad-002590304e93') AND IsMarked=0 AND IsFolder = 0
	UNION ALL
	SELECT a.[1CRejectionReasonID] AS RejectionReasonID, a.Description, a.FullDescription
	FROM 
	[1CRejectionReasons] a
	JOIN
	[RejectReasons] b ON a.ParentID = b.RejectionReasonID
	WHERE IsMarked=0 AND IsFolder = 0
	)
	
	SELECT * FROM RejectReasons ORDER BY Description
END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolRejectionReasons] TO [PalletRepacker]
    AS [dbo];

