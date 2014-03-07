--SELECT * FROM tDstRtnHead WHERE LrDate >= '2013-11-27'
--SELECT * FROM tDstRtnBody
SELECT
  DRB.PluCode,
  SUM(drb.thcount) ThCount
FROM
  tDstRtnHead DRH,
  tDstRtnBody DRB
WHERE
  DRH.BillNo   = DRB.BillNo
AND DRH.CkCode = '01'
AND DRH.TjrCode = '0043'
  --AND DRH.TjrName = '*'
AND DRH.LrDate >= '2013-11-27'
GROUP BY
  DRB.PluCode
ORDER BY
  DRB.PluCode