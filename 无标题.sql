select * from v$flash_recovery_area_usage;
--50G
ALTER SYSTEM SET db_recovery_file_dest_size = 53687091200 SCOPE=BOTH

--40G
ALTER SYSTEM SET db_recovery_file_dest_size = 42949672960 SCOPE=BOTH
DESC dba_outstanding_alerts
select reason,object_type,suggested_action from dba_outstanding_alerts;

alter table "HSCMP"."TSTKLSKC" compress for oltp
alter table "HSCMP"."TSTKLSKC" move