--------------------------------------------------------
--  文件已创建 - 星期五-三月-07-2014   
--------------------------------------------------------
-- 无法呈现对象 HSCMP 的 PACKAGE DDL。带有 DBMS_METADATA 的 PHSCWMS_DB 正在尝试内部生成器。
CREATE 
PACKAGE PHSCWMS_DB is

/*===============================================*/
--标题：PHSCWMS_DB
/*===============================================*/

--功能：导出处理过程
procedure GetWlBillData
    (ps_BillNo    IN  tOrdCgHead.BillNo%type,
     ps_YwType    IN  tOrdJhHead.YwType%type,
     pi_UserId    IN  tOrdJhHead.UserId%type,
     ps_UserCode  IN  tOrdJhHead.UserCode%type,
     ps_UserName  IN  tOrdJhHead.UserName%type,
     pd_Date      IN  tOrdJhHead.JzDate%type,
     pi_Result    OUT integer,
     ps_Message   OUT varchar2);
     
--功能：导入处理过程     
procedure ReceWlBillData
    (ps_DataKey   IN  tSkuPlu.PluName%type,
     ps_DataType  IN  tSkuPlu.PluName%type,
     pi_UserId    IN  tOrdJhHead.UserId%type,
     pd_Date      IN  tOrdJhHead.JzDate%type,
     pi_Result    OUT integer,
     ps_Message   OUT varchar2);

--功能：集成平台通过此返回数据集     
procedure GetWlBillData
    (ps_DataKey   IN  tSkuPlu.PluName%type,
     ps_DataType  IN  tSkuPlu.PluName%type,
     pc_OutRefCur Out   sys_refcursor,               
     pi_Result    OUT integer,
     ps_Message   OUT varchar2);
     
--功能：通过此返回主键数据集     
procedure GetWlBillDataKeys
    (ps_Tbn       IN  varchar2,
     pc_OutRefCur Out sys_refcursor,               
     pi_Result    OUT integer,
     ps_Message   OUT varchar2);
     
--功能：转移数据到历史
procedure IO_MovHis
    (ps_DataKey  IN  tSkuPlu.PluName%type,
     ps_DataType IN  tSkuPlu.PluName%type,
     pi_Result  Out integer,
     ps_Message Out varchar2);

--功能：记录接口日志   
procedure WriteIOLog(ps_ErrType IN varchar2,ps_ErrMeg IN varchar2);
--功能：记录操作日志
procedure WriteIOCmpLog
    (ps_LogType      IN    IO_HsCmpLog.LogType%type,
     pd_LogTime      IN    IO_HsCmpLog.LogTime%type,
     pi_UserId       IN    IO_HsCmpLog.UserId%type,
     ps_YwType       IN    IO_HsCmpLog.YwType%type,
     ps_YwName       IN    IO_HsCmpLog.YwName%type,
     ps_DataKey      IN    IO_HsCmpLog.DataKey%type,
     ps_LogMeg       IN    IO_HsCmpLog.LogMeg%type);
     
--功能：修改单据的状态
--ps_CallTag释义：01-发送成功时调用，02-发送失败时调用，03记账成功时调用，04配送单传递至物流时调用
procedure UpdatBillState
     (ps_BillNo      IN    IO_tBillTranState.BillNo%type,
      ps_YwType      IN    IO_tBillTranState.Ywtype%type,
      ps_ReturnCode  IN    varchar2,
      ps_ReturnMsg   IN    Io_HscmpLog.Logmeg%type,
      ps_CallTag     IN    varchar2);
end PHSCWMS_DB;
