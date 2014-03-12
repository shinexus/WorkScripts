SELECT * FROM tOrdYhHead;
SELECT * FROM tOrdYhBody; 

/**** 门店商品要货数量_记账时间排序 ****/
SELECT OYH.BillNo, OYH.OrgCode, OYH.JzDate, OYB.PluCode, OYB.QrCount, OYB.PsJobNo FROM tOrdYhHead OYH, tOrdYhBody OYB
WHERE OYH.JzDate BETWEEN '2014-03-07' AND '2014-03-08' AND OYB.PluCode = '110402076' AND OYH.BillNo = OYB.BillNo
ORDER BY OYH.JzDate;

/**** 门店商品要货数量_配送数量****/
SELECT OYH.BillNo, OYB.PsJobNo, DPH.BillNo AS DPH_BillNo, OYH.OrgCode, OYH.JzDate, OYB.PluCode, OYB.QrCount, DPB.SglCount, DPB.PsCount
FROM tOrdYhHead OYH, tOrdYhBody OYB, tDstPsHead DPH, tDstPsBody DPB
WHERE OYH.OrgCode LIKE '%%' AND OYH.JzDate BETWEEN '2014-03-07' AND '2014-03-08' 
AND OYB.PluCode = '110402076' 
AND OYH.BillNo = OYB.BillNo AND DPH.RefBillNo = OYB.PsJobNo AND DPH.ShOrgCode = OYH.OrgCode AND DPB.BillNo = DPH.BillNo AND DPB.PluCode = OYB.PluCode
ORDER BY OYH.JzDate;

