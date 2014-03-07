SELECT
  SUM(HCOST)
FROM
  (
    SELECT
      a.RptDate AS Rq,
      a.SaleNo  AS BillNo,
      ''        AS BillType,
      ''        AS YwType,
      a.OrgCode,
      a.OrgName,
      a.DepCode,
      a.DepName,
      a.ClsCode,
      a.ClsName,
      TO_CHAR(JTaxRate) AS TaxRate,
      ''                AS CkCode,
      ''                AS CkName,
      a.JhHtCode        AS HtCode,
      (
        SELECT
          HtName
        FROM
          tCntContract
        WHERE
          HtCode=a.JhHtCode
      ) AS HtName,
      a.EtpCode,
      a.EtpName,
      a.PluCode,
      a.PluName,
      a.Unit,
      a.JhEtpCode AS SupCode,
      a.JhEtpName AS SupName,
      a.HJCost    AS HCost,
      a.WJCost    AS WCost,
      a.JyMode,
      a.JhJsCode                      AS JsCode,
      TO_CHAR(a.XsDate, 'yyyy-mm-dd') AS YwDate,
      a.datatype,
      KcBillNo
    FROM
      TSALPLUDETAIL201205 a
    INNER JOIN tOrgManage b
    ON
      a.OrgCode=b.OrgCode
    WHERE
      b.FOrgCode='CW01'
    AND RptDate>='2012-05-01'
    AND RptDate<='2012-05-01'
  )
WHERE
  JsCode       ='2'
AND NOT supCode='00099'
AND htcode    <>'001012'
AND orgcode   <>'7001'
AND HtCode = '001451'