/**** 验收单的提交主存储过程 ****/
EXEC SSTK_COMMIT_JH_ORA();

/**** 提交时统一处理公共存储过程(开始) ****/
/**** PSSY_DB 系统共用接口，一切记账，由此进入 ****/
PSSY_DB.sStk_FollowMeBegin_ORA(ps_BillNo,ps_YwType,pi_UserId,ps_UserCode,ps_UserName,pd_Date,pi_Result,ps_Message);

/**** 采购验收单的记账主存储过程 ****/
sStk_Account_JhCg_ORA(ps_BillNo,ps_YwType,pi_UserId,ps_UserCode,ps_UserName,pd_Date,pi_Result,ps_Message);

/**** 验收单的记账主存储过程(通信接口调用) ****/
sStk_YwNext_JhCg_ORA(ps_BillNo,ps_YwType,pi_UserId,ps_UserCode,ps_UserName,pd_Date,ps_SendFlag,pi_Result,ps_Message);