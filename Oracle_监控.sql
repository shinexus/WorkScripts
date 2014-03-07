-- 查看数据库链接数:   
select * from v$session;   
  
-- 查看那些用户在使用数据库   
select distinct username from v$session;   
  
-- 查看数据库的SID   
select name from v$database;   
  
-- 查看系统被锁的事务时间   
select * from v$locked_object;   
  
-- 监控正在执行的事务   
select * from v$transaction;   
  
-- 查看是不是采用了RAC   
select * from gv$instance; 


select a.sid,spid,status,substr(a.program,1,40) prog,a.terminal,osuser,value/60/100 value 
from v$session a,v$process b,v$sesstat c 
where c.statistic#=12 and c.sid=a.sid and a.paddr=b.addr order by value desc; 