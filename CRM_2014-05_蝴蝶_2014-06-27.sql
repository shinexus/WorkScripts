/**** 2014-0_15次蝴蝶 ****/
SELECT d.orgcode,
  d.orgname,
  b.vipname,
  b.address,
  c.cardfaceno,
  b.mobile,
  b.gender,
  SUM(a.trantimes)
FROM trptcon201405 a,
  tisuvipinfo b,
  tisucard c,
  torginfo d
WHERE a.cardfaceno=c.cardfaceno
AND b.vipinfono   =c.vipcardno
AND c.isuorgcode  =d.orgcode
AND a.contotal   >=
  (SELECT ROUND(AVG(contotal),2) FROM trptcon201405
  )
GROUP BY d.orgcode,
  d.orgname,
  b.vipname,
  b.address,
  c.cardfaceno,
  b.mobile,
  b.gender
HAVING SUM(a.trantimes)<15;

/**** 2014-0_08次蝴蝶 ****/
SELECT d.orgcode,
  d.orgname,
  b.vipname,
  b.address,
  c.cardfaceno,
  b.mobile,
  b.gender,
  SUM(a.trantimes)
FROM trptcon201405 a,
  tisuvipinfo b,
  tisucard c,
  torginfo d
WHERE a.cardfaceno=c.cardfaceno
AND b.vipinfono   =c.vipcardno
AND c.isuorgcode  =d.orgcode
AND a.contotal   >=
  (SELECT ROUND(AVG(contotal),2) FROM trptcon201405
  )
GROUP BY d.orgcode,
  d.orgname,
  b.vipname,
  b.address,
  c.cardfaceno,
  b.mobile,
  b.gender
HAVING SUM(a.trantimes)<8;

/**** 2014-01至2014-06_15次蝴蝶 ****/

select d.orgcode as "组织编码",
       d.orgname as "组织名称",
       b.vipname as "会员姓名",
       b.address as "地址",
       c.cardfaceno as "卡面号",
       b.mobile as "手机号",
       case b.gender
         when '0' then
          '男'
         else
          '女'
       end as "性别",
       sum(a.trantimes) as "消费次数"
  from tRptConSumByMonth a, tisuvipinfo b, tisucard c, torginfo d
 where a.vipcardno = c.vipcardno
   and b.vipinfono = c.vipcardno
   and c.isuorgcode = d.orgcode
   and a.rptdate between '2014-01' and '2014-06'
   and a.contotal >=
       (select round(sum(contotal) / sum(trantimes), 2)
          from tRptConSumByMonth
         where rptdate between '2014-01' and '2014-06')
 group by d.orgcode,
          d.orgname,
          b.vipname,
          b.address,
          c.cardfaceno,
          b.mobile,
          b.gender
having sum(a.trantimes) < 15;

/**** 2014-01至2014-06_8次蝴蝶 ****/

select d.orgcode as "组织编码",
       d.orgname as "组织名称",
       b.vipname as "会员姓名",
       b.address as "地址",
       c.cardfaceno as "卡面号",
       b.mobile as "手机号",
       case b.gender
         when '0' then
          '男'
         else
          '女'
       end as "性别",
       sum(a.trantimes) as "消费次数"
  from tRptConSumByMonth a, tisuvipinfo b, tisucard c, torginfo d
 where a.vipcardno = c.vipcardno
   and b.vipinfono = c.vipcardno
   and c.isuorgcode = d.orgcode
   and a.rptdate between '2014-01' and '2014-06'
   and a.contotal >=
       (select round(sum(contotal) / sum(trantimes), 2)
          from tRptConSumByMonth
         where rptdate between '2014-01' and '2014-06')
 group by d.orgcode,
          d.orgname,
          b.vipname,
          b.address,
          c.cardfaceno,
          b.mobile,
          b.gender
having sum(a.trantimes) < 8;
