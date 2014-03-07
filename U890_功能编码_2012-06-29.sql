SELECT [localeid]
      ,[cAuth_ID]
      ,[cAuth_Name]
  FROM [UFSystem].[dbo].[UA_Auth_lang]
  WHERE localeid = 'zh-CN'
  AND cAuth_ID LIKE 'AM%'
ORDER BY cAuth_ID
GO


