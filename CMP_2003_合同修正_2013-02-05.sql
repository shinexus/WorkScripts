/*
select * from tOrdYhHead where orgcode = '2003' and usercode = '0031'
select * from tOrdYhBody where BillNo = '1001JHYH201302070050'
select * from tCntContract where HTCODE = '0050111'
*/
select * from tOrdCgHead where BillNo = '1001201302080252';

/*�߲�
UPDATE tOrdCgHead 
SET 
CNTID = '10010000005318', 
HTCODE = '0050110', 
HTNAME = '����н��۳���ó���޹�˾(�߲�2)' where BillNo = '1001201302080252'
*/
/*ˮ��
UPDATE tOrdCgHead 
SET 
CNTID = '10010000005320', 
HTCODE = '0050111', 
HTNAME = '����н��۳���ó���޹�˾(ˮ��2)' where BillNo = '1001201302080197'
*/