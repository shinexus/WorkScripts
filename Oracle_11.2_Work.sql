select 
  (select clscode from tCatCategory 
    where clscode like '__' )
    as ��������
  from tCatCategory 
  where clscode like '_' 
  order by clscode

select clscode as �ļ�����, clsname as �ļ�����
  from tCatCategory 
  where clscode like '____' 
  order by clscode