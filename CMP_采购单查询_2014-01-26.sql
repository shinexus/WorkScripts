/** Խ�����յ���1001JHYW201401160395
 ** Խ��ɹ�����1001201401160268
 ** ��Ʒ���룺  500101004  ��ID��10010000036333       ��
 ** ��˰���ۣ�  26.3200    ��tOrdJhBody���е�HjPrice   ��
 ** ��ͬ���ۣ�  27.7008    ��tCntCxBody���е�NewHjPrice��
 ** ����˰�ʣ�  17
 ** ��ͬ���룺  9990523305 ��ID��10010000006320       ��
 ** sCnt_GetPluJPrice     ����ֵ��27.7008
 ** sCnt_GetCntPluJPrice  ����ֵ��27.7008
 ***************************************
 ** Խ�����յ���1001JHYW201401160292
 ** Խ��ɹ�����1001201401140352
 
/** �û�������־
SELECT * FROM tSysLog WHERE LogContent LIKE '%1001JHYW201401160395%';
SELECT * FROM tSysLog WHERE LogContent LIKE '%1001JHYW201401160292%';
 
/** 10010000036333
SELECT PluID FROM tSkuPlu WHERE PluCode = '500101004'; 

/** �����еı��޼�¼
SELECT * FROM tOrdCgBody_JhPrice WHERE PluCode = '500101004';
SELECT * FROM tOrdCgBody_JhPrice WHERE BillNo = '1001201401160268';

/** �ɹ�������
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201401160268';

/** �ɹ�����ϸ��
SELECT * FROM tOrdCgBody WHERE PluCode = '500101004';

/** ���յ���ϸ��
 ** HjPrice����˰����
SELECT * FROM tOrdJhBody WHERE PluCode = '500101004';

/** ��ͬ��
SELECT * FROM tCntContract WHERE HtCode = '9990523305';
select cntid from tordcghead where billno = '1001201401160268'
/** ��ͬ���۵���ϸ��
SELECT * FROM tCntCxBody WHERE PluCode = '500101004';
**/


/**** �ɹ�������  ****/
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201403070221';

/**** ����Խ��ɹ���������Ч���� ****/
UPDATE tOrdCgHead SET YxDate = '2014-03-17' WHERE BillNo = '1001201403100222';
