SELECT SysDate FROM DUAL;
--2014-03-26 17:09:35
SELECT sysdate -1 FROM dual;
--2014-03-25 17:10:32
SELECT LAST_DAY(SYSDATE) FROM dual;
--2014-03-31 17:12:01
SELECT TO_CHAR(SysDate,'YYYYMM') FROM dual;
--201403

--