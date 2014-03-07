--SELECT * FROM tOrdThHead WHERE BillNo IN (
--SELECT RefBillNo FROM tDstRtnHead WHERE JzDate IS NULL AND LrDate >= '2013-11-27')

SELECT
  pth.BillNo,
  pth.RefBillNo,
  th.YwType,
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
AND pth.JzDate IS NULL
AND th.LrDate  >= '2013-11-27'
ORDER BY
  Pth.RefBillNo;