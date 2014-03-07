SELECT *
  FROM [UFDATA_006_2013].[dbo].[fa_Total]
GO

//年初原值合计
SELECT SUM(dblYearValue)
  FROM [UFDATA_006_2013].[dbo].[fa_Total]
GO

