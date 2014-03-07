--SELECT
--  orgcode,
--  orgname,
--  rptdate,
--  xshcost,
--  xshtotal,
--  jycount
--SELECT SUM (XSHTOTAL)
SELECT *
FROM
  (
    SELECT
      a.orgcode AS orgcode,
      (
        SELECT
          --orgcode, 
          orgname
        FROM
          torgmanage
        WHERE
        --orgcode <> '0001'          AND 
          a.orgcode = orgcode
      )             AS orgname,
      a.rptdate     AS rptdate,
      SUM(xshcost)  AS xshcost,
      SUM(xshtotal) AS xshtotal,
      b.jycount     AS jycount
    FROM
      tRptSupXsRpt a ,
      
      (
        SELECT
          orgcode,
          jzdate,
          COUNT(DISTINCT saleno) AS jycount
        FROM
          TSALSALEPLU201203
        WHERE
          jzdate BETWEEN '2012-03-01' AND '2012-03-05'
        AND trantype <> '5'
        AND plucode  <> '660101010'
        GROUP BY
          orgcode,
          jzdate
      )
      b
   
    WHERE 
    --a.OrgCode <> '0001'
    a.orgcode = b.orgcode
    AND rptdate BETWEEN '2012-03-01' AND '2012-03-05'
    --AND a.orgcode LIKE '%'
    AND supcode   <> '00099'
    AND a.rptdate  =b.jzdate
    AND a.orgcode NOT IN ('0001','2002','7001')
    GROUP BY
      a.orgcode,
      a.rptdate,
      b.jycount
    ORDER BY
      a.orgcode,
      a.rptdate
  )
  res