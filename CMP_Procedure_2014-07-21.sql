/**** ���յ����ύ���洢���� ****/
EXEC SSTK_COMMIT_JH_ORA();

/**** �ύʱͳһ�������洢����(��ʼ) ****/
/**** PSSY_DB ϵͳ���ýӿڣ�һ�м��ˣ��ɴ˽��� ****/
PSSY_DB.sStk_FollowMeBegin_ORA(ps_BillNo,ps_YwType,pi_UserId,ps_UserCode,ps_UserName,pd_Date,pi_Result,ps_Message);

/**** �ɹ����յ��ļ������洢���� ****/
sStk_Account_JhCg_ORA(ps_BillNo,ps_YwType,pi_UserId,ps_UserCode,ps_UserName,pd_Date,pi_Result,ps_Message);

/**** ���յ��ļ������洢����(ͨ�Žӿڵ���) ****/
sStk_YwNext_JhCg_ORA(ps_BillNo,ps_YwType,pi_UserId,ps_UserCode,ps_UserName,pd_Date,ps_SendFlag,pi_Result,ps_Message);