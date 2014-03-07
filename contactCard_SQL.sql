-- Employee contact card 

SELECT * FROM [UFDATA_002_2010].[dbo].[hr_hi_person]

SELECT * FROM Department

SELECT	
	[cPsn_Num], 
	[cPsn_Name], 
	[cDept_num],
(select cDepName from Department WHERE cDepCode = cDept_num) as deptName, 
	[rCheckInFlag], 
	[cPsnMobilePhone], 
	[cPsnPostAddr], 
	[cPsnFAddr] 
FROM
	[hr_hi_person]
ORDER BY
	cPsn_Num
	
