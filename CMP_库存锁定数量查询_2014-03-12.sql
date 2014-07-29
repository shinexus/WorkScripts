SELECT * FROM tStkLsKcLock WHERE YwBillNo = '1001PSYW201402200010';
/****
DELETE FROM tStkLsKcLock WHERE YwBillNo = '1001PSYW201402200010';
****/

SELECT SLK.YwBillNo,
  DPH.ShOrgCode,
  SLK.YwType,
  SLK.OrgCode,
  SLK.CkCode,
  SP.PluCode,
  SP.PluName,
  SLK.LockCount,
  SLK.LockDate
FROM tStkLsKcLock SLK,
  tSkuPlu SP,
  tDstPsHead DPH
WHERE SLK.PluID = SP.PluID
AND SP.PluCode LIKE '%%'
AND SLK.OrgCode LIKE '%%'
AND SLK.YwBillNo = DPH.BillNo
AND SLK.LockDate BETWEEN '2014-01-01' AND SysDate
ORDER BY LockDate;

SELECT * FROM tStkLsKcLock
WHERE PluId = (SELECT PluId FROM tSkuPlu WHERE PluCode = '200203030')
ORDER BY LockDate DESC;