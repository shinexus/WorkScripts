--select instance_name from v$instance
--select * from v$asm_disk
--select group_number,disk_number,mode_status,name from v$asm_disk where disk_number = '0' and group_number = '0'
--select * from v$asm_operation

--��Ӵ���
--ALTER DISKGROUP DATA ADD FAILGROUP DATA_0001 DISK '\\.\ORCLDISKDATA4' NAME DATA_0004 SIZE 70001 M

--��ȥ���̣�ǿ�ƣ�����ƽ������10
--ALTER DISKGROUP DATA DROP DISK _DROPPED_0001_DATA FORCE REBALANCE POWER 10

--��ȥ����,����ƽ������10
--ALTER DISKGROUP DATA2 DROP DISK DATA_0003 REBALANCE POWER 10

--����ƽ������飬����ƽ������10
--ALTER DISKGROUP DATA REBALANCE POWER 10

--��������
--ORA-1500����������Ҫ��¼��+ASMʵ��
--ALTER DISKGROUP DATA ONLINE DISK '_DROPPED_0001_DATA'

--��鲢�޸�������
--ALTER DISKGROUP DATA CHECK REPAIR

--װ�ش�����
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

--�ر����ݿ�
--shutdown immediate;

--�������ݿ⵽mount״̬
--startup mount;

--���ù鵵ģʽ
--archive log list;
--alter database archivelog;
--���ù鵵
--alter database noarchivelog;

--�����ݿ�
--ALTER DATABASE OPEN;

--�鿴���ݿ��Ƿ�����
--select flashback_on from v$database;

--��������
--alter database flashback on;
--�ر�����
--alter database flashback off;

--����������ԭ��
--CREATE RESTORE POINT SP1 GUARANTEE FLASHBACK DATABASE;

--SELECT FLASHBACK_ON,LOG_MODE FROM V$DATABASE;

--�鿴��ԭ��
--SELECT NAME,TO_CHAR(TIME,'YYYY/MM/DD HH24:MI:SS') FROM V$RESTORE_POINT;
--select name from v$restore_point;
--ɾ����ԭ��
--drop restore point TEST;
--drop restore point ''2014-02-09'';
--��ԭ����ԭ��
--FLASHBACK DATABASE TO RESTORE POINT TEST;
--SQL ����: ORA-38701: �������ݿ���־ 64 ���� 65 �߳� 1: "E:\RECOVERY_AREA\NODE\FLASHBACK\O1_MF_9HGWDV0Q_.FLB" ORA-27041: �޷����ļ�
--��ԭ��ʱ���
--FLASHBACK DATABASE TO TIMESTAMP TO_TIMESTAMP('2014/02/09 09:12:54','YYYY/MM/DD HH24:MI:SS');

--ɾ��ӳ�񸱱�
--DELETE NOPROMPT DATAFILECOPY 6, 5, 4, 3;
--ɾ�����ݼ�
--DELETE NOPROMPT BACKUPSET 2;

--recover database;
--alter database force logging;