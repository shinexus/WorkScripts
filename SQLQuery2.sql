SELECT distinct
	a.[��Ա����], a.[����], b.[����], a.[��λ], a.[ְ��]
FROM 
	[work_tmp].[dbo].[2011_users_mu] a, 
	[work_tmp].[dbo].[2011_users] b
WHERE 
	a.���� = b.����
ORDER by [��Ա����]
GO


