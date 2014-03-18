/*********************************************************************
SELECT CMP.*,
  WMS.*,
  CMP.KcCnt - WMS.WMQty AS CntQty
FROM
  (SELECT b.plucode,
    b.pluname,
    DECODE(a.ckcode,'01','01-正常仓','02','02-不良品仓') CW,
    SUM(NVL(A.KCCOUNT,0)) KCCNT
  FROM tStkLsKc a,
    tskuplu b
  WHERE A.OrgCode = '0001'
  AND a.pluid     =b.pluid
  GROUP BY b.plucode,
    b.pluname,
    DECODE(a.ckcode,'01','01-正常仓','02','02-不良品仓')
  ) cmp,
  (SELECT e.fcode,
    e.fname,
    DECODE(b.fwrhcode,'01','01-正常仓','02','02-不良品仓') WR,
    SUM(NVL(S.FQTY,0)) WMQTY
  FROM tbinarticles@HDWMS s ,
    twrhzone@HDWMS b,
    tarticle@HDWMS e
  WHERE SUBSTR(s.fbin,1,2)=b.fcode
  AND s.farticle          =e.fgid
  GROUP BY e.fcode,
    e.fname,
    DECODE(b.fwrhcode,'01','01-正常仓','02','02-不良品仓')
  )WMS
WHERE CMP.plucode=WMS.fcode(+)
AND CMP.CW       =WMS.WR(+)
AND CMP.KCCNT   <>WMS.WMQTY
ORDER BY CMP.plucode;
*********************************************************************/

/******************************************************************************************/
SELECT plucode,
  pluname,
  cw,
  kccnt,
  fcode,
  fname,
  wr,
  wmqty,
  kccnt-wmqty AS CntQty,
  WmQty-KcCnt AS SYCOUNT
FROM
  (SELECT DECODE(CMP.plucode,NULL,fcode,plucode) AS plucode,
    cmp.pluname,
    DECODE(cmp.cw,NULL,wr,cw)      AS cw,
    DECODE(cmp.kccnt,NULL,0,kccnt) AS kccnt,
    WMS.fcode,
    wms.fname,
    wms.wr,
    DECODE(wms.wmqty,NULL,0,wmqty) AS wmqty
  FROM
    (SELECT b.plucode,
      b.pluname,
      DECODE(a.ckcode,'01','01-正常仓','02','02-不良品仓') CW,
      SUM(NVL(A.KCCOUNT,0)) KCCNT
    FROM tStkLsKc a,
      tskuplu b
    WHERE A.OrgCode = '0001'
    AND a.pluid     =b.pluid
    GROUP BY b.plucode,
      b.pluname,
      DECODE(a.ckcode,'01','01-正常仓','02','02-不良品仓')
    ) cmp
  FULL JOIN
    (SELECT e.fcode,
      e.fname,
      DECODE(b.fwrhcode,'01','01-正常仓','02','02-不良品仓') WR,
      SUM(NVL(S.FQTY,0)) WMQTY
    FROM tbinarticles@HDWMS s ,
      twrhzone@HDWMS b,
      tarticle@HDWMS e
    WHERE SUBSTR(s.fbin,1,2)=b.fcode
    AND s.farticle          =e.fgid
    GROUP BY e.fcode,
      e.fname,
      DECODE(b.fwrhcode,'01','01-正常仓','02','02-不良品仓')
    )WMS
  ON CMP.plucode   =WMS.fcode
  AND CMP.CW       =WMS.WR
  WHERE CMP.KCCNT <>WMS.WMQTY
  OR (KCCNT       <>0
  AND wms.WMQTY   IS NULL)
  OR (WMS.WMQTY   <>0
  AND kccnt       IS NULL))
  WHERE PluCode IN (
'240003003',
'240007017',
'240006014',
'240000004',
'240004002',
'240003016',
'210406011',
'210400095',
'240006019',
'240006017',
'200205035',
'200209046',
'250003009',
'250003007',
'250000023',
'210303026',
'240003002',
'240000003',
'240004001',
'200403064',
'250002006',
'230203034',
'200001026',
'240006016',
'240007020',
'220207010',
'220204001',
'220208004',
'220207011',
'220002004',
'200501015',
'200500049',
'200004006',
'220200008',
'220200010',
'200900003',
'200609007',
'200505031',
'240006011',
'240006024',
'220208007',
'220201003',
'220208009',
'220208005',
'230001286',
'230001287',
'230002026',
'230002040',
'230003002',
'200403069',
'200303084',
'200203041',
'240007034',
'200300079',
'200300080',
'220100016',
'220106004',
'220306004',
'220306003',
'230203038',
'210200001',
'200502006',
'240007036',
'230202014',
'240104001',
'210406021',
'210406020',
'240006015',
'240006023',
'200303081',
'240003013',
'240000009',
'210204048',
'210204018',
'210200019',
'210200034',
'210200043',
'210200018',
'210200044',
'210202001',
'210204044',
'210202007',
'210204019',
'210204051',
'210204041',
'220302009',
'210200042',
'210204034',
'200205042',
'210200004',
'210200003',
'210204006',
'210200002',
'210204004',
'240006004',
'210400008',
'220202005',
'220208027',
'210304009',
'210304010',
'210304008'  )
ORDER BY plucode;