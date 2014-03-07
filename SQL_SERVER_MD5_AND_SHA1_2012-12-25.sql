SELECT hashbytes('MD5','shinexus')
SELECT hashbytes('SHA1','shinexus')

select substring(sys.fn_VarBinToHexStr(hashbytes('MD5','shinexus')),3,32)

SELECT REPLACE (sys.fn_VarBinToHexStr(hashbytes('MD5','shinexus')), '0x','')