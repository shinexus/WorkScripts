--SELECT * FROM tRptSupXsRpt ORDER BY orgcode
--SELECT * FROM tempTable_forReport0139
--SELECT * FROM TSALSALEPLU201203 ORDER BY OrgCode
--SELECT object_name AS table_name FROM user_objects WHERE object_name BETWEEN
-- 'TSALSALEPLU201203' AND 'TSALSALEPLU201203'
SELECT
  SUM(XSHTOTAL)
FROM
  (
    SELECT
      a.orgcode AS orgcode,
      (
        SELECT
          orgname
        FROM
          torgmanage
        WHERE
        a.orgcode <> '0001' and
          a.orgcode = orgcode
      )             AS orgname,
      a.rptdate     AS rptdate,
      SUM(xshcost)  AS xshcost,
      SUM(xshtotal) AS xshtotal--,
      --b.jycount     AS jycount
    FROM
      tRptSupXsRpt )a,
    --WHERE
      --OrgCode <> '0001'
  --)  a,
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
  a.orgcode = b.orgcode
AND rptdate BETWEEN '2012-03-01' AND '2012-03-05'
AND a.orgcode LIKE '%'
AND supcode <> '00099'
AND a.rptdate=b.jzdate
  --and a.orgcode <> '0001'
AND a.orgcode NOT IN ('2002','7001')
GROUP BY
  a.orgcode,
  a.rptdate,
  b.jycount
ORDER BY
  a.orgcode,
  a.rptdate --) res