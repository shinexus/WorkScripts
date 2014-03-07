--SELECT * FROM biee_dim_TABLE_clscategory
--SELECT * FROM tCatcategory ORDER BY ClsCode
SELECT
  clscode,
  clsname,
  SUBSTR(ClsCode,1,4) AS ClsCode_S,
  (select clsname as clscode_S_name from tcatcategory where clscode=clscode_s)
FROM
  tCatCategory
WHERE
  LENGTH(clscode)=6
ORDER BY
  ClsCode