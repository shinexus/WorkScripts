SELECT * FROM tsalsale
ORDER BY xsDate
--
select count(*) AS "交易量", to_char(xsDate, 'YYYY-MM-DD HH24') AS "交易时段"
from tsalsale
where 
--xsDate >= to_date(SYSDATE(), 'YYYY-MM-DD hh24:mi:ss')
xsDate < to_date(SYSDATE, 'YYYY-MM-DD hh24:mi:ss')
group by to_char(xsDate, 'YYYY-MM-DD HH24')
ORDER BY "交易时段"