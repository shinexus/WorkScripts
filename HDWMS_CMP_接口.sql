/**collate  collateitem************/
/**********************************/
--WMS_HSCMP-- 
--�������൥ 
select * from wm_mis_tincinv;
select * from wm_mis_tincinvdtl; 

--������ĵ� 
select * from wm_mis_tdecinv; 
select * from wm_mis_tdecinvdtl; 

--�����ƿⵥ 
--select * from wm_mis_tmoveinv; 
--select * from Wm_Mis_Tmoveinvdtl; 
SELECT * FROM io_tstkyk WHERE PluCode = '110004101' ORDER BY FSendTime DESC;

--����װ��/����� 
select * from wm_mis_talcntc ORDER BY FSendTime DESC; 
select * from wm_mis_talcntcdtl;
--DELETE FROM wm_mis_talcntc
SELECT * from wm_mis_talcntcdtl ORDER BY FSendTime DESC;

--���Ͷ��� 
select * from wm_mis_tstknord@HDWMS; 
select * from wm_mis_tstknorddtl@HDWMS WHERE FSrcordNum = '1001201403130198'; 

--��Ӧ���˻��� 
SELECT * FROM WM_MIS_TVENDORRTN WHERE FSRCNUM = '1001THYW201312210032'; 
SELECT * FROM WM_MIS_TVENDORRTNDTL ; 

--�ŵ��˻��� 
SELECT * FROM WM_MIS_TSTORERTN 
WHERE FsrcNum LIKE '%1001PSTH201401130017%'
ORDER BY FReturnDate DESC;

SELECT * FROM WM_MIS_TSTORERTN 
WHERE Num = 'WMS11401060004';
/**
DELETE FROM WM_MIS_TSTORERTN WHERE Num = 'WMS11401060004';
**/
/******
UPDATE WM_MIS_TSTORERTN SET FsrcNum = '1001PSTH201401120031'
WHERE Num = 'WMS11401060004';
*******/

SELECT * FROM WM_MIS_TSTORERTNDTL
WHERE Num = (
SELECT Num FROM WM_MIS_TSTORERTN 
WHERE FsrcNum = '1001THYW201401020046'
);

---HSCMP_WMS------ 
--���������
select * from mis_wm_talcntc WHERE Num = 'P1001PSYW201401240022';
select * from mis_wm_talcntcdtl;

--���ն��� 
select * from mis_wm_tstkinord@HDWMS; 
select * from mis_wm_tstkinorddtl@HDWMS; 
SELECT * FROM Mis_Wm_Tordalc; 

--�ŵ��˻��� 
select * from mis_wm_tstorertnntc;
select * from mis_wm_tstorertnntcdtl;

--��Ӧ���˻��� 
select * from mis_wm_tvendorrtnntc;
select * from mis_wm_tvendorrtnntcdtl;
SELECT * FROM MIS_WM_TSTORERTNNTCDTL WHERE NUM='1001THYW201401030033';

--���ջ�Ʒ 
SELECT * FROM MIS_WM_TARTICLE;
SELECT * FROM MIS_WM_TARTICLECODE;
SELECT * FROM MIS_WM_TARTICLEQPC;
SELECT * FROM MIS_WM_TARTICLEVENDOR;

--������� 
SELECT * FROM MIS_WM_TSORT;
--�����ŵ� 
SELECT * FROM MIS_WM_TSTORE;
SELECT * FROM MIS_WM_TCLIENT;
--���չ�Ӧ�� 
SELECT * FROM MIS_WM_TVENDOR; 
/**********************************/