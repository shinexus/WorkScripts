/**collate  collateitem************/
/**********************************/
--WMS_HSCMP-- 
--发送溢余单 
select * from wm_mis_tincinv;
select * from wm_mis_tincinvdtl; 

--发送损耗单 
select * from wm_mis_tdecinv; 
select * from wm_mis_tdecinvdtl; 

--发送移库单 
select * from wm_mis_tmoveinv@HDWMS;
select * from Wm_Mis_Tmoveinvdtl@HDWMS;
SELECT * FROM IO_TSTKYK;
SELECT * FROM IO_TSTKYK WHERE BillNo = 'WMS11404080100';
SELECT * FROM IO_TSTKYKHIS WHERE BillNo = 'WMS11404080100';

SELECT * FROM IO_TSTKYK@HDWMS WHERE BillNo = 'WMS11404080100';
SELECT * FROM IO_TSTKYKHIS@HDWMS WHERE BillNo = 'WMS11404080100';

--发送装车/配货单 
select * from wm_mis_talcntc ORDER BY FSendTime DESC; 
select * from wm_mis_talcntcdtl;
--DELETE FROM wm_mis_talcntc
SELECT * from wm_mis_talcntcdtl ORDER BY FSendTime DESC;

--发送定单 
select * from wm_mis_tstknord@HDWMS; 
select * from wm_mis_tstknorddtl@HDWMS WHERE FSrcordNum = '1001201403130198'; 

--供应商退货单 
SELECT * FROM WM_MIS_TVENDORRTN WHERE FSRCNUM = '1001THYW201405070021'; 
SELECT * FROM WM_MIS_TVENDORRTN@HDWMS WHERE FSRCNUM = '1001THYW201405070021'; 
SELECT * FROM WM_MIS_TVENDORRTNDTL ; 

--门店退货单 
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
--接收配货单
select * from mis_wm_talcntc WHERE Num = 'P1001PSYW201401240022';
select * from mis_wm_talcntcdtl;

--接收定单 
select * from mis_wm_tstkinord@HDWMS; 
select * from mis_wm_tstkinorddtl@HDWMS; 
SELECT * FROM Mis_Wm_Tordalc; 

--门店退货单 
select * from mis_wm_tstorertnntc@HDWMS;
select * from mis_wm_tstorertnntcdtl;

--供应商退货单 
select * from mis_wm_tvendorrtnntc@HDWMS;
select * from mis_wm_tvendorrtnntc;
--delete from  mis_wm_tvendorrtnntc
select * from mis_wm_tvendorrtnntchis;
select * from mis_wm_tvendorrtnntcdtl@HDWMS;
select * from mis_wm_tvendorrtnntcdtl;
--DELETE from mis_wm_tvendorrtnntcdtl;
select * from mis_wm_tvendorrtnntcdtlhis;
SELECT * FROM MIS_WM_TSTORERTNNTCDTL@HDWMS WHERE NUM='1001THYW201401030033';

--接收货品 
SELECT * FROM MIS_WM_TARTICLE;
SELECT * FROM MIS_WM_TARTICLECODE;
SELECT * FROM MIS_WM_TARTICLEQPC;
SELECT * FROM MIS_WM_TARTICLEVENDOR;

--接收类别 
SELECT * FROM MIS_WM_TSORT;
--接收门店 
SELECT * FROM MIS_WM_TSTORE;
SELECT * FROM MIS_WM_TCLIENT;
--接收供应商 
SELECT * FROM MIS_WM_TVENDOR; 
/**********************************/