--YwStatus = 0:待批
--YwStatus = 1:正常
--YwStatus = 2:预淘汰
--YwStatus = 3:淘汰
SELECT * FROM tSkuPlu 
WHERE
YwStatus = '3'
ORDER BY PluCode

--AND PromFormula = '3'
AND PluCode LIKE '30%'
--AND Unit <> '条'
AND Spec <> '1*10'
--AND DotDecimal = '0'

SELECT * FROM　tSkuPluPackageHead
SELECT * FROM　tSkuPluPackageBody
WHERE PluCode LIKE '30%'
AND Unit <> '条'

SELECT * FROM tSkuMulBar
WHERE Pluid IN (SELECT PLUID FROM tSKUPLU WHERE YwStatus = '3')

SELECT * FROM tSkuPlu 
WHERE YwStatus = '1'
AND PluID NOT IN(
SELECT PluID FROM tCntPlu)

SELECT * FROM tSkuPlu
WHERE PluID IN (
SELECT PLUID FROM　tCntPlu
WHERE CntID IN(
SELECT CntID FROM tCntContract
WHERE HtStatus = '3'))
