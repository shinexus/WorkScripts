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
--select * from wm_mis_tmoveinv; 
--select * from Wm_Mis_Tmoveinvdtl; 
SELECT * FROM io_tstkyk WHERE PluCode = '110004101' ORDER BY FSendTime DESC;

--发送装车/配货单 
select * from wm_mis_talcntc ORDER BY FSendTime DESC; 
select * from wm_mis_talcntcdtl;
--DELETE FROM wm_mis_talcntc
SELECT * from wm_mis_talcntcdtl ORDER BY FSendTime DESC;

--发送定单 
select * from wm_mis_tstknord; 
select * from wm_mis_tstknorddtl WHERE FSrcordNum = '1001201401220223'; 

--供应商退货单 
SELECT * FROM WM_MIS_TVENDORRTN WHERE FSRCNUM = '1001THYW201312210032'; 
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
select * from mis_wm_tstkinord; 
select * from mis_wm_tstkinorddtl; 
SELECT * FROM Mis_Wm_Tordalc; 

--门店退货单 
select * from mis_wm_tstorertnntc;
select * from mis_wm_tstorertnntcdtl;

--供应商退货单 
select * from mis_wm_tvendorrtnntc;
select * from mis_wm_tvendorrtnntcdtl;
SELECT * FROM MIS_WM_TSTORERTNNTCDTL WHERE NUM='1001THYW201401030033';

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