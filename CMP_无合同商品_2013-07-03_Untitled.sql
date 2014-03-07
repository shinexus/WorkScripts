SELECT * FROM tSkuPlu WHERE PluCode NOT IN (

SELECT PluCode FROM tCntPlu
)
AND YwStatus IN ('0','1')