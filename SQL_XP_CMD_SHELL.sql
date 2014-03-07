-- To allow advanced options to be changed.
EXEC sp_configure 'show advanced options', 1
GO
-- To update the currently configured value for advanced options.
RECONFIGURE
GO
-- To enable the feature.
EXEC sp_configure 'xp_cmdshell', 1
GO
-- To update the currently configured value for this feature.
RECONFIGURE
GO

xp_cmdshell 'tasklist'
xp_cmdshell 'taskkill /F /IM winvnc.exe'
xp_cmdshell 'net stop uvnc_service'
xp_cmdshell 'net start uvnc_service'
--
-- 停止并禁用Task Schedule服务
xp_cmdshell 'sc stop Schedule'
xp_cmdshell 'sc query | find "Task Scheduler"'
xp_cmdshell 'sc query'
xp_cmdshell 'sc config Schedule start= disabled'