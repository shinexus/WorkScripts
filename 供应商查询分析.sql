declare
  i integer;

begin
  select count(*) into i from user_tables where table_name = 'SUPPLY_TMP';
  if i > 0
  then
    -- dbms_output.put_line('该表已存在!');
    execute immediate 'drop table SUPPLY_TMP';
  else
    -- dbms_output.put_line('该表不存在');
    -- end if;
    execute immediate 'create global temporary table SUPPLY_TMP
(
  pluid varchar2(20),
  plucode varchar2(20),
  pluname varchar2(40),
  barcode varchar2(20),
  clscode varchar2(20),
  etpcode varchar2(20),
  kccount number(19,4),
  hjprice number(19,4)

)';
  end if;
end;
/*
select * from SUPPLY_TMP
drop table SUPPLY_TMP
*/
/*
if exist_table('SUPPLY_TMP')
  then
drop table SUPPLY_TMP

else
  */
/*片段一*/
/*
create global temporary table SUPPLY_TMP
(
  pluid varchar2(20),
  plucode varchar2(20),
  pluname varchar2(40),
  barcode varchar2(20),
  clscode varchar2(20),
  etpcode varchar2(20),
  kccount number(19,4),
  hjprice number(19,4)

)
end if ;
*/



/* 第二步执行 */
insert into supply_tmp
  (pluid, plucode, pluname, barcode, clscode, etpcode, kccount, hjprice)
  select b.pluid,
         c.plucode,
         c.pluname,
         c.barcode,
         d.clscode,
         a.etpcode,
         e.kccount,
         round(c.hjprice, 2) as hjprice
  
    from tCntContract a,
         tCntPlu      b,
         tSkuPlu      c,
         tCatCategory d,
         
         (select pluid, sum(kccount) as kccount
            from vStkLsKcCount
           group by pluid) e
  
   where a.cntid = b.cntid
     and b.pluid = c.pluid
     and c.ywstatus = '1'
     and c.clsid = d.clsid
     and b.pluid = e.pluid
     and b.orgcode like '%'
  
   group by b.pluid,
            e.pluid,
            c.plucode,
            c.pluname,
            c.barcode,
            d.clscode,
            a.etpcode,
            e.kccount,
            c.hjprice;

/**************************/
declare
  j integer;

begin
  select count(*)
    into i
    from user_tables
   where table_name = 'AVGCOUNT_TMP';
  if j > 0
  then
    -- dbms_output.put_line('该表已存在!');
    execute immediate 'drop table AVGCOUNT_TMP';
  else
    -- dbms_output.put_line('该表不存在');
    -- end if;
    execute immediate 'create global temporary table AVGCOUNT_TMP
(
  pluid varchar2(20) not null,
  kxdate number(19,4) not null
)';
  end if;
end;
/**************************/
/*
 drop table AVGCOUNT_TMP
create global temporary table AVGCOUNT_TMP
(
  pluid varchar2(20) not null,
  kxdate number(19,4) not null
)
*/

insert into avgcount_tmp
  (pluid, kxdate)
  select h.pluid, round((h.kccount / (f.xscount / g.days)), 0) as kxdate
    from (select pluid, sum(xscount) as xscount
            from tSalPluDetail201008
           where xsdate >= to_date('2010/08/01', 'yyyy/mm/dd')
             and xsdate <= to_date('2010/08/27', 'yyyy/mm/dd')
           group by pluid
          having sum(xscount) <> 0) f,
         (select to_date('2010/08/27', 'yyyy/mm/dd') -
                 to_date('2010/08/01', 'yyyy/mm/dd') as days
            from dual
           where (to_date('2010/08/27', 'yyyy/mm/dd') -
                 to_date('2010/08/01', 'yyyy/mm/dd')) <> 0) g,
         
         (select pluid, sum(kccount) as kccount
            from vStkLsKcCount
          
           group by pluid) h
   where f.pluid = h.pluid

/* 最后的展现 */  
    select j.pluid,
           j.plucode,
           j.pluname,
           j.barcode,
           j.clscode,
           j.kccount,
           j.hjprice,
           k.kxdate
            from SUPPLY_TMP j, AVGCOUNT_TMP k
           where j.pluid = k.pluid
             and etpcode = '00008'
           group by j.pluid,
              j.plucode,
              j.pluname,
              j.barcode,
              j.clscode,
              j.kccount,
              j.hjprice,
              k.kxdate
