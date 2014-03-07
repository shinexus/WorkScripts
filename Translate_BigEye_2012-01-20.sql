
/**201;291
[Select BillNo,YwType,]+&DjDate+[,hCost,wCost,SupCode,SupName]+&et+[from tOrdJhhead]+&innerjoin+[where]+&rqscop+&and_forg+&and_org
+[ and YwType in ('0904','0905','0906')]+&et
+[ and not (YwType='0906' and nvl(RefBillType,0)='0907')]+&et
+[ order by billno]
*/
--SELECT * FROM tSysYwType ORDER BY YwType
--SELECT * FROM tOrdJhHead WHERE HtCode = '005012'
--SELECT * FROM tOrdJhBody WHERE BillNo = '1001JHYW201202010226'
--201
SELECT * FROM ToRdJhBody WHERE BillNo = '1001JHYW201202040729'
INSERT INTO ToRdJhBody
SELECT * FROM ToRdJhBody@ZBCMP WHERE BillNo = '1001JHYW201202040729'
SELECT * FROM tStkKcJzHead201202@ZBCMP WHERE YwBillNo = '1001JHYW201202040729'

Select BillNo,YwType, RptDate as DjDate ,hCost,wCost,HtCode,SupCode,SupName
FROM tOrdJhhead a INNER JOIN tOrgManage b on a.OrgCode=b.OrgCode
where RptDate>='2012-02-01' and RptDate<='2012-02-09'
and ForgCode='CW01'
and YwType in ('0904','0905','0906')
and not (YwType='0906' and nvl(RefBillType,0)='0907')
and a.orgcode NOT IN ('7001','2002')
and a.htcode NOT IN ('002941','002942','005011')
AND a.HtCode = '005012'
AND a.Orgcode = '2008'
AND BillNo = '1001JHYW201202040729'
--GROUP BY a.ORGCODE
--ORDER BY HCOST
ORDER BY BillNo

--291
SELECT SUM(HCOST)
--SELECT billno,ywtype,JZDATE,hcost,wcost,supcode,supname
--验收单主表
FROM tOrdJhhead a 
INNER JOIN torgmanage b ON a.OrgCode = b.OrgCode
WHERE
--日期范围，大眼睛生成凭证界面上的两个日期变量
RptDate >= '2012-02-01'
AND RptDate <= '2012-02-09'
AND a.orgcode = b.orgcode
AND YwType in ('0904','0905','0906','0907')
--AND YwType = '0907'
--0902-采购
--0903-要货
--0904-物流采购验收
--0905-门店采购验收
--0906-无采购验收
--0907-直送验收
--0908-配送验收
--AND NOT (YwType='0906' and nvl(RefBillType,0)='0907')
AND a.HtCode NOT IN ('002941','002942','005011')
AND a.OrgCode NOT IN ('7001','2002')
ORDER BY BillNo

/**202;292
[Select BillNo,YwType,]+&DjDate+[,-1*HCost as Hcost,-1*WCost as WCost,SupCode,SupName]+&et+[from tOrdThhead]+&innerjoin+[where]+&rqscop+&and_forg+&and_org
+[ and YwType in ('0911','0914')]+&et
+[ and not (YwType='0914' and nvl(RefBillType,0)='0913')]+&et
+[ order by billno]
*/
SELECT * FROM tOrdThHead where YwType IN ('0911','0912')

--SELECT a.OrgCode,  SUM(HCOST)
Select BillNo,YwType, RptDate as DjDate ,-1*HCost as Hcost,-1*WCost as WCost,SupCode,SupName
from tOrdThhead@ZBCMP a inner join tOrgManage b on a.OrgCode=b.OrgCode
where RptDate>='2012-02-01' and RptDate<='2012-02-09'
 and ForgCode='CW01'
and a.orgcode NOT IN ('7001','2002')
--AND a.OrgCode = '2002'
 and a.HtCode NOT IN ('002941','002942','005011')
--AND a.HtCode LIKE '00501%'
 and YwType in ('0911','0914')
 and not (YwType='0914' and nvl(RefBillType,0)='0913')
