select * from dba_tables where OWNER = 'HSCMP' 

select table_name, tablespace_name, num_rows from dba_tables 
where OWNER = 'HSCMP' 
and table_name like '%TEMP%' 
--and tablespace_name= 'SYSTEM'
and num_rows > '0'
order by num_rows desc

delete from ORGLSKC_DAILYTEMP
select * from ORGLSKC_DAILYTEMP

alter table "HSCMP"."TEMP_TSKUGTPLU" enable row movement
alter table "HSCMP"."TEMP_TSKUGTPLU" shrink space 
