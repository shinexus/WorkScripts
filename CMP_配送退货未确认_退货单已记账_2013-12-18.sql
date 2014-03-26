--SELECT * FROM tOrdThHead WHERE BillNo IN (
--SELECT RefBillNo FROM tDstRtnHead WHERE JzDate IS NULL AND LrDate >= '2013-11-27')
--SELECT * FROM tDstRtnHead WHERE BillNo = '1001PSTH201402130007';

SELECT
  pth.BillNo,
  pth.RefBillNo,
  th.YwType,
  pth.tjdate PthTjData,
  pth.JzDate PthJzDate,
  th.JzDate ThJzDate,
  pth.ThOrgCode,
  pth.ThOrgName,
  pth.ThCount PthThCount,
  th.ThCount
FROM
  tDstRtnHead pth,
  tOrdThHead th
WHERE
  pth.RefBillNo = th.BillNo
--AND pth.datastatus = '3'
AND pth.tjdate IS NOT NULL
AND pth.JzDate IS NULL
AND th.LrDate  >= '2013-11-27'
ORDER BY
  Pth.RefBillNo;
 
/**********************************************************/
SELECT '商品('
  || M.PluCode
  || ')存在同种类型多条明细数据'
FROM
  (SELECT PluCode,
    PluType
  FROM tDstRtnHead H,
    tDstRtnBody B
  WHERE H.BillNo=B.BillNo
  AND h.Billno  ='1001PSTH201403150004'
  ) M
GROUP BY PluCode,
  PluType
HAVING COUNT(1)>1;

/***********************************************************/
SELECT M.PluCode
FROM
  (SELECT PluCode,
    PluType
  FROM tDstRtnHead H,
    tDstRtnBody B
  WHERE H.BillNo=B.BillNo
  AND h.Billno  ='1001PSTH201403150004'
  ) M
GROUP BY PluCode,
  PluType
HAVING COUNT(1)>1;