--���۽����ظ���ˮ�쳣���ݱ�
select * FROM tSysRSaleERR;
--������Ʒ�ظ���ˮ�쳣���ݱ�
select * FROM tSysRSalePluERR;
--���۸����ظ���ˮ�쳣���ݱ�
select * FROM tSysRSalePayERR;
--������Ʒ�Ż��ظ���ˮ�쳣���ݱ�
select * FROM tSysRSalePluDscERR;
--�տ���ظ���־��ˮ�쳣���ݱ�
select * FROM tSysRPosLogERR;

SELECT * FROM tSysBillType
ORDER BY BillCode

SELECT * FROM tSysOverLog WHERE OrgCode = '3001' ORDER BY ItemCode

SELECT * FROM tSalSale WHERE JzDate = NULL