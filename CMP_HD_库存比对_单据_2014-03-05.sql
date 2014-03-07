----CMP与WMS单据商品库存比对------
SELECT cmp.type        AS "单据类型",
  cmp.BillNo           AS "海信单据数量",
  wms.num              AS "海鼎单据数量",
  cmp.BillNo - wms.num AS "数量差异"
FROM
  (SELECT '采购验收' type,
    COUNT(DISTINCT OJH.BillNo) BillNo
  FROM tOrdJhHead OJH,
    tOrdJhBody OJB
  WHERE OJH.JzDate >= '2013-11-27'
  AND OJH.YwType    = '0905'
  AND OJH.OrgCode   = 'ZB'
  AND OJH.BillNo    = OJB.BillNo
  UNION ALL
  SELECT '采购退货'type,
    COUNT(DISTINCT OTH.BillNo) BillNo
  FROM tOrdThHead OTH,
    tOrdThBody OTB
  WHERE OTH.JzDate >= '2013-11-27'
  AND OTH.YwType    = '0914'
  AND OTH.BillNo    = OTB.BillNo
  UNION ALL
  SELECT '配送退货' type,
    COUNT(DISTINCT DRH.BillNo) BillNo
  FROM tDstRtnHead DRH,
    tDstRtnBody DRB
  WHERE DRH.JzDate >= '2013-11-27'
  AND DRH.YwType    = '2004'
  AND DRH.BillNo    = DRB.BillNo
  UNION ALL
  SELECT '配送单' type,
    COUNT(DISTINCT DPH.BillNO) BillNo
  FROM tDstPsHead DPH
  WHERE DPH.LrDate >= '2013-11-27'
  AND DPH.JzDate   IS NOT NULL
  AND YwType       IN ('2003','2007')
  UNION ALL
  SELECT '溢余单' type,
    COUNT(DISTINCT SUBSTR(CLH.remark,1,14)) BillNo
  FROM tCouLsPdHead CLH,
    tCouLsPdBody CLB
  WHERE CLH.JzDate >= '2013-11-27'
  AND CLH.OrgCode   = 'ZB'
  AND CLH.BillNo    = CLB.BillNo
  AND CLH.remark LIKE '%自动生成%'
  AND CLB.ykcount>0
  UNION ALL
  SELECT '损耗单' type,
    COUNT(DISTINCT SUBSTR(CLH.remark,1,14)) BillNo
  FROM tCouLsPdHead CLH,
    tCouLsPdBody CLB
  WHERE CLH.JzDate >= '2013-11-27'
  AND CLH.OrgCode   = 'ZB'
  AND CLH.BillNo    = CLB.BillNo
  AND CLH.remark LIKE '%自动生成%'
  AND CLB.ykcount<0
  ) cmp,
  (SELECT a.type,
    a.num
  FROM
    (SELECT '采购验收' type,
      COUNT(DISTINCT a.fsrcnum) num
    FROM tord@HDWMS a ,
      torddtl@HDWMS b
    WHERE a.num            =b.num
    AND a.wmsexchangetime IS NOT NULL
    AND a.stat             ='6500'
    UNION ALL
    SELECT '损耗单' type,
      COUNT(DISTINCT A.NUM) num
    FROM TDECINV@HDWMS A ,
      TDECINVDTL@HDWMS L
    WHERE A.NUM   =L.NUM
    AND a.FSNDTIME>'2013-12-27'
    AND A.STAT    ='100'
    UNION ALL
    SELECT '溢余单'type,
      COUNT(DISTINCT a.num) num
    FROM tincinv@HDWMS a ,
      tincinvdtl@HDWMS b
    WHERE a.num     =b.num
    AND a.stat      ='100'
    AND a.fsndtime IS NOT NULL
    AND a.fsndtime  >'2013-12-27'
    UNION ALL
    SELECT '配送退货' type,
      COUNT(DISTINCT A.FSRCNUM) num
    FROM TSTORERTNNTC@HDWMS A ,
      TSTORERTNNTCDTL@HDWMS B
    WHERE A.FSENDTIME IS NOT NULL
    AND A.NUM          =B.NUM
    UNION ALL
    SELECT '采购退货' type,
      COUNT(DISTINCT a.fsrcnum) num
    FROM tvendorrtnreq@HDWMS a ,
      tvendorrtnreqdtl@HDWMS b
    WHERE a.num            =b.num
    AND a.wmsexchangetime IS NOT NULL
    UNION ALL
    SELECT '配送单' type,
      COUNT(DISTINCT c.fsrcnum)
    FROM tship@HDWMS a ,
      tshipdtl@HDWMS b ,
      talcntc@HDWMS c
    WHERE a.num            =b.num
    AND b.falcntcnum       =c.num
    AND a.wmsexchangetime IS NOT NULL
    ) a
  )wms
WHERE cmp.type=wms.type
ORDER BY cmp.BillNo;
