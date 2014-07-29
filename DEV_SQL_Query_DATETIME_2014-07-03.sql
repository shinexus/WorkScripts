USE [kpi_forms_db]
GO

SELECT *
  FROM [dbo].[u_kpi_table]
  WHERE u_kpi_ins_datetime >= (SELECT DATEADD(MONTH, DATEDIFF(MONTH,0,getdate()), 0))
GO

--http://www.uzzf.com/news/2276.html
--http://jsdjt.blog.163.com/blog/static/7771121200922092018404/
--http://www.cnblogs.com/adandelion/archive/2006/11/08/554312.html


/**** 当前日期 ****/
SELECT GETDATE()
/**** 当前季度的第一天 ****/
SELECT DATEADD(quarter, DATEDIFF(quarter,0,getdate()), 0)
SELECT DATEADD(quarter, DATEDIFF(quarter,0,'2014-06-20'), 0)
/**** 当前月份的第一天 ****/
SELECT DATEADD(MONTH, DATEDIFF(MONTH,0,getdate()), 0)
/**** 2014-06 第一天 ****/
SELECT DATEADD(MONTH, DATEDIFF(MONTH,0,'2014-06-01'), 0)
/**** 当前月份最后一天 ****/
SELECT DATEADD(DD,-DAY(DATEADD(M,1,GETDATE())),DATEADD(M,1,GETDATE())) 
SELECT DATEADD(ms,-1,DATEADD(mm, DATEDIFF(m,0,getdate())+1, 0))
/**** 2014-06 最后一天 ****/
SELECT DATEADD(ms,-2,DATEADD(mm, DATEDIFF(m,0,'2014-06-01')+1, 0)) 
SELECT DATEADD(ms,-1,DATEADD(mm, DATEDIFF(m,0,'2014-06-01')+1, 0))
 

/**** 用户确认日期（格式：2014-07） ****/
SELECT u_kpi_conf_datetime FROM [dbo].[u_kpi_table] WHERE u_kpi_conf_datetime IS NOT NULL

SELECT YEAR(u_kpi_conf_datetime) FROM [dbo].[u_kpi_table] WHERE u_kpi_conf_datetime IS NOT NULL
SELECT MONTH(u_kpi_conf_datetime) FROM [dbo].[u_kpi_table] WHERE u_kpi_conf_datetime IS NOT NULL

SELECT DISTINCT CONVERT(nvarchar, YEAR(u_kpi_conf_datetime))+'-'+ CONVERT(nvarchar, MONTH(u_kpi_conf_datetime)) FROM [dbo].[u_kpi_table] WHERE u_kpi_conf_datetime IS NOT NULL
SELECT DISTINCT CONVERT(nvarchar, YEAR(u_kpi_conf_datetime))+'-0'+ CONVERT(nvarchar, MONTH(u_kpi_conf_datetime)) AS SelectData FROM [dbo].[u_kpi_table] WHERE u_kpi_conf_datetime IS NOT NULL

SELECT CONVERT(nvarchar,'2014-07-04')

 SELECT [id], [UserName], [u_kpi] ,[u_kpi_std] ,[u_kpi_comm] ,[u_kpi_rat] ,[u_kpi_fx] ,[uM_kpi_rec] ,[u_kpi_ref], [u_Kpi_ins_datetime] FROM [kpi_forms_db].[dbo].[u_kpi_table] WHERE [Username]='徐津煜' AND u_kpi_ins_datetime BETWEEN (SELECT DATEADD(MONTH, DATEDIFF(MONTH,0,'2014-07-01'), 0)) AND (SELECT DATEADD(ms,-1,DATEADD(mm, DATEDIFF(m,0,'2014-07-01')+1, 0))) AND [u_kpi_conf] = 1 



