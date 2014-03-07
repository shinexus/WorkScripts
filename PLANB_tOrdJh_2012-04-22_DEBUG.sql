/*
*1001JHYW201204170338
*/

SELECT HCost FROM tOrdJhHead
WHERE BillNo = '1001JHYW201204170338'
;
SELECT SUM(HCost) FROM tOrdJhBody
WHERE BillNo = '1001JHYW201204170338'
ORDER By PluCode

Select BillNo,YwType, RptDate as DjDate ,hCost,wCost,SupCode,SupName
from tOrdJhhead a inner join tOrgManage b on a.OrgCode=b.OrgCode
where RptDate>='2012-04-17' and RptDate<='2012-04-17'
 and ForgCode='CW01'
 and YwType='0908'
 and ForgCode='CW01'
 and a.orgcode NOT IN ('7001','2002')
 AND BillNo = '1001JHYW201204170338'
 order by billno
 
 /*
 *1001JHYW201204170024
 */
 SELECT HCost FROM tOrdJhHead
WHERE BillNo = '1001JHYW201204170024'
;
SELECT SUM(HCOST) FROM tOrdJhBody
WHERE BillNo = '1001JHYW201204170024'
ORDER By PluCode

select '1001JHYW201204170024' as BillNo,c.BillType,'0908' as YwType,c.OrgCode,c.OrgName,
	       (select depcode from torgdept where depid=d.Depid) as depcode,
	       (select depname from torgdept where depid=d.Depid) as depname,
	       (select ClsCode from tcatcategory where clsid=e.Clsid) as ClsCode,
	       (select ClsName from tcatcategory where clsid=e.Clsid) as ClsName,
	       to_char((select jtaxrate from tstkpc where pcno=d.pcno)) as taxrate,
	       c.CkCode,c.CkName,
	       (select HtCode from tCntContract where Cntid=d.Cntid) as HtCode,
	       (select HtName from tCntContract where Cntid=d.Cntid) as HtName,
	       d.PluCode,d.PluName,d.Unit,
	       d.EtpCode as SupCode,
	       (select EtpName from tEtpSupplier where EtpCode=d.EtpCode and OrgCode=c.OrgCode) as SupName,
	      d.HCost,
	       d.WCost,
	       d.JyMode,
	       d.JsCode
	  from tStkKcjzHead201204 c, tStkKcjzBody201204 d, tskuplu e
	 where c.billno=d.billno
	   and '1001JHYW201204170024'=c.Ywbillno
	   and '0908'=c.Ywtype
	   and d.Pluid=e.Pluid
     ORDER BY PluCode
     
     SELECT * FROM tStkKcjzHead201204
     WHERE YwBillNo = '1001JHYW201204170024'
     
     SELECT PluCode,SUM(HCost) FROM tStkKcjzBody201204
     WHERE BillNo = '1001KCJZ120417000377'
     GROUP BY PluCode
     ORDER BY PluCode