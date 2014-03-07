SELECT
  b.BILLNO,
  b.JZDATE,
  b.ORGCODE,
  b.ORGNAME,
  b.HTCODE,
  b.HTNAME,
  b.DEPNAME,
  b.DEPCODE,
  b.HCOST AS B_Hcost,
  a.HCOST AS A_Hcost
FROM
  TORDJHHEAD b,
  tordjhhead@zbcmp a
WHERE
  b.billno  = a.billno
AND b.JZDATE >='2012-03-01'
AND b.JZDATE <='2012-04-01'
ORDER BY
  BILLNO