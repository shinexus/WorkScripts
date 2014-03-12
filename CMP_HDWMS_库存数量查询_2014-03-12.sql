SELECT CMP.*,
  WMS.*,
  CMP.KcCnt - WMS.WMQty AS CntQty
FROM
  (SELECT b.plucode,
    b.pluname,
    DECODE(a.ckcode,'01','01-������','02','02-����Ʒ��') CW,
    SUM(NVL(A.KCCOUNT,0)) KCCNT
  FROM tStkLsKc a,
    tskuplu b
  WHERE A.OrgCode = '0001'
  AND a.pluid     =b.pluid
  GROUP BY b.plucode,
    b.pluname,
    DECODE(a.ckcode,'01','01-������','02','02-����Ʒ��')
  ) cmp,
  (SELECT e.fcode,
    e.fname,
    DECODE(b.fwrhcode,'01','01-������','02','02-����Ʒ��') WR,
    SUM(NVL(S.FQTY,0)) WMQTY
  FROM tbinarticles@HDWMS s ,
    twrhzone@HDWMS b,
    tarticle@HDWMS e
  WHERE SUBSTR(s.fbin,1,2)=b.fcode
  AND s.farticle          =e.fgid
  GROUP BY e.fcode,
    e.fname,
    DECODE(b.fwrhcode,'01','01-������','02','02-����Ʒ��')
  )WMS
WHERE CMP.plucode=WMS.fcode(+)
AND CMP.CW       =WMS.WR(+)
AND CMP.KCCNT   <>WMS.WMQTY
ORDER BY CMP.plucode;