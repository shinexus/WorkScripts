SELECT [cUser_Id]
,hashbytes('MD5', cUser_Id) as md5
,hashbytes('SHA1', cUser_Id) as sha1
      ,[cUser_Name]
      ,[cPassword]
      ,[iAdmin]
      ,[cDept]
      ,[cBelongGrp]
      ,[nState]
      ,[cUserEmail]
      ,[cUserHand]
      ,[SaveMailCount]
      ,[SaveSMSCount]
      ,[localeid]
      ,[iErrorCount]
      ,[dPasswordDate]
      ,[cSysUserName]
      ,[cSysUserPassword]
      ,[bLogined]
      ,[authenMode]
      ,[bRefuseModifyLoginDate]
      ,[iUserType]
      ,[bAutoCloseException]
  FROM [UFSystem].[dbo].[UA_User]
GO


