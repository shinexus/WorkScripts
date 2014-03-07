--------------------------------------------------------
--  �ļ��Ѵ��� - ������-����-07-2014   
--------------------------------------------------------
-- �޷����ֶ��� HSCMP �� PACKAGE DDL������ DBMS_METADATA �� PHSCWMS_DB ���ڳ����ڲ���������
CREATE 
PACKAGE PHSCWMS_DB is

/*===============================================*/
--���⣺PHSCWMS_DB
/*===============================================*/

--���ܣ������������
procedure GetWlBillData
    (ps_BillNo    IN  tOrdCgHead.BillNo%type,
     ps_YwType    IN  tOrdJhHead.YwType%type,
     pi_UserId    IN  tOrdJhHead.UserId%type,
     ps_UserCode  IN  tOrdJhHead.UserCode%type,
     ps_UserName  IN  tOrdJhHead.UserName%type,
     pd_Date      IN  tOrdJhHead.JzDate%type,
     pi_Result    OUT integer,
     ps_Message   OUT varchar2);
     
--���ܣ����봦�����     
procedure ReceWlBillData
    (ps_DataKey   IN  tSkuPlu.PluName%type,
     ps_DataType  IN  tSkuPlu.PluName%type,
     pi_UserId    IN  tOrdJhHead.UserId%type,
     pd_Date      IN  tOrdJhHead.JzDate%type,
     pi_Result    OUT integer,
     ps_Message   OUT varchar2);

--���ܣ�����ƽ̨ͨ���˷������ݼ�     
procedure GetWlBillData
    (ps_DataKey   IN  tSkuPlu.PluName%type,
     ps_DataType  IN  tSkuPlu.PluName%type,
     pc_OutRefCur Out   sys_refcursor,               
     pi_Result    OUT integer,
     ps_Message   OUT varchar2);
     
--���ܣ�ͨ���˷����������ݼ�     
procedure GetWlBillDataKeys
    (ps_Tbn       IN  varchar2,
     pc_OutRefCur Out sys_refcursor,               
     pi_Result    OUT integer,
     ps_Message   OUT varchar2);
     
--���ܣ�ת�����ݵ���ʷ
procedure IO_MovHis
    (ps_DataKey  IN  tSkuPlu.PluName%type,
     ps_DataType IN  tSkuPlu.PluName%type,
     pi_Result  Out integer,
     ps_Message Out varchar2);

--���ܣ���¼�ӿ���־   
procedure WriteIOLog(ps_ErrType IN varchar2,ps_ErrMeg IN varchar2);
--���ܣ���¼������־
procedure WriteIOCmpLog
    (ps_LogType      IN    IO_HsCmpLog.LogType%type,
     pd_LogTime      IN    IO_HsCmpLog.LogTime%type,
     pi_UserId       IN    IO_HsCmpLog.UserId%type,
     ps_YwType       IN    IO_HsCmpLog.YwType%type,
     ps_YwName       IN    IO_HsCmpLog.YwName%type,
     ps_DataKey      IN    IO_HsCmpLog.DataKey%type,
     ps_LogMeg       IN    IO_HsCmpLog.LogMeg%type);
     
--���ܣ��޸ĵ��ݵ�״̬
--ps_CallTag���壺01-���ͳɹ�ʱ���ã�02-����ʧ��ʱ���ã�03���˳ɹ�ʱ���ã�04���͵�����������ʱ����
procedure UpdatBillState
     (ps_BillNo      IN    IO_tBillTranState.BillNo%type,
      ps_YwType      IN    IO_tBillTranState.Ywtype%type,
      ps_ReturnCode  IN    varchar2,
      ps_ReturnMsg   IN    Io_HscmpLog.Logmeg%type,
      ps_CallTag     IN    varchar2);
end PHSCWMS_DB;
