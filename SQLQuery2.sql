SELECT distinct
	a.[人员编码], a.[姓名], b.[部门], a.[岗位], a.[职务]
FROM 
	[work_tmp].[dbo].[2011_users_mu] a, 
	[work_tmp].[dbo].[2011_users] b
WHERE 
	a.姓名 = b.姓名
ORDER by [人员编码]
GO


