select *
from tCntContract
where etpcode = '00086'

select *
from tCntPlu

select distinct
a.etpcode as 供应商编码,
a.etpname as 供应商名称,
--b.PLUCODE as 商品编码,
c.pluname as 商品名称,
c.spec as 规格
from 
tCntContract a, 
tCntPlu b, 
tSkuPlu c
where 
a.cntid  = b.cntid and
b.plucode = c.plucode
order by 
a.etpcode

---------------------------------
SELECT "供应商编码", "供应商名称", "商品名称", "规格" FROM(
select distinct 
a.etpcode as 供应商编码, 
a.etpname as 供应商名称, 

c.pluname as 商品名称, 
c.spec as 规格 
from  
tCntContract a,  
tCntPlu b,  
tSkuPlu c 
where  
a.cntid  = b.cntid and 
b.plucode = c.plucode 
order by  
a.etpcode
)

--

select *
from tSkuPlu