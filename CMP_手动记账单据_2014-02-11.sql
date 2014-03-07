/**** 退货单记账 ****/

/**** YwType = '0914' 总部采购退货 ****
退货单的提交主存储过程
SSTK_COMMIT_TH_ORA (ps_BillNo, ps_YwType, pi_UserId, ps_UserCode, ps_UserName, pd_Date);
**************************************/
SSTK_COMMIT_TH_ORA('1001THYW201401270006', '0914', '0', '*', '*', SysDate);

/**** 已提交的单据，直接调用记账过程 ****
采购退货单的记账主存储过程
sStk_Account_ThCg_ORA (ps_BillNo, ps_YwType, pi_UserId, ps_UserCode, ps_UserName, pd_Date);
*************************************/
sStk_Account_ThCg_ORA ('1001THYW201401270006', '0914', '0', '*', '*', SysDate);