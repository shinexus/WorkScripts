select * from tOrdThHead
WHERE RptDate >= '2012-02-01'
and SupCode = '00105'

--INSERT INTO tOrdThBody
select * from tOrdThBody
--where BillNo IN ('1001THYW201202110061','1001THYW201202110086','1001THYW201202110087')
where BillNo = '1001THYW201202030086'

--INSERT INTO tOrdThBody
select * from tOrdThBody
WHERE BillNo = '1001THYW201202010175'

select '1001THYW201202010175' as BillNo,c.BillType,'0914' as YwType,c.OrgCode,c.OrgName,d.HCost, d.WCost, d.JyMode, d.JsCode
from tStkKcJzHead201202 c, tStkKcJzBody201202 d, tskuplu e
where c.BillNo = d.BillNo
and d.pluid = '10010000005914'
--and d.Pluid = e.Pluid
and c.YwBillNo = '1001THYW201202010175'

select * from tStkKcJzHead201202
where YwBillNo = '1001JHYW201202020721'
select SUM(HCOST) from tstkkcjzbody201202
WHERE BillNo = '1001KCJZ120202003899'
AND pluid = '110502039'

--WHERE PCno = '1001THYW201202010175'

select '1001THYW201202030086' as BillNo,c.BillType,'0911' as YwType,c.OrgCode,c.OrgName,
(select depcode           from torgdept         where depid=d.Depid)  as depcode,
(select depname           from torgdept         where depid=d.Depid)  as depname,
(select ClsCode           from tcatcategory     where clsid=e.Clsid)  as ClsCode,
(select ClsName           from tcatcategory     where clsid=e.Clsid)  as ClsName,
to_char((select jtaxrate  from tstkpc           where pcno=d.pcno))   as taxrate, c.CkCode,c.CkName,
(select HtCode            from tCntContract     where Cntid=d.Cntid)  as HtCode,
(select HtName            from tCntContract     where Cntid=d.Cntid)  as HtName, d.PluCode,d.PluName,d.Unit, d.EtpCode as SupCode,
(select EtpName           from tEtpSupplier     where EtpCode=d.EtpCode and OrgCode=c.OrgCode) as SupName, d.HCost, d.WCost, d.JyMode, d.JsCode
from tStkKcjzHead201202 c, tStkKcjzBody201202 d, tskuplu e
where c.billno=d.billno and '1001THYW201202030086'=c.Ywbillno and '0911'=c.Ywtype and d.Pluid=e.Pluid

--------------------
INSERT INTO tskuplu
select * from tskuplu@ZBCMP where pluid = '10010000001216'
select * from tskuplu where pluid = '10010000001216'

select '1001THYW201202030086' as BillNo,c.BillType,'0911' as YwType,c.OrgCode,c.OrgName
from tStkKcjzHead201202 c, tStkKcjzBody201202 d, tskuplu e
where c.billno=d.billno and '1001THYW201202030086'=c.Ywbillno and '0911'=c.Ywtype and d.Pluid=e.Pluid

select * from  tSalPluDetail201202
where jscode = '2'
and Orgcode NOT IN ('2002','7001')
and rptdate between '2012-02-01' and '2012-02-09'
and JhHtCode NOT in ('002941','002942','005011')
--where EtpCode = '00099'

select SUM(hcost) from (
	select a.RptDate as Rq,a.SaleNo as BillNo,'' as BillType,'' as YwType,a.OrgCode,a.OrgName,
		a.DepCode,a.DepName,a.ClsCode,a.ClsName,to_char(XTaxRate) as TaxRate,'' as CkCode,'' as CkName,
		a.JhHtCode  as HtCode,(select HtName from tCntContract where HtCode=a.JhHtCode) as HtName,
		a.EtpCode,a.EtpName,
		a.PluCode,a.PluName,a.Unit,
		a.JhEtpCode as SupCode,a.JhEtpName as SupName,
		a.HXTotal as HCost,
		a.WXTotal as WCost,
		a.JyMode,
		a.JhJsCode as JsCode,
		to_char(a.XsDate, 'yyyy-mm-dd') as YwDate,a.datatype,
		KcBillNo
	from TSALPLUDETAIL201202 a inner join tOrgManage b on a.OrgCode=b.OrgCode
	where  b.FOrgCode='CW01' 
  and RptDate>='2012-02-01' and RptDate<='2012-02-09' ) 
  
  where datatype<>'D' and datatype<>'E' and not (jscode='2' and  supCode='00099')  
  and orgcode NOT IN ('2002','7001') 
  and htcode NOT IN ('002941','002942','005011')
--------------------------------------------------
--913