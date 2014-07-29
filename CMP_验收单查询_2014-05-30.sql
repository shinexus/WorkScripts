/**** ���յ�����        ****/
/**** YwType = '0904' �����ɹ����� ****/
/**** YwType = '0905' �ŵ�ɹ�����
/**** YwType = '0906' �޲ɹ�����
/**** YwType = '0907' ֱ������
/**** YwType = '0908' ��������    ****/
SELECT *
FROM tOrdJhHead
WHERE YwType = '0905'
AND HtCode = '002941'
AND RptDate BETWEEN '2014-06-01' AND '2014-06-01'
ORDER BY JzDate DESC;

/*************************************************************/
SELECT * FROM tOrdJhBody WHERE BillNo IN (
SELECT BillNo
FROM tOrdJhHead
WHERE YwType = '0905'
AND HtCode = '002941'
AND RptDate BETWEEN '2014-06-01' AND '2014-06-01'
);

SELECT OJH.BillNo,
  OJH.JzDate,
  OJH.JzrName,
  OJH.RptDate,
  OJH.OrgCode,
  OJH.OrgName,
  OJB.PluCode,
  OJB.PluName,
  SUM(OJB.JhCount),
  SUM(OJB.HCost),
  SUM(OJB.WCost),
  SUM(OJB.STotal),
  SUM(OJB.CjTotal)
FROM tOrdJhHead OJH,
  tOrdJhBody OJB
WHERE OJH.YwType = '0905'
AND OJH.HtCode   = '002941'
AND OJH.BillNo   = OJB.BillNo
AND RptDate BETWEEN '2014-06-01' AND '2014-06-01'
GROUP BY PluCode,
  OJH.BillNo,
  OJH.JzDate,
  OJH.JzrName,
  OJH.RptDate,
  OJH.OrgCode,
  OJH.OrgName,
  OJB.PluCode,
  OJB.PluName
ORDER BY BillNo DESC;

/**** 9990823308 ��򱱴������(��Ʒ�� ****/
/**** 9990923309 ��򱱴������(����Ʒ�� ****/
SELECT * FROM tOrdJhHead WHERE BillNo = '1001JHYW201407213191';
/**** �޸ĺ�ͬ ****/
--UPDATE tOrdJhHead SET HtCode = '9990823308' WHERE BillNo = '1001JHYW201407213191';

/**** �޸ĵ���״̬ ****/
/**** 0��¼�룻1��������2��ת��3���ύ��4-�ɼ��ˣ�9-�ر� ****/
/**** JzRId = '91' ****/
/**** TjDate = NULL ****/
--UPDATE tOrdJhHead SET DataStatus = '9' WHERE BillNo = '1001JHYW201407213191';
--UPDATE tOrdJhHead SET TjDate = NULL, JzDate = NULL WHERE BillNo = '1001JHYW201407213191';

/**** �޸Ĳɹ��� ****/
/**** YwStatus 0-δִ�У�1-ִ���У�2-ִ����ɣ�3-�˹��᰸��4-�����Զ��᰸ ****/
/**** ʵ������ SDCount ****/
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201407210172';
SELECT * FROM tOrdCgBody WHERE BillNo = '1001201407210172';
--UPDATE tOrdCgHead SET SDCount = '0', YwStatus = '1' WHERE BillNo = '1001201407210172';
--UPDATE tOrdCgBody SET SDCount = '0' WHERE BillNo = '1001201407210172';

/**** ���������� ****/
/**** ��˰���۽�HCost����δ˰���۽�WCost����˰�JTaxTotal����������ۣ�CjTotal�� ****/
--UPDATE tOrdJhHead SET HCost = '0', WCost = '0', JTaxTotal = '0', CjTotal = '0' WHERE BillNo = '1001JHYW201407213191';

/**** ������ϸ���� ****/
/**** ��˰���ۣ�HjPrice����δ˰���ۣ�WjPrice����˰�ʣ�JTaxRate������˰���۽�HCost����δ˰���۽�WCost����˰�JTaxTotal����������ۣ�CjTotal�� ****/
SELECT * FROM tOrdJhBody WHERE BillNo = '1001JHYW201407213191';
--UPDATE tOrdJhBody SET HjPrice = '0', WjPrice = '0', JTaxRate = '0', HCost = '0', WCost = '0', JTaxTotal = '0', CjTotal = '0' WHERE BillNo = '1001JHYW201407213191';

/**** �޸�������� ****/
SELECT * FROM tStkLsKc WHERE PluId = (SELECT PluId FROM tSkuPlu WHERE PluCode = '450004082') AND OrgCode = '0001';
SELECT * FROM tStkLsKc WHERE PcGUID = '1001JHYW201407213191000001' AND PcNo = '1001JHYW201407213191000001' AND HCost = '2916';
--DELETE  FROM tStkLsKc WHERE PcGUID = '1001JHYW201407213191000001' AND PcNo = '1001JHYW201407213191000001' AND HCost = '2916';

/**** �޸Ŀ����˵� ****/
SELECT * FROM tStkKcJzHead;
SELECT * FROM tStkKcJzBody WHERE PluCode = '450004082';

/**** Ӧ�����㵥�ݻ��ܱ� ****/
/**** 9990823308 ��򱱴������(��Ʒ����CntId��10010000007105 ****/
/**** ��˰������HFSTotal������˰������WFSTotal�� ****/
SELECT * FROM tCntContract WHERE HtCode = '9990823308';
SELECT * FROM tCntContract WHERE CntId = '10010000006331';

SELECT * FROM tAcpPayBill WHERE YwBillNo = '1001JHYW201407213191';
--UPDATE tAcpPayBill SET HtId = '10010000007105', HFSTotal = '0', WFSTotal = '0' WHERE YwBillNo = '1001JHYW201407213191';

SELECT * FROM tAcpJsHead WHERE HtId = '10010000006331';

/**** ���㵥ȷ����ϸ�� ****/
SELECT * FROM tAcpPayBillConfirmBody;
