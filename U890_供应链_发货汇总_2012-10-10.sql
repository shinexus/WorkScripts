-- DispatchList:	�����˻�������
-- csvouchtype:		��Դ��������
-- cDLCode:			�����˻�����
-- dverifydate:		�������
-- dverifysystime:	���ʱ��
-- cVouchType:		�������ͱ���
-- cCusCode:		�ͻ�����
select * from DispatchList
WHERE cCusCode LIKE '030100%'
AND DLID = '38367'
ORDER BY dDate

-- DispatchLists:	�����˻����ӱ�
-- DLID:			�����˻��������ʶ
-- cInvCode:		�������
-- iQuantity:		����
-- cMemo:			��ע
-- cUnitID:			������λ����
SELECT * FROM DispatchLists
WHERE DLID = '38367'

-- Inventory:		�������
-- cInvStd:			����ͺ�
-- cComUnitCode:	��������λ����
-- cAssComUnitCode:	��������λ����
SELECT * FROM Inventory

-- ComputationUnit:	������λ
SELECT * FROM ComputationUnit