/**  collate  collateitem  ****************************************************
***  数据字典  *****************************************************************/
SELECT * FROM Collate@HDWMS;
SELECT * FROM Collateitem@HDWMS;

/**  HDWMS_LOG  ***************************************************************
***  接收日志：WM_MIS_TRECVLOG
***  发送日志：WM_MIS_TSENDLOG  ************************************************/
SELECT * FROM WM_MIS_TSENDLOG;
SELECT * FROM WM_MIS_TRECVLOG;
SELECT * FROM wm_mis_talcntcdtl@HDWMS WHERE FsrcNum = 'P'||'1001201403130198';
/******************************************************************************/

/****  CMP_LOG  ***************************************************************/
SELECT * FROM tsysywtype ORDER BY YwType;

/**************************************
 TRUNCATE TABLE IO_HscmpLog;
 DELETE FROM IO_HscmpLog;
 DELETE 4,013,696 行已删除，用时357.86秒。
***************************************/
SELECT * FROM IO_HscmpLog WHERE LogTime >= '2014-04-08' ORDER BY LogTime DESC;
SELECT * FROM IO_HscmpLog WHERE LogMeg  LIKE '%520001069%' ORDER BY LogTime DESC;
SELECT * FROM IO_HscmpLog WHERE DataKey = '1001THYW201404250031' ORDER BY LogTime DESC;

/****  YwType=1808；YwName=移库结果接收  ****/
SELECT * FROM IO_HscmpLog WHERE YwType = '1808' ORDER BY LogTime DESC;
SELECT * FROM IO_HscmpLog WHERE YwType = '1808' AND DataKey = 'WMS11404080100' ORDER BY LogTime DESC;
SELECT * FROM IO_HscmpLog WHERE YwType = '1808' AND DataKey LIKE 'WMS1140408%' ORDER BY LogTime DESC;
SELECT * FROM IO_HscmpLog WHERE YwType = '1808' AND LogMeg LIKE '%[01=>02]%' ORDER BY LogTime DESC;
SELECT * FROM IO_HscmpLog WHERE YwType = '1808' AND LogMeg LIKE '%[02=>01]%' ORDER BY DataKey;
SELECT * FROM IO_HscmpLog WHERE YwType = '1808' AND LogMeg LIKE '%300001045%' ORDER BY LogTime DESC;
--DELETE FROM IO_HscmpLog WHERE YwType = '1808';

/****  YwType=2003；YwName=配送结果接收  ****/
SELECT * FROM IO_HscmpLog WHERE YwType = '2003' ORDER BY LogTime DESC;
--DELETE FROM IO_HscmpLog WHERE YwType = '2003';

/****  YwType=2004；YwName=配送退货接收  ****/
SELECT * FROM IO_HscmpLog WHERE YwType = '2004' ORDER BY LogTime DESC;
SELECT * FROM IO_HscmpLog WHERE YwType = '2004' AND DataKey LIKE '%PSTH%' ORDER BY LogTime DESC;

/****  YwType=0905；YwName=采购验收结果接收  ****/
SELECT * FROM IO_HscmpLog WHERE YwType = '0905' ORDER BY LogTime DESC;
--DELETE FROM IO_HscmpLog WHERE YwType = '0905';

/****  YwType=0914；YwName=采购退货接收  ****/
SELECT * FROM IO_HscmpLog WHERE YwType = '0914' ORDER BY LogTime DESC;
--DELETE FROM IO_HscmpLog WHERE YwType = '0914';

/****  YwType=2004；YwName=物流报溢接收;物流报损接收  ****/
SELECT * FROM IO_HscmpLog WHERE YwType = '1902' ORDER BY DataKey DESC;

SELECT * FROM IO_tTrgLog ORDER BY LogTime DESC;
SELECT * FROM IO_tBillTranState WHERE BillNo = '1001THYW201401270006' ORDER BY TjTime DESC;
--DELETE FROM IO_tBillTranState WHERE BillNo = '1001THYW201403290027';
SELECT * FROM tSysPerDayLog ORDER BY LogTime DESC;
--SELECT * FROM IO_tDstRtn
/******************************************************************************/

/**  tStkLsKc 连锁库存表  *********************************/
SELECT *
--COUNT(KcCount) --126
FROM tStkLsKc WHERE OrgCode = '0001' AND CkCode = '01' AND KcCount > '0' ORDER BY KcCount DESC;

SELECT * FROM tStkLsKc WHERE PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520001012') AND OrgCode = '0001' AND CkCode = '02' AND KcCount > '0' ORDER BY KcCount DESC;
SELECT * FROM tStkLsKc WHERE PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520300081') AND OrgCode = '0001' AND CkCode = '02' AND KcCount > '0' ORDER BY KcCount DESC;
SELECT * FROM tStkLsKc WHERE PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '540006007') AND OrgCode = '0001' AND CkCode = '02' AND KcCount > '0' ORDER BY KcCount DESC;

