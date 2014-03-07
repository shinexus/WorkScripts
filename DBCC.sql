SELECT * FROM SYSDATABASES

exec sp_databases 

--exec sp_dboption 'UFDATA_008_2012', 'single', 'true'
exec sp_dboption 'UFDATA_011_2013', 'single', 'true'

dbcc checkdb ("UFDATA_011_2013",repair_rebuild)
--dbcc checkdb ("UFMeta_008",repair_rebuild)
--dbcc checkdb ("UFDATA_009_2012",REPAIR_ALLOW_DATA_LOSS)
--DBCC CHECKTABLE("UFDATA_008_2012",repair_rebuild)

--exec sp_dboption 'UFDATA_008_2012', 'single', 'false'
exec sp_dboption 'UFDATA_011_2013', 'single', 'false'

--–ﬁ∏¥°∞ø…“…°±
USE MASTER
GO
SP_CONFIGURE 'ALLOW UPDATES',1 
GO
RECONFIGURE WITH OVERRIDE
GO
ALTER DATABASE hscscm SET EMERGENCY
GO
update sysdatabases set status=-32768 where dbid=DB_ID('hscscm')
GO
sp_dboption 'hscscm', 'single user', 'true'
GO
--
dbcc rebuild_log('hscscm','E:\HSCSCM_DB_DATA\\hscscm_log.ldf')

CREATE DATABASE [hscscm_1] ON 
(	
	FILENAME = N'E:\HSCSCM_DB_DATA\HSCSCM.mdf'
)
 FOR ATTACH
GO
DBCC CHECKDB("hscscm",repair_rebuild)
GO
DBCC CHECKDB('hscscm','REPAIR_ALLOW_DATA_LOSS')
GO
ALTER DATABASE UFDATA_006_2012 SET ONLINE
GO
sp_configure 'allow updates', 0 reconfigure with override
GO
sp_dboption 'hscscm', 'single user', 'false'
GO

--2012-08-04
exec sp_dboption 'UFDATA_009_2011', 'single', 'true'
ALTER DATABASE UFDATA_008_2012 SET COMPATIBILITY_LEVEL = 80
GO
EXEC sp_dbcmptlevel UFDATA_008_2012,80
GO
exec sp_dboption 'UFDATA_009_2012', 'single', 'false'
exec sp_dboption 'UFMeta_009', 'single', 'false'

ALTER DATABASE UFDATA_009_2011 SET OFFLINE
ALTER DATABASE UFDATA_009_2011 SET ONLINE

ALTER DATABASE UFDATA_009_2012 SET OFFLINE
ALTER DATABASE UFDATA_009_2012 SET ONLINE

ALTER DATABASE UFMeta_009 SET OFFLINE
ALTER DATABASE UFMeta_009 SET ONLINE