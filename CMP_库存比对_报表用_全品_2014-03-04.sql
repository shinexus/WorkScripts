SELECT SP.PluCode                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS "��Ʒ����",
  SP.PluID                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                AS "��ƷID",
  DECODE(SJRS.RecCount,NULL,0,SJRS.RecCount)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              AS "�ڳ�����",
  DECODE(OJHC.JC,NULL,0,OJHC.JC)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS "+�ɹ���������",
  DECODE(OTHC.OTC,NULL,0,OTHC.OTC)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        AS "-�ɹ��˻�����",
  DECODE(DTHC.TC,NULL,0,DTHC.TC)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS "+�����˻�����",
  DECODE(DPHC.PC,NULL,0,DPHC.PC)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          AS "-��������",
  DECODE(CLPC.YKC,NULL,0,CLPC.YKC)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        AS "+ӯ������",
  DECODE( (DECODE(SJRS.RecCount,NULL,0,SJRS.RecCount) + DECODE(OJHC.JC,NULL,0,OJHC.JC) - DECODE(OTHC.OTC,NULL,0,OTHC.OTC) + DECODE(DTHC.TC,NULL,0,DTHC.TC) - DECODE(DPHC.PC,NULL,0,DPHC.PC) + DECODE(CLPC.YKC,NULL,0,CLPC.YKC)), NULL,0, (DECODE(SJRS.RecCount,NULL,0,SJRS.RecCount) + DECODE(OJHC.JC,NULL,0,OJHC.JC) - DECODE(OTHC.OTC,NULL,0,OTHC.OTC) + DECODE(DTHC.TC,NULL,0,DTHC.TC) - DECODE(DPHC.PC,NULL,0,DPHC.PC) + DECODE(CLPC.YKC,NULL,0,CLPC.YKC)) )                                                                                                          AS ERC ,
  DECODE(SJRSE.RecCount, NULL, 0, SJRSE.RecCount)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         AS "��ĩ����",
  DECODE( ((DECODE(SJRS.RecCount,NULL,0,SJRS.RecCount) + DECODE(OJHC.JC,NULL,0,OJHC.JC) - DECODE(OTHC.OTC,NULL,0,OTHC.OTC) + DECODE(DTHC.TC,NULL,0,DTHC.TC) - DECODE(DPHC.PC,NULL,0,DPHC.PC) + DECODE(CLPC.YKC,NULL,0,CLPC.YKC)) - DECODE(SJRSE.RecCount, NULL, 0, SJRSE.RecCount)), NULL, 0, ((DECODE(SJRS.RecCount,NULL,0,SJRS.RecCount) + DECODE(OJHC.JC,NULL,0,OJHC.JC) - DECODE(OTHC.OTC,NULL,0,OTHC.OTC) + DECODE(DTHC.TC,NULL,0,DTHC.TC) - DECODE(DPHC.PC,NULL,0,DPHC.PC) + DECODE(CLPC.YKC,NULL,0,CLPC.YKC)) - DECODE(SJRSE.RecCount, NULL, 0, SJRSE.RecCount)) ) AS "����"
