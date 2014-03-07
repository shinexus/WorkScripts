/**
*sRptRPT10010000001373
**/
/*
SELECT OrgCode, OrgName, SUM(HXTOTAL) AS HXTOTAL
FROM tsalpludetail201202
--SELECT * FROM tsalpludetail201202
--WHERE OrgCode = '1001'
--AND RptDate > '2012-01-01'
WHERE OrgCode NOT IN ('0001')
AND RptDate > '2012-02-01'
AND RptDate < '2012-02-02'
AND ETPCODE NOT IN ('00099')
AND PluCode NOT IN ('660101010')
GROUP BY OrgCode, OrgName
ORDER BY OrgCode
*/
---------------------------------------------------------
--SELECT * FROM tCvsHandCash
--SELECT * FROM tRptSupXsRpt
--下列交易笔数不准确（1652+1815=3467）实际（1633+1788=3421）B计划（1481+1626=3107）
--SELECT * FROM tRptOrgParam  WHERE OrgCode = '1001' AND RptDate BETWEEN '2012-02-01' AND '2012-02-02'
SELECT
  rpt.OrgCode,
  nam.OrgName,
  SUM(rpt.XSHTOTAL)                       AS XSHTOTAL,
  SUM(rop.JyCount)                        AS JyCount,
  SUM(ch.SyHKTotal)                       AS SyHKTotal,
  SUM(ch.stlktotal)                       AS stlktotal,
  SUM(ch.shandtotal)                      AS shandtotal,
  (SUM(rpt.XSHTOTAL) - SUM(ch.SyHKTotal)) AS sxjtotal
  --(XSHTOTAL - SyHKTotal) as sxjtotal
FROM
  (
    SELECT
      OrgCode,
      SUM(XSHTOTAL) AS XSHTOTAL
    FROM
      tRptSupXsRpt
    WHERE
      RptDate BETWEEN '2012-02-01' AND '2012-02-02'
    AND OrgCode NOT IN ('0001')
    AND SupCode NOT IN ('00099')
    GROUP BY
      OrgCode
    ORDER BY
      OrgCode
  )
  rpt,
  tOrgManage nam,
  (
    SELECT
      OrgCode,
      NVL(SUM(jycount),0.00) AS JyCount
    FROM
      tRptOrgParam
    WHERE
      rptdate BETWEEN '2012-02-01' AND '2012-02-02'
    GROUP BY
      OrgCode
    ORDER BY
      OrgCode
  )
  rop,
  (
    SELECT
      orgcode,
      SUM(syhktotal)  AS syhktotal,
      SUM(sgwqtotal)  AS sgwqtotal,
      SUM(stlktotal)  AS stlktotal,
      SUM(shandtotal) AS shandtotal
    FROM
      (
        SELECT
          orgcode,
          SUM(yhandtotal) AS yhandtotal,
          /*现金需要计算
          case paycode when '0' then nvl(sum(shandtotal),0.00) end as
          sxjtotal,
          */
          CASE paycode
            WHEN '2'
            THEN NVL(SUM(shandtotal),0.00)
          END AS syhktotal,
          CASE paycode
            WHEN '4'
            THEN NVL(SUM(shandtotal),0.00)
          END AS sgwqtotal,
          CASE paycode
            WHEN '9'
            THEN NVL(SUM(shandtotal),0.00)
          END AS stlktotal,
          NVL(
            CASE
              WHEN paycode NOT IN ('0','2','4','9')
              THEN NVL(SUM( shandtotal),0.00)
            END,0.00)     AS sqttotal,
          SUM(shandtotal) AS shandtotal
          --sum(shandtotal-yhandtotal) as cdktotal
        FROM
          tcvshandcash
        WHERE
          jzdate BETWEEN '2012-02-01' AND '2012-02-02'
        GROUP BY
          orgcode,
          paycode
      )
    GROUP BY
      orgcode
  )
  ch
WHERE
  rpt.OrgCode   = nam.OrgCode
AND rpt.OrgCode = rop.OrgCode
AND rpt.OrgCode = ch.OrgCode
GROUP BY
  rpt.OrgCode,
  nam.OrgName,
  JyCount,
  SyHKTotal
  --sxjtotal
