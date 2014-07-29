USE [kpi_aspnet_db]
GO

SELECT *
  FROM [dbo].[aspnet_Users]
  ORDER BY UserName
GO

SELECT *
  FROM [dbo].[aspnet_UsersInRoles]
GO



USE [kpi_forms_db]
GO

SELECT *
  FROM [dbo].[u_kpi_table]
  ORDER BY UserName
GO

--UPDATE [dbo].[u_kpi_table] SET u_kpi_m = 'ÄÂöË' WHERE u_kpi_m = ' ÄÂöË'



SELECT * from [kpi_forms_db].[dbo].[u_kpi_userInManager]
ORDER BY uManagerName

select a.UserId,b.UserName,a.uManagerId,name1 
from [kpi_forms_db].[dbo].[u_kpi_userInManager] a join [kpi_aspnet_db].[dbo].[aspnet_Users] b on a.UserId=b.userid join (select userid,username as name1 from[kpi_aspnet_db].[dbo].[aspnet_Users]) c on a.uManagerId=c.userid
ORDER BY name1


DELETE FROM [kpi_forms_db].[dbo].[u_kpi_userInManager] WHERE UserId='BCFFB767-7781-4EB8-A640-1468733B115C' AND uManagerId='BCFFB767-7781-4EB8-A640-1468733B115C'

UPDATE [kpi_forms_db].[dbo].[u_kpi_userInManager] SET UserName = (SELECT UserName FROM [kpi_aspnet_db].[dbo].[aspnet_Users] WHERE UserId = [kpi_forms_db].[dbo].[u_kpi_userInManager].[UserId])
UPDATE [kpi_forms_db].[dbo].[u_kpi_userInManager] SET uManagerName = (SELECT UserName FROM [kpi_aspnet_db].[dbo].[aspnet_Users] WHERE UserId = [kpi_forms_db].[dbo].[u_kpi_userInManager].[uManagerId])

USE [kpi_forms_db]
GO

INSERT INTO [dbo].[u_kpi_userInManager]
           ([UserId]
           ,[uManagerId]
           ,[UserName]
           ,[uManagerName])
     VALUES
           (<UserId, uniqueidentifier,>
           ,<uManagerId, uniqueidentifier,>
           ,<UserName, nvarchar(50),>
           ,<uManagerName, nvarchar(50),>)
GO

