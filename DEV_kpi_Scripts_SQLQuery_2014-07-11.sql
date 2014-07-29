USE [kpi_forms_db]
GO

SELECT *
  FROM [dbo].[u_kpi_table]
  WHERE UserName = 'Œ‚∫Í'
GO

--DELETE FROM [dbo].[u_kpi_table] WHERE UserName <> '–ÏΩÚÏœ'

UPDATE [dbo].[u_kpi_table] SET u_kpi_conf = '0', u_kpi_doneconf = '0' WHERE UserName = 'Œ‚∫Ï'
UPDATE [dbo].[u_kpi_table] SET UserName='»Ÿ¡¢æ˝' WHERE UserName = '»Ÿ¿ˆæ˝'

SELECT SUM(u_kpi_rat) AS SumKpiRat FROM [dbo].[u_kpi_table] WHERE UserName = '–ÏΩÚÏœ' AND u_kpi_conf = '1' AND u_kpi_ins_datetime >= (SELECT DATEADD(MONTH, DATEDIFF(MONTH,0,getdate()), 0))

SELECT * FROM [kpi_forms_db].[dbo].[u_kpi_table] WHERE [Username]='–ÏΩÚÏœ' AND u_kpi_ins_datetime >= (SELECT DATEADD(MONTH, DATEDIFF(MONTH,0,getdate()), 0)) AND [u_kpi_conf] = 1

SELECT * FROM [kpi_forms_db].[dbo].[u_kpi_table] WHERE [Username]='–ÏΩÚÏœ' AND [u_kpi_conf] = 1 AND u_kpi_conf_datetime IS NOT NULL

SELECT SUM(u_kpi_rat) AS SumKpiRat FROM [dbo].[u_kpi_table] WHERE UserName = '≤‚ ‘1' AND u_kpi_conf = '1' AND u_kpi_ins_datetime >= (SELECT DATEADD(MONTH, DATEDIFF(MONTH,0,getdate()), 0))