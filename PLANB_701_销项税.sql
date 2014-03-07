--SELECT * FROM tSysYwType ORDER BY YwType
--SELECT * FROM tStkPc@ZBCMP WHERE PCNO = '1001JHYW201202010003600001'
--SELECT * FROM tDstPsBody
--SELECT * FROM tOrdJhHead
--SELECT * FROM tOrdJhBody WHERE BillNo = '1001JHYW201202020665'
--SELECT * FROM tOrgManage
--SELECT * FROM tStkKcjzHead201202 WHERE JzDate BETWEEN '2012-02-01' AND '2012-02-10' ORDER BY YwBillNo
--SELECT * FROM tStkKcjzBody201202 WHERE BillNo = '1001KCJZ120201000008'

----------------------------------------
-- 2012-03-02 16:09:56  (701#)
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
  RptDate  >='2012-02-01'
AND RptDate<='2012-02-10'
AND ForgCode='CW01'
AND YwType IN ('0904','0905','0906','0907')
AND NOT
  (
    SupCode='00155'
  )
AND a.orgcode  IN ('7001','2002')
AND htcode NOT IN ('002941','002942','005011')
ORDER BY
  billno
END;
----------------------------
--  2012-03-02 16:09:56  (701#)
----------------------------
SELECT
  '1001JHYW201202010003' AS BillNo,
  c.BillType,
  '0907' AS YwType,
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
AND '1001JHYW201202010003'=c.Ywbillno
AND '0907'                =c.Ywtype
AND d.Pluid               =e.Pluid