order by billno
--GROUP BY a.OrgCode
--ORDER BY a.OrgCode
----------
SELECT * FROM tSysYwType ORDER BY YwType
SELECT * FROM tOrdThHead
WHERE
RptDate >= '2012-02-01'
--AND RptDate <= '2012-02-09'
AND OrgCode NOT IN ('2002','7001')
AND YwType IN ('0911','0913')
--0911:门店采购退货
--0913:门店直送退货给供应商
AND HtCode IN ('002941','002942','005011')

SELECT BillNo,YwType,JzDate,-1*HCost as Hcost,-1*WCost as Wcost,SupCode,SupName
FROM tOrdThHead a
INNER JOIN tOrgManage b ON a.orgcode = b.orgcode
WHERE
RptDate >= '2012-02-01'
--AND RptDate <= '2012-02-09'
AND a.orgcode = b.orgcode
AND a.OrgCode NOT IN ('2002','7001')
AND a.HtCode IN ('002941','002942','005011')
AND YwType in ('0911','0914')
--AND NOT (YwType='0914' and nvl(RefBillType,0)='0913')
ORDER BY BillNo

/**203
[Select BillNo,YwType,]+&DjDate+[,PsCost as hCost,wPsCost as wCost,SupCode,SupName]+&et+[from tOrdJhhead]+&innerjoin+[where]+&rqscop+&and_forg+&and_org
+[ and YwType='0907']+&et
+[ and not (YwType='0907' and ForgCode<>']+mZbForgCode+[')]+&et
+[ order by billno]
*/
SELECT * FROM tOrdJhHead WHERE BillNo in  ('1001JHYW201201080065','1001JHYW201201070337','1001JHYW201201070330')
SELECT BillNo,BillType FROM tOrdJhHead WHERE BillNo in  ('1001JHYW201201080065','1001JHYW201201070337','1001JHYW201201070330')

SELECT BillNo,YwType,JzDate,PsCost as hCost,wPsCost as wCost,SupCode,SupName
FROM tOrdJhHead a
INNER JOIN tOrgManage b ON a.orgcode = b.orgcode
WHERE
RptDate >= '2012-01-01'
AND RptDate <= '2012-01-09'
AND a.orgcode = b.orgcode
AND YwType = '0907'
AND NOT (YwType='0907' and ForgCode <> 'CW01')
ORDER BY BillNo

/**204
[Select BillNo,YwType,]+&DjDate+[,-1*PsCost as hCost,-1*wPsTotal as wCost,SupCode,SupName]+&et+[from tOrdthhead]+&innerjoin+[where]+&rqscop+&and_forg+&and_org
+[ and YwType='0913']+&et
+[ and not (YwType='0913' and ForgCode<>']+mZbForgCode+[')]+&et
+[ order by billno]
*/
SELECT * FROM tOrdThHead
SELECT BillNo,YwType,JzDate,-1*PsCost as hCost,-1*wPsTotal as wCost,SupCode,SupName
FROM tOrdThhead a
INNER JOIN tOrgManage b ON a.orgcode = b.orgcode
WHERE
RptDate >= '2012-01-01'
AND RptDate <= '2012-01-09'
AND a.orgcode = b.orgcode
AND YwType = '0913'
AND NOT (YwType='0913' and ForgCode <> 'CW01')
ORDER BY BillNo

