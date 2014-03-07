SELECT
  /*SP.PluCode                                               AS "商品编码",
  SP.PluID                                                      AS "商品ID",*/
  SJRS.RecCount                                                 AS "期初数量",
  OJHC.JC                                                       AS "+采购验收数量",
  OTHC.OTC                                                      AS "-采购退货数量",
  DTHC.TC                                                       AS "+配送退货数量",
  DPHC.PC                                                       AS "-配送数量",
  CLPC.YKC                                                      AS "+盈亏数量",
  (OJHC.JC + OJHC.JC - OTHC.OTC + DTHC.TC - DPHC.PC + CLPC.YKC) AS ERC ,
  SJRSE.RecCount                                                AS EC
FROM
  /*(SELECT PluCode, PluID FROM tSkuPlu
  ) SP,*/
  (
  /****  tStkJxcRptSouceYYMM  门店进销存数据源表  ****/
  /****  DataType = 0  入库  ****/
  /****  DataType = 1  出库  ****/
  /****  DataType = 2  期末  ****/
  /**** 2013-11-27 期末库存 ****/
  /**** YwType:0000,DataType:2,RecCount:270 ****/
  /**** YwType:1904,DataType:1,RecCount: 36 ****/
  /**** WMS:270,CMP:306 - 36 = 270          ****/
  SELECT PluID,
    RecCount
  FROM tStkJxcRptSouce201311
  WHERE YwType = '0000'
  AND OrgCode  = '0001'
  AND RptDate  = '2013-11-27'
  AND PluID    =
    (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003'
    )
  ) SJRS,
  /**** 采购验收 ****/
  /**** WMS:350,CMP:370 ****/
  (
  SELECT SUM(OJB.JhCount) AS JC
  FROM tOrdJhHead OJH,
    tOrdJhBody OJB
  WHERE OJH.JzDate BETWEEN '2013-11-27' AND '2014-03-04'
  AND OJH.YwType  = '0905'
  AND OJH.OrgCode = 'ZB'
  AND OJH.BillNo  = OJB.BillNo
  AND OJB.PluCode = '520000003'
  ) OJHC,
  /**** 采购退货 ****/
  /**** WMS:26,CMP:26 ****/
  (
  SELECT SUM(OTB.ThCount) AS OTC
  FROM tOrdThHead OTH,
    tOrdThBody OTB
  WHERE OTH.JzDate BETWEEN '2013-11-27' AND '2014-03-04'
  AND OTH.YwType  = '0914'
  AND OTH.BillNo  = OTB.BillNo
  AND OTB.PluCode = '520000003'
  ) OTHC,
  /**** 配送退货 ****/
  /**** WMS:115,CMP:115 ****/
  (
  SELECT SUM(DRB.ThCount) AS TC
  FROM tDstRtnHead DRH,
    tDstRtnBody DRB
  WHERE DRH.JzDate BETWEEN '2013-11-27' AND '2014-03-04'
  AND DRH.YwType  = '2004'
  AND DRH.BillNo  = DRB.BillNo
  AND DRB.PluCode = '520000003'
  ) DTHC,
  /**** 配送单 ****/
  /**** WMS:685,CPM:685 ****/
  (
  SELECT SUM(DPB.PsCount) AS PC
  FROM tDstPsHead DPH,
    tDstPsBody DPB
  WHERE DPH.JzDate BETWEEN '2013-11-27' AND '2014-03-04'
  AND YwType      = '2003'
  AND DPH.BillNo  = DPB.BillNo
  AND DPB.PluCOde = '520000003'
  ) DPHC,
  /**** 损益单 ****/
  /**** WMS:0,CMP:[122]    ****/
  (
  SELECT SUM(CLB.YkCount) AS YKC
  FROM tCouLsPdHead CLH,
    tCouLsPdBody CLB
  WHERE CLH.JzDate BETWEEN '2013-11-27' AND '2014-03-04'
  AND CLH.OrgCode = 'ZB'
  AND CLH.BillNo  = CLB.BillNo
  AND CLB.PluCode = '520000003'
  ) CLPC,
  /**** 2014-03-04 期末库存 ****/
  /**** YwType:0000,DataType:2,RecCount:28 ****/
  /**** YwType:2003,DataType:1,RecCount:12 ****/
  (
  SELECT PluID,
    RecCount
  FROM tStkJxcRptSouce201403
  WHERE YwType = '0000'
  AND OrgCode  = '0001'
  AND RptDate  = '2014-03-04'
  AND PluID    =
    (SELECT PluID
    FROM tSkuPlu
    WHERE PluCode = '520000003'
    )
  ) SJRSE
  /*WHERE  SJRS.PluID = SP.PluID
  AND CLPC.PluID = SP.PluID
  AND DPHC.PluID = SP.PluID
  AND DTHC.PluID = SP.PluID*/
  ;