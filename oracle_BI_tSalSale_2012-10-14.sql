SELECT * FROM tsalsale
ORDER BY xsDate
--
select count(*) AS "������", to_char(xsDate, 'YYYY-MM-DD HH24') AS "����ʱ��"
from tsalsale
where 
--xsDate >= to_date(SYSDATE(), 'YYYY-MM-DD hh24:mi:ss')
xsDate < to_date(SYSDATE, 'YYYY-MM-DD hh24:mi:ss')
group by to_char(xsDate, 'YYYY-MM-DD HH24')
ORDER BY "����ʱ��"