SELECT
  orgcode,
  (
    SELECT
      orgname
    FROM
      torgmanage
    WHERE
      A.orgcode=orgcode
  )            AS orgname,
  rptdate      AS rptdate,
  SUM(xscount) AS xscount,
  SUM(hjcost)  AS hjcost,
  SUM(hxtotal) total,
  SUM(hmtotal) AS hmtotal,
  CASE SUM(hxtotal)
    WHEN 0
    THEN 0
    ELSE ROUND(SUM(hmtotal)*100.0/SUM(hxtotal),2)
  END AS mlv,
  (
    SELECT
      jycount
    FROM
      tRptOrgParam
    WHERE
      a.orgcode  =orgcode
    AND a.rptdate=rptdate
  ) AS jycount,
  ROUND( SUM(hxtotal)/
  (
    SELECT
      *
      --jycount
    FROM
      tRptOrgParam
    WHERE
      --a.orgcode  =orgcode
      orgcode = '2003' and rptdate = '2013-03-22'
      select * from tRptOrgParam where paramid = '24324'
      DELETE FROM tRptOrgParam where paramid = '24324'
      
    AND a.rptdate=rptdate
  )
  ,2) AS CustPrice
FROM
  tRptGatherRpt a
WHERE
  rptdate BETWEEN '2013-03-22' AND '2013-03-22'
AND orgcode LIKE '2003'
AND orgcode<>'0001'
AND EXISTS
  (
    SELECT
      *
    FROM
      tusrrightorg r
    WHERE
      --r.orgcode=a.orgcode
      r.orgcode='2003'
  )
GROUP BY
  orgcode,
  rptdate;