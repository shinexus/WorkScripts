
--251_��������Ʒ�ɱ�
--701_��������Ʒ�ɹ�����
--702_��������Ʒ�ɹ��˻�
--901_��Ʊ��ҵ��
--901_CB2��Ʊ��ҵ��
--901_CB��Ʊ��ҵ��
--913_����;���ܲ�����
--913_�Ƕ����ŵ���������
--914_�ŵ��˻����ܲ�
--914_�ܲ�����

SELECT * FROM [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document]
	WHERE Voucher_Id = '7252'
	
DELETE FROM [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document]
	WHERE Voucher_Id = '901'
	
INSERT INTO [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document]
	SELECT * FROM [FinanceInterface].[dbo].[Cmp2Fnc_Document]	
	WHERE Voucher_Id = '901'
	
SELECT * FROM [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document_Procedure]
	WHERE D_Name like '252%'
		
DELETE FROM [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document_Procedure]
	WHERE D_Name like '901%'

INSERT INTO [Pb_FinanceInterface].[dbo].[Cmp2Fnc_Document_Procedure]
	SELECT * FROM [FinanceInterface].[dbo].[Cmp2Fnc_Document_Procedure]
	--WHERE D_Name like '901%'
	WHERE D_Name = '901_��Ʊ��ҵ��'
