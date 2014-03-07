/**** 批次表 ****/
SELECT * FROM tStkPc;
SELECT * FROM tStkPc WHERE PcNo = '1001LSPD201402150080500001';
SELECT * FROM tStkPc WHERE PcNo = '1001LSPD201402130044500001';
SELECT * FROM tStkPc WHERE PcNo = '1001LSPD201402130044500001';
SELECT * FROM tStkPc WHERE PcNo = '1001LSPD201402130045500001';
SELECT * FROM tStkPc WHERE PcNo = '1001JHYW201402080130000010';
SELECT * FROM tStkPc WHERE PcNo = '1001JHYW201401180136000003';
/*************************************************************************
UPDATE tStkPc SET ThCount = '0' WHERE PcNo = '1001LSPD201402150080500001';
UPDATE tStkPc SET ThCount = '0' WHERE PcNo = '1001LSPD201402130045500001';
UPDATE tStkPc SET ThCount = '0' WHERE PcNo = '1001JHYW201402080130000010';
**************************************************************************/
/**** 批次索引表 ****/
SELECT * FROM tStkPcGUID;
SELECT * FROM tStkPcGUID WHERE PcGuID = '1001JHYW201402110147000001';
SELECT * FROM tStkPcGUID WHERE PcGuID = '1001JHYW201401180136000003';

/**** 业务单批次附件表 ****/
SELECT * FROM tStkLsPcYW;
SELECT * FROM tStkLsPcYW WHERE BillNo = '1001THYW201401270006' AND BillType = '0914' AND InOrgCode = '0001' AND PcNo = '1001JHYW201401180136000003' AND PluID = (SELECT PluID FROM tSkuPlu WHERE PluCode = '520000003');

/**** 业务单批次索引附件表 ****/
SELECT * FROM tStkPcGUIDYW;

/**** 批次索引库存表 ****/
SELECT * FROM tStkPcGUIDKc;

/**** sStk_DeclsKcTh_ORA ***********************************************************/
/**** Cur1821_Head *****************************************************************/
    select OrgCode,OrgName,InOrgCode,CkCode,CkName,nvl(CntID,0) As CntId,
           SupCode,nvl(JyMode,'0') As JyMode,nvl(JsCode,'0') As JsCode,
           ZbOrgCode,IsZdJPrice As IsZd,nvl(PsCntID,0) As PsCntID,
           case when nvl(PsJyMode,'0')='9'
                then nvl(JyMode,'0') else nvl(PsJyMode,'0') end As PsJyMode,
           case when nvl(PsJsCode,'0')='9'
                then nvl(JsCode,'0') else nvl(PsJsCode,'0') end As PsJsCode,
           DepId,DepCode,DepName,RptDate
      from tOrdThHead where BillNo='1001THYW201401270006';
     
/**** Cur1821_Body *****************************************************************/
select A.BillNo,A.DepId,A.DepCode,A.DepName,A.PluId,A.ExPluCode,B.PcGUID,B.PcNo,B.CntID,B.RecCount,B.HJPrice,B.WJPrice,
       B.HCost,B.WCost,B.PluType,B.ToSerialNo,A.HJPrice As THJPrice,A.ExPluName,A.PluCode,A.PluName,A.Spec,
       A.Unit,B.PackUnit,B.PackQty,B.EtpCode,B.JyMode,B.JsCode,
       nvl((select Tag from tStkIsTz_SysTemp where PcNo=B.PcNo),'1') As IsTz,B.WlAreaCode,B.JTaxRate,B.JTaxCalType
from   tOrdThBody A,tStkLsPcYW B where A.BillNo='1001THYW201401270006' and A.BillNo=B.BillNo and B.BillType='0914' 
       and A.SerialNo=B.ToSerialNo;
     
/**** Cur1821_TH *****************************************************************/
select BillNo,sum(TzHTotal) As TzHTotal,sum(TzWTotal) As TzWTotal,sum(OutHCost) As OutHCost,sum(OutWCost) As OutWCost,
       sum(InHCost)  As InHCost,sum(InWCost) As InWCost,sum(TzCount)  As TzCount
from tStkUpInPcBody where BillNo='1001THYW201401270006' group by BillNo;
     
/**** Cur1821_Jz *****************************************************************/
select InOrgCode,BillNo from tStkKcJzHead where YwBillNo='1001THYW201401270006' and YwType='0914';

/**********************************************************************************************************************/
SELECT SLK.* FROM tStkLsKc SLK, 
(select OrgCode,OrgName,InOrgCode,CkCode,CkName,nvl(CntID,0) As CntId,SupCode,nvl(JyMode,'0') As JyMode,
        nvl(JsCode,'0') As JsCode,ZbOrgCode,IsZdJPrice As IsZd,nvl(PsCntID,0) As PsCntID,
           case when nvl(PsJyMode,'0')='9'
                then nvl(JyMode,'0') else nvl(PsJyMode,'0') end As PsJyMode,
           case when nvl(PsJsCode,'0')='9'
                then nvl(JsCode,'0') else nvl(PsJsCode,'0') end As PsJsCode,
        DepId,DepCode,DepName,RptDate from tOrdThHead where BillNo='1001THYW201401270006') HREC,
(select A.BillNo,A.DepId,A.DepCode,A.DepName,A.PluId,A.ExPluCode,B.PcGUID,B.PcNo,B.CntID,B.RecCount,B.HJPrice,B.WJPrice,
        B.HCost,B.WCost,B.PluType,B.ToSerialNo,A.HJPrice As THJPrice,A.ExPluName,A.PluCode,A.PluName,A.Spec,
        A.Unit,B.PackUnit,B.PackQty,B.EtpCode,B.JyMode,B.JsCode,
       nvl((select Tag from tStkIsTz_SysTemp where PcNo=B.PcNo),'1') As IsTz,B.WlAreaCode,B.JTaxRate,B.JTaxCalType
from   tOrdThBody A,tStkLsPcYW B where A.BillNo='1001THYW201401270006' and A.BillNo=B.BillNo and B.BillType='0914' 
       and A.SerialNo=B.ToSerialNo) BREC
WHERE SLK.OrgCode = HREC.InOrgCode AND SLK.CkCode = HREC.CkCode AND SLK.PcNo = BREC.PcNo;
