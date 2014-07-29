
USE [kpi_aspnet_db]
GO


SELECT *
  FROM [dbo].[aspnet_Applications]
GO


SELECT *
  FROM [dbo].[aspnet_Users]
GO


SELECT *
  FROM [dbo].[aspnet_Roles]
GO

SELECT *
  FROM [dbo].[aspnet_UsersInRoles]
GO

SELECT UserName FROM [dbo].[aspnet_Users] WHERE UserId IN (SELECT UserId FROM [dbo].[aspnet_UsersInRoles] WHERE RoleId='3525fbef-c1ab-4be5-94af-740e7db93e52')

SELECT UserName FROM [dbo].[aspnet_Users] WHERE UserId NOT IN (SELECT UserId FROM [dbo].[aspnet_UsersInRoles] WHERE RoleId='3525fbef-c1ab-4be5-94af-740e7db93e52')

SELECT U.UserName, UIR.UserId, UIR.RoleId, R.RoleName FROM [dbo].[aspnet_Users] U,  [dbo].[aspnet_UsersInRoles] UIR, [dbo].[aspnet_Roles] R
WHERE U.UserId = UIR.UserId AND R.RoleId = UIR.RoleId
GO

DELETE FROM [dbo].[aspnet_UsersInRoles]
WHERE	UserId = (SELECT UserId FROM [dbo].[aspnet_Users] WHERE UserName = '«Ò÷”√¿') 
AND		RoleId = (SELECT RoleId FROM [dbo].[aspnet_Roles] WHERE RoleName = 'Financial')

SELECT UserName, UserId FROM [dbo].[aspnet_Users] WHERE UserId IN (SELECT UserId FROM [dbo].[aspnet_UsersInRoles] WHERE RoleId='3525FBEF-C1AB-4BE5-94AF-740E7DB93E52')

SELECT UserName, UserId FROM [dbo].[aspnet_Users] WHERE UserId NOT IN (SELECT UserId FROM [dbo].[aspnet_UsersInRoles] WHERE RoleId ='3525FBEF-C1AB-4BE5-94AF-740E7DB93E52')

USE [kpi_aspnet_db]
GO

USE [kpi_forms_db]
GO

SELECT *
  FROM [dbo].[u_kpi_table]
  WHERE u_kpi_conf_datetime IS NOT NULL

  SELECT *
  FROM [dbo].[u_kpi_table]
  WHERE UserName <> '–ÏΩÚÏœ' AND u_kpi_m <> '–ÏΩÚÏœ'

  SELECT *
  FROM [dbo].[u_kpi_table]
  WHERE u_kpi_m IS NULL OR u_kpi_m <> '–ÏΩÚÏœ'

  UPDATE [dbo].[u_kpi_table]
  SET u_kpi_m = NULL
  WHERE UserName LIKE '%≤‚ ‘%'
GO

SELECT 'ERROR' FROM [dbo].[u_kpi_table]

UPDATE [dbo].[u_kpi_table] SET u_kpi_rec = '0', u_kpi_conf_datetime = NULL
WHERE UserName = '”√ªß1'




