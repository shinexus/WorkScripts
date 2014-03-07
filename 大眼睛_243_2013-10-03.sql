/*
Select BillNo,BillType as YwType,RptDate as rq,a.OrgCode,a.Orgname,EtpCode as
SupCode,EtpName as SupName,SsTotal as Hcost,SsTotal-XTaxTotal as wCost,CkCode,
CkName,billtype
from tWslXsHead a inner join tOrgManage b on a.OrgCode=b.OrgCode
where BillType='0' and  RptDate>='2013-09-30' and RptDate<='2013-09-30'
and ForgCode='CW01'
order by billno
*/
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
      TO_CHAR(XTaxRate) AS TaxRate,
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
      a.HXTotal   AS HCost,
      a.WXTotal   AS WCost,
      a.JyMode,
      a.JhJsCode                      AS JsCode,
      TO_CHAR(a.XsDate, 'yyyy-mm-dd') AS YwDate,
      a.datatype,
      KcBillNo
    FROM
      TSALPLUDETAIL201309 a
    INNER JOIN tOrgManage b
    ON
      a.OrgCode=b.OrgCode
    WHERE
      b.FOrgCode='CW01'
    AND RptDate>='2013-09-30'
    AND RptDate<='2013-09-30'
  )
WHERE
  DataType IN ('D') 