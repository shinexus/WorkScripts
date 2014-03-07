--SELECT * FROM tSysYwType ORDER BY YwType
--SELECT * FROM tDstPsHead
--SELECT * FROM tDstPsBody
--SELECT * FROM tOrdJhHead
--SELECT * FROM tOrdJhBody WHERE BillNo = '1001JHYW201202020665'
--SELECT * FROM tOrgManage
--SELECT * FROM tStkKcjzHead201202
--SELECT * FROM tStkKcjzBody201202
Select a.BillNo,a.YwType,a. RptDate as DjDate ,sum(b.hCost) as hCost,sum(b.wCost) as Wcost,a.SupCode,a.SupName,to_char(b.jtaxrate) as TaxRate
from tOrdJhhead a,tOrdjhbody b
where RptDate>='2012-02-01' and RptDate<='2012-02-02'
 and a.billno=b.billno and a.YwType in ('0904','0905','0906','0907')
 and not (SupCode='00155' )
 and a.orgcode in ('7001','2002')
 and a.HtCode NOT IN ('002941','002942','005011'
group by a.billno,a.ywtype,a.supcode,a.supname,b.jtaxrate,a.rptdate
order by a.billno