SELECT * FROM tStkLsKc WHERE PcNo = '1001LSPD201402140029500001' AND OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003') ORDER BY KcCount DESC;
SELECT * FROM tStkLsKc WHERE PcNo = '1001LSPD201402130044500001' AND OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520001012') ORDER BY KcCount DESC;
SELECT * FROM tStkLsKc WHERE OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003') ORDER BY KcCount DESC;

/*******************************************************************
INSERT INTO tStkLsKc 
(OrgCode, DepID, PREDEPID, CKCODE, PLUID, EXPLUCODE, PCGUID, PcNo, KcCount, Hcost, Wcost, PluType, JhDate, TEMPDATE, WLAREACODE, PACKQTY) VALUES 
('0001', '11', '0', '01', '10010000002285', '*', '1001JHYW201402110147000001', '1001LSPD201402140029500001', '6', '125.4', '107.18', '0', '2014-02-11 13:28:33', NULL, '*', '1');

UPDATE tStkLsKc SET KcCount = '20' WHERE PcNo = '1001JHYW201401180136000003' AND OrgCode = '0001' AND CkCode = '02' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003');
UPDATE tStkLsKc SET KcCount = '10' WHERE PcNo = '1001LSPD201402130044500001' AND OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520001012');
UPDATE tStkLsKc SET KcCount = '28' WHERE PcNo = '1001LSPD201402130045500001' AND OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520300081');

DELETE FROM tStkLsKc WHERE PcNo = '1001LSPD201402140029500001' AND OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003');
*********************************************************************/
SELECT SUM(JhCount), SUM(ThCount), SUM(xscount), SUM(XsThCount) FROM tStkPc WHERE PluID = '10010000030177' ORDER BY JhDate DESC;

/***tStkLsKcLock 连锁库存锁定表***/
SELECT * FROM tStkLsKcLock WHERE Orgcode = '0001' AND pluid = (select pluid from tskuplu where plucode = '310100024');
SELECT * FROM tStkLsKcLock WHERE OrgCode = '0001' AND YwBillNo = '1001PSYW201312180157';

/**  tStkJxcRptSouceYYMM  门店进销存数据源表  *************************************
***  01仓库2013-11-30期末库存  **************************************************/
/**  DataType = 0  入库  **/
/**  DataType = 1  出库  **/
/**  DataType = 2  期末  **/
SELECT * FROM tStkJxcRptSouce201403;

SELECT SJRS.OrgCode, SJRS.CkCode, SJRS.YwType,SJRS.DataType, SJRS.RptDate, SJRS.RecCount, SJRS.DataType 
FROM tStkJxcRptSouce201403 SJRS
WHERE SJRS.OrgCode = '0001' AND SJRS.PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '110402076')
ORDER BY RptDate;

/**  退货单主表  ****************************************************************
***  YwType = 0911  门店采购退货         *****************************************
***  YwType = 0912  门店退货给总部       *****************************************
***  YwType = 0913  门店直送退货给供应商  *****************************************
***  YwType = 0914  总部采购退货         *****************************************
*******************************************************************************/
SELECT * FROM tOrdThHead WHERE BillNo = '1001THYW201401060045' ORDER BY LrDate DESC;
SELECT * FROM tOrdThBody WHERE BillNo = '1001THYW201401060045';

SELECT th.BillNo, th.RefBillNo, th.OrgCode, th.OrgName, th.BillType, th.YwType, th.LrDate, th.JzDate, th.CkCode, tb.PluCode, tb.PluType, tb.PluName, tb.ThCount, th.DataStatus 
FROM tOrdThHead th, tOrdThBody tb
WHERE th.BillNo = tb.BillNo
AND th.YwType = '0912'
AND th.DataStatus = '9'
AND th.JzDate IS NULL
AND th.LrDate >= '2013-11-27' ORDER BY th.LrDate;

/**  配送退货单主表  *************************************************************
***  YwType = 0911  门店采购退货         *****************************************
***  YwType = 0912  门店退货给总部       *****************************************
***  YwType = 0913  门店只送退货给供应商   ****************************************
***  YwType = 0914  总部采购退货         ****************************************
*******************************************************************************/
SELECT * FROM tDstRtnHead WHERE RefBillNo LIKE '1001THYW20140102005%' ORDER By LrDate DESC;

SELECT pth.BillNo, pth.RefBillNo, th.YwType, pth.LrDate, pth.ThOrgCode, pth.ThOrgName, pth.ThCount, th.ThCount
FROM tDstRtnHead pth, tOrdThHead th
WHERE pth.RefBillNo = th.BillNo
AND th.TjrCode = '*' AND th.TjrName = '*'
AND th.LrDate >= '2013-11-27'
--AND th.BillNo = '1001THYW201312020005'
ORDER BY th.LrDate;

/**  tOrdJhHead  验收单主表  **
***
***
*/
SELECT * FROM tOrdJhHead;

--alter system set processes=200 scope=spfile;
--show parameters processes;
--select count(*) from v$process;

