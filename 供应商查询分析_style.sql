-- select * from SUPPLY_TMP
-- drop table SUPPLY_TMP

declare
  i integer;

begin
  select count(*) into i from User_Tables where Table_Name = 'SUPPLY_TMP';
  if i > 0
  then
  
    execute immediate 'drop table SUPPLY_TMP';
  else
  
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


/* 第二步执行 */
insert into Supply_Tmp
  (Pluid, Plucode, Pluname, Barcode, Clscode, Etpcode, Kccount, Hjprice)
  select b.Pluid,
         c.Plucode,
         c.Pluname,
         c.Barcode,
         d.Clscode,
         a.Etpcode,
         e.Kccount,
         Round(c.Hjprice, 2) as Hjprice
  
    from Tcntcontract a,
         Tcntplu      b,
         Tskuplu      c,
         Tcatcategory d,
         
         (select Pluid, sum(Kccount) as Kccount
            from Vstklskccount
           group by Pluid) e
  
   where a.Cntid = b.Cntid
     and b.Pluid = c.Pluid
     and c.Ywstatus = '1'
     and c.Clsid = d.Clsid
     and b.Pluid = e.Pluid
     and b.Orgcode like '%'
  
   group by b.Pluid,
            e.Pluid,
            c.Plucode,
            c.Pluname,
            c.Barcode,
            d.Clscode,
            a.Etpcode,
            e.Kccount,
            c.Hjprice;

/**************************/
declare
  j integer;

begin
  select count(*)
    into i
    from User_Tables
   where Table_Name = 'AVGCOUNT_TMP';
  if j > 0
  then
  
    execute immediate 'drop table AVGCOUNT_TMP';
  else
  
    execute immediate 'create global temporary table AVGCOUNT_TMP
(
  pluid varchar2(20) not null,
  kxdate number(19,4) not null
)';
  end if;
end;

insert into Avgcount_Tmp
  (Pluid, Kxdate)
  select h.Pluid, Round((h.Kccount / (f.Xscount / g.Days)), 0) as Kxdate
    from (select Pluid, sum(Xscount) as Xscount
            from Tsalpludetail201008
           where Xsdate >= To_Date('2010/08/01', 'yyyy/mm/dd')
             and Xsdate <= To_Date('2010/08/27', 'yyyy/mm/dd')
           group by Pluid
          having sum(Xscount) <> 0) f,
         (select To_Date('2010/08/27', 'yyyy/mm/dd') -
                 To_Date('2010/08/01', 'yyyy/mm/dd') as Days
            from Dual
           where (To_Date('2010/08/27', 'yyyy/mm/dd') -
                 To_Date('2010/08/01', 'yyyy/mm/dd')) <> 0) g,
         
         (select Pluid, sum(Kccount) as Kccount
            from Vstklskccount
          
           group by Pluid) h
   where f.Pluid = h.Pluid
  
  /* 最后的展现 */
    select j.Pluid,
           j.Plucode,
           j.Pluname,
           j.Barcode,
           j.Clscode,
           j.Kccount,
           j.Hjprice,
           k.Kxdate
            from Supply_Tmp j, Avgcount_Tmp k
           where j.Pluid = k.Pluid
             and Etpcode = '00008'
           group by j.Pluid,
              j.Plucode,
              j.Pluname,
              j.Barcode,
              j.Clscode,
              j.Kccount,
              j.Hjprice,
              k.Kxdate
