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
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201407140024';

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

SELECT * FROM tOrdCgHead ORDER BY LrDate DESC;

/**** ���²ɹ��������еĺ�ͬ����ͺ�ͬ���� ****/
/**** ��Ʒ��ͬ�轫����˰���۽�CgHCost����δ˰���۽�CgWCost����˰�CgJTaxTotal�����ۼ۽�STotal����������ۣ�CjTotal�� ****/
/**** Σ�ղ����� ****/
/**** ע��������䣡 ****/
/**** 9990823308 ��򱱴������(��Ʒ�� ****/
/**** 9990923309 ��򱱴������(����Ʒ�� ****/
SELECT * FROM tOrdCgHead WHERE BillNo = '1001201407210172';
--UPDATE tOrdCgHead SET HtCode = '9990823308', HtName = '��򱱴������(��Ʒ��', CgHCost = '0', CgWCost = '0', CgJTaxTotal = '0', STotal = '0', CjTotal = '0' WHERE BillNo = '1001201407210172';

/**** ����HtCode֮�󣬸�����ϸ��˰���ۣ�HjPrice������˰���۽�CgHCost����δ˰���ۣ�WjPrice����δ˰���۽�CgWCost�����ۼۣ�Price�����ۼ۽�STotal����˰�ʣ�JTaxRate����˰�CgJTaxTotal�� ****/
/**** Σ�ղ����� ****/
/**** ע��������䣡 ****/
SELECT * FROM tOrdCgBody WHERE BillNo = '1001201407210172';
--UPDATE tOrdCgBody SET HjPrice = '0', CgHCost = '0', WjPrice = '0', CgWCost = '0', Price = '0', STotal = '0', JTaxRate = '0', CgJTaxTotal = '0' WHERE BillNo = '1001201407210172';

/**** ����Խ��ɹ���������Ч���� ****/
--UPDATE tOrdCgHead SET YxDate = '2014-03-25' WHERE BillNo = '1001201403120256';


SELECT * FROM tOrdCgHead WHERE BillNo IN ('1001201403170121', '1001201403260151');
