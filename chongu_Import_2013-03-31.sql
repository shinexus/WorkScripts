SELECT * FROM tOrdCgHead
--WHERE JzDate >= '2013-04-15'
WHERE JzDate BETWEEN '2013-04-19' AND '2013-04-17'
AND SupCode = '00501'       --'00501' �ǽ��۳ɵĺ�ͬ����
AND HtCode = '005012'
AND HOrgcode IS NOT NULL
--AND InOrgCode NOT IN ('ZB') --'ZB'    ���ܲ�����֯����
AND JzDate IS NOT NULL      --'JzDate'�������ڲ���Ϊ��
--AND Remark IS NOT NULL
AND (Remark IS NOT NULL or hOrgCode = '0001') 
ORDER BY BillNo
;
--UPDATE tOrdCgHead SET Remark = '�ܲ�ûд��ע' WHERE billNo = '1001201304190227'

SELECT * FROM tordcghead
WHERE BillNo IN ('1001201304190227')
;
SELECT BillNO,PluCode,PluName,CgCount,cgHCost,HjPrice FROM tOrdCgBody order by billno DESC