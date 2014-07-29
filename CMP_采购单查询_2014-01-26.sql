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
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201407140024';

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

SELECT * FROM tOrdCgHead ORDER BY LrDate DESC;

/**** 更新采购单主表中的合同编码和合同名称 ****/
/**** 赠品合同需将：含税进价金额（CgHCost）、未税进价金额（CgWCost）、税额（CgJTaxTotal）、售价金额（STotal）、进销差价（CjTotal） ****/
/**** 危险操作！ ****/
/**** 注意条件语句！ ****/
/**** 9990823308 天津北大荒望捷(赠品） ****/
/**** 9990923309 天津北大荒望捷(进口品） ****/
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201407210172';
--UPDATE tOrdCgHead SET HtCode = '9990823308', HtName = '天津北大荒望捷(赠品）', CgHCost = '0', CgWCost = '0', CgJTaxTotal = '0', STotal = '0', CjTotal = '0' WHERE BillNo = '1001201407210172';

/**** 更新HtCode之后，更新明细表含税进价（HjPrice）、含税进价金额（CgHCost）、未税进价（WjPrice）、未税进价金额（CgWCost）、售价（Price）、售价金额（STotal）、税率（JTaxRate）、税额（CgJTaxTotal） ****/
/**** 危险操作！ ****/
/**** 注意条件语句！ ****/
SELECT * FROM tOrdCgBody WHERE BillNo = '1001201407210172';
--UPDATE tOrdCgBody SET HjPrice = '0', CgHCost = '0', WjPrice = '0', CgWCost = '0', Price = '0', STotal = '0', JTaxRate = '0', CgJTaxTotal = '0' WHERE BillNo = '1001201407210172';

/**** 更新越库采购单到货有效日期 ****/
--UPDATE tOrdCgHead SET YxDate = '2014-03-25' WHERE BillNo = '1001201403120256';


SELECT * FROM tOrdCgHead WHERE BillNo IN ('1001201403170121', '1001201403260151');