/**209
mExtraLimits=2;mCbSr='CB';    
select a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,
a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(JTaxRate) as TaxRate,'' as CkCode,'' as CkName,
a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,
a.PluCode,a.PluName,a.Unit,a.JhEtpCode as SupCode,a.JhEtpName as SupName,
a.HJCost as HCost,a.WJCost as WCost,
a.JyMode,a.JhJsCode as JsCode,to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,KcBillNo
from mTb a inner join ]+mOrgManage+[ b on a.OrgCode=b.OrgCode]
union all ... ... 
JsCode='2' and not JyMode='3'
*/
SELECT * FROM tSalPluDetail201201
SELECT a.RptDate as Rq,a.SaleNo as BillNo,'' as billtype,'' as YwType,a.orgcode,a.orgname,
a.depcode,a.depname,a.clscode,a.clsname,to_char(JTaxRate) as TaxRate,'' as CkCode,'' as CkName,
a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,
a.PluCode,a.PluName,a.Unit,a.JhEtpCode as SupCode,a.JhEtpName as SupName,
a.HJCost as HCost,a.WJCost as WCost,a.JyMode,a.JhJsCode as JsCode,
to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,KcBillNo
FROM tsalpludetail201201 a
INNER JOIN tOrgManage b ON a.orgcode = b.orgcode
--UNION ALL
AND JsCode = '2' 
AND NOT JyMode = '3'

/**241
mExtraLimits=2;mCbSr='SR';         
+[	select a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,]
+[		a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(XTaxRate) as TaxRate,'' as CkCode,'' as CkName,]
+[		a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,]
+[		a.PluCode,a.PluName,a.Unit,a.JhEtpCode as SupCode,a.JhEtpName as SupName,]
+[		a.HXTotal as HCost,a.WXTotal as WCost,]
+[		a.JyMode,a.JhJsCode as JsCode,to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,KcBillNo]
+[	from mTb a inner join ]+mOrgManage+[ b on a.OrgCode=b.OrgCode]
+[	union all ... ... ]
datatype<>'D' and datatype<>'E'
*/
SELECT * FROM tsalpludetail201201
SELECT a.RptDate as Rq,a.SaleNo as BillNo,'' as billtype,'' as YwType,a.orgcode,a.orgname,
a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,
a.PluCode,a.PluName,a.Unit,a.JhEtpCode as SupCode,a.JhEtpName as SupName,a.HXTotal as HCost,
a.WXTotal as WCost,a.JyMode,a.JhJsCode as JsCode,to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,KcBillNo
FROM tsalpludetail201201 a
INNER JOIN tOrgManage b ON a.orgcode = b.orgcode
AND DataType <> 'D' 
AND DataType <> 'E'

