/*
select * from tOrdYhHead where orgcode = '2003' and usercode = '0031'
select * from tOrdYhBody where BillNo = '1001JHYH201302070050'
select * from tCntContract where HTCODE = '0050111'
*/
select * from tOrdCgHead where BillNo = '1001201302080252';

/*蔬菜
UPDATE tOrdCgHead 
SET 
CNTID = '10010000005318', 
HTCODE = '0050110', 
HTNAME = '天津市锦聚成商贸有限公司(蔬菜2)' where BillNo = '1001201302080252'
*/
/*水果
UPDATE tOrdCgHead 
SET 
CNTID = '10010000005320', 
HTCODE = '0050111', 
HTNAME = '天津市锦聚成商贸有限公司(水果2)' where BillNo = '1001201302080197'
*/