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
  '�߲ˣ�4600��',
  --pdb.sjcount AS "ʵ������",
  SUM(pdb.hjprice) AS "��˰����",
  SUM(pdb.sjcount) AS "ʵ������",
  SUM(pdb.SjSCost) AS "ʵ���ۼ۽��"
  --pdb.SjSCost AS "ʵ���ۼ۽��"
  --pdh.jzrname AS "������",
  --PdH.JzDate AS "��������"
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
  'ˮ����4601��',
  --pdb.sjcount AS "ʵ������",
  SUM(pdb.hjprice) AS "��˰����",
  SUM(pdb.sjcount) AS "ʵ������",
  SUM(pdb.SjSCost) AS "ʵ���ۼ۽��"
  --pdb.SjSCost AS "ʵ���ۼ۽��"
  --pdh.jzrname AS "������",
  --PdH.JzDate AS "��������"
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