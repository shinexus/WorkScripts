/**** 业务类型 ****/
SELECT * FROM tSysYwType ORDER BY YwType;

/**** 商品编码表 ****/
/**** YwStatus:业务状态；0:待批；1:正常；2:预淘汰；3:淘汰 ****/
/**** IsOnline:上线状态；0:下线；1:上线 ****/
SELECT * FROM tSkuPlu WHERE YwStatus = '3';

/**** 合同表 ****/
/**** HtStatus:合同状态；0:未执行；1:执行；3:终止；4:单方续签 ****/
SELECT * FROM tCntContract;

/**** 合同商品表 ****/
SELECT * FROM tCntPlu;

/**********************************************************************/
SELECT sp.PluCode, sp.PluName, sp.YwStatus, cc.HtCode, cc.HtName, cc.HtStatus
FROM tSkuPlu sp, tCntPlu cp, tCntContract cc
WHERE sp.YwStatus = '3' AND cp.PluCode = sp.Plucode AND cc.CntID = cp.CntID AND cc.HtStatus = '3'
ORDER BY PluCode;

/**********************************************************************/
/**** 不存在于合同商品表的商品 *******************************************/
SELECT * FROM tSkuPlu WHERE PluID NOT IN (SELECT PluID FROM tCntPlu);
SELECT * FROM tSkuPlu WHERE PluCode NOT IN (SELECT PluCode FROM tCntPlu) ORDER BY PluCode;
SELECT COUNT(PluCode) FROM tSkuPlu;
SELECT COUNT(PluCOde) FROM tSkuPlu WHERE PluCode NOT IN (SELECT PluCode FROM tCntPlu);

/**** 淘汰状态的合同商品 *******************************************************************/
SELECT * FROM tSkuPlu WHERE PluCode IN (SELECT PluCode FROM tCntPlu) AND YwStatus = '3' ORDER BY PluCode;

/**** 应付单据表（视图） *********************/
/**** YwType:业务类型；    2301:普通采购发票***/
/**** IsFinished:结清标志；0:否；1:是 ********/
SELECT * FROM TAcpAccReceipt WHERE IsFinished = '0';