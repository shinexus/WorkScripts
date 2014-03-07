SELECT *
  FROM [posdb3002].[dbo].[tCvsHandCash]
  WHERE JzDate = '2013-08-01'
  AND PosNo = '0002'
GO

UPDATE [posdb3002].[dbo].[tCvsHandCash]
SET Tag = '0'
WHERE JzDate = '2013-08-11'
  AND PosNo = '0001'


