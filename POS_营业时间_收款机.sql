/*���������޸�*/
--�տ��
--����տ����������
select * from tjkPosjzdate

--�޸��տ����������
UPDATE tJkPosJzDate SET JzDate = '2012-04-05', LastJzDate = '2012-04-04'

--����տ����ˮ
SELECT * FROM tSalSale WHERE JzDate = '2012-04-07'

--�޸��տ����ˮ
UPDATE tSalSale SET JzDate = '2012-04-06' WHERE JzDate='2012-04-07'

--�տ�����
--����տ����ˮ
SELECT * FROM tSalSale WHERE PosNo='0009' AND JzDate = '2012-04-07'

--�޸��տ����ˮ
UPDATE tSalSale SET JzDate = '2012-04-06' WHERE PosNo = '0009' AND JzDate='2012-04-07'

--ҵ�����ݿ�
--����տ����ˮ

--�޸��տ����ˮ

/*��ˮ�����޸�*/
--�տ��
SELECT * FROM tSalSale
--2010-01-01;2012-04-11
UPDATE tSalSale SET XsDate = DATEADD (MONTH,27,XsDate)
UPDATE tSalSale SET XsDate = DATEADD (DAY,10,XsDate)
