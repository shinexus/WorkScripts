/**  tStkLsKc Á¬Ëø¿â´æ±í  *********************************/
SELECT * FROM tStkLsKc;
SELECT *
--COUNT(KcCount) --126
FROM tStkLsKc WHERE OrgCode = '0001' AND CkCode = '01' AND KcCount > '0' ORDER BY KcCount DESC;

SELECT * FROM tStkLsKc WHERE PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520001012') AND OrgCode = '0001' AND CkCode = '02' AND KcCount > '0' ORDER BY KcCount DESC;
SELECT * FROM tStkLsKc WHERE PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520300081') AND OrgCode = '0001' AND CkCode = '02' AND KcCount > '0' ORDER BY KcCount DESC;
SELECT * FROM tStkLsKc WHERE PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '540006007') AND OrgCode = '0001' AND CkCode = '02' AND KcCount > '0' ORDER BY KcCount DESC;

SELECT * FROM tStkLsKc WHERE PcNo = '1001LSPD201402140029500001' AND OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003') ORDER BY KcCount DESC;
SELECT * FROM tStkLsKc WHERE PcNo = '1001LSPD201402130044500001' AND OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520001012') ORDER BY KcCount DESC;
SELECT * FROM tStkLsKc WHERE OrgCode = '0001' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003') ORDER BY KcCount DESC;

/********************************************************
SELECT *
FROM
  (SELECT Pluid ,
    Plucode ,
    Pluname ,
    Barcode ,
    Unit ,
    Spec ,
    Orgcode ,
    OrgCode$ ,
    JjMode ,
    KcCount ,
    LockCount ,
    KyCount ,
    HCostSum ,
    WCostSum ,
    SumPrice ,
    MinCount ,
    MaxCount ,
    Price ,
    CargoNo ,
    NewHJPrice,
    CASE
      WHEN KcCount <= 0
      THEN 0
      WHEN HCostSum < 0
      THEN 0
      ELSE ROUND(NVL(HCostSum/KcCount,0),4)
    END AS NowKPPrice
  FROM
    (SELECT A.PluId ,
      B.PluCode ,
      B.PluName ,
      B.BarCode ,
      B.Unit ,
      B.Spec ,
      A.OrgCode ,
      C.OrgName AS OrgCode$,
      A.JjMode ,
      NVL(
      (SELECT SUM(KcCount)
      FROM tStkLsKc
      WHERE OrgCode=A.OrgCode
      AND PluId    =A.PluId
      ) ,0)-NVL(
      (SELECT SUM(XsCount)
      FROM tSalWtzPluDetail Wt
      WHERE Wt.OrgCode =A.OrgCode
      AND Wt.PluID     =A.PluID
      AND Wt.DataType IN ('0','A','B','C','7')
      ) , 0) AS KcCount,
      NVL(
      (SELECT SUM(LockCount)
      FROM tStkLsKcLock
      WHERE OrgCode =A.OrgCode
      AND PluId     =A.PluId
      ) ,0) AS LockCount,
      NVL(
      (SELECT SUM(KcCount)
      FROM tStkLsKc
      WHERE OrgCode=A.OrgCode
      AND PluId    =A.PluId
      ) ,0)-NVL(
      (SELECT SUM(XsCount)
      FROM tSalWtzPluDetail Wt
      WHERE Wt.OrgCode =A.OrgCode
      AND Wt.PluID     =A.PluID
      AND Wt.DataType IN ('0','A','B','C','7')
      ) , 0)           -NVL(
      (SELECT SUM(LockCount)
      FROM tStkLsKcLock
      WHERE OrgCode =A.OrgCode
      AND PluId     =A.PluId
      ) ,0) AS KyCount,
      NVL(
      (SELECT SUM(HCost)
      FROM Tstklskc
      WHERE OrgCode =A.Orgcode
      AND Pluid     =A.Pluid
      ) ,0) AS HCostSum,
      NVL(
      (SELECT SUM(WCost)
      FROM Tstklskc
      WHERE OrgCode =A.Orgcode
      AND Pluid     =A.Pluid
      ) ,0) AS WCostSum,
      NVL(
      (SELECT SUM(A.Price*Kccount)
      FROM Tstklskc
      WHERE Orgcode =A.Orgcode
      AND pluid     =A.Pluid
      ) ,0) AS SumPrice,
      NVL(
      (SELECT NewHjPrice
      FROM tSkuEtpParas
      WHERE PluId   = A.Pluid
      AND OrgCode   = A.Orgcode
      AND NewJhDate =
        (SELECT MAX(NewJhDate)
        FROM tSkuEtpParas
        WHERE PluId = A.Pluid
        AND OrgCode = A.Orgcode
        )
      AND rownum = 1
      ) ,0) AS NewHJPrice,
      A.MinCount ,
      A.MaxCount ,
      A.Price ,
      B.CargoNo
    FROM tSkuPluEx A ,
      tSkuPlu B ,
      tOrgManage C
    WHERE A.PluId    =B.PluId
    AND A.OrgCode    =C.OrgCode
    AND C.OrgClass   ='1'
    AND C.IsManaStock='1'
    AND EXISTS
      (SELECT PluId
      FROM tStkLsKc
      WHERE PluId =A.PluId
      AND OrgCode =A.OrgCode
      )
    AND A.orgCode='0001'
    ) vStkLsPlu
  WHERE ( ( ( vStkLsPlu.OrgCode IN
    (SELECT OrgCode
    FROM
      (SELECT OrgCode
      FROM tOrgManage
        START WITH OrgCode       = 'ZB'
        CONNECT BY Prior OrgCode = PreOrgCode
      )
    )
  OR vStkLsPlu.OrgCode = '*' ) ) )
  )
*********************************************************/