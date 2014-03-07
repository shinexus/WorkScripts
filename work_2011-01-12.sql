select * from v$asm_DISK
select * from v$datafile
select * from v$asm_operation
select * from v$spparameter
select * from v$recovery_file_dest
select * from v$flash_recovery_area_usage

select instance_name, host_name, failover_type, failover_method, failed_over
from v$instance
cross join
(select failover_type, failover_method, failed_over 
from v$session where username = 'SYS')