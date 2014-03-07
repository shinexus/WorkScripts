select 
  (select clscode from tCatCategory 
    where clscode like '__' )
    as 二级编码
  from tCatCategory 
  where clscode like '_' 
  order by clscode

select clscode as 四级编码, clsname as 四级名称
  from tCatCategory 
  where clscode like '____' 
  order by clscode