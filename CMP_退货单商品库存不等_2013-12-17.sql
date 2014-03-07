SELECT
  th.BillNo,
  th.RefBillNo,
  th.OrgCode,
  th.OrgName,
  th.BillType,
  th.YwType,
  th.LrDate,
  th.JzDate,
  th.CkCode,
  tb.PluCode,
  tb.PluType,
  tb.PluName,
  tb.ThCount,
  th.DataStatus,
  kc.kccount
FROM
  tOrdThHead th,
  tOrdThBody tb,
  (
    SELECT
      plu.plucode,
      ls.plutype,
      ls.orgcode,
      SUM(ls.kccount) AS kccount
    FROM
      tstklskc ls,
      tskuplu plu
    WHERE
      ls.pluid=plu.pluid
    GROUP BY
      plu.plucode,
      ls.plutype,
      ls.orgcode
  )
  kc
WHERE
  th.BillNo       = tb.BillNo
AND kc.plucode    = tb.plucode
AND tb.plutype    = kc.plutype
AND kc.orgcode    = th.orgcode
AND th.YwType     = '0912'
AND th.DataStatus = '9'
AND th.JzDate    IS NULL
AND th.LrDate    >= '2013-11-27'
ORDER BY
  th.LrDate ;
