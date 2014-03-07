SELECT
  KxName,
  SUM(KxTotal)
FROM
  tAcpJsKxBody
WHERE
  BillNo = '1001YFJS201204060005'
GROUP BY
  KxName
ORDER BY
  KxName