-- ���PosComSvrͨѶ����_[��Ӱ������ʹ��]

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
