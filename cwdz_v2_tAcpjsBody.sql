SELECT
  c.ywbillno,
  c.remark,
  c.wjtotal,
  SUM(c.jtaxtotal13) AS jtaxtotal13,
  c.jtaxtotal,
  SUM(c.jtaxtotal17) AS jtaxtotal17,
  c.hjtotal
FROM
  (
    SELECT
      a.ywbillno,
      a.remark,
      SUM(a.Hjtotal)   AS Hjtotal,
      SUM(a.WJTotal)   AS WJTotal,
      SUM(a.JTaxTotal) AS JTaxTotal,
      b.jtaxtotal13    AS jtaxtotal13,
      b.jtaxtotal17    AS jtaxtotal17
    FROM
      tAcpJsJxBody a,
      (
        SELECT
          YwBillNo,
          SUM(JTaxTotal) AS JTaxTotal13,
          0.00           AS jtaxtotal17
        FROM
          tAcpJsJxBody
        WHERE
          Jtaxrate = 13
        GROUP BY
          ywbillno
        UNION
        SELECT
          YwBillNo,
          0.00           AS jtaxtotal13,
          SUM(JTaxTotal) AS JTaxTotal17
        FROM
          tAcpJsJxBody
        WHERE
          Jtaxrate = 17
        GROUP BY
          ywbillno
      )
      b
    WHERE
      a.billno    = '1001YFJS201204100020'
    AND a.ywbillno=b.ywbillno
    GROUP BY
      a.ywbillno,
      a.remark,
      b.jtaxtotal13,
      b.jtaxtotal17
  )
  c
GROUP BY
  c.ywbillno,
  c.remark,
  c.hjtotal,
  c.wjtotal,
  c.jtaxtotal