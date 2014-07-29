-- ================================================
-- Template generated from Template Explorer using:
-- Create Procedure (New Menu).SQL
--
-- Use the Specify Values for Template Parameters 
-- command (Ctrl-Shift-M) to fill in the parameter 
-- values below.
--
-- This block of comments will not be included in
-- the definition of the procedure.
-- ================================================
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE Proc_ExcelImportSQL 
	-- Add the parameters for the stored procedure here
	@OrgCode char(4), 
	@OrgName nvarchar(50),
	@ClsCode nvarchar(10)
AS

DECLARE
@InsertCommandString char(400)
SET
@InsertCommandString = 
'
INSERT INTO [dbo].[u_cls_Table] () VALUES ()
'

--BEGIN
--	-- SET NOCOUNT ON added to prevent extra result sets from
--	-- interfering with SELECT statements.
--	SET NOCOUNT ON;

--    -- Insert statements for procedure here
--	SELECT <@Param1, sysname, @p1>, <@Param2, sysname, @p2>
--END
GO

SELECT b.name FROM sysobjects a INNER JOIN syscolumns b ON a.id = b.id WHERE (a.name = 'u_cls_Table')

SELECT * FROM sysobjects ORDER BY Name
