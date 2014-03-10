/** 越库验收单：1001JHYW201401160395
 ** 越库采购单：1001201401160268
 ** 商品编码：  500101004  （ID：10010000036333       ）
 ** 含税进价：  26.3200    （tOrdJhBody表中的HjPrice   ）
 ** 合同报价：  27.7008    （tCntCxBody表中的NewHjPrice）
 ** 进项税率：  17
 ** 合同编码：  9990523305 （ID：10010000006320       ）
 ** sCnt_GetPluJPrice     返回值：27.7008
 ** sCnt_GetCntPluJPrice  返回值：27.7008
 ***************************************
 ** 越库验收单：1001JHYW201401160292
 ** 越库采购单：1001201401140352
 
/** 用户操作日志
SELECT * FROM tSysLog WHERE LogContent LIKE '%1001JHYW201401160395%';
SELECT * FROM tSysLog WHERE LogContent LIKE '%1001JHYW201401160292%';
 
/** 10010000036333
SELECT PluID FROM tSkuPlu WHERE PluCode = '500101004'; 

/** 过程中的表无记录
SELECT * FROM tOrdCgBody_JhPrice WHERE PluCode = '500101004';
SELECT * FROM tOrdCgBody_JhPrice WHERE BillNo = '1001201401160268';

/** 采购单主表
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201401160268';

/** 采购单明细表
SELECT * FROM tOrdCgBody WHERE PluCode = '500101004';

/** 验收单明细表
 ** HjPrice：含税进价
SELECT * FROM tOrdJhBody WHERE PluCode = '500101004';

/** 合同表
SELECT * FROM tCntContract WHERE HtCode = '9990523305';
select cntid from tordcghead where billno = '1001201401160268'
/** 合同报价单明细表
SELECT * FROM tCntCxBody WHERE PluCode = '500101004';
**/


/**** 采购单主表  ****/
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201403070221';

/**** 更新越库采购单到货有效日期 ****/
UPDATE tOrdCgHead SET YxDate = '2014-03-17' WHERE BillNo = '1001201403100222';
