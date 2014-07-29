/**** 2014-0_15�κ��� ****/
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

/**** 2014-0_08�κ��� ****/
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

/**** 2014-01��2014-06_15�κ��� ****/

select d.orgcode as "��֯����",
       d.orgname as "��֯����",
       b.vipname as "��Ա����",
       b.address as "��ַ",
       c.cardfaceno as "�����",
       b.mobile as "�ֻ���",
       case b.gender
         when '0' then
          '��'
         else
          'Ů'
       end as "�Ա�",
       sum(a.trantimes) as "���Ѵ���"
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

/**** 2014-01��2014-06_8�κ��� ****/

select d.orgcode as "��֯����",
       d.orgname as "��֯����",
       b.vipname as "��Ա����",
       b.address as "��ַ",
       c.cardfaceno as "�����",
       b.mobile as "�ֻ���",
       case b.gender
         when '0' then
          '��'
         else
          'Ů'
       end as "�Ա�",
       sum(a.trantimes) as "���Ѵ���"
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
