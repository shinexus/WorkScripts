select 
a.PLUCODE as ������Ʒ����,
b.[����] AS ��Ȼ���,
a.pluname AS ������Ʒ����,
b.���� AS �����Ʒ����,
a.SPEC AS ���Ź��,
b.������� AS ��ȹ��,
a.unit AS ���ŵ�λ,
b.[��С���۵�λ] AS ��ȵ�λ
from 
[HX_tSkuPlu_2013-04-25] a, 
[CG_tSkuPlu_2013-04-24] b
where 
a.PLUCODE = b.����
and a.UNIT <> b.��С���۵�λ
order by a.PLUCODE