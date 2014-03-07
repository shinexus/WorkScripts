/**
SELECT * FROM tSysYwType ORDER BY YwType
**/
/****************************** 
**** 01仓库2013-11-30期末库存
**** JyMode = 0     经销
**** JyMode = 1     代销
**** JyMode = 2     联销
**** YwType = 0000  ？
**** YwType = 0902  采购
**** YwType = 0904  物流采购验收
**** YwType = 0905  门店采购验收
**** YwType = 0906  无采购验收
**** YwType = 0907  直送验收
**** YwType = 0908  配送验收
*******************************/

SELECT
  --*
  RptDate,
  RecCount
FROM
  tStkJxcRptSouce201312
WHERE
  OrgCode  = '0001'
--AND CkCode = '01'
AND PluID  =
  (
    SELECT
      PluID
    FROM
      tSkuPlu
    WHERE
      PluCode = '200401025'
  )
  AND RptDate >= '2013-12-04'
AND DataType = '2'

/******
SELECT
  --*
  SUM(LockCount)--1495
FROM
  tStkLsKcLock
WHERE
  Orgcode = '0001'
--AND LockDate BETWEEN '2013-11-27' AND '2013-12-05'
--AND LockDate >= '2013-11-27'
ORDER BY
  LockCount DESC
***/
/**
SELECT * FROM tSkuPlu WHERE PluID = '10010000001679'
**/
--DELETE FROM tStkLsKcLock WHERE YwBillNo = '1001PSYW201112040003' AND LockCount = '1'
--DELETE FROM tStkLsKcLock WHERE OrgCode = '0001' AND LockDate < '2013-11-27'
--SELECT YwStatus FROM tDstPsHead WHERE BillNo = '1001PSYW201312050002'
--UPDATE tDstPsHead SET YwStatus = '2' WHERE BillNo = '1001PSYW201312050002'

/****
SELECT * FROM tStkLsKc 
WHERE OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode='200401025')
ORDER BY KcCount DESC
****/