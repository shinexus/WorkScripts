/**** 处理 总部采购退货 0914
***** 1001THYW201401270006
****/

/**** 损益记录 ****/
SELECT * FROM tCouLsPdHead WHERE OrgCode = '0001';
SELECT * FROM tCouLsPdHead WHERE ReMark LIKE '1001THYW201401270006%';
SELECT BillNo, LrDate, UserName, YkCount, ReMark FROM tCouLsPdHead WHERE ReMark LIKE '1001THYW201401270006%';

SELECT * FROM tCouLsPdBody WHERE PluCode = '520000003' AND BillNo IN (SELECT BillNo FROM tCouLsPdHead WHERE ReMark LIKE '1001THYW201401270006%');

/**** 配送单记录 ****/
SELECT * FROM tDstPsHead WHERE BillNo IN (
SELECT BillNo FROM tDstPsBody WHERE PluCode IN (
SELECT PluCode FROM tCouLsPdBody WHERE BillNo IN (
SELECT BillNo FROM tCouLsPdHead WHERE ReMark LIKE '1001THYW201401270006%')))
AND LrDate >= '2013-12-01'
ORDER BY BillNo DESC;