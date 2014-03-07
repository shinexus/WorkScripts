SELECT
  hd.billno,
  hd.JzDate,
  hd.orgcode,
  bd.plucode,
  SUM(bd.thcount) AS thcount,
  ls.kccount,
  (SUM(bd.thcount)-ls.kccount) AS cy
FROM
  tOrdThHead hd,
  tOrdThBody bd,
  (
    SELECT
      kc.orgcode,
      plu.plucode,
      SUM(kc.kccount) AS kccount
    FROM
      tstklskc kc,
      tskuplu plu
    WHERE
      kc.pluid=plu.pluid
    GROUP BY
      kc.orgcode,
      plu.plucode
  )
  ls
WHERE
  hd.billno    =bd.billno
AND hd.orgcode =ls.orgcode
AND bd.plucode =ls.plucode
AND hd.LrDate >='2013-11-27'
AND hd.jzdate IS NULL
AND hd.YwType  = '0912'
GROUP BY
  hd.billno,
  hd.JzDate,
  hd.orgcode,
  bd.plucode,
  ls.kccount
HAVING
  (
    SUM(bd.thcount)-ls.kccount
  )
  >0
ORDER BY
  hd.orgcode,
  bd.plucode;
