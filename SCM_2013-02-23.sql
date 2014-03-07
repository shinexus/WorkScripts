Use Master
Go

ALTER DATABASE hscscm SET EMERGENCY
GO

sp_configure 'allow updates', 1
reconfigure with override
Go

sp_configure 'allow updates', 0
GO

SELECT * FROM SYSDATABASES
select * from sys.database_files

EXEC sp_attach_db
@dbname='HSCSCM_1',
@filename1='E:\HSCSCM_DB_DATA\HSCSCM.mdf',
@filename2='E:\HSCSCM_DB_DATA\HSCSCM_2.mdf'

UPDATE sysdatabases 
 set status = 32768 
 where name='hscscm' 

DBCC REBUILD_LOG(
'hscscm','E:\HSCSCM_DB_DATA\hscscm_log_.ldf'
)

SP_DBOPTION 'hscscm', 'single user', 'true'
GO

DBCC CHECKALLOC('HSCSCM',REPAIR_REBUILD)
DBCC CHECKDB('HSCSCM',REPAIR_REBUILD)


EXEC sp_attach_single_file_db
@dbname='HSCSCM_2',
@physname= 'E:\HSCSCM_DB_DATA\HSCSCM.mdf'

RESTORE DATABASE HSCSCM WITH RECOVERY