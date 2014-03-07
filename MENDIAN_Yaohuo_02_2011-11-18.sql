SELECT *
  FROM [workTemp].[dbo].[etpplu]
GO
SELECT *
  FROM [workTemp].[dbo].[table_yaohuo_01]
GO

SELECT 
B.ETPCODE, B.ETPNAME, A.pluname, B.FREQ, B.MON, B.TUE, B.WED, B.THU, B.FRI, B.SAT, B.SUN
  FROM 
  [workTemp].[dbo].[etpplu] A,
  [workTemp].[dbo].[TABLE_YAOHUO_01] B
  WHERE A.ETPCODE = B.ETPCODE
GO


