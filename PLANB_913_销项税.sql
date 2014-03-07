/****
*913_非独立门店配送验收
*****/
--SELECT * FROM tSysYwType ORDER BY YwType
--SELECT * FROM tDstPsHead
--SELECT * FROM tDstPsBody
--SELECT SUM(HCOST) FROM tOrdJhHead WHERE JZDATE BETWEEN '2012-02-01' AND '2012
-- -02-10' AND HORGCODE IN ('2002','7001')
--SELECT * FROM tOrdJhBody WHERE BillNo = '1001JHYW201202020665'
--SELECT * FROM tOrgManage
--SELECT * FROM TSALPLUDETAIL201202
----------------------------------------
2012-03-02 20:21:09 (913#)
----------------------------------------
SELECT
  BillNo,
  YwType,
  RptDate AS DjDate ,
  hCost,
  wCost,
  SupCode,
  SupName
FROM
  tOrdJhhead a
INNER JOIN tOrgManage b
ON
  a.OrgCode=b.OrgCode
WHERE
  RptDate   >='2012-02-01'
AND RptDate <='2012-02-10'
AND ForgCode ='CW01'
AND YwType   ='0908'
AND ForgCode ='CW01'
AND a.orgcode='7001'
ORDER BY
  billno
------------------------------------------
-- 2012-03-02 20:21:09  (913#)
------------------------------------------
SELECT
  '1001JHYW201202010413' AS BillNo,
  c.BillType,
  '0908' AS YwType,
  c.OrgCode,
  c.OrgName,
  (
    SELECT
      depcode
    FROM
      torgdept
    WHERE
      depid=d.Depid
  ) AS depcode,
  (
    SELECT
      depname
    FROM
      torgdept
    WHERE
      depid=d.Depid
  ) AS depname,
  (
    SELECT
      ClsCode
    FROM
      tcatcategory
    WHERE
      clsid=e.Clsid
  ) AS ClsCode,
  (
    SELECT
      ClsName
    FROM
      tcatcategory
    WHERE
      clsid=e.Clsid
  ) AS ClsName,
  TO_CHAR(
  (
    SELECT
      jtaxrate
    FROM
      tstkpc
    WHERE
      pcno=d.pcno
  )
  ) AS taxrate,
  c.CkCode,
  c.CkName,
  (
    SELECT
      HtCode
    FROM
      tCntContract
    WHERE
      Cntid=d.Cntid
  ) AS HtCode,
  (
    SELECT
      HtName
    FROM
      tCntContract
    WHERE
      Cntid=d.Cntid
  ) AS HtName,
  d.PluCode,
  d.PluName,
  d.Unit,
  d.EtpCode AS SupCode,
  (
    SELECT
      EtpName
    FROM
      tEtpSupplier
    WHERE
      EtpCode  =d.EtpCode
    AND OrgCode=c.OrgCode
  ) AS SupName,
  d.HCost,
  d.WCost,
  d.JyMode,
  d.JsCode
FROM
  tStkKcjzHead201202 c,
  tStkKcjzBody201202 d,
  tskuplu e
WHERE
  c.billno                =d.billno
AND '1001JHYW201202010413'=c.Ywbillno
AND '0908'                =c.Ywtype
AND d.Pluid               =e.Pluid
  -----------
  --mExtraLimits=1;
  -----------
  --[Select BillNo,YwType,]+&DjDate+[,hCost,wCost,SupCode,SupName]+&et+[from
  --tOrdJhHead]+&innerjoin+[where]+&rqscop+&and_forg+&and_org
  --+[ and YwType='0908']+&et
  --+[ and ForgCode=']+mZbForgCode+[']+&et
  --+[ and a.orgcode in (']+hjm+[',']+yiyang+[')]+&et
  --+[ order by billno]
  --===================
  --[SELECT a.BillNo, a.YwType, a.]+&DjDate+[, a.hCost, a.wCost, a.SupCode,
  --a.SupName, c.jtaxrate AS taxrate]+&et
  --+[FROM tOrdJhHead a, tOrdJhBody c]+&et
  --+[WHERE a.BillNo = c.BillNo]+&et
  --+[ AND ]+&rqscop+&and_forg+&et
  --+[ AND ForgCode=']+mZbForgCode+[']+&et
  --+[ and a.orgcode in (']+hjm+[',']+yiyang+[')]+&et
  --+[ order by billno]
  --===================
  -----------
  --Select BillNo,YwType, RptDate as DjDate ,hCost,wCost,SupCode,SupName
  --from tOrdJhHead a inner join tOrgManage b on a.OrgCode=b.OrgCode
  --where RptDate>='2012-02-01' and RptDate<='2012-02-10'
  --and ForgCode='CW01'
  --and YwType='0908'
  --and ForgCode='CW01'
  --and a.orgcode in ('7001','2002')
  --order by billno 