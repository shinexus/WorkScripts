SELECT * FROM tOrdYhHead;
SELECT * FROM tOrdYhBody; 

/**** 门店商品要货数量_记账时间排序 ****/
SELECT OYH.BillNo, OYH.OrgCode, OYH.JzDate, OYB.PluCode, OYB.QrCount, OYB.PsJobNo FROM tOrdYhHead OYH, tOrdYhBody OYB
WHERE OYH.JzDate BETWEEN '2014-03-07' AND '2014-03-08' AND OYB.PluCode = '110402076' AND OYH.BillNo = OYB.BillNo
ORDER BY OYH.JzDate;

/**** 门店商品要货数量_配送数量 ****/
SELECT OYH.BillNo, OYB.PsJobNo, DPH.BillNo AS DPH_BillNo, OYH.OrgCode, OYH.JzDate, OYH.SdDate, OYB.PluCode, OYB.QrCount, DPB.SglCount, DPB.PsCount, DPH.JzDate AS DPH_JzDate
FROM tOrdYhHead OYH, tOrdYhBody OYB, tDstPsHead DPH, tDstPsBody DPB
WHERE OYH.OrgCode LIKE '%%' AND OYH.JzDate BETWEEN '2014-03-07' AND '2014-03-08' 
AND OYB.PluCode = '110402076' 
AND OYH.BillNo = OYB.BillNo AND DPH.RefBillNo = OYB.PsJobNo AND DPH.ShOrgCode = OYH.OrgCode AND DPB.BillNo = DPH.BillNo AND DPB.PluCode = OYB.PluCode
ORDER BY OYH.JzDate;

/****  ****/
SELECT * FROM tOrdYhHead WHERE BillNo IN (
SELECT BillNo FROM tOrdYhBody
WHERE PsJobNo = '1001PSRW201402200003')
AND OrgCode = '3001'
ORDER BY BillNo;

SELECT * FROM tOrdYhHead WHERE BillNo IN (
SELECT BillNo FROM tOrdYhBody
WHERE PluCode = '520301025' AND PsJobNo = '1001PSRW201402200003')
ORDER BY BillNo;

SELECT * FROM tOrdYhBody
WHERE BillNo = '1001JHYH201402170216'
ORDER BY PluCode;

SELECT SUM(YhCount) FROM tOrdYhBody
WHERE PsJobNo = '1001JHYH201402170216';

