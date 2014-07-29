SELECT orgcode,
  orgname,
  SUM(thxtotal)                        AS thxtotal,
  SUM(thmtotal)                        AS thmtotal,
  SUM(tjycount)                        AS tjycount,
  ROUND(SUM(thxtotal)/SUM(tjycount),2) AS tCustPrice,
  CASE SUM(thxtotal)
    WHEN 0
    THEN 0
    ELSE ROUND(SUM(thmtotal)*100.0/SUM(thxtotal),2)
  END                                    AS tmlv,
  SUM(tqhxtotal)                         AS tqhxtotal1,
  SUM(tqhmtotal)                         AS tqhmtotal1,
  SUM(tqjycount)                         AS tqjycount1,
  ROUND(SUM(tqhxtotal)/SUM(tqjycount),2) AS tqCustPrice1,
  CASE SUM(tqhxtotal)
    WHEN 0
    THEN 0
    ELSE ROUND(SUM(tqhmtotal)*100.0/SUM(tqhxtotal),2)
  END AS tqmlv1
FROM
  (SELECT orgcode,
    (SELECT orgname FROM torgmanage WHERE a.orgcode = inorgcode
    )            AS orgname,
    SUM(hxtotal) AS thxtotal,
    SUM(hmtotal) AS thmtotal,
    (SELECT jycount
    FROM tRptOrgParam
    WHERE a.orgcode=orgcode
    AND a.rptdate  =rptdate
    )    AS tjycount,
    0.00 AS tqhxtotal,
    0.00 AS tqhmtotal,
    0.00 AS tqjycount
  FROM tRptGatherRpt A
  WHERE rptdate BETWEEN '2014-05-01' AND '2014-05-10'
  AND orgcode LIKE '1001'
  AND orgcode<>'0001'
  AND clscode LIKE '%'
  GROUP BY orgcode,
    rptdate
  UNION
  SELECT orgcode,
    (SELECT orgname FROM torgmanage WHERE a.orgcode = inorgcode
    )            AS orgname,
    0.00         AS thxtotal,
    0.00         AS thmtotal,
    0.00         AS tjycount,
    SUM(hxtotal) AS tqhxtotal,
    SUM(hmtotal) AS tqhmtotal,
    (SELECT jycount
    FROM tRptOrgParam
    WHERE a.orgcode=orgcode
    AND a.rptdate  =rptdate
    ) AS tqjycount
  FROM tRptGatherRpt A
  WHERE rptdate BETWEEN '2014-04-01' AND '2014-04-10'
  AND orgcode LIKE '1001'
  AND orgcode<>'0001'
  AND clscode LIKE '%'
  GROUP BY orgcode,
    rptdate
  ) M
GROUP BY orgcode,
  orgname;
  
/**********************************************************************************************************************/
SELECT * FROM tRptGatherRpt;
