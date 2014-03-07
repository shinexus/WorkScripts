--SELECT * FROM TSALPLUDETAIL201202
SELECT
  *
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
      TSALPLUDETAIL201202 a
    INNER JOIN tOrgManage b
    ON
      a.OrgCode=b.OrgCode
    WHERE
      b.FOrgCode='CW01'
    AND RptDate>='2012-02-01'
    AND RptDate<='2012-02-02'
  )
WHERE
  JsCode     ='2'
AND supCode <>'00099'
AND orgcode IN ('2002','7001')
