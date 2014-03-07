--select instance_name from v$instance
--select * from v$asm_disk
--select group_number,disk_number,mode_status,name from v$asm_disk where disk_number = '0' and group_number = '0'
--select * from v$asm_operation

--添加磁盘
--ALTER DISKGROUP DATA ADD FAILGROUP DATA_0001 DISK '\\.\ORCLDISKDATA4' NAME DATA_0004 SIZE 70001 M

--移去磁盘，强制，重新平衡能力10
--ALTER DISKGROUP DATA DROP DISK _DROPPED_0001_DATA FORCE REBALANCE POWER 10

--移去磁盘,重新平衡能力10
--ALTER DISKGROUP DATA2 DROP DISK DATA_0003 REBALANCE POWER 10

--重新平衡磁盘组，重新平衡能力10
--ALTER DISKGROUP DATA REBALANCE POWER 10

--磁盘联机
--ORA-1500：此命令需要登录到+ASM实例
--ALTER DISKGROUP DATA ONLINE DISK '_DROPPED_0001_DATA'

--检查并修复磁盘组
--ALTER DISKGROUP DATA CHECK REPAIR

--装载磁盘组
--ALTER DISKGROUP DATA MOUNT

select * from v$asm_DISK;
select * from v$datafile;
select * from v$asm_operation;
select * from v$spparameter;
select * from v$recovery_file_dest;
select * from v$flash_recovery_area_usage;
select * from v$asm_file;

archive log list;
SELECT INSTANCE_NAME FROM GV$INSTANCE; 
select * from gv$px_process;

--关闭数据库
--shutdown immediate;

--启动数据库到mount状态
--startup mount;

--启用归档模式
--archive log list;
--alter database archivelog;
--禁用归档
--alter database noarchivelog;

--打开数据库
--ALTER DATABASE OPEN;

--查看数据库是否开闪回
--select flashback_on from v$database;

--启用闪回
--alter database flashback on;
--关闭闪回
--alter database flashback off;

--创建担保还原点
--CREATE RESTORE POINT SP1 GUARANTEE FLASHBACK DATABASE;

--SELECT FLASHBACK_ON,LOG_MODE FROM V$DATABASE;

--查看还原点
--SELECT NAME,TO_CHAR(TIME,'YYYY/MM/DD HH24:MI:SS') FROM V$RESTORE_POINT;
--select name from v$restore_point;
--删除还原点
--drop restore point TEST;
--drop restore point ''2014-02-09'';
--还原到还原点
--FLASHBACK DATABASE TO RESTORE POINT TEST;
--SQL 错误: ORA-38701: 闪回数据库日志 64 序列 65 线程 1: "E:\RECOVERY_AREA\NODE\FLASHBACK\O1_MF_9HGWDV0Q_.FLB" ORA-27041: 无法打开文件
--还原到时间点
--FLASHBACK DATABASE TO TIMESTAMP TO_TIMESTAMP('2014/02/09 09:12:54','YYYY/MM/DD HH24:MI:SS');

--删除映像副本
--DELETE NOPROMPT DATAFILECOPY 6, 5, 4, 3;
--删除备份集
--DELETE NOPROMPT BACKUPSET 2;

--recover database;
--alter database force logging;