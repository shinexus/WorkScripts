/****
SELECT * from tsysywtype ORDER BY YwType;
****/
/****  tDstPsHead���͵�����   ******************************************************
*****  PsType   = '0' ��ͨ����*****************************************************
*****  PsType   = '1' Խ������*****************************************************
*****  YwStatus = '0' δ����  ****************************************************
*****  YwStatus = '1' ������  *****************************************************
*****  YwStatus = '2' ������  *****************************************************
*****  YwStatus = '3' �ѽ᰸  *****************************************************/
SELECT * FROM tDstPsHead WHERE BillNo = '1001PSYW201401270160' ORDER BY LrDate;

SELECT * FROM tDstPsBody WHERE BillNo = '1001PSYW201401270160';
SELECT * FROM tDstPsBody WHERE BillNo = '1001PSYW201403250008' AND PluCode = '120401055';


SELECT * FROM tDstPsHead WHERE ShOrgCode = '1001' AND BillNo IN ( 
SELECT BillNo FROM tDstPsBody WHERE PluCode = '310200031');


/**** ���µ���״̬�������ٴμ���
UPDATE tDstPsHead SET TjDate = NULL, JzDate = NULL, DataStatus = '0' WHERE BillNo = '1001PSYW201401150106';
****/

/**** δ���յ����͵���ͳ���Խ�� **/
--UPDATE tDstPsHead SET YwStatus = '3' WHERE BillNo = '1001PSYW201312170138'

/**** 0�������͵������� YwStatus = '3' �����ŵ����ջ��� 
SELECT * FROM tDstPsHead WHERE LrDate >= '2013-11-27' AND PsCount = '0';
UPDATE tDstPsHead SET YwStatus = '3' WHERE BillNo = '1001PSYW201401240167';
UPDATE tDstPsHead SET YwStatus = '3' WHERE LrDate >= '2013-11-27' AND JzDate IS NOT NULL AND PsCount = '0';
****/

/**** ������Ʒ״̬
/**** PluType = '0'(��Ʒ)
/**** PluType = '1'(��Ʒ)
/**** PluType = '2'������Ʒ��
UPDATE tDstPsBody SET PluType = '0' WHERE BillNo = '1001PSYW201403250008' AND PluCode = '120401055';


/*******************************************************/
SELECT * FROM tDstPsHead;
SELECT * FROM tDstPsBody;

SELECT tDPH.BillNo, tDPH.ShOrgName, tDPH.JzDate, tDPB.PluCode, tDPB.PsCount FROM tDstPsHead tDPH, tDstPsBody tDPB
WHERE tDPH.BillNo = tDPB.BillNo
AND tDPB.PluCode = '520000003'
AND tDPH.LrDate BETWEEN '2014-02-01' AND SysDate
AND JzDate IS NULL
ORDER BY tDPH.BillNo DESC;

