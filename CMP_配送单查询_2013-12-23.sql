/****
SELECT * from tsysywtype ORDER BY YwType;
****/
/****  tDstPsHead配送单主表   ******************************************************
*****  PsType   = '0' 普通配送*****************************************************
*****  PsType   = '1' 越库配送*****************************************************
*****  YwStatus = '0' 未验收  ****************************************************
*****  YwStatus = '1' 验收中  *****************************************************
*****  YwStatus = '2' 已验收  *****************************************************
*****  YwStatus = '3' 已结案  *****************************************************/
SELECT * FROM tDstPsHead WHERE BillNo = '1001PSYW201401270160' ORDER BY LrDate;

SELECT * FROM tDstPsBody WHERE BillNo = '1001PSYW201401270160';
SELECT * FROM tDstPsBody WHERE BillNo = '1001PSYW201403250008' AND PluCode = '120401055';


SELECT * FROM tDstPsHead WHERE ShOrgCode = '1001' AND BillNo IN ( 
SELECT BillNo FROM tDstPsBody WHERE PluCode = '310200031');


/**** 更新单据状态，可以再次记账
UPDATE tDstPsHead SET TjDate = NULL, JzDate = NULL, DataStatus = '0' WHERE BillNo = '1001PSYW201401150106';
****/

/**** 未验收的配送单，统配和越库 **/
--UPDATE tDstPsHead SET YwStatus = '3' WHERE BillNo = '1001PSYW201312170138'

/**** 0数量配送单，更新 YwStatus = '3' 避免门店验收混乱 
SELECT * FROM tDstPsHead WHERE LrDate >= '2013-11-27' AND PsCount = '0';
UPDATE tDstPsHead SET YwStatus = '3' WHERE BillNo = '1001PSYW201401240167';
UPDATE tDstPsHead SET YwStatus = '3' WHERE LrDate >= '2013-11-27' AND JzDate IS NOT NULL AND PsCount = '0';
****/

/**** 更新商品状态
/**** PluType = '0'(正品)
/**** PluType = '1'(赠品)
/**** PluType = '2'（促销品）
UPDATE tDstPsBody SET PluType = '0' WHERE BillNo = '1001PSYW201403250008' AND PluCode = '120401055';


/*******************************************************/
SELECT * FROM tDstPsHead;
SELECT * FROM tDstPsBody;

SELECT tDPH.BillNo, tDPH.ShOrgName, tDPH.JzDate, tDPB.PluCode, tDPB.PsCount FROM tDstPsHead tDPH, tDstPsBody tDPB
WHERE tDPH.BillNo = tDPB.BillNo
AND tDPB.PluCode = '520000003'
AND tDPH.LrDate BETWEEN '2014-02-01' AND SysDate
AND JzDate IS NULL
ORDER BY tDPH.BillNo DESC;

