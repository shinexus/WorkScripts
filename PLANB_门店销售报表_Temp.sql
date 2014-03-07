
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
  SUM(xshtotal) AS xshtotal--,
  --b.jycount     AS jycount
FROM
  tRptSupXsRpt a
  --WHERE a.OrgCode <> '0001'  
GROUP BY
  a.orgcode,
  a.rptdate
  
ORDER BY a.OrgCode