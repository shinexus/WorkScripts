-- �鿴���ݿ�������:   
select * from v$session;   
  
-- �鿴��Щ�û���ʹ�����ݿ�   
select distinct username from v$session;   
  
-- �鿴���ݿ��SID   
select name from v$database;   
  
-- �鿴ϵͳ����������ʱ��   
select * from v$locked_object;   
  
-- �������ִ�е�����   
select * from v$transaction;   
  
-- �鿴�ǲ��ǲ�����RAC   
select * from gv$instance; 


select a.sid,spid,status,substr(a.program,1,40) prog,a.terminal,osuser,value/60/100 value 
from v$session a,v$process b,v$sesstat c 
where c.statistic#=12 and c.sid=a.sid and a.paddr=b.addr order by value desc; 