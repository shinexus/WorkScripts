select *
from tCntContract
where etpcode = '00086'

select *
from tCntPlu

select distinct
a.etpcode as ��Ӧ�̱���,
a.etpname as ��Ӧ������,
--b.PLUCODE as ��Ʒ����,
c.pluname as ��Ʒ����,
c.spec as ���
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
SELECT "��Ӧ�̱���", "��Ӧ������", "��Ʒ����", "���" FROM(
select distinct 
a.etpcode as ��Ӧ�̱���, 
a.etpname as ��Ӧ������, 

c.pluname as ��Ʒ����, 
c.spec as ��� 
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