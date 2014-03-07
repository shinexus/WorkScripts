/**
*sRptRPT10010000000084
*SELECT * FROM tempTable_forReport0139
**/
vs_BgnDate VARCHAR2(10);
vs_EndDate VARCHAR2(10);
vs_OrgCode VARCHAR2(10);
vs_type    VARCHAR2(1);
vs_sql     VARCHAR2(4000);
tblname    VARCHAR2(100);
/* 创建所需的临时表
create table tempTable_forReport0139
(
orgcode varchar2(4),
orgname varchar2(30),
rptdate date,
xshcost number,
xshtotal number,
jycount number
)
*/
CURSOR tblname_cur
IS
  SELECT
    object_name AS table_name
  FROM
    user_objects
  WHERE
    (
      object_name BETWEEN 'TSALSALEPLU'
      ||SUBSTR(vs_bgndate,1,4)
      ||SUBSTR(vs_bgndate,6,2)
    AND 'TSALSALEPLU'
      ||SUBSTR(vs_enddate,1,4)
      ||SUBSTR(vs_enddate,6,2)
    );
BEGIN
  vs_BgnDate:=TO_CHAR(:BgnDate,'YYYY-MM-DD');
  vs_EndDate:=TO_CHAR(:EndDate,'YYYY-MM-DD');
  vs_OrgCode:=:OrgCode;
  vs_type   :=:type;
  DELETE
  FROM
    tempTable_forReport0139;
  OPEN tblname_cur;
  LOOP
    FETCH
      tblname_cur
    INTO
      tblname;
    EXIT
  WHEN tblname_cur %notfound;
    vs_sql:='insert into tempTable_forReport0139'||
    ' select orgcode,orgname,rptdate,xshcost,xshtotal,jycount'|| ' from '||
    ' (select a.orgcode as orgcode,'||
    ' (select orgname from torgmanage where a.orgcode = orgcode) as orgname,'||
    '  a.rptdate as rptdate,'|| ' sum(xshcost) as xshcost,'||
    ' sum(xshtotal) as xshtotal,'|| ' b.jycount as jycount'||
    ' from tRptSupXsRpt a,  (select orgcode,jzdate,count(distinct saleno) as jycount'
    || ' from '||tblname|| ' where jzdate between '''||vs_BgnDate||''''||
    ' and '''||vs_EndDate||''''|| ' and trantype <> '''||5||''''||
    ' and plucode <> '''||'660101010'||''''|| ' group by orgcode,jzdate) b'||
    ' where a.orgcode = b.orgcode'|| '  and rptdate between '''||vs_BgnDate||
    ''''||' and '''||vs_EndDate||''''|| '  and a.orgcode like '''||vs_OrgCode||
    '%'''|| '  and supcode <> '''||'00099'||''''|| ' and a.rptdate=b.jzdate '||
    ' group by a.orgcode,a.rptdate,b.jycount '||
    ' order by a.orgcode,a.rptdate) res';
    EXECUTE immediate (vs_sql);
    COMMIT;
  END LOOP;
  CLOSE tblname_cur;
  IF vs_type=0 THEN
    OPEN result_set FOR SELECT orgcode
  AS
    orgcode,
    orgname
  AS
    orgname,
    rptdate
  AS
    rptdate,
    xshcost
  AS
    xshcost,
    (xshtotal-xshcost)
  AS
    xshmtotal,
    jycount
  AS
    jycount,
    ROUND(xshtotal/jycount,2)
  AS
    custprice,
    CASE xshtotal
    WHEN 0 THEN
      0
    ELSE
      ROUND((xshtotal-xshcost)*100/xshtotal,2)
    END
  AS
    mlv,
    xshtotal
  AS
    xshtotal FROM tempTable_forReport0139 WHERE orgcode NOT IN ('2002','7001')
    order by orgcode,
    rptdate;
  END IF;
  IF vs_type=1 THEN
    OPEN result_set FOR SELECT orgcode
  AS
    orgcode,
    orgname
  AS
    orgname,
    SUM(xshcost)
  AS
    xshcost,
    SUM(xshtotal-xshcost)
  AS
    xshmtotal,
    SUM(jycount)
  AS
    jycount,
    ROUND(SUM(xshtotal)/SUM(jycount),2)
  AS
    custprice,
    CASE SUM(xshtotal)
    WHEN 0 THEN
      0
    ELSE
      ROUND(SUM(xshtotal-xshcost)*100/SUM(xshtotal),2)
    END
  AS
    mlv,
    SUM(xshtotal)
  AS
    xshtotal FROM tempTable_forReport0139 WHERE orgcode NOT IN ('2002','7001')
    group by orgcode,
    orgname order by orgcode;
  END IF;
  DELETE
  FROM
    tempTable_forReport0139;
END;
