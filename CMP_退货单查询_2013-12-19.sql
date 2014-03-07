/**  业务类型表 **************************
SELECT * FROM tSysYwType ORDER BY YwType
****************************************/
/**  退货单主表  ****************************************************************
***  YwType = 0911  门店采购退货         *****************************************
***  YwType = 0912  门店退货给总部       *****************************************
***  YwType = 0913  门店直送退货给供应商  *****************************************
***  YwType = 0914  总部采购退货         *****************************************
*******************************************************************************/
SELECT * FROM tOrdThHead WHERE BillNo = '1001THYW201401040034';
SELECT TjDate, JzDate, DataStatus, IsNeedTjWl, IsZdJPrice FROM tOrdThHead WHERE BillNo = '1001THYW201401270006';

/** 更新退货单仓库
UPDATE tOrdThHead SET CkCode = '02', CkName = '不良品仓' WHERE BillNo = '1001THYW201401270021';

/** 更新单据状态，可以再次记账 *****************************************
UPDATE tOrdThHead SET TjDate = NULL, JzDate = NULL, DataStatus = '0'
WHERE BillNo = '1001THYW201401270021';

*********************************************************************/

/** 门店退货单中间表 **/
SELECT * FROM WM_MIS_TSTORERTN ORDER BY FSrcNum;
/****/

/** 2014-01-11_未形成配送退货单的门店退单 **/
SELECT * FROM tOrdThHead 
WHERE BillNo NOT IN (SELECT RefBillNo FROM tDstRtnHead)
AND YwType = '0912' AND LrDate BETWEEN '2013-11-27' AND SysDate AND DataStatus = '9'
ORDER BY LrDate DESC;
/**************************************/

/** 2014-01-13_未记账门店退货单 **/
SELECT * FROM tOrdThHead
WHERE YwType = '0912' AND JzDate IS NULL AND LrDate BETWEEN '2013-11-27' AND SysDate
ORDER BY LrDate DESC;
/******************************/

/** 2014-01-13_未记账配送退货单 **/
SELECT * FROM tDstRtnHead
WHERE YwType = '0912' AND JzDate IS NULL AND LrDate BETWEEN '2013-11-27' AND SysDate
ORDER BY LrDate DESC;

SELECT * FROM tDstRtnHead WHERE RefBillNo = '1001PSTH201312140018';

/** 更新单据状态，可以再次记账
UPDATE tDstRtnHead SET TjDate = NULL, JzDate = NULL, DataStatus = '0'
WHERE BillNo = '1001PSTH201312250021';

/** 调用过程提交单据
sStk_Commit_PsTh_ORA;

调用过程记账单据
sStk_Account_PsTh_Ora;

调试 tStkPcGuidYw 业务单批次索引附件表
select * from tStkPcGuidYw where BillNo='1001PSTH201401050005';
select * from tStkPcGuidYw where BillType='2004';
select * from tStkPcGuidYw where plucode = '520102018' ORDER BY BillNo DESC;
**/

/******************************/

/** 2014-01-16_返回类型错误的配送退货单 **/
SELECT DISTINCT Logtype, UserID, YwType, YwName, DataKey, LogMeg FROM IO_HscmpLog
WHERE YwType = '2004' AND LogMeg LIKE '%THYW%'
ORDER BY DataKey DESC;
/*************************************/

/** 2014-01-17_处理返回类型错误的配送退货单 **/
--门店退货单接口表 
SELECT * FROM WM_MIS_TSTORERTN 
WHERE FsrcNum LIKE '%1001THYW201401020084%'
ORDER BY FReturnDate DESC;

SELECT * FROM WM_MIS_TSTORERTN 
WHERE Num = 'WMS11401020017';
/**
DELETE FROM WM_MIS_TSTORERTN WHERE Num = 'WMS11401060004';
**/
/******
UPDATE WM_MIS_TSTORERTN SET FsrcNum = '1001PSTH201401120031'
WHERE Num = 'WMS11401020017';
*******/

SELECT * FROM IO_HSCMPLOG WHERE DataKey = '1001THYW201401270006';

SELECT * FROM tOrdThHead WHERE BillNo = '1001THYW201401270006';

/****
UPDATE tOrdThHead SET 
DataStatus = '9', 
JzDate = '2014-01-28' || '14:55:56', 
TjrCode = '*', TjrName = '*',
JzrCode = '*', JzrName = '*' 
WHERE BillNo = '1001THYW201401270006';
****/

/**** 2014-02-17 未提交及未记账采购退货单 ****/
SELECT * FROM tOrdThHead
WHERE YwType = '0914' AND JzDate IS NULL AND LrDate BETWEEN '2013-11-27' AND SysDate
ORDER BY LrDate DESC;