/********251*
mExtraLimits=2;mCbSr='CB';mMacroSubstitution=1;mMacroSubstitution=2;    
+[	select a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,]
+[		a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(JTaxRate) as TaxRate,'' as CkCode,'' as CkName,]
+[		a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,]
+[		a.PluCode,a.PluName,a.Unit,a.JhEtpCode as SupCode,a.JhEtpName as SupName,]
+[		a.HJCost as HCost,a.WJCost as WCost,]
+[		a.JyMode,a.JhJsCode as JsCode,to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,KcBillNo]
+[	from mTb a inner join ]+mOrgManage+[ b on a.OrgCode=b.OrgCode]
+[	union all ... ... ]
[JsCode in ('0','1') and not JyMode='3' and orgcode NOT IN (']+hjm+[',']+Yiyang+[')]
************/
/*****
&and_forge
[ and ForgCode=']+mForgCode+[']
&and_in_forge
[ and OrgCode in(select OrgCode from ]+mOrgManage+[ where FOrgcode=']+mForgCode+[')]
*****/
--SELECT * FROM tsalpludetail201201
SELECT SUM(WCOST) FROM (
SELECT a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,a.DepCode,
a.DepName,a.ClsCode,a.ClsName,to_char(JTaxRate) as TaxRate,'' as CkCode,'' as CkName,a.JhHtCode as HtCode,
(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,a.PluCode,a.PluName,a.Unit,
a.JhEtpCode as SupCode,a.JhEtpName as SupName,a.HJCost as HCost,a.WJCost as WCost,a.JyMode,
a.JhJsCode as JsCode,to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,KcBillNo
FROM tsalpludetail201201 a 
INNER JOIN tOrgManage b ON a.orgcode = b.orgcode
AND a.RptDate BETWEEN '2012-01-01' AND '2012-01-26'
AND JsCode IN ('0','1')
AND NOT JyMode = '3'
AND a.OrgCode NOT IN ('2002','7001')
)
GROUP BY OrgCode
ORDER BY OrgCode

/********252
mExtraLimits=2;mCbSr='CB';mMacroSubstitution=1;mMacroSubstitution=2; 
************/
/********701,791
[Select BillNo,YwType,]+&DjDate+[,hCost,wCost,SupCode,SupName]+&et+[from tOrdJhhead]+&innerjoin+[where]+&rqscop+&and_forg+&and_org
+[ and YwType in ('0904','0905','0906','0907')]+&et
+[ and not (SupCode='00155' )]+&et
+[ and a.orgcode=']+hjm+[']+&et
+[ and a.orgcode=']+Yiyang+[']+&et
+[ order by billno]
*********/
SELECT SUM(WCOST) FROM tOrdJhHead@ZBCMP
WHERE RptDate >= '2012-02-01'
AND RptDate <= '2012-02-09'
AND YwType IN ('0904','0905','0906','0907')
AND NOT (SupCode = '0913')
AND orgCode = '2002'
AND HtCode IN ('002941','002942','005011')
ORDER BY BillNo

SELECT BillNo,YwType,JzDate,hCost,wCost,SupCode,SupName
FROM tOrdJhHead a
INNER JOIN tOrgManage b ON a.orgcode = b.orgcode
AND a.orgcode = b.orgcode
AND RptDate >= '2012-02-01'
AND RptDate <= '2012-02-09'
AND YwType IN ('0904','0905','0906','0907')
AND NOT (SupCode = '0913')
AND a.orgCode IN ('2002','7001')
AND a.HtCode IN ('002941','002942','005011')
ORDER BY BillNo

/********752***********/
select * from (
	select a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,
		a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(JTaxRate) as TaxRate,'' as CkCode,'' as CkName,
		a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,
		a.EtpCode,a.EtpName,
		a.PluCode,a.PluName,a.Unit,
		a.JhEtpCode as SupCode,a.JhEtpName as SupName,
		a.HJCost as HCost,
		a.WJCost as WCost,
		a.JyMode,
		a.JhJsCode as JsCode,
		to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,a.datatype,
		KcBillNo
	from TSALPLUDETAIL201202 a inner join tOrgManage b on a.OrgCode=b.OrgCode
	where  b.FOrgCode='CW01' and RptDate>='2012-02-01' and RptDate<='2012-02-11' ) where 
  --JsCode in ('0','1') and  
  JyMode>='2' and orgcode = '2002'

/********901
mExtraLimits=2;mCbSr='SR';mMacroSubstitution=2; 
+[	select a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,]
+[		a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(XTaxRate) as TaxRate,'' as CkCode,'' as CkName,]
+[		a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,]
+[		a.PluCode,a.PluName,a.Unit,a.JhEtpCode as SupCode,a.JhEtpName as SupName,]
+[		a.HXTotal as HCost,a.WXTotal as WCost,]
+[		a.JyMode,a.JhJsCode as JsCode,to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,KcBillNo]
+[	from mTb a inner join ]+mOrgManage+[ b on a.OrgCode=b.OrgCode]
+[	union all ... ... ]
[JsCode='2' and  supCode='00099' and orgcode<>']+hjm+[']
************/
SELECT * FROM tsalpludetail201201
SELECT a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,
a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(XTaxRate) as TaxRate,'' as CkCode,'' as CkName,
a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,
a.PluCode,a.PluName,a.Unit,a.JhEtpCode as SupCode,a.JhEtpName as SupName,a.HXTotal as HCost,
a.WXTotal as WCost,a.JyMode,a.JhJsCode as JsCode,to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,KcBillNo
FROM tsalpludetail201201 a
INNER JOIN tOrgManage b ON a.orgcode = b.orgcode
AND JsCode = '2'
AND SupCode = '00099'
AND OrgCode NOT IN ('2002','7001')


/********913
mExtraLimits=1; 
[Select BillNo,YwType,]+&DjDate+[,hCost,wCost,SupCode,SupName]+&et+[from tOrdJhhead]+&innerjoin+[where]+&rqscop+&and_forg+&and_org
+[ and YwType='0908']+&et
+[ and ForgCode=']+mZbForgCode+[']+&et
+[ and a.orgcode=']+hjm+[']+&et
+[ and a.orgcode=']+Yiyang+[']+&et
+[ order by billno]
************/
--SELECT * FROM tOrdJhHead WHERE YwType = '0908'
select SUM(HCOST) from (
	select a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,
		a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(JTaxRate) as TaxRate,'' as CkCode,'' as CkName,
		a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,
		a.EtpCode,a.EtpName,
		a.PluCode,a.PluName,a.Unit,
		a.JhEtpCode as SupCode,a.JhEtpName as SupName,
		a.HJCost as HCost,
		a.WJCost as WCost,
		a.JyMode,
		a.JhJsCode as JsCode,
		to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,a.datatype,
		KcBillNo
	from TSALPLUDETAIL201202 a inner join tOrgManage b on a.OrgCode=b.OrgCode
where  b.FOrgCode='CW01' and RptDate>='2012-02-01' and RptDate<='2012-02-09') 
where JsCode='2' 
and NOT supCode='00099' 
and orgcode IN ('7001','2002')

--1001JHYW201201030208

/*****************913
mExtraLimits=1;mCbSr='CB';
[Select BillNo,YwType,]+&DjDate+[,PsTotal as hCost,wPsTotal as wCost]+&et+[from tDstPsHead]+&innerjoin+[where]+&rqscop+&and_forg+&and_org
+[ and a.OrgType='0' and YwType='2003']+&et
+[ and a.shorgcode=']+hjm+[']+&et
+[ order by BillNo]
************************/
/*****
&and_forge
[ and ForgCode=']+mForgCode+[']
&and_in_forge
[ and OrgCode in(select OrgCode from ]+mOrgManage+[ where FOrgcode=']+mForgCode+[')]
*****/
SELECT * FROM tDstPsHead
--SELECT BillNo,YwType,JzDate,PsTotal as hCost,wPsTotal as wCost
SELECT *
FROM tDstPsHead a
INNER JOIN tOrgManage b ON a.OrgCode = b.OrgCode
WHERE RptDate BETWEEN '2012-02-01' AND '2012-02-01'
AND a.OrgCode = b.OrgCode
AND a.OrgType = '0'
AND YwType = '2003'
--AND a.shorgcode IN ('2002','7001')
AND a.shorgcode = '2002'
ORDER BY BillNo

/*****************DEBUG CODE*****************/
select * from (
	select a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,
		a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(JTaxRate) as TaxRate,'' as CkCode,'' as CkName,
		a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,
		a.EtpCode,a.EtpName,
		a.PluCode,a.PluName,a.Unit,
		a.JhEtpCode as SupCode,a.JhEtpName as SupName,
		a.HJCost as HCost,
		a.WJCost as WCost,
		a.JyMode,
		a.JhJsCode as JsCode,
		to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,a.datatype,
		KcBillNo
	from TSALPLUDETAIL201201 a inner join tOrgManage b on a.OrgCode=b.OrgCode
	where  b.FOrgCode='CW01' and RptDate>='2012-01-01' and RptDate<='2012-01-26' and a.orgcode<>'2002' 
and a.orgcode<>'7001') 
where JsCode='2' and not JyMode='3' 

/********************************TRA************************************/
select '1001JHYW201202010132' as BillNo,c.BillType,'0907' as YwType,c.OrgCode,c.OrgName,
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
	  from tStkKcjzHead201202 c, tStkKcjzBody201202 d, tskuplu e
	 where c.billno=d.billno
	   and '1001JHYW201202010132'=c.Ywbillno
	   and '0907'=c.Ywtype
	   and d.Pluid=e.Pluid
     
     ------------------------
select * from tStkKcJzHead201202

select * from tSysClassDict
--where DatasetName = 'tSalPluDetailZb'
ORDER BY Datasetname
--CLASSID = '18010'
