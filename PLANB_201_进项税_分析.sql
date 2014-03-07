--SELECT * FROM tOrdJhHead
--SELECT * FROM tOrdJhBody
--语句中并没有查询JTAXRAT
SELECT
  BillNo,
  YwType,
  RptDate AS DjDate ,
  hCost,
  wCost,
  SupCode,
  SupName
FROM
  tOrdJhhead a
INNER JOIN tOrgManage b
ON
  a.OrgCode=b.OrgCode
WHERE
  RptDate  >='2012-02-01'
AND RptDate<='2012-02-02'
AND ForgCode='CW01'
AND YwType IN ('0904','0905','0906')
AND NOT
  (
    YwType              ='0906'
  AND NVL(RefBillType,0)='0907'
  )
AND a.orgcode NOT IN ('7001','2002')
AND a.htcode NOT  IN ('002941','002942','005011')
ORDER BY
  billno