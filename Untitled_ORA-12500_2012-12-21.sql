select count(*) from v$process

show parameter process

SELECT t2.MACHINE,t2.OSUSER,t2.PROGRAM,t2.action,t2.sid,t1.pid,t2.username
  FROM v$process t1, v$session t2
 WHERE t1.addr = t2.paddr
   AND t2.username = 'HSCMP'
   order by machine,sid
   
   alter system set processes=250 scope=spfile;
   --------------
   select count(10) from v$session;
select count(1) from v$session where status = 'INACTIVE';