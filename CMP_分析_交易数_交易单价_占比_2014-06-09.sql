/**** ��֯1002��2014-04��ˮ ****/
SELECT * FROM tSalSale201404 WHERE OrgCode = '1002';

/**** ��ˮ������60899 ****/
SELECT COUNT(SaleNo) FROM tSalSale201404 WHERE OrgCode = '1002';

/**** ȫ����ˮƽ��ʵ�ս����׵��ۣ���48.81 ****/
SELECT AVG(SsTotal) FROM tSalSale201404 WHERE TranType <> '5' AND OrgCode = '1002';

/**** С��ƽ�����׵��ۣ�48.81����ˮ������53415��ռ��87.71% ****/
SELECT COUNT(SaleNo) FROM tSalSale201404 WHERE OrgCode = '1002' AND SsTotal <= '48.81';
SELECT (53415/60899)*100 FROM DUAL;

/**** ������ƽ�����׵��ۣ�48.81����ˮ������7484��ռ��12.29% ****/
SELECT COUNT(SaleNo) FROM tSalSale201404 WHERE OrgCode = '1002' AND SsTotal >= '48.81';
SELECT (7484/60899)*100 FROM DUAL;

/**** ============================================================================================================ ****/
SELECT AVG(SsTotal) FROM tSalSale201404 WHERE TranType <> '5';
SELECT OrgCode, COUNT(SaleNo), SUM(SsTotal), AVG(SsTotal) FROM tSalSale201401 WHERE TranType <> '5' GROUP BY OrgCode ORDER BY OrgCode;
SELECT OrgCode, COUNT(SaleNo), SUM(SsTotal), AVG(SsTotal) FROM tSalSale201402 WHERE TranType <> '5' GROUP BY OrgCode ORDER BY OrgCode;
SELECT OrgCode, COUNT(SaleNo), SUM(SsTotal), AVG(SsTotal) FROM tSalSale201403 WHERE TranType <> '5' GROUP BY OrgCode ORDER BY OrgCode;
SELECT OrgCode, COUNT(SaleNo), SUM(SsTotal), AVG(SsTotal) FROM tSalSale201404 WHERE TranType <> '5' GROUP BY OrgCode ORDER BY OrgCode;
SELECT OrgCode, COUNT(SaleNo), SUM(SsTotal), AVG(SsTotal) FROM tSalSale201405 WHERE TranType <> '5' GROUP BY OrgCode ORDER BY OrgCode;

/**** 24.42 ****/
SELECT AVG(SsTotal) FROM tSalSale201404 WHERE TranType <> '5' AND OrgCode = '1002';

SELECT COUNT(SaleNo) FROM tSalSale201404 WHERE OrgCode = '1001' AND SsTotal <= '24.42';

/**** 43864 ****/
SELECT COUNT(SaleNo) FROM tSalSale201404 WHERE OrgCode = '1002' AND SsTotal <= '24.42';
SELECT (43864/60899)*100 FROM DUAL;
/****  ****/
SELECT COUNT(SaleNo) FROM tSalSale201404 WHERE OrgCode = '1002' AND SsTotal >= '24.42';
SELECT (17036/60899)*100 FROM DUAL;

select saleno,orgcode,sstotal from tsalsale201403 where sstotal>10000 AND OrgCode = '2008';
