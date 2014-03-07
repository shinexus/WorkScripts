/**** 2013-11-27 期末库存 ****/
/**** YwType:0000,DataType:2,RecCount:270 ****/
/**** YwType:1904,DataType:1,RecCount: 36 ****/
/**** WMS:270,CMP:306 - 36 = 270          ****/
SELECT * FROM tStkJxcRptSouce201311 
WHERE YwType = '0000' AND OrgCode = '0001' 
AND RptDate = '2013-11-27' 
AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003');

/**** 采购验收 ****/
/**** WMS:350,CMP:370 ****/
SELECT OJH.BillNo, SUM(OJB.JhCount) FROM tOrdJhHead OJH, tOrdJhBody OJB 
WHERE OJH.JzDate >= '2013-11-27' AND OJH.YwType = '0905' AND OJH.BillNo = OJB.BillNo AND OJB.PluCode = '520000003' 
GROUP BY OJH.BillNo ORDER BY OJH.BillNo;

/**** 采购退货 ****/
/**** WMS:26,CMP:26 ****/
SELECT OTH.BillNo, SUM(OTB.ThCount) FROM tOrdThHead OTH, tOrdThBody OTB 
WHERE OTH.JzDate >= '2013-11-27' AND OTH.YwType = '0914' AND OTH.BillNo = OTB.BillNo AND OTB.PluCode = '520000003'
GROUP BY OTH.BillNo ORDER BY OTH.BillNo;

/**** 配送退货 ****/
/**** WMS:115,CMP:115 ****/
SELECT DRH.BillNo, SUM(DRB.ThCount) FROM tDstRtnHead DRH, tDstRtnBody DRB
WHERE DRH.JzDate >= '2013-11-27' AND DRH.YwType = '2004' AND DRH.BillNo = DRB.BillNo AND DRB.PluCode = '520000003'
GROUP BY DRH.BillNo ORDER BY DRH.BillNo;

/**** 配送单 ****/
/**** WMS:685,CPM:685 ****/
SELECT DPH.BillNO, SUM(DPB.PsCount) FROM tDstPsHead DPH, tDstPsBody DPB
WHERE DPH.JzDate >= '2013-11-27' AND YwType = '2003' AND DPH.BillNo = DPB.BillNo AND DPB.PluCode = '520000003'
GROUP BY DPH.BillNo ORDER BY DPH.BillNo;

/**** 移库单 ****/
SELECT SYH.BillNo, SYB.YkCount, SYH.OldCkCode, SYH.NewCkCode FROM tStkYkHead SYH, tStkYkBody SYB
WHERE SYH.JzDate >= '2013-11-27' AND SYH.BillNo = SYB.BillNo AND SYB.PluCode = '520000003'
ORDER BY SYH.BillNo;

/**** 损益单 ****/
/**** WMS:0,CMP:[308]    ****/
/*
SELECT * FROM tCouLsPdHead WHERE OrgCode = 'ZB' ORDER BY LrDate DESC;
SELECT * FROM tCouLsPdBody WHERE BillNo = '1001LSPD201403040006';
*/
SELECT CLB.BillNo, /*SUM(CLB.SjCount)*/ CLB.YkCount FROM tCouLsPdHead CLH, tCouLsPdBody CLB
WHERE CLH.JzDate >= '2013-11-27' AND CLH.OrgCode = 'ZB' AND CLH.BillNo = CLB.BillNo AND CLB.PluCode = '520000003'
/*GROUP BY CLB.BillNo*/ ORDER BY CLH.BillNo;

/**** 2014-03-03 期末库存 ****/
/**** YwType:0000,DataType:2,RecCount:28 ****/
/**** YwType:2003,DataType:1,RecCount:12 ****/
SELECT * FROM tStkJxcRptSouce201403 
WHERE OrgCode = '0001' 
AND RptDate = '2014-03-03' 
AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003');

/**** WMS:24,CMP:44 ****/
/**** WMS 01 :04 WMS 02 :20 ****/
SELECT (270+370-26+115-685) FROM DUAL;