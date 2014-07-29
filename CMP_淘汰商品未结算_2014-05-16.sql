/**** ҵ������ ****/
SELECT * FROM tSysYwType ORDER BY YwType;

/**** ��Ʒ����� ****/
/**** YwStatus:ҵ��״̬��0:������1:������2:Ԥ��̭��3:��̭ ****/
/**** IsOnline:����״̬��0:���ߣ�1:���� ****/
SELECT * FROM tSkuPlu WHERE YwStatus = '3';

/**** ��ͬ�� ****/
/**** HtStatus:��ͬ״̬��0:δִ�У�1:ִ�У�3:��ֹ��4:������ǩ ****/
SELECT * FROM tCntContract;

/**** ��ͬ��Ʒ�� ****/
SELECT * FROM tCntPlu;

/**********************************************************************/
SELECT sp.PluCode, sp.PluName, sp.YwStatus, cc.HtCode, cc.HtName, cc.HtStatus
FROM tSkuPlu sp, tCntPlu cp, tCntContract cc
WHERE sp.YwStatus = '3' AND cp.PluCode = sp.Plucode AND cc.CntID = cp.CntID AND cc.HtStatus = '3'
ORDER BY PluCode;

/**********************************************************************/
/**** �������ں�ͬ��Ʒ�����Ʒ *******************************************/
SELECT * FROM tSkuPlu WHERE PluID NOT IN (SELECT PluID FROM tCntPlu);
SELECT * FROM tSkuPlu WHERE PluCode NOT IN (SELECT PluCode FROM tCntPlu) ORDER BY PluCode;
SELECT COUNT(PluCode) FROM tSkuPlu;
SELECT COUNT(PluCOde) FROM tSkuPlu WHERE PluCode NOT IN (SELECT PluCode FROM tCntPlu);

/**** ��̭״̬�ĺ�ͬ��Ʒ *******************************************************************/
SELECT * FROM tSkuPlu WHERE PluCode IN (SELECT PluCode FROM tCntPlu) AND YwStatus = '3' ORDER BY PluCode;

/**** Ӧ�����ݱ���ͼ�� *********************/
/**** YwType:ҵ�����ͣ�    2301:��ͨ�ɹ���Ʊ***/
/**** IsFinished:�����־��0:��1:�� ********/
SELECT * FROM TAcpAccReceipt WHERE IsFinished = '0';