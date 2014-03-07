/*
SELECT * FROM tSysOverShopLog WHERE OrgCode = '2005' OrDER BY BgnDate DESC
DELETE FROM tSysOverShopLog
*/
SELECT
  saleno ,
  SUM(sale),
  SUM(plu),
  SUM(pay)
FROM
  (
    SELECT
      saleno,
      SUM(sstotal) AS sale,
      0            AS plu,
      0            AS pay
    FROM
      tsalsale
    WHERE
      orgcode   ='2005'
    AND trantype='1'
    AND jzdate  ='2013-10-06'
    GROUP BY
      saleno
    UNION ALL
    SELECT
      saleno,
      0            AS sale,
      SUM(sstotal) AS plu,
      0            AS pay
    FROM
      tsalsaleplu plu
    WHERE
      orgcode    ='2005'
    AND trantype ='1'
    AND packtype<>'2'
    AND EXISTS
      (
        SELECT
          1
        FROM
          tsalsale
        WHERE
          orgcode  ='2005'
        AND jzdate ='2013-10-06'
        AND saleno =plu.saleno
      )
    GROUP BY
      saleno
    UNION ALL
    SELECT
      saleno,
      0            AS sale,
      0            AS plu,
      SUM(sstotal) AS pay
    FROM
      tsalsalepay pay
    WHERE
      orgcode   ='2005'
    AND trantype='1'
    AND EXISTS
      (
        SELECT
          1
        FROM
          tsalsale
        WHERE
          orgcode  ='2005'
        AND jzdate ='2013-10-06'
        AND saleno =pay.saleno
      )
    GROUP BY
      saleno
  )
  T
GROUP BY
  saleno    
HAVING
  --SUM(sale)<>SUM(Plu)
  SUM(sale)<>SUM(pay)
ORDER BY SaleNo  
  /*
  SELECT * FROM tSalSale    WHERE SaleNo = '2013100600016780';
  SELECT * FROM tSalSalePlu WHERE SaleNo = '2013100600016780';
  SELECT * FROM tSalSalePay WHERE SaleNo = '2013100600016780';
  
  SELECT * FROM TSALSALEPLUPACKAGE WHERE SaleNo IN ('2013100600016780','2013100600016781','2013100600016782','2013100600016783','2013100600016784','2013100600016785','2013100600016786');
  
  SELECT * FROM tSalSale where trantype = '5'
  */
  /*
  UPDATE tSalSale SET Tag = '8' WHERE trantype = '5'
  UPDATE tSalSale SET Tag = '65' WHERE SaleNo IN ('2013100600016836','
  2013100600016837','2013100600016838','2013100600016839')
  
  DELETE FROM tSalSale    WHERE SaleNo IN ('2013100600016780','2013100600016781','2013100600016782','2013100600016783','2013100600016784','2013100600016785','2013100600016786');
  DELETE FROM tSalSalePay WHERE SaleNo IN ('2013100600016780','2013100600016781','2013100600016782','2013100600016783','2013100600016784','2013100600016785','2013100600016786');
  DELETE FROM tSalSalePlu WHERE SaleNo IN ('2013100600016780','2013100600016781','2013100600016782','2013100600016783','2013100600016784','2013100600016785','2013100600016786');
  
  DELETE FROM TSALSALEPLUPACKAGE WHERE SaleNo IN ('2013100600016780','2013100600016781','2013100600016782','2013100600016783','2013100600016784','2013100600016785','2013100600016786');
    
  */
  
  
  
