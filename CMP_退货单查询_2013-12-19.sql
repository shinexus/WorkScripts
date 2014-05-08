/**  ҵ�����ͱ� **************************
SELECT * FROM tSysYwType ORDER BY YwType
****************************************/
/**  �˻�������  ****************************************************************
***  YwType = 0911  �ŵ�ɹ��˻�         *****************************************
***  YwType = 0912  �ŵ��˻����ܲ�       *****************************************
***  YwType = 0913  �ŵ�ֱ���˻�����Ӧ��  *****************************************
***  YwType = 0914  �ܲ��ɹ��˻�         *****************************************
*******************************************************************************/
SELECT * FROM tOrdThHead WHERE BillNo = '1001THYW201403290027';
SELECT TjDate, JzDate, DataStatus, IsNeedTjWl, IsZdJPrice FROM tOrdThHead WHERE BillNo = '1001THYW201401270006';

SELECT * FROM tOrdThHead WHERE LrDate >= '2013-11-27'AND YwType = '0914' AND BillNo IN(
SELECT BillNo FROM tOrdThBody WHERE PluCOde = '310001032');

SELECT * FROM tOrdThBody WHERE PluCode = '310001079' AND BillNo IN (SELECT BillNo FROM tOrdThHead WHERE OrgCode != 'ZB' AND LrDate >= '2013-11-27');

/** �����˻����ֿ�
UPDATE tOrdThHead SET CkCode = '02', CkName = '����Ʒ��' WHERE BillNo = '1001THYW201312070045';

/** ���µ���״̬�������ٴμ��� *****************************************
UPDATE tOrdThHead SET TjDate = NULL, JzDate = NULL, DataStatus = '0'
WHERE BillNo = '1001THYW201403290027';

*********************************************************************/

/** �ŵ��˻����м�� **/
SELECT * FROM WM_MIS_TSTORERTN ORDER BY FSrcNum;
/****/

/** 2014-01-11_δ�γ������˻������ŵ��˵� **/
SELECT * FROM tOrdThHead 
WHERE BillNo NOT IN (SELECT RefBillNo FROM tDstRtnHead)
AND YwType = '0912' AND LrDate BETWEEN '2013-11-27' AND SysDate AND DataStatus = '9'
ORDER BY LrDate DESC;
/**************************************/

/** 2014-01-13_δ�����ŵ��˻��� **/
SELECT * FROM tOrdThHead
WHERE YwType = '0912' AND JzDate IS NULL AND LrDate BETWEEN '2013-11-27' AND SysDate
ORDER BY LrDate DESC;
/******************************/

/** 2014-01-13_δ���������˻��� **/
SELECT * FROM tDstRtnHead
WHERE YwType = '0912' AND JzDate IS NULL AND LrDate BETWEEN '2013-11-27' AND SysDate
ORDER BY LrDate DESC;

SELECT * FROM tDstRtnHead WHERE RefBillNo = '1001PSTH201312140018';

/** ���µ���״̬�������ٴμ���
UPDATE tDstRtnHead SET TjDate = NULL, JzDate = NULL, DataStatus = '0'
WHERE BillNo = '1001PSTH201312250021';

/** ���ù����ύ����
sStk_Commit_PsTh_ORA;

���ù��̼��˵���
sStk_Account_PsTh_Ora;

���� tStkPcGuidYw ҵ����������������
select * from tStkPcGuidYw where BillNo='1001PSTH201401050005';
select * from tStkPcGuidYw where BillType='2004';
select * from tStkPcGuidYw where plucode = '520102018' ORDER BY BillNo DESC;
**/

/******************************/

/** 2014-01-16_�������ʹ���������˻��� **/
SELECT DISTINCT Logtype, UserID, YwType, YwName, DataKey, LogMeg FROM IO_HscmpLog
WHERE YwType = '2004' AND LogMeg LIKE '%THYW%'
ORDER BY DataKey DESC;
/*************************************/

/** 2014-01-17_���������ʹ���������˻��� **/
--�ŵ��˻����ӿڱ� 
SELECT * FROM WM_MIS_TSTORERTN 
WHERE FsrcNum LIKE '%1001THYW201401020084%'
ORDER BY FReturnDate DESC;

SELECT * FROM WM_MIS_TSTORERTN 
WHERE Num = 'WMS11401020017';
/**
DELETE FROM WM_MIS_TSTORERTN WHERE Num = 'WMS11401060004';
**/
/******
UPDATE WM_MIS_TSTORERTN SET FsrcNum = '1001PSTH201401120031'
WHERE Num = 'WMS11401020017';
*******/

SELECT * FROM IO_HSCMPLOG WHERE DataKey = '1001THYW201401270006';

SELECT * FROM tOrdThHead WHERE BillNo = '1001THYW201401270006';

/****
UPDATE tOrdThHead SET 
DataStatus = '9', 
JzDate = '2014-01-28' || '14:55:56', 
TjrCode = '*', TjrName = '*',
JzrCode = '*', JzrName = '*' 
WHERE BillNo = '1001THYW201401270006';
****/

/**** 2014-02-17 δ�ύ��δ���˲ɹ��˻��� ****/
SELECT * FROM tOrdThHead
WHERE YwType = '0914' AND JzDate IS NULL AND LrDate BETWEEN '2013-11-27' AND SysDate
ORDER BY LrDate DESC;
/*****************************************/

/**** �ɹ��˻��ӿڱ�����ȱʧ ************************************************************************/
select * from mis_wm_tvendorrtnntc;
select * from mis_wm_tvendorrtnntcdtl;
select * from mis_wm_tvendorrtnntc@HDWMS;
select * from mis_wm_tvendorrtnntcdtl@HDWMS;

/**** �ɹ��˻������¼���ӿ�����  ********************************************************************/

insert into MIS_WM_TVENDORRTNNTC(NUM,FVENDOR,FVDRCODE,FRTNDATE,FCLS,FSRC,FWRH,FFILLER,
           FCREATETIME,FSENDTIME,FSRCORG,FDESTORG,FMEMO)
    select H.BillNo,456,H.Supcode,H.Lrdate,'�˹�Ӧ��','HSCMP','02',H.Usercode,sysdate,sysdate,
           'HSCMP','WMS1',null
      from tOrdThHead H
     where H.BillNo='1001THYW201405070021' ;     
     
 insert into MIS_WM_TVENDORRTNNTCDTL(NUM,LINE,FARTICLE,FARTICLECODE,FQTY,FPRICE,
            FSENDTIME,FSRCORG,FDESTORG)
     select H.BillNo,B.Serialno,123,B.PluCode,B.Thcount,B.Hjprice,sysdate,'HSCMP','WMS1'
       from tOrdThHead H,tOrdThBody B
     where H.BillNo=B.BillNo and H.BillNo='1001THYW201405070021';      
       
 update WM_MIS_TSENDLIST set FSENDTIME=sysdate where FCLS='��Ӧ���˻�֪ͨ��';
