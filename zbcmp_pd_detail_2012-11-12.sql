/*
SELECT * FROM tCouLsPdHead
SELECT * FROM tCouLsPdBody ORDER By BillNo
SELECT * FROM tOrgDept ORDER BY OrgCode
SELECT * FROM tOrgManage
SELECT * FROM tcatcategory WHERE ClsCode LIKE '46%'
SELECT * FROM tSkuPlu
*/
SELECT
  --PdB.BillNo,
  --ctg.clsname,
  --pdb.plucode,
  --PdB.PluName,
  --ToD.orgcode,
  Tom.orgName,
  '蔬菜（4600）',
  --pdb.sjcount AS "实盘数量",
  SUM(pdb.hjprice) AS "含税进价",
  SUM(pdb.sjcount) AS "实盘数量",
  SUM(pdb.SjSCost) AS "实盘售价金额"
  --pdb.SjSCost AS "实盘售价金额"
  --pdh.jzrname AS "记账人",
  --PdH.JzDate AS "记账日期"
FROM
  tCouLsPdHead PdH,
  tCouLsPdBody PdB,
  tOrgDept ToD,
  tOrgManage ToM,
  tcatcategory CtG,
  tSkuPlu TsP
WHERE
  PdH.JzDate BETWEEN '2012-10-15' AND '2012-11-10'
AND SubStr(CtG.Clscode,1,4) LIKE '4600%'
AND PdB.billNo  = pdh.billno
AND PdB.depid   = tod.depid
AND tod.orgcode = tom.orgcode
AND pdb.pluid   = tsp.pluid
AND tsp.clsid   = ctg.clsid
GROUP BY
  Tom.orgName
--ORDER BY
--  PdB.BillNo
UNION
SELECT
  --PdB.BillNo,
  --ctg.clsname,
  --pdb.plucode,
  --PdB.PluName,
  --ToD.orgcode,
  Tom.orgName,
  '水果（4601）',
  --pdb.sjcount AS "实盘数量",
  SUM(pdb.hjprice) AS "含税进价",
  SUM(pdb.sjcount) AS "实盘数量",
  SUM(pdb.SjSCost) AS "实盘售价金额"
  --pdb.SjSCost AS "实盘售价金额"
  --pdh.jzrname AS "记账人",
  --PdH.JzDate AS "记账日期"
FROM
  tCouLsPdHead PdH,
  tCouLsPdBody PdB,
  tOrgDept ToD,
  tOrgManage ToM,
  tcatcategory CtG,
  tSkuPlu TsP
WHERE
  PdH.JzDate BETWEEN '2012-10-15' AND '2012-11-10'
AND SubStr(CtG.Clscode,1,4) LIKE '4601%'
AND PdB.billNo  = pdh.billno
AND PdB.depid   = tod.depid
AND tod.orgcode = tom.orgcode
AND pdb.pluid   = tsp.pluid
AND tsp.clsid   = ctg.clsid
GROUP BY
  Tom.orgName