FROM
  (SELECT PluCode, PluID FROM tSkuPlu WHERE PluCode = '460105004'
  ) SP,
  (
  /****  tStkJxcRptSouceYYMM  �ŵ����������Դ��  ****/
  /****  DataType = 0  ���  ****/
  /****  DataType = 1  ����  ****/
  /****  DataType = 2  ��ĩ  ****/
  /**** 2013-11-27 ��ĩ��� ****/
  /**** YwType:0000,DataType:2,RecCount:270 ****/
  /**** YwType:1904,DataType:1,RecCount: 36 ****/
  /**** WMS:270,CMP:306 - 36 = 270          ****/
  SELECT PluID,
    SUM(RecCount) AS RecCount
  FROM tStkJxcRptSouce201311
  WHERE YwType = '0000'
  AND OrgCode  = '0001'
  AND RptDate  = '2013-11-27'
  GROUP BY PluID
  ) SJRS,
  /**** �ɹ����� ****/
  /**** WMS:350,CMP:370 ****/
  (
  SELECT PluID,
    SUM(OJB.JhCount) AS JC
  FROM tOrdJhHead OJH,
    tOrdJhBody OJB
  WHERE OJH.JzDate BETWEEN '2013-11-27' AND SysDate -1
  AND OJH.YwType  = '0905'
  AND OJH.OrgCode = 'ZB'
  AND OJH.BillNo  = OJB.BillNo
  GROUP BY PluID
  ) OJHC,
  /**** �ɹ��˻� ****/
  /**** WMS:26,CMP:26 ****/
  (
  SELECT PluID,
    SUM(OTB.ThCount) AS OTC
  FROM tOrdThHead OTH,
    tOrdThBody OTB
  WHERE OTH.JzDate BETWEEN '2013-11-27' AND '2014-03-07'
  AND OTH.YwType = '0914'
  AND OTH.BillNo = OTB.BillNo
  GROUP BY PluID
  ) OTHC,
  /**** �����˻� ****/
  /**** WMS:115,CMP:115 ****/
  (
  SELECT PluID,
    SUM(DRB.ThCount) AS TC
  FROM tDstRtnHead DRH,
    tDstRtnBody DRB
  WHERE DRH.JzDate BETWEEN '2013-11-27' AND SysDate -1
  AND DRH.YwType = '2004'
  AND DRH.BillNo = DRB.BillNo
  GROUP BY PluID
  ) DTHC,
  /**** ���͵� ****/
  /**** WMS:685,CPM:685 ****/
  (
  SELECT PluID,
    SUM(DPB.PsCount) AS PC
  FROM tDstPsHead DPH,
    tDstPsBody DPB
  WHERE DPH.JzDate BETWEEN '2013-11-27' AND SysDate -1
  AND YwType     = '2003'
  AND DPH.BillNo = DPB.BillNo
  GROUP BY PluID
  ) DPHC,
  /**** ���浥 ****/
  /**** WMS:0,CMP:[122]    ****/
  (
  SELECT PluID,
    SUM(CLB.YkCount) AS YKC
  FROM tCouLsPdHead CLH,
    tCouLsPdBody CLB
  WHERE CLH.JzDate BETWEEN '2013-11-27' AND SysDate -1
  AND CLH.OrgCode = 'ZB'
  AND CLH.BillNo  = CLB.BillNo
  GROUP BY PluID
  ) CLPC,
  /**** 2014-03-04 ��ĩ��� ****/
  /**** YwType:0000,DataType:2,RecCount:28 ****/
  /**** YwType:2003,DataType:1,RecCount:12 ****/
  (
  SELECT PluID,
    SUM(RecCount) AS RecCount
  FROM tStkJxcRptSouce201403
  WHERE YwType = '0000'
  AND OrgCode  = '0001'
  AND RptDate  = TO_CHAR(SysDate -1, 'YYYY-MM-DD')
    --AND RptDate  = '2014-03-26'
  GROUP BY PluID
  ) SJRSE
WHERE SJRS.PluID (+) = SP.PluID
AND CLPC.PluID (+)   = SP.PluID
AND DPHC.PluID (+)   = SP.PluID
AND DTHC.PluID (+)   = SP.PluID
AND OTHC.PluID (+)   = SP.PluID
AND OJHC.PluID (+)   = SP.PluID
AND SJRSE.PluID (+)  = SP.PluID
  --AND ( (DECODE(SJRS.RecCount,NULL,0,SJRS.RecCount) + DECODE(OJHC.JC,NULL,0,OJHC.JC) - DECODE(OTHC.OTC,NULL,0,OTHC.OTC) + DECODE(DTHC.TC,NULL,0,DTHC.TC) - DECODE(DPHC.PC,NULL,0,DPHC.PC) + DECODE(CLPC.YKC,NULL,0,CLPC.YKC)) - SJRSE.RecCount) IS NOT NULL
  --AND ( (DECODE(SJRS.RecCount,NULL,0,SJRS.RecCount) + DECODE(OJHC.JC,NULL,0,OJHC.JC) - DECODE(OTHC.OTC,NULL,0,OTHC.OTC) + DECODE(DTHC.TC,NULL,0,DTHC.TC) - DECODE(DPHC.PC,NULL,0,DPHC.PC) + DECODE(CLPC.YKC,NULL,0,CLPC.YKC)) - SJRSE.RecCount) != 0;