--SELECT * FROM biee_dim_table_calendar
--DELETE FROM biee_dim_table_calendar
INSERT
INTO
  biee_dim_table_calendar
  (
    calendar_date,
    day_key,
    per_name_month,
    per_name_qtr,
    per_name_year
  )
SELECT DISTINCT
  rptdate,
  TO_CHAR(To_DATE(rPtDate,'yyyy-mm-dd'),'yyyymmdd'),
  SUBSTR(rptdate,1,7),
  TO_CHAR(To_DATE(rPtDate,'yyyy-mm-dd'),'yyyy-Q'),
  SUBSTR(rptdate,1,4)
FROM
  tsalpludetailyyyymm
ORDER BY
  rptdate
  /*
  INSERT INTO biee_dim_table_calender(calendar_date)
  SELECT DISTINCT rptDate FROM tSalPluDetailYYYYMM ORDER BY Rptdate
  */
  /*
  UPDATE biee_dim_table_calendar a SET a.per_name_month =
  (select SUBSTR(b.rptdate,1,7) FROM tsalpludetailyyyymm b
  WHERE b.rptdate=a.calendar_date)
  */
  