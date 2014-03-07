select 
a.PLUCODE as 海信商品编码,
b.[货号] AS 冲谷货号,
a.pluname AS 海信商品名称,
b.名称 AS 冲谷商品名称,
a.SPEC AS 海信规格,
b.基本规格 AS 冲谷规格,
a.unit AS 海信单位,
b.[最小销售单位] AS 冲谷单位
from 
[HX_tSkuPlu_2013-04-25] a, 
[CG_tSkuPlu_2013-04-24] b
where 
a.PLUCODE = b.货号
and a.UNIT <> b.最小销售单位
order by a.PLUCODE