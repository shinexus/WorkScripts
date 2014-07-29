/**** 验收单主表        ****/
/**** YwType = '0904' 物流采购验收 ****/
/**** YwType = '0905' 门店采购验收
/**** YwType = '0906' 无采购验收
/**** YwType = '0907' 直送验收
/**** YwType = '0908' 配送验收    ****/
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

/**** 9990823308 天津北大荒望捷(赠品） ****/
/**** 9990923309 天津北大荒望捷(进口品） ****/
SELECT * FROM tOrdJhHead WHERE BillNo = '1001JHYW201407213191';
/**** 修改合同 ****/
--UPDATE tOrdJhHead SET HtCode = '9990823308' WHERE BillNo = '1001JHYW201407213191';

/**** 修改单据状态 ****/
/**** 0－录入；1－审批；2－转审；3－提交；4-可记账；9-关闭 ****/
/**** JzRId = '91' ****/
/**** TjDate = NULL ****/
--UPDATE tOrdJhHead SET DataStatus = '9' WHERE BillNo = '1001JHYW201407213191';
--UPDATE tOrdJhHead SET TjDate = NULL, JzDate = NULL WHERE BillNo = '1001JHYW201407213191';

/**** 修改采购单 ****/
/**** YwStatus 0-未执行；1-执行中；2-执行完成；3-人工结案；4-超期自动结案 ****/
/**** 实到数量 SDCount ****/
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201407210172';
SELECT * FROM tOrdCgBody WHERE BillNo = '1001201407210172';
--UPDATE tOrdCgHead SET SDCount = '0', YwStatus = '1' WHERE BillNo = '1001201407210172';
--UPDATE tOrdCgBody SET SDCount = '0' WHERE BillNo = '1001201407210172';

/**** 更新主表金额 ****/
/**** 含税进价金额（HCost）、未税进价金额（WCost）、税额（JTaxTotal）、进销差价（CjTotal） ****/
--UPDATE tOrdJhHead SET HCost = '0', WCost = '0', JTaxTotal = '0', CjTotal = '0' WHERE BillNo = '1001JHYW201407213191';

/**** 更新明细表金额 ****/
/**** 含税进价（HjPrice）、未税进价（WjPrice）、税率（JTaxRate）、含税进价金额（HCost）、未税进价金额（WCost）、税额（JTaxTotal）、进销差价（CjTotal） ****/
SELECT * FROM tOrdJhBody WHERE BillNo = '1001JHYW201407213191';
--UPDATE tOrdJhBody SET HjPrice = '0', WjPrice = '0', JTaxRate = '0', HCost = '0', WCost = '0', JTaxTotal = '0', CjTotal = '0' WHERE BillNo = '1001JHYW201407213191';

/**** 修改连锁库存 ****/
SELECT * FROM tStkLsKc WHERE PluId = (SELECT PluId FROM tSkuPlu WHERE PluCode = '450004082') AND OrgCode = '0001';
SELECT * FROM tStkLsKc WHERE PcGUID = '1001JHYW201407213191000001' AND PcNo = '1001JHYW201407213191000001' AND HCost = '2916';
--DELETE  FROM tStkLsKc WHERE PcGUID = '1001JHYW201407213191000001' AND PcNo = '1001JHYW201407213191000001' AND HCost = '2916';

/**** 修改库存记账单 ****/
SELECT * FROM tStkKcJzHead;
SELECT * FROM tStkKcJzBody WHERE PluCode = '450004082';

/**** 应付结算单据汇总表 ****/
/**** 9990823308 天津北大荒望捷(赠品），CntId：10010000007105 ****/
/**** 含税发生金额（HFSTotal）、无税发生金额（WFSTotal） ****/
SELECT * FROM tCntContract WHERE HtCode = '9990823308';
SELECT * FROM tCntContract WHERE CntId = '10010000006331';

SELECT * FROM tAcpPayBill WHERE YwBillNo = '1001JHYW201407213191';
--UPDATE tAcpPayBill SET HtId = '10010000007105', HFSTotal = '0', WFSTotal = '0' WHERE YwBillNo = '1001JHYW201407213191';

SELECT * FROM tAcpJsHead WHERE HtId = '10010000006331';

/**** 结算单确认明细表 ****/
SELECT * FROM tAcpPayBillConfirmBody;
