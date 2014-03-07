SELECT * FROM tOrdCgHead
--WHERE JzDate >= '2013-04-15'
WHERE JzDate BETWEEN '2013-04-19' AND '2013-04-17'
AND SupCode = '00501'       --'00501' 是锦聚成的合同编码
AND HtCode = '005012'
AND HOrgcode IS NOT NULL
--AND InOrgCode NOT IN ('ZB') --'ZB'    是总部的组织编码
AND JzDate IS NOT NULL      --'JzDate'记账日期不可为空
--AND Remark IS NOT NULL
AND (Remark IS NOT NULL or hOrgCode = '0001') 
ORDER BY BillNo
;
--UPDATE tOrdCgHead SET Remark = '总部没写备注' WHERE billNo = '1001201304190227'

SELECT * FROM tordcghead
WHERE BillNo IN ('1001201304190227')
;
SELECT BillNO,PluCode,PluName,CgCount,cgHCost,HjPrice FROM tOrdCgBody order by billno DESC