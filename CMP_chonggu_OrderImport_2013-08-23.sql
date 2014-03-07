--DELETE FROM tOrdCgHead;
--DELETE FROM tOrdCgBody
--SELECT * FROM tOrdCgHead@hsczbcmp WHERE SupCode = '00501' ORDER BY BillNo DESC

--select * FROM tordCgHead
--SELECT * FROM tOrdCgBody
--SELECT * FROM LOG_tOrdCgHead
--WHERE lrdate >= '2013-08-21' ORDER BY LrDate
begin
INSERT INTO tOrdCgHead 
SELECT *
/***
BILLNO,
TO_DATE(LRDATE, 'yyyy-mm-dd hh24:mi:ss'),
USERID,
USERCODE,
USERNAME,
TO_DATE(JZDATE, 'yyyy-mm-dd hh24:mi:ss'),
JZRID,
JZRCODE,
JZRNAME,
JZTYPE,
RPTDATE,
PRNTIMES,
TO_DATE(PRNDATE, 'yyyy-mm-dd hh24:mi:ss'),
TIMEMARK,
YWTYPE,
YWIOTYPE,
ORGCODE,
ORGNAME,
HORGCODE,
HORGNAME,
INORGCODE,
YSORGCODE,
YSORGNAME,
DEPID,
DEPCODE,
DEPNAME,
SUPCODE,
SUPNAME,
SUPMAILADDR,
EMAIL,
TELEPHONE,
FAX,
CNTID,
HTCODE,
HTNAME,
PSCNTID,
PSHTCODE,
PSHTNAME,
JYMODE,
JSCODE,
PSJYMODE,
PSJSCODE,
CGYID,
CGYCODE,
CGYNAME,
CGTYPE,
CXBILLNO,
PSTYPE,
ISZC,
ISZS,
CGCOUNT,
CGHCOST,
CGWCOST,
CGJTAXTOTAL,
PSCOST,
STOTAL,
CJTOTAL,
SDCOUNT,
XDDATE,
ZXDATE,
ZDDATE,
YXDATE,
DHDATE,
YWSTATUS,
YSTIMES,
CGQKFLAG,
REMARK,
DATASTATUS,
QRCOUNT,
LINKMAN,
LKMTEL,
YSORGADDRESS,
YSORGLINKMAN,
YSORGLKMTEL
***/
FROM
(SELECT * FROM tOrdCgHead@hsczbcmp
WHERE SupCode = '00501'
AND InOrgCode <> 'ZB'
AND JzDate IS NOT NULL
AND LrDate >= TO_CHAR(sysdate,'yyyy-mm-dd'))
WHERE BillNo NOT IN (SELECT BillNo FROM tOrdCgHead);
--COMMIT ;
INSERT INTO tordcgbody
SELECT
  *
FROM
  tOrdCgBody@hsczbcmp
WHERE
  BillNo IN
  (
    SELECT
      billno
    FROM
      (
        SELECT
          *
        FROM
          tOrdCgHead@hsczbcmp
        WHERE
          SupCode      = '00501'
        AND InOrgCode <> 'ZB'
        AND JzDate    IS NOT NULL
        AND LrDate    >= TO_CHAR(sysdate,'yyyy-mm-dd')
      )
    WHERE
      BillNo NOT IN
      (
        SELECT
          BillNo
        FROM
          tOrdCgHead
          --tOrdCgBody
      )
  ); 
--COMMIT ;
end;