ORDER BY
  rpt.OrgCode
  /*************温茜的代码*************
  SELECT rpt.OrgCode,
  nam.OrgName,
  sum(rpt.XSHTOTAL) as xshtotal,
  sum(rop.JyCount) as jycount,
  sum(ch.SyHKTotal) as syhktotal
  FROM (select orgcode, sum(xshtotal) as xshtotal
  from tRptSupXsRpt
  where orgcode <> '0001'
  and supcode <> '00099'
  and rptdate between '2012-02-01' and '2012-02-02'
  group by orgcode) rpt,
  tOrgManage nam,
  (SELECT OrgCode, nvl(sum(jycount), 0.00) as JyCount
  from tRptOrgParam
  where rptdate between '2012-02-01' and '2012-02-02'
  group by OrgCode) rop,
  (select orgcode,
  sum(syhktotal) as syhktotal,
  sum(sgwqtotal) as sgwqtotal
  from (SELECT orgcode,
  case paycode
  when '2' then
  nvl(sum(shandtotal), 0.00)
  end as syhktotal,
  case paycode
  when '4' then
  nvl(sum(shandtotal), 0.00)
  end as sgwqtotal
  from tcvshandcash
  WHERE jzdate between '2012-02-01' and '2012-02-02'
  GROUP BY orgcode, paycode
  ORDER BY orgcode) chc
  group by orgcode) ch
  WHERE rpt.OrgCode = nam.OrgCode
  AND rpt.OrgCode = rop.OrgCode
  AND rpt.OrgCode = ch.OrgCode
  GROUP BY rpt.OrgCode, nam.OrgName
  ORDER BY rpt.OrgCode
  *************温茜的代码*************/
  --_________________________________
  /*
  vs_bgndate varchar2(10);
  vs_enddate varchar2(10);
  begin
  vs_bgndate:=to_char(:pbgndate,'yyyy-mm-dd');
  vs_enddate:=to_char(:penddate,'yyyy-mm-dd');
  open result_set for
  select c.orgcode,c.orgname,d.total,c.yhandtotal,sum(d.total-c.yhandtotal) as
  hdtotal,e.jycount,c.sxjtotal,c.syhktotal,
  c.sgwqtotal,c.szptotal,c.sqttotal,c.shandtotal,c.cdktotal,c.sctotal,c.remark
  from (  select orgcode,orgname,sum(yhandtotal) as yhandtotal,
  sum(sxjtotal) as sxjtotal,
  sum(syhktotal) as syhktotal,
  sum(sgwqtotal) as sgwqtotal,
  sum(szptotal) as szptotal,
  sum(sqttotal) as sqttotal,
  sum(shandtotal) as shandtotal,
  sum(cdktotal) as cdktotal,
  sctotal,remark
  from (  select a.orgcode,b.orgname,
  sum(yhandtotal) as yhandtotal,
  case paycode when '0' then nvl(sum(shandtotal),0.00) end as sxjtotal,
  case paycode when '2' then nvl(sum(shandtotal),0.00) end as syhktotal,
  case paycode when '4' then nvl(sum(shandtotal),0.00) end as sgwqtotal,
  case paycode when '6' then nvl(sum(shandtotal),0.00) end as szptotal,
  nvl(case when paycode not in ('0','2','4','6') then nvl(sum(shandtotal),0.00)
  end,0.00) as sqttotal,
  sum(shandtotal) as shandtotal,
  sum(shandtotal-yhandtotal) as cdktotal,
  a.remark as sctotal,
  a.remark as remark
  from tcvshandcash a,tOrgManage b
  where a.orgcode=b.orgcode
  and jzdate between '2012-01-01' and '2012-02-02'
  group by a.orgcode,orgname,paycode,a.remark
  )
  group by orgcode,orgname,sctotal,remark) c,
  ( SELECT orgcode,nvl(sum(hxtotal),0.00) as total
  from tRptGatherRpt where rptdate between vs_bgndate and vs_enddate group by
  orgcode
  ) d,
  ( SELECT orgcode,
  nvl(sum(jycount),0.00) as jycount
  from tRptOrgParam where rptdate between vs_bgndate and vs_enddate group by
  orgcode
  ) e
  where c.orgcode=d.orgcode
  and d.orgcode=e.orgcode
  group by c.orgcode,c.orgname,d.total,c.yhandtotal,e.jycount,c.sxjtotal,
  c.syhktotal,
  c.sgwqtotal,c.szptotal,c.sqttotal,c.shandtotal,c.cdktotal,c.sctotal,c.remark;
  end;
  select * from tstkkcjzhead
  select * from tstkkcjzbody where billno = '1001KCJZ120105000256'
  */
   