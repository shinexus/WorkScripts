SELECT [OrgCode] AS '��֯����',[PosNo] AS '�տ����',[UserCode] AS '�û�����',[CshName] AS '����Ա����',[LrDate] AS '¼������',[JzDate] AS '��������',CASE [PayCode] WHEN '0' THEN '�ֽ�' WHEN '2' THEN '���п�' WHEN '4' THEN '����ȯ' WHEN '8' THEN '���п�' WHEN '51' THEN '��ͨ��' END AS '֧������',[YHandTotal] AS 'Ӧ�����',[SHandTotal] AS 'ʵ�����',[Tag] AS '�ϴ���־' FROM [posdb1001].[dbo].[tCvsHandCash]
GO

/*
SELECT [OrgCode] AS '��֯����'
      ,[PosNo] AS '�տ����'
      ,[UserCode] AS '�û�����'
      ,[CshName] AS '����Ա����'
      ,[LrDate] AS '¼������'
      ,[JzDate] AS '��������'
      ,[PayCode]
      ,[BillNo]      
      ,[UserID]      
      ,[YHandTotal]
      ,[SHandTotal]
      ,[BgnSaleNo]
      ,[EndSaleNo]
      ,[Tag] AS '�ϴ���־'
      ,[Remark]      
      ,[CshId]
      ,[CshCode]
      
  FROM [posctrl2010].[dbo].[tCvsHandCash]
GO