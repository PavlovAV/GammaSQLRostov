-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetSpoolCoreWeight]
(
	@ProductID uniqueidentifier
)
RETURNS decimal(18,2)
AS
BEGIN
	DECLARE @Result decimal(18,2),@Format decimal(18,5), @CoreWeight decimal(18,5)

	SELECT @CoreWeight = dbo.GetCoreWeight(a.[1CCharacteristicID]),
	@Format = 
	CASE
	WHEN dbo.GetCharSpoolFormat(a.[1CCharacteristicID]) = 0 THEN a.RealFormat
	ELSE
	dbo.GetCharSpoolFormat(a.[1CCharacteristicID])
	END
	FROM ProductSpools a
	WHERE a.ProductID = @ProductID
	
	SELECT @Result = @CoreWeight*@Format/1000

	RETURN @Result

END


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [Wrapper]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [OperatorRW]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [OperatorBDM]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [TechnologSGB]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [Engineer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [Dispetcher]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [QualityInspector]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [OperatorConverting]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [TechnologSGI]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [WarehouseOperator]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [Loader]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [Baler]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [Viewer]
    AS [dbo];


GO
GRANT EXECUTE
    ON OBJECT::[dbo].[GetSpoolCoreWeight] TO [PalletRepacker]
    AS [dbo];

