SELECT
  OrgJh.BillNo    AS "验收单据号",
  OrgJh.refbillno AS "验收配送单据号",
  OrgJh.horgcode  AS "货主组织编码",
  OrgJh.horgname  AS "货主组织名称",
  OrgJh.plucode   AS "验收商品编码",
  OrgJh.PsShCount AS "验收收货数量",
  DtsPs.BillNo    AS "配送单据号",
  DtsPs.ShOrgCode AS "收货组织编码",
  DtsPs.ShOrgName AS "收货组织名称",
  DtsPs.PluCode   AS "配送商品编码",
  DtsPs.PsCount   AS "配送数量"
FROM
  (
    SELECT
      JH.billno ,
      JH.refbillno ,
      JH.horgcode ,
      jh.horgname ,
      JB.plucode ,
      SUM(PsShCount) PsShCount
    FROM
      tOrdJhHead JH ,
      tOrdJhBody JB
    WHERE
      JH.RefBillType = '2003'
    AND JH.billno    =JB.billno
    GROUP BY
      JH.billno,
      JH.refbillno,
      JH.horgcode,
      JH.horgname,
      JB.pluid,
      JB.plucode
  )
  OrgJh,
  (
    SELECT
      PH.billno,
      PH.shorgcode,
      PH.shorgname,
      --PB.pluid,
      PB.plucode ,
      SUM(PB.pscount) pscount
    FROM
      tDstPsHead PH,
      tDstPsBody PB
    WHERE
      PH.billno   =PB.billno
    AND PH.pstype =0
    AND PH.jzdate>='2013-11-27'
    GROUP BY
      PH.billno,
      PH.shorgcode,
      PH.shorgname,
      --PB.pluid,
      PB.plucode
  )
  DtsPs
WHERE
  OrgJh.refbillno   =DtsPs.billno
AND OrgJh.PsShCount<>DtsPs.pscount
AND OrgJh.pluCode   =DtsPs.plucode