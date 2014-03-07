SELECT [OrgCode] AS '组织编码',[PosNo] AS '收款机号',[UserCode] AS '用户编码',[CshName] AS '收银员姓名',[LrDate] AS '录入日期',[JzDate] AS '结账日期',CASE [PayCode] WHEN '0' THEN '现金' WHEN '2' THEN '银行卡' WHEN '4' THEN '购物券' WHEN '8' THEN '城市卡' WHEN '51' THEN '津通卡' END AS '支付代码',[YHandTotal] AS '应交金额',[SHandTotal] AS '实交金额',[Tag] AS '上传标志' FROM [posdb1001].[dbo].[tCvsHandCash]
GO

/*
SELECT [OrgCode] AS '组织编码'
      ,[PosNo] AS '收款机号'
      ,[UserCode] AS '用户编码'
      ,[CshName] AS '收银员姓名'
      ,[LrDate] AS '录入日期'
      ,[JzDate] AS '结账日期'
      ,[PayCode]
      ,[BillNo]      
      ,[UserID]      
      ,[YHandTotal]
      ,[SHandTotal]
      ,[BgnSaleNo]
      ,[EndSaleNo]
      ,[Tag] AS '上传标志'
      ,[Remark]      
      ,[CshId]
      ,[CshCode]
      
  FROM [posctrl2010].[dbo].[tCvsHandCash]
GO