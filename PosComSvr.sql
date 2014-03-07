-- 解决PosComSvr通讯报错_[不影响正常使用]

Delete from tPosDtsFileLstDefault
 where TableName in ('tProBillHead',
                     'tProPluAreaHead',
                     'tProPluAreaBody',
                     'tProCertiRateDetail',
                     'tProCertiRateHead',
                     'tProCertiType',
                     'tProGroupShop',
                     'tProTimProject')

 Delete from tJkPosDtsFileLstDefault
 where TableName in ('tProBillHead',
                     'tProPluAreaHead',
                     'tProPluAreaBody',
                     'tProCertiRateDetail',
                     'tProCertiRateHead',
                     'tProCertiType',
                     'tProGroupShop',
                     'tProTimProject')
