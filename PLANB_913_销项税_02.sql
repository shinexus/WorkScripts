SELECT SUM(HCOST),SUM(WCOST)
FROM (
SELECT
  a.BillNo AS BillNo,
  b.YwType  AS YwType,
  b.RptDate AS RptDate ,
  SUM(a.hCost) AS hCost,
  SUM(a.wCost) AS wCost,
  b.SupCode AS SupCode,
  b.SupName AS SupName,
  to_char(a.jtaxrate) AS taxrate
FROM
  tOrdJhBody a,
  (
    SELECT
      BillNo,Ywtype,RptDate,SupCode,SupName
    FROM
      tOrdJhHead
    WHERE
      OrgCode IN ('2002','7001')
    AND RptDate BETWEEN '2012-02-01' AND '2012-02-10'
    AND ywType = '0908'
  )
  b
WHERE
  a.BillNo = b.BillNo
GROUP BY
  a.BillNo,
  a.Jtaxrate,
  b.YwType,
  b.RptDate,
  b.SupCode,
  b.SupName
ORDER BY
  BillNo
)