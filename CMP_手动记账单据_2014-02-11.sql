/**** �˻������� ****/

/**** YwType = '0914' �ܲ��ɹ��˻� ****
�˻������ύ���洢����
SSTK_COMMIT_TH_ORA (ps_BillNo, ps_YwType, pi_UserId, ps_UserCode, ps_UserName, pd_Date);
**************************************/
SSTK_COMMIT_TH_ORA('1001THYW201401270006', '0914', '0', '*', '*', SysDate);

/**** ���ύ�ĵ��ݣ�ֱ�ӵ��ü��˹��� ****
�ɹ��˻����ļ������洢����
sStk_Account_ThCg_ORA (ps_BillNo, ps_YwType, pi_UserId, ps_UserCode, ps_UserName, pd_Date);
*************************************/
sStk_Account_ThCg_ORA ('1001THYW201401270006', '0914', '0', '*', '*', SysDate);