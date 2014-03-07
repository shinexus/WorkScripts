--------------------------------------------------------
--  �ļ��Ѵ��� - ������-����-07-2014   
--------------------------------------------------------
-- �޷����ֶ��� HSCMP �� PACKAGE BODY DDL������ DBMS_METADATA �� PHSCWMS_DB ���ڳ����ڲ���������
CREATE 
PACKAGE BODY PHSCWMS_DB is

/*===============================================*/
--���⣺PHSCWMS_DB
--�汾��5.10.5.4
/*===============================================*/

--���ܣ���¼������־
procedure WriteIOCmpLog
    (ps_LogType      IN    IO_HsCmpLog.LogType%type,
     pd_LogTime      IN    IO_HsCmpLog.LogTime%type,
     pi_UserId       IN    IO_HsCmpLog.UserId%type,
     ps_YwType       IN    IO_HsCmpLog.YwType%type,
     ps_YwName       IN    IO_HsCmpLog.YwName%type,
     ps_DataKey      IN    Io_HsCmpLog.Datakey%type,
     ps_LogMeg       IN    IO_HsCmpLog.LogMeg%type)
Is
  pragma autonomous_transaction;
Begin
  insert into IO_HscmpLog(LogType,LogTime,UserId,YwType,YwName,DataKey,LogMeg)
       values (ps_LogType,sysdate,pi_UserId,ps_YwType,ps_YwName,ps_DataKey,ps_LogMeg);    
  commit;
Exception
  When Others then rollback;
End WriteIOCmpLog;

--ȡ���û���Ϣ
procedure SysGet_Usr_Info
   (pi_UserId      IN    tUsrUser.UserId%type,   
    pr_Out         OUT   PHSCWMS_VAR.P_UsrUser_RecType,
    pi_Result      Out integer,
    ps_Message Out varchar2) 
Is
  cursor CurHSC_GetUsr is 
    select UserCode,UserName 
      from tUsrUser
     where UserId=pi_UserId;
Begin
  pi_Result:=-1;
  ps_Message:='ȡ���û���Ϣʧ��'; 
  
/*=================��ȡ�û���Ϣ================*/    
  pr_Out.UserId:=pi_UserId;
  if CurHSC_GetUsr%isopen then close CurHSC_GetUsr; end if;
  open CurHSC_GetUsr;
  fetch CurHSC_GetUsr 
   into pr_Out.UserCode,pr_Out.UserName;
  if CurHSC_GetUsr%notfound then
    if CurHSC_GetUsr%isopen then close CurHSC_GetUsr; end if;
    return;
  end if;
  if CurHSC_GetUsr%isopen then close CurHSC_GetUsr; end if;
/*=================�ɹ�================*/   
  pi_Result:=1;
  ps_Message:='ȡ���û���Ϣ�ɹ�';
Exception when others then
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'ȡ���û���Ϣʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_GetUsr%isopen then close CurHSC_GetUsr; end if;
  end; 
End SysGet_Usr_Info;

--���ܣ�������Ʒ����ȡ����Ʒ��Ϣ
procedure SysGet_PluCode_Plu
   (ps_PluCode      IN    tSkuPlu.PluCode%type,   --���룺��Ʒ������
    pr_Out          OUT   PHSCWMS_VAR.P_OutPlu_RecType,    --�������Ʒ��Ϣ
    pi_Result       Out   integer,
    ps_Message      Out   varchar2)   --��������ش�����Ϣ
Is
  Cursor CurHSC_GetPlu is 
    select PluId,PluCode,PluName,Spec,Unit,BarCode
      from tSkuPlu
     where PluCode=ps_PluCode 
       and IsActive='1';
  vr_B CurHSC_GetPlu%rowtype;
Begin
  /*=================������ʼ��=================*/
  pi_Result:=-1; 
  ps_Message:='������Ʒ����ȡ����Ʒ��Ϣʧ��'; 
  
  /*=================ȡ����Ʒ��Ϣ=================*/
  open CurHSC_GetPlu;
  fetch CurHSC_GetPlu into vr_B;
  if CurHSC_GetPlu%found then
    select vr_B.PluId,vr_B.PluCode,vr_B.PluName,vr_B.Spec,vr_B.Unit,vr_B.BarCode
      into pr_Out.PluId,pr_Out.PluCode,pr_Out.PluName,pr_Out.Spec,pr_Out.Unit,pr_Out.BarCode
      from dual;
  end if;
  if CurHSC_GetPlu%isopen then close CurHSC_GetPlu; end if;
  /*=================�ɹ�===========================*/
  pi_Result:=1; 
  ps_Message:='������Ʒ����ȡ����Ʒ��Ϣ�ɹ�'; 
Exception when others then
  begin
    pi_Result:=-1;    
    ps_Message:=nvl(ps_Message,'���á�SysGet_PluCode_Plu��ʱ����δ֪����')||Sqlerrm;
    ps_Message:=substr(ps_Message,1,2000);
    if CurHSC_GetPlu%isopen then close CurHSC_GetPlu; end if;
    return;
  end;
End;

--�жϽ������ݺ͵�����ϸ���е������Ƿ�һ��
procedure Sys_CheckData
    (ps_BillNoIO      In tOrdCgHead.BillNo%type,     
     ps_TableIO       In varchar2,
     ps_BillNo        In tOrdCgHead.BillNo%type, 
     ps_TableBill     In varchar2,        
     pi_Result        Out integer,
     ps_Message       Out varchar2)
Is
  vi_Count_IO    integer;
  vi_Count_Bill  integer;
  vs_Sql         varchar2(2000);
  vc_Data        sys_refcursor;
Begin
  pi_Result:=-1;
  ps_Message:='�ж�����һ����ʧ��:ҵ�񵥾�('||ps_BillNo||')����������ԭ���ݼ�¼����ͬ!';

/*=================�жϼ�¼���Ƿ���ͬ===========================*/
  execute immediate('select count(1)  from '||ps_TableIO||
                    ' where FSRCORDNUM =:ms_BillNo ')
               into vi_Count_IO
              using ps_BillNoIO; 
  execute immediate('select count(1)  from '||ps_TableBill||
                    ' where BillNo=:ms_BillNo')
               into vi_Count_Bill
              using ps_BillNo;        
  if vi_Count_IO<>vi_Count_Bill then 
    ps_Message:='ҵ�񵥾�('||ps_BillNo||')����������ԭ���ݼ�¼����ͬ:���ռ�¼��('||
                to_char(vi_Count_IO)||')'||',ԭ���ݼ�¼��('||to_char(vi_Count_Bill)||')';
    return;
  end if;

/*=================�ж�SerialNo����Ʒ��ԭ�����Ƿ���ȫ��ͬ===========================*/  
  vs_Sql:='select ''���Ϊ''||to_char(A.SerialNo)||''����Ʒ(''||A.PluCode||'')''
             from '||ps_TableBill||' A where A.BillNo='''||ps_BillNo||''' '||
          ' and not exists ( select 1 from '||ps_TableIO||' B 
                              where B.FSRCORDNUM='''||ps_BillNoIO||''' '||
                              '  and A.SerialNo=B.LINE
                                 and A.PluCode=B.FARTICLECODE
                            )';
  open vc_Data for vs_Sql;
  fetch vc_Data into ps_Message;
  if vc_Data%found then
    ps_Message:='�ж�����һ����ʧ��:ԭ����('||ps_BillNo||')��'||ps_Message||
                 '��¼����������в����!';
    if vc_Data%isopen then close vc_Data; end if;
    return;
  end if;   
  if vc_Data%isopen then close vc_Data; end if;
  
/*=================�ɹ�===========================*/
  pi_Result:=1; 
  ps_Message:='�ж�����һ���Գɹ�'; 
Exception when others then
  begin
    pi_Result:=-1;    
    ps_Message:=nvl(ps_Message,'���á�Sys_CheckData��ʱ����δ֪����')||Sqlerrm;
    ps_Message:=substr(ps_Message,1,2000);
    if vc_Data%isopen then close vc_Data; end if;
    return;
  end;
End Sys_CheckData;


--���ܣ�ת�ƽ��ձ��е����ݵ���ʷ��
procedure IO_MovHis
    (ps_DataKey  IN  tSkuPlu.PluName%type,
     ps_DataType IN  tSkuPlu.PluName%type,
     pi_Result  Out integer,
     ps_Message Out varchar2)
Is
Begin
  pi_Result:=1;
  return;
/*=================��ʼ������================*/ 
  pi_Result:=-1;
  ps_Message:='����ת����ʷʱ����!';
/*=================�Ϸ����ж�================*/ 
  if upper(ps_DataType) not in (upper('WM_MIS_TSTKNORD'),
          upper('WM_MIS_TSTORERTN'),upper('IO_tEtpCustomer'),upper('IO_tOrdCg'),
          upper('IO_tDstPs'),upper('IO_tDstRtn'),upper('IO_tOrdTh'),
          upper('WM_MIS_TSTKNORD'),upper('IO_tDstPs'),upper('IO_tDstRtn'),
          upper('IO_tOrdTh'),upper('IO_tStkKc'),upper('IO_tStkYk')) then 
    return;
  end if;
/*=================ת��������Ϣ===============*/
  if upper(ps_DataType) in ('WM_MIS_TSTKNORD') then 
    Insert into WM_MIS_TSTKNORDHIS
    select * from WM_MIS_TSTKNORD where FSRCORDNUM=ps_DataKey;
    delete from WM_MIS_TSTKNORD where FSRCORDNUM=ps_DataKey;

    Insert into WM_MIS_TSTKNORDDTLHIS
    select * from WM_MIS_TSTKNORDDTL where FSRCORDNUM=ps_DataKey;
    delete from WM_MIS_TSTKNORDDTL where FSRCORDNUM=ps_DataKey;    
  end if;
  
  if upper(ps_DataType) in ('WM_MIS_TSTORERTN') then     
    Insert into WM_MIS_TSTORERTNDTLHIS
    select *
      from WM_MIS_TSTORERTNDTL
     where NUM in
           (select NUM from WM_MIS_TSTORERTN where FSRCNUM = ps_DataKey);
    delete from WM_MIS_TSTORERTNDTL
     where NUM in
           (select NUM from WM_MIS_TSTORERTN where FSRCNUM = ps_DataKey);
    
    Insert into WM_MIS_TSTORERTNHIS
    select * from WM_MIS_TSTORERTN where FSRCNUM=ps_DataKey;

    delete from WM_MIS_TSTORERTN where FSRCNUM=ps_DataKey;    
  end if;
  
/*=================�ɹ��˳�================*/    
  pi_Result:=1;
  ps_Message:='����ת�Ƶ���ʷ�ɹ�';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=nvl(ps_Message,'���á�IO_MovHis��ʱ����δ֪����')||Sqlerrm;
    ps_Message:=substr(ps_Message,1,2000);
    return;
  end;  
End IO_MovHis;

procedure GetWlBillData
    (ps_BillNo   IN  tOrdCgHead.BillNo%type,
     ps_YwType   IN  tOrdJhHead.YwType%type,
     pi_UserId   IN  tOrdJhHead.UserId%type,
     ps_UserCode IN tOrdJhHead.UserCode%type,
     ps_UserName IN tOrdJhHead.UserName%type,
     pd_Date     IN tOrdJhHead.JzDate%type,
     pi_Result   OUT integer,
     ps_Message  OUT varchar2)
Is
  vs_SQL       varchar2(2000);
  vs_HOrgCode  tOrdCgHead.HOrgCode%type; 
  vs_TBN       varchar2(255);
  vc_Data        sys_refcursor;
  vs_YwName    Tsysywtype.Ywtypename%type;
  vd_Date      date;   
  vi_count     integer;
  cur_all      Sys_Refcursor;
  vs_PsType    tOrdCgHead.Pstype%type;
Begin
/*=================��ʼ������================*/ 
  pi_Result:=-1;
  vd_Date:=sysdate; 
  ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ������ҵ������('||ps_YwType||')�Ƿ���';
  if ps_YwType not in ('0902','2003','2007','0914','0912','2004') then return; end if;
  ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ�ȡ���ܲ�����ʧ�ܣ�';
  select InOrgCode into vs_HOrgCode from tOrgManage where OrgType='1001';
  select decode(ps_YwType,'0902','tOrdCgHead','2003','tDstPsHead','2007','tDstPsHead','2004','tDstRtnHead','tOrdThHead') As TNB
    into vs_TBN
    from dual;
/*=================�Ϸ����ж�================*/ 
  vs_SQL:=' select 1 as MyData from '||vs_TBN||' where BillNo='''||ps_BillNo||''' ';
  if ps_YwType in ('0902') then 
    vs_SQL:=vs_SQL||' and HOrgCode='''||vs_HOrgCode||''' '; 
  end if;
  if ps_YwType in ('0914') then 
    vs_SQL:=vs_SQL||' and InOrgCode='''||vs_HOrgCode||''' '; 
  end if;
/*  if ps_YwType in ('0912') then 
    vs_SQL:=vs_SQL||' and InOrgCode='''||vs_HOrgCode||''' '; 
  end if;*/
  if ps_YwType in ('2003','2007','0914','0912','2004') then
    vs_SQL:=vs_SQL||' and TjDate is null and DataStatus<>''9'' '; 
  end if;
  
  if not PSTO.IsExistsData(vs_SQL) then goto GetWlBillData; end if;
  if ps_YwType in ('0902','2003','0914','0912','2004') then  
    if ps_YwType='0902' then 
    vs_SQL:= '  select ''��Ʒ(''||M.PluCode||'')��ͬ�����ʹ��ڶ�����ϸ����''
                  from
                      ( select PluCode,PluTYpe
                                 from tOrdCgHead H,tOrdCgBody B
                                     where H.BillNo=B.BillNo
                                       and h.Billno='''||ps_BillNo||'''
                       ) M
                  group by  PluCode,PluType
                 having Count(1)>1';
    end if;
    
    if ps_YwType in ('2003') then 
      vs_SQL:= 'select ''��Ʒ(''||M.PluCode||'')����ͬ�����;��в�ͬ�ļ۸�''
                  from
                      ( select PluCode,PluType
                                      from tDstPsHead H,tDstPsBody B
                                     where H.BillNo=B.BillNo
                                       and h.Billno='''||ps_BillNo||'''
                                     group by PluCode,PluType,
                                     case when H.Orgtype=''0'' then B.price
                                              when H.OrgType=''1'' then B.psprice
                                         end
                       ) M
                  group by  PluCode,PluType
                 having Count(1)>1';
    end if;
    
    if ps_YwType in ('0912','0914') then 
      vs_SQL:= 'select ''��Ʒ(''||M.PluCode||'')����ͬ�����Ͷ�����ϸ����''
                  from 
                     ( select  PluCode,PluType
                         from tOrdThHead H,tOrdThBody B
                        where H.BillNo=B.BillNo
                          and h.Billno='''||ps_BillNo||'''
                      ) M 
                 group by  PluCode,PluType
                having Count(1)>1';
    end if;
    if ps_YwType in ('2004') then 
      vs_SQL:= 'select ''��Ʒ(''||M.PluCode||'')����ͬ�����Ͷ�����ϸ����''
                  from 
                     ( select  PluCode,PluType
                         from tDstRtnHead H,tDstRtnBody B
                        where H.BillNo=B.BillNo
                          and h.Billno='''||ps_BillNo||'''
                      ) M 
                 group by  PluCode,PluType
                having Count(1)>1';
    end if;    
    open vc_Data for vs_Sql;
    fetch vc_Data into ps_Message;
    if vc_Data%found then
      ps_Message:='�Ӻ���ϵͳ��������ʧ��:'||ps_Message||';�����޷�����';
      if vc_Data%isopen then close vc_Data; end if;
      return;
    end if;   
    if vc_Data%isopen then close vc_Data; end if;
 end if; 
 /*=================��ʼ���ݵ�״̬��================*/ 
    if ps_YwType='0902' then
      vs_YwName := '�ɹ���';
    else 
      if ps_YwType in ('2003','2007') then
        vs_YwName := '���͵�';
      else 
        if ps_YwType='2004' then
          vs_YwName := '�����˻���';
        else
          if ps_YwType='0914' then
            vs_YwName := '�ɹ��˻���';  
          end if;
          if ps_YwType='0912' then
            vs_YwName := '�ŵ��˻���';  
          end if;
          
        end if;
      end if;
    end if;  
    ps_Message:='����'||vs_YwName||'('||ps_BillNo||')�ĳ�ʼ״̬ʧ��!';
    insert into IO_tBillTranState(BillNo,YwType,BillState,TjTime,
           CmpState,CmpTime,CmpMessage,PlatState,PlatTime,PlatMessage,WlState,WlTime,Wlmessage)
     values(ps_BillNo,ps_YwType,'0',sysdate,
            '0',null,null,'0',null,null,'0',null,null);
/*=================����ɹ���================*/
  if ps_YwType='0902' then    
    ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ������ɹ���('||ps_BillNo||')��������ʧ�ܣ�';   
    delete from MIS_WM_TSTKINORD where NUM=ps_BillNo;
    Insert into MIS_WM_TSTKINORD(num,fcls,Fvendor,FVENDORCODE,FEXPECTEDDATE,FEXPIREDATE,FSRC,FWRH,
           FFILLER,FCREATETIME,FSENDTIME,FRTNINFO,FMEMO,FSRCORG,FDESTORG,FISQUICK,FCODE)
    select H.BillNo,case when H.Pstype='0' then '0' when psType='1' then '1' else '0' end,
           456,H.Supcode,to_date(H.Zddate,'YYYY-MM-DD'),to_date(H.YxDate,'YYYY-MM-DD'),
           'HSCMP','01',H.Usercode,H.Lrdate,vd_Date,null,
           H.Remark,'HSCMP','WMS1','0',H.Ysorgcode
     from tOrdCgHead H
    where H.BillNo=ps_BillNo;
    
    delete from MIS_WM_TSTKINORDDTL where NUM=ps_BillNo;
    Insert into MIS_WM_TSTKINORDDTL(NUM,LINE,FARTICLE,FARTICLECODE,FQTY,FPRICE,FSENDTIME,
           FSRCORG,FDESTORG,FTAXRATE,FQPCSTR,FQPC)
    select H.BillNo,B.SERIALNO,123,B.PluCode,B.Cgcount,B.Hjprice,vd_Date,'HSCMP','WMS1',
           B.JTAXRATE,B.SPEC,B.Packcount      
     from tOrdCgHead H,tOrdCgBody B
    where H.BillNo=B.BillNo and H.BillNo=ps_BillNo; 
    
    open cur_all for select PsType from tOrdCgHead where BillNo=ps_BillNo;
    fetch cur_all into vs_PsType;
    close cur_all;
    if vs_PsType='1' then 
      ps_Message:='�Ӻ���ϵͳ��������Խ�ⵥ�ݶ�Ӧʧ��';    
      delete from MIS_WM_TORDALC where FORDNUM=ps_BillNo;
      insert into MIS_WM_TORDALC(Fordnum,FALCNUM,FSENDTIME,FSRCORG,FDESTORG)
      select A.BillNo, 'P'||B.Billno, vd_Date, 'HSCMP', 'WMS1'
        from tOrdCgHead A,tDstPsHead B
       where A.BillNo=ps_BillNo and A.BillNo=B.Refbillno;  
        /*from (select BillNo from tOrdCgHead where BillNo = ps_BillNo) X,
             (select Refbillno
                from Tdstpsjobbill
               where RefBillType = '2'
                 and PsJobNo in (select PsJobNo
                                   from Tdstpsjobbill
                                  where refBillNo = ps_BillNo
                                    and refBillType = '3')) Y;*/
      select count(*) into vi_count from WM_MIS_TSENDLIST where FCLS='�����䵥��Ӧ';
      if vi_count=0 then 
        Insert into WM_MIS_TSENDLIST(FSENDTIME,FCLS,FNOTE,FSRCORG,FDESTORG,FDELTIME)
        values(vd_Date,'�����䵥��Ӧ',null,'HSCMP','WMS1',null);
      else
        update WM_MIS_TSENDLIST set FSENDTIME=vd_Date where FCLS='�����䵥��Ӧ'; 
      end if;
      
      ps_Message:='�Ӻ���ϵͳ����Խ�����͵���ʧ��';    
      delete from MIS_WM_TALCNTC where NUM=ps_BillNo;
      Insert into MIS_WM_TALCNTC(NUM,FSTORECODE,FALCREASON,FSRC,FWRH,FFILLER,FCREATETIME,
             FSENDTIME,FALCTIME,FMEMO,FSRCORG,FDESTORG,FCLS,FISQUICK)
      select 'P' || H.BIllNo,H.Shorgcode,'Խ�����','HSCMP','01',H.Usercode,H.Lrdate,vd_Date,
             vd_Date,H.Remark,'HSCMP','WMS1',case when H.YwType='2003' then '0' 
                                                  when H.YwType='2007' then '1' end,'0'
        from tDstPsHead H
       where 'P'||BillNo in (select FALCNUM from MIS_WM_TORDALC where FORDNUM=ps_BillNo)
         and H.TjDate is null;
       
       Insert into MIS_WM_TALCNTCDTL(num,LINE,FARTICLE,FARTICLECODE,FQTY,FPRICE,FSENDTIME,FMEMO,
              FSRCORG,FDESTORG,FWRHCARD,FALCPRICE,FSTOREPRICE,FPRODUCEDATE,FDIRECT)
       select 'P' || H.BillNo,B.Serialno,123,B.PluCode,B.Pscount,B.Psprice,vd_Date,B.Remark,'HSCMP','WMS1',
              null,B.Psprice,B.Psprice,B.Scdate,null
        from tDstPsHead H,tDstPsBody B
       where H.BillNo=B.BillNo and 'P'||H.BillNo in (select FALCNUM from MIS_WM_TORDALC where FORDNUM=ps_BillNo)
         and H.TjDate is null;

      select count(*) into vi_count from WM_MIS_TSENDLIST where FCLS='���֪ͨ��';
      if vi_count=0 then 
        Insert into WM_MIS_TSENDLIST(FSENDTIME,FCLS,FNOTE,FSRCORG,FDESTORG,FDELTIME)
        values(vd_Date,'���֪ͨ��',null,'HSCMP','WMS1',null);
      else
        update WM_MIS_TSENDLIST set FSENDTIME=vd_Date where FCLS='���֪ͨ��'; 
      end if;                            
    end if;
    
    select count(*) into vi_count from WM_MIS_TSENDLIST where FCLS='��Ӫ����';
    if vi_count=0 then 
      Insert into WM_MIS_TSENDLIST(FSENDTIME,FCLS,FNOTE,FSRCORG,FDESTORG,FDELTIME)
      values(vd_Date,'��Ӫ����',null,'HSCMP','WMS1',null);
    else
      update WM_MIS_TSENDLIST set FSENDTIME=vd_Date where FCLS='��Ӫ����'; 
    end if;
  end if;
/*=================�������͵�================*/
  if ps_YwType in ('2003') then 
    ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ��������͵�('||ps_BillNo||')��������ʧ�ܣ�';    
    delete from MIS_WM_TALCNTC where NUM=ps_BillNo;
    Insert into MIS_WM_TALCNTC(NUM,FSTORECODE,FALCREASON,FSRC,FWRH,FFILLER,FCREATETIME,
           FSENDTIME,FALCTIME,FMEMO,FSRCORG,FDESTORG,FCLS,FISQUICK)
    select 'P' || H.BIllNo,H.Shorgcode,'ͳ������','HSCMP','01',H.Usercode,H.Lrdate,vd_Date,
           vd_Date,H.Remark,'HSCMP','WMS1',case when H.YwType='2003' then '0' 
                                                when H.YwType='2007' then '1' end,'0'
      from tDstPsHead H
     where H.BillNo=ps_BillNo
       and H.TjDate is null;
     
     Insert into MIS_WM_TALCNTCDTL(num,LINE,FARTICLE,FARTICLECODE,FQTY,FPRICE,FSENDTIME,FMEMO,
            FSRCORG,FDESTORG,FWRHCARD,FALCPRICE,FSTOREPRICE,FPRODUCEDATE,FDIRECT)
     select 'P' || H.BillNo,B.Serialno,123,B.PluCode,B.Pscount,B.Psprice,vd_Date,B.Remark,'HSCMP','WMS1',
            null,B.Psprice,B.Psprice,B.Scdate,null
      from tDstPsHead H,tDstPsBody B
     where H.BillNo=B.BillNo and H.BillNo=ps_BillNo
       and H.TjDate is null;

    select count(*) into vi_count from WM_MIS_TSENDLIST where FCLS='���֪ͨ��';
    if vi_count=0 then 
      Insert into WM_MIS_TSENDLIST(FSENDTIME,FCLS,FNOTE,FSRCORG,FDESTORG,FDELTIME)
      values(vd_Date,'���֪ͨ��',null,'HSCMP','WMS1',null);
    else
      update WM_MIS_TSENDLIST set FSENDTIME=vd_Date where FCLS='���֪ͨ��'; 
    end if;
                     
  end if;
/*=================����WSL��================*/
  if ps_YwType in ('1601') then 
    ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ�����������('||ps_BillNo||')��������ʧ�ܣ�';    
    delete from MIS_WM_TALCNTC where NUM=ps_BillNo;
    Insert into MIS_WM_TALCNTC(NUM,FSTORECODE,FALCREASON,FSRC,FWRH,FFILLER,FCREATETIME,
           FSENDTIME,FALCTIME,FMEMO,FSRCORG,FDESTORG,FCLS,FISQUICK)
    select H.BIllNo,H.Etpcode,'ͳ������','HSCMP','01',H.Usercode,H.Lrdate,vd_Date,
           vd_Date,H.Remark,'HSCMP','WMS1','0','0'
      from tWslXsHead H
     where H.BillNo=ps_BillNo
       and H.TjDate is null;
     
     Insert into MIS_WM_TALCNTCDTL(num,LINE,FARTICLE,FARTICLECODE,FQTY,FPRICE,FSENDTIME,FMEMO,
            FSRCORG,FDESTORG,FWRHCARD,FALCPRICE,FSTOREPRICE,FPRODUCEDATE,FDIRECT)
     select 'W' || H.BillNo,B.Serialno,123,B.PluCode,B.Pfcount,B.Pfprice,vd_Date,B.Remark,'HSCMP','WMS1',
            null,B.Pfprice,B.Pfprice,null,null
      from tWslXsHead H,tWslXsBody B
     where H.BillNo=B.BillNo and H.BillNo=ps_BillNo
       and H.TjDate is null;  
    
    select count(*) into vi_count from WM_MIS_TSENDLIST where FCLS='���֪ͨ��';
    if vi_count=0 then 
      Insert into WM_MIS_TSENDLIST(FSENDTIME,FCLS,FNOTE,FSRCORG,FDESTORG,FDELTIME)
      values(vd_Date,'���֪ͨ��',null,'HSCMP','WMS1',null);
    else
      update WM_MIS_TSENDLIST set FSENDTIME=vd_Date where FCLS='���֪ͨ��'; 
    end if;                    
  end if;  
/*=================����rtn��================*/
  if ps_YwType='2004' then 
    ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ����������˻���('||ps_BillNo||')��������ʧ�ܣ�';  

    delete from MIS_WM_TSTORERTNNTC where NUM=ps_BillNo; 
    insert into MIS_WM_TSTORERTNNTC(NUM,FSTORECODE,FRTNDATE,FSRC,FFILLER,FWRH,FCREATETIME,
           FSENDTIME,FCASEBARCODE,FRTNREASON,FSRCORG,FDESTORG,FMEMO)
    select H.BillNo,H.ORGCODE,H.Lrdate,'HSCMP',H.Usercode,'02',sysdate,sysdate,null,null,
           'HSCMP','WMS1',null
      from tDstRtnHead H
     where H.BillNo=ps_BillNo and H.TjDate is null;
     
     delete from MIS_WM_TSTORERTNNTCDTL where NUM=ps_BillNo;    
     insert into MIS_WM_TSTORERTNNTCDTL(Num,LINE,FARTICLE,FARTICLECODE,FQTY,FPRICE,FVENDOR,FVENDORCODE,
                 FSENDTIME,FRTNREASON,FSRCORG,FDESTORG,FALCNTC)
     select H.BillNo,B.SerialNo,123,B.Plucode,B.Thcount,B.Thprice,0,'0',sysdate,null,'HSCMP','WMS1',null
       from tDstRtnHead H,tDstRtnBody B
     where H.BillNo=B.BillNo and H.BillNo=ps_BillNo
       and H.TjDate is null;
       
    select count(*) into vi_count from WM_MIS_TSENDLIST where FCLS='�ŵ��˻�֪ͨ��';
    if vi_count=0 then 
      Insert into WM_MIS_TSENDLIST(FSENDTIME,FCLS,FNOTE,FSRCORG,FDESTORG,FDELTIME)
      values(vd_Date,'�ŵ��˻�֪ͨ��',null,'HSCMP','WMS1',null);
    else
      update WM_MIS_TSENDLIST set FSENDTIME=vd_Date where FCLS='�ŵ��˻�֪ͨ��'; 
    end if;  

  end if;
  
/*=================�����˻���================*/
  if ps_YwType='0914' then 
    ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ������ɹ��˻���('||ps_BillNo||')��������ʧ�ܣ�';  

    delete from MIS_WM_TVENDORRTNNTC where NUM=ps_BillNo;
    insert into MIS_WM_TVENDORRTNNTC(NUM,FVENDOR,FVDRCODE,FRTNDATE,FCLS,FSRC,FWRH,FFILLER,
           FCREATETIME,FSENDTIME,FSRCORG,FDESTORG,FMEMO)
    select H.BillNo,456,H.Supcode,H.Lrdate,'�˹�Ӧ��','HSCMP','02',H.Usercode,sysdate,sysdate,
           'HSCMP','WMS1',null
      from tOrdThHead H
     where H.BillNo=ps_BillNo and H.TjDate is null;
     
     delete from MIS_WM_TVENDORRTNNTCDTL where NUM=ps_BillNo;    
     insert into MIS_WM_TVENDORRTNNTCDTL(NUM,LINE,FARTICLE,FARTICLECODE,FQTY,FPRICE,
            FSENDTIME,FSRCORG,FDESTORG)
     select H.BillNo,B.Serialno,123,B.PluCode,B.Thcount,B.Hjprice,sysdate,'HSCMP','WMS1'
       from tOrdThHead H,tOrdThBody B
     where H.BillNo=B.BillNo and H.BillNo=ps_BillNo
       and H.TjDate is null;
       
    select count(*) into vi_count from WM_MIS_TSENDLIST where FCLS='��Ӧ���˻�֪ͨ��';
    if vi_count=0 then 
      Insert into WM_MIS_TSENDLIST(FSENDTIME,FCLS,FNOTE,FSRCORG,FDESTORG,FDELTIME)
      values(vd_Date,'��Ӧ���˻�֪ͨ��',null,'HSCMP','WMS1',null);
    else
      update WM_MIS_TSENDLIST set FSENDTIME=vd_Date where FCLS='��Ӧ���˻�֪ͨ��'; 
    end if;       
  end if; 
/*=================����Shop�˻���================*/
  if ps_YwType='0912' then 
    ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ������ŵ��˻���('||ps_BillNo||')��������ʧ�ܣ�';  

    delete from MIS_WM_TSTORERTNNTC where NUM=ps_BillNo; 
    insert into MIS_WM_TSTORERTNNTC(NUM,FSTORECODE,FRTNDATE,FSRC,FFILLER,FWRH,FCREATETIME,
           FSENDTIME,FCASEBARCODE,FRTNREASON,FSRCORG,FDESTORG,FMEMO)
    select H.BillNo,H.ORGCODE,H.Lrdate,'HSCMP',H.Usercode,'02',sysdate,sysdate,null,null,
           'HSCMP','WMS1',null
      from tOrdThHead H
     where H.BillNo=ps_BillNo and H.TjDate is null;
     
     delete from MIS_WM_TSTORERTNNTCDTL where NUM=ps_BillNo;    
     insert into MIS_WM_TSTORERTNNTCDTL(Num,LINE,FARTICLE,FARTICLECODE,FQTY,FPRICE,FVENDOR,FVENDORCODE,
                 FSENDTIME,FRTNREASON,FSRCORG,FDESTORG,FALCNTC)
     select H.BillNo,B.SerialNo,123,B.Plucode,B.Thcount,B.Hjprice,0,'0',sysdate,null,'HSCMP','WMS1',null
       from tOrdThHead H,tOrdThBody B
     where H.BillNo=B.BillNo and H.BillNo=ps_BillNo
       and H.TjDate is null;
       
    select count(*) into vi_count from WM_MIS_TSENDLIST where FCLS='�ŵ��˻�֪ͨ��';
    if vi_count=0 then 
      Insert into WM_MIS_TSENDLIST(FSENDTIME,FCLS,FNOTE,FSRCORG,FDESTORG,FDELTIME)
      values(vd_Date,'�ŵ��˻�֪ͨ��',null,'HSCMP','WMS1',null);
    else
      update WM_MIS_TSENDLIST set FSENDTIME=vd_Date where FCLS='�ŵ��˻�֪ͨ��'; 
    end if;  
  end if;   
/*=================���µ���״̬================*/
  if ps_YwType in ('2003','2007','0914','2004','0912','1601') then
    ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ�����ҵ�񵥾�('||ps_BillNo||')״̬ʧ�ܣ�';
    vs_SQL:=' update '||vs_TBN||
            '    set TjrID=:mm_UserId,TjrCode=:mm_UserCode, '||
            '        TjrName=:mm_UserName,TjDate=:mm_Date, '||
            '        DataStatus=''9'' '||
            '  where BillNo=:mm_BillNo ';
    execute immediate (vs_SQL) 
        using pi_UserId,ps_UserCode,ps_UserName,
              pd_Date,ps_BillNo;
  end if;
  
/*=================pi_Result=2end���˹���================*/  
  if ps_YwType in ('2003','2007','0914','2004','0912','1601') then
    pi_Result:=2;
    ps_Message:='�Ӻ���ϵͳ�������ݳɹ���';
    return;
  end if;
/*=================�ɹ��˳�================*/
<<GetWlBillData>>  
  pi_Result:=1;
  ps_Message:='�Ӻ���ϵͳ�������ݳɹ���';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'�Ӻ���ϵͳ��������ʱ����δ֪����')||Sqlerrm,1,2000);
    if vc_Data%isopen then close vc_Data; end if;
    return;
  end;
End GetWlBillData;

--���ܣ�Jh������ռ���
procedure Set_OrdCg
  (ps_BillNo   in tOrdJhHead.BillNo%type,  
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType,  
   pd_JzDate   IN  date,    
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  cursor CurHSC_GetCGBillNo is
    select FSRCORDNUM as CgBillNo
      from WM_MIS_TSTKNORD
     where FSRCORDNUM=ps_BillNo
       for update;
  
  cursor CurHSC_GetCk(ms_OrgCode tStkStore.OrgCode%type) is 
    select CkCode,CkName
      from tStkStore    
     where OrgCode=ms_OrgCode
       and KcType='0'
       and rownum=1;
       
  cursor CurHSC_CheckCgCount is 
    select '�ɹ����յ�('||ps_BillNo||')��Ϣ����ʧ��:��Ʒ'||B.FARTICLECODE||'-'||C.PluName||'��ʵ�ʲɹ�����'||
           to_char(B.FQTY)||'���������ԭ���ݲɹ�����'||to_char(C.CgCount)
      from WM_MIS_TSTKNORD A,WM_MIS_TSTKNORDDTL B, tOrdCgBody C
     where A.NUM=B.NUM
       and A.FSRCORDNUM=ps_BillNo
       and A.FSRCORDNUM=C.BillNo
       and B.LINE=C.SerialNo
       and B.FQTY>C.CgCount;
  
  Cursor Cur_CgHD is
    Select OrgCode,CntID,PsType,PsCntID,HOrgCode,CgType,DepId,DepCode,DepName,
           Nvl((Select IsLast from tOrgDept Where DepId=A.DepId),'0') as IsLast,
           Nvl((Select OrgType from tOrgManage where OrgCode=A.YsOrgCode),'*') as OrgType
      From tOrdCgHead A
     Where BillNo=ps_BillNo
       and JzDate is not null and YwStatus in ('0','1');
  Rec_CgHD Cur_CgHD%rowtype;
  
  Cursor Cur_CgBD is
    Select SerialNo,PluID,HJPrice, WJPrice
      From tOrdCgBody 
     Where BillNo=ps_BillNo and ZsType='0';
  Rec_CgBD Cur_CgBD%rowtype;        
       
  vs_YwType     tOrdCgHead.YwType%type;   
  vs_CkCode     tStkStore.Ckcode%type;
  vs_CkName     Tstkstore.CkName%type;
  vs_InOrgCode  tOrgManage.InOrgCode%type;
  vs_OrgCode    tOrgManage.OrgCode%type;
  vs_BillNo     tOrdCgHead.BillNo%type;
  vs_Ord_CgJhUseCgJPrice varchar2(20);
  vs_IsCntPrice  varchar2(1);
  
  vf_HJPrice tOrdCgBody.HJPrice%type;
  vf_WJPrice tOrdCgBody.WJPrice%type;
  vs_JTaxCalType tSkuPlu.Jtaxcaltype%type;
  vs_JhDate        varchar2(10);  
  vs_PriceType     varchar2(10);  
  vi_JTaxRate      tSkuPlu.JTaxRate%Type;  
  vs_CgBillNo      varchar2(20); 
Begin

/*==========��ʼ������================*/ 
  pi_Result:=-1;
  ps_Message:='�ɹ����յ�('||ps_BillNo||')��Ϣ���մ���ʧ��:��ʼ������';  
  vs_YwType:='0905';   
  ps_Message:='�ɹ����յ�('||ps_BillNo||')��Ϣ���մ���ʧ��:ȡ���ܲ���Ϣʧ��'; 
  select OrgCode,InOrgCode into vs_OrgCode,vs_InOrgCode from tOrgManage where OrgType='1001';
/*==========ȡ���ܲ�����Ʒ�ֿ�================*/ 
  ps_Message:='�ɹ����յ�('||ps_BillNo||')��Ϣ���մ���ʧ��:û��ȡ����Ʒ�ֿ�';
  if CurHSC_GetCk%isopen then close CurHSC_GetCk; end if;
  open CurHSC_GetCk(vs_InOrgCode);
  fetch CurHSC_GetCk into vs_CkCode,vs_CkName;
  if CurHSC_GetCk%notfound then
    if CurHSC_GetCk%isopen then close CurHSC_GetCk; end if;
    return;
  end if;
  if CurHSC_GetCk%isopen then close CurHSC_GetCk; end if;

/*==========���Ϸ���================*/ 
  if PSTO.IsExistsData('select 1 as MyData from tOrdJhHead where BillNo='''||ps_BillNo||''' for update') then
    ps_Message:='�ɹ����յ�('||ps_BillNo||')��Ϣ���մ���ʧ��:�����յ��Ѵ���!';
    return;
  end if;  
  
  ps_Message:='�ɹ����յ�('||ps_BillNo||')��Ϣ���մ���ʧ��:�ڽ��ձ���û������';
  if CurHSC_GetCGBillNo%isopen then close CurHSC_GetCGBillNo; end if;
  open CurHSC_GetCGBillNo;
  fetch CurHSC_GetCGBillNo into vs_CGBillNo;
  if CurHSC_GetCGBillNo%notfound then
    if CurHSC_GetCGBillNo%isopen then close CurHSC_GetCGBillNo; end if;
    return;
  end if;
  if CurHSC_GetCGBillNo%isopen then close CurHSC_GetCGBillNo; end if;
  
  Sys_CheckData(Ps_BillNo,'WM_MIS_TSTKNORDDTL',vs_CGBillNo,'tOrdCgBody',pi_Result,ps_Message);  
  if pi_Result<>1 then return; end if;
  pi_Result:=-1; 
  
  ps_Message:='�ɹ����յ�('||ps_BillNo||')��Ϣ���մ���ʧ��:��Ʒʵ�ʲɹ��������������ԭ���ݲɹ�����';
  if CurHSC_CheckCgCount%isopen then close CurHSC_CheckCgCount; end if;
  open CurHSC_CheckCgCount;
  fetch CurHSC_CheckCgCount into ps_Message;
  if CurHSC_CheckCgCount%found then
    if CurHSC_CheckCgCount%isopen then close CurHSC_CheckCgCount; end if;
    return;
  end if;
  if CurHSC_CheckCgCount%isopen then close CurHSC_CheckCgCount; end if;
  
  sSysGetBillNo('0904',vs_BillNo);
  if nvl(vs_BillNo,'*')='*' then return; end if;
  
  Delete from tOrdCgBody_JhPrice where billno = ps_BillNo;
  Insert Into tOrdCgBody_JhPrice
           (billno, serialno, pluid, plucode, pluname, explucode, expluname, 
           barcode, spec, unit, cargono, depid, depcode, depname, hjprice, 
           wjprice, psprice, lhjprice, lwjprice, discountrate, price, jtaxrate, 
           packunit, packqty, packcount, sglcount, cgcount, cghcost, cgwcost, 
           cgjtaxtotal, pscost, stotal, cjtotal, sdcount, zscount, remark, 
           pricetype, jdrate, qrcount, zstype, tag, tpheight, tplong,jpricetype,plutype)           
    select billno, rownum as serialno, pluid, plucode, pluname, explucode, expluname, 
           barcode, spec, unit, cargono, depid, depcode, depname, hjprice, 
           wjprice, psprice, lhjprice, lwjprice, discountrate, price, jtaxrate, 
           packunit, packqty, packcount, sglcount, cgcount, cghcost, cgwcost, 
           cgjtaxtotal, pscost, stotal, cjtotal, sdcount, zscount, remark, 
           pricetype, jdrate, qrcount, zstype, tag, tpheight, tplong,'0',plutype           
      from tordcgbody
     where billno = ps_BillNo;
         
  Open Cur_CgHD;
  Fetch Cur_CgHD into Rec_CgHD;
  Close Cur_CgHD;      
  --�õ�ѡ��"�ɹ�����ʱ�۸�ȡ�Բɹ���"
  vs_Ord_CgJhUseCgJPrice:=Nvl(fGetSysOptionValue('*','ORD','Ord_CgJhUseCgJPrice'),'1');
  select Nvl(IsMngJPrice,'1') into vs_IsCntPrice from tcntcontract where cntid = (select cntid from tordcghead where billno = ps_BillNo);
  If (vs_Ord_CgJhUseCgJPrice='0') and (vs_IsCntPrice='1') then 
    --���²ɹ����еļ۸�
    vs_JhDate := to_char(sysdate, 'YYYY-MM-DD');            
    Open Cur_CgBD;
    Loop
      Fetch Cur_CgBD into Rec_CgBD;
      Exit When Cur_CgBD%NotFound;
      --ȡ����Ʒ����   
      sCnt_GetPluJPrice(Rec_CgHD.OrgCode, Rec_CgHD.HOrgCode, Rec_CgHD.CntId, Rec_CgBD.PluId, vs_JhDate,
                        vf_HJPrice, vf_WJPrice, vi_JTaxRate, vs_JTaxCalType, vs_PriceType, 
                        pi_Result, ps_Message);
       if (pi_Result='1') then
         Update tOrdCgBody_JhPrice 
            Set JPriceType=vs_PriceType
         Where BillNo=ps_BillNo and SerialNo=Rec_CgBD.Serialno;     
       end if;
       If (pi_Result='1') and ((vf_HJPrice<>Rec_CgBD.HJPrice) or (vf_WJPrice<>Rec_CgBD.WJPrice)) then
         Update tOrdCgBody_JhPrice 
            Set HJPrice=vf_HJPrice,WJPrice=vf_WJPrice,
                PsPrice=Case When (Rec_CgHD.PsType='2') and (Rec_CgHD.PsCntID=0 or PriceType in ('1','4')) 
                             then vf_HJPrice 
                             When (Rec_CgHD.PsType='2') and (PriceType in ('2'))
                             then vf_HJPrice*(1+JdRate/100.0)
                             Else PsPrice
                        End,
                CgHCost=Round(vf_HJPrice*CgCount,2),
                CgWCost=Case When vs_JTaxCalType='0' then 
                          Round(Round(vf_HJPrice*CgCount,2)/(1+JTaxRate/100),2)
                        Else Round(Round(vf_HJPrice*CgCount,2)*(1-JTaxRate/100),2)
                        End,
                JTaxRate=vi_JTaxRate
                --JPriceType=vs_PriceType
          Where BillNo=ps_BillNo and SerialNo=Rec_CgBD.Serialno;
         Update tOrdCgBody_JhPrice 
            Set CgJTaxTotal=CgHCost-CgWCost,
                CjTotal=STotal-CgHCost,
                PsCost=Round(PsPrice*CgCount,2)
          Where BillNo=ps_BillNo and SerialNo=Rec_CgBD.Serialno;      
       End If;
    End Loop;
    Close Cur_CgBD;
  End If;
/*==========���յ�����================*/ 
  ps_Message:='�ɹ���('||ps_BillNo||')��Ϣ���ս��մ���ʧ��'||'���������յ�����ʧ�ܣ�';  
  insert into tOrdJhHead(BillNo,LrDate,UserID,UserCode,UserName,IsNeedTjWl,
         JzType,YwType,YwIOType,YsPluType, OrgCode,OrgName,InOrgCode,
         HOrgCode,HOrgName,DepId,DepCode,DepName,ZbOrgCode,ZbOrgName,
         SupCode,SupName,CntID,HtCode,HtName,JyMode,JsCode,CkCode,CkName,
         RefBillType,RefBillNo,YsrId,YsrCode,YsrName,IsFp,Remark,
         DataStatus,IsYkYs)
  select vs_BillNo,pd_JzDate,pr_User.UserId,pr_User.UserCode,pr_User.UserName,'0',
         '0',vs_YwType,'1','0',
         A.YsOrgCode,A.YsOrgName,A.InOrgCode,A.HOrgCode,A.HOrgName,
         A.DepId,A.DepCode,A.DepName,C.OrgCode,C.OrgName,A.SupCode,A.SupName,
         A.CntId,A.HtCode,A.HtName,A.JyMode,A.JsCode,vs_CkCode,vs_CkName,
         '0902',ps_BillNo,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
         '0',A.Remark,'0',decode(A.PsType,'1','1','0') As IsYkYs
    from tOrdCgHead A,tOrgManage B,tOrgManage C
   where A.BillNo=ps_BillNo and A.HOrgCode=B.OrgCode 
     and B.ZbOrgCode=C.OrgCode;
  
  ps_Message:='�ɹ����յ�('||ps_BillNo||')��Ϣ���մ���ʧ��'||'���������յ���ϸʧ�ܣ�';  
  insert into TORDJHBODY(BillNo,SerialNo,ToSerialNo,PluID,PluCode,PluName,
         ExPluCode,ExPluName,BarCode,Spec,Unit,CargoNo,PluType,
         DepId,DepCode,DepName,HJPrice,WJPrice,Price,JTaxRate,
         PackUnit,PackQty,PackCount,SglCount,JhCount,
         HCost,WCost,JTaxTotal,STotal,CjTotal,CjRate,ScDate,
         BzDays,Remark,JTaxCalType,DqDate)
  select vs_BillNo,rownum,B.SerialNo,B.PluId,B.PluCode,B.PluName,
         B.ExPluCode,B.ExPluName,B.BarCode,B.Spec,B.Unit,B.CargoNo,B.PluType,
         B.DepId,B.DepCode,B.DepName,B.HJPrice,B.WJPrice,B.Price,B.JTaxRate,
         B.PackUnit,B.PackQty,
         (case when B.PackQty<=0 or B.PackQty=1 then 0 
               else Floor(H.FQTY/B.PackQty) end) As PackCount,
         (case when B.PackQty<=0 or B.PackQty=1 then H.FQTY
               else H.FQTY-Floor(H.FQTY/B.PackQty)*B.PackQty 
           end) As SglCount,H.FQTY,
         Round(H.FQTY*B.HJPrice,2),--Host
         Case When P.JTaxCalType='0' then--WHost
                Round(Round(B.HJPrice*H.FQTY,2)/(1+B.JTaxRate/100),2)
              Else Round(Round(B.HJPrice*H.FQTY,2)*(1-B.JTaxRate/100),2)
              End,
         Round(H.FQTY*B.HJPrice,2)- Case When P.JTaxCalType='0' then --JTaxTotal
                Round(Round(B.HJPrice*H.FQTY,2)/(1+B.JTaxRate/100),2)
              Else Round(Round(B.HJPrice*H.FQTY,2)*(1-B.JTaxRate/100),2)
              End,
         Round(H.FQTY*B.Price,2),--STotal
         Round(H.FQTY*B.Price,2)-Round(H.FQTY*B.HJPrice,2),--CjTotal
         case when (B.Price*H.FQTY=0) or ((B.Price*H.FQTY-B.HjPrice*H.FQTY)=0) then
                   0
              else
                Round(((B.Price-B.HjPrice)/B.Price)*100,2)
              end,                          
         '',
         0,null,P.JTAXCALTYPE,''
    from WM_MIS_TSTKNORDDTL H,tOrdCgBody_JhPrice B,tSkuPlu P
   where H.FSRCORDNUM=ps_BillNo
     and H.FSRCORDNUM=B.BillNo and H.LINE=B.Serialno
     and B.PluId=P.PluId;
                 
  ps_Message:='�ɹ���('||ps_BillNo||')��Ϣ���ս��մ���ʧ��'||'���������յ�����ĺϼ�����ʧ�ܣ�';
  update tOrdJhHead
     set (JhCount,HCost,WCost,JTaxTotal,STotal,CjTotal)=
         (select sum(JhCount),sum(HCost),sum(WCost),
                 sum(JTaxTotal),sum(STotal),sum(CjTotal)
            from tOrdJhBody 
           where BillNo=vs_BillNo)
   where BillNo=vs_BillNo;
    
/*==========���յ�����================*/ 
/*  sStk_Commit_Jh_ORA(vs_BillNo,vs_YwType,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
                            pd_JzDate,pi_Result,ps_Message);
  if pi_Result<>1 then
    ps_Message:='�ɹ���('||ps_BillNo||')��Ϣ���ս��մ���ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;    
    return; 
  end if;   */  
/*==========ת�����ݵ���ʷ��================*/ 
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TSTKNORD',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if; 
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TSTKNORDDTL',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if; 
     
/*==========*�ɹ�================*/ 
  pi_Result:=1;
  ps_Message:='�ɹ�������Ϣ���ճɹ�';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'�ɹ�������Ϣ����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_GetCk%isopen then close CurHSC_GetCk; end if;
    if CurHSC_GetCGBillNo%isopen then close CurHSC_GetCGBillNo; end if;
    if CurHSC_CheckCgCount%isopen then close CurHSC_CheckCgCount; end if;
    return;
  end;  
End Set_OrdCg;

--���ܣ�Ord�˻�������ռ���
procedure Set_OrdTh
  (ps_BillNo in tOrdJhHead.BillNo%type,    
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType, 
   pd_JzDate   IN  date, 
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  cursor CurHSC_GetIOData is
    select A.FSRCNUM as BillNo,B.LINE as SerialNo,B.FARTICLECODE as PluCode,
           '0' as PluType,B.FREALQTY as ThCount,null as Remark
      from WM_MIS_TVENDORRTN A,WM_MIS_TVENDORRTNDTL B
     where A.NUM=B.NUM
       and A.FSRCNUM=ps_BillNo
       for update;
  
  cursor CurHSC_CheckOrdTh is
    select '�ɹ��˻�('||ps_BillNo||')�����ڻ��Ѽ���!'
      from tOrdThHead
     where BillNo=ps_BillNo
       and TjDate is not null
       and JzDate is null
       for update;     
  cursor CurHSC_CheckThCount is 
    select '�ɹ��˻�('||ps_BillNo||')��Ϣ����ʧ��:��Ʒ'||C.FARTICLECODE||'��ʵ���˻�����'||
           to_char(C.FREALQTY)||'���������ԭ�����˻�����'||to_char(B.ThCount)
      from WM_MIS_TVENDORRTN A, tOrdThBody B,WM_MIS_TVENDORRTNDTL C
     where A.NUM=C.NUM
       and A.FSRCNUM=ps_BillNo
       and A.FSRCNUM=B.BillNo
       and C.LINE=B.SerialNo
       and C.FREALQTY>B.ThCount;
     
  vs_YwType   tOrdJhHead.YwType%type;
  vs_IoHasRec varchar2(1);
  vs_IsAllZero   varchar2(1);
Begin
/*==========��ʼ������==================*/  
  pi_Result:=-1;
  ps_Message:='�ɹ��˻�('||ps_BillNo||')��Ϣ����ʧ��:��ʼ������';
  vs_YwType:='0914'; 

/*==========�Ϸ����ж�==================*/  
/*  Sys_CheckData(Ps_BillNo,'WM_MIS_TVENDORRTNDTL',ps_BillNo,'tOrdThBody',pi_Result,ps_Message);  
  if pi_Result<>1 then return; end if;
  pi_Result:=-1; */
  
  ps_Message:='�ɹ��˻�('||ps_BillNo||')��Ϣ����ʧ��:�ɹ��������ڻ��Ѽ���!';
  if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
  open CurHSC_CheckOrdTh;
  fetch CurHSC_CheckOrdTh into ps_Message;
  if CurHSC_CheckOrdTh%notfound then
    if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
    return;
  end if;
  if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
  
  ps_Message:='�ɹ��˻�('||ps_BillNo||')��Ϣ����ʧ��:��Ʒʵ���˻��������������ԭ�����˻�����';
  if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
  open CurHSC_CheckThCount;
  fetch CurHSC_CheckThCount into ps_Message;
  if CurHSC_CheckThCount%found then
    if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
    return;
  end if;
  if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
  
/*==========���²ɹ��˻�����ϸʧ��==================*/  
  ps_Message:='�ɹ��˻�('||ps_BillNo||')��Ϣ����ʧ��:���²ɹ��˻�����ϸ��������!';
  vs_IoHasRec:='0';
  vs_IsAllZero:='1';
  for vr_B in CurHSC_GetIOData 
  Loop    
    if vr_B.ThCount<>0 then
      vs_IsAllZero:='0';
    end if; 
    vs_IoHasRec:='1';       
    update tOrdThBody B
       set (PluCode,ThCount,HCost,WCost,JTaxTotal,STotal,CjTotal,CjRate,Remark,
            B.PackCount,SglCount)=
           (select vr_B.PluCode,vr_B.ThCount,
             Round(vr_B.ThCount*B.HJPrice,2),--Host
             Case When P.JTaxCalType='0' then--WHost
                    Round(Round(B.HJPrice*vr_B.ThCount,2)/(1+B.JTaxRate/100),2)
                  Else Round(Round(B.HJPrice*vr_B.ThCount,2)*(1-B.JTaxRate/100),2)
                  End,
             Round(vr_B.ThCount*B.HJPrice,2)- Case When P.JTaxCalType='0' then --JTaxTotal
                    Round(Round(B.HJPrice*vr_B.ThCount,2)/(1+B.JTaxRate/100),2)
                  Else Round(Round(B.HJPrice*vr_B.ThCount,2)*(1-B.JTaxRate/100),2)
                  End,
             Round(vr_B.ThCount*B.Price,2),--STotal
             Round(vr_B.ThCount*B.Price,2)-Round(vr_B.ThCount*B.HJPrice,2),--CjTotal
             case when (B.Price*vr_B.ThCount=0) or ((B.Price*vr_B.ThCount-B.HjPrice*vr_B.ThCount)=0) then
                       0
                  else
                    Round(((B.Price-B.HjPrice)/B.Price)*100,2)
                  end, 
                          
             vr_B.Remark,
            (case when B.PackQty<=0 or B.PackQty=1 then 0 
                  else Floor(vr_B.ThCount/B.PackQty) end) As PackCount,
            (case when B.PackQty<=0 or B.PackQty=1 then vr_B.ThCount
                  else vr_B.ThCount-Floor(vr_B.ThCount/B.PackQty)*B.PackQty 
             end) As SglCount
            from tSkuPlu P
           where P.PluId=B.PluId)
     where BillNo=vr_B.Billno and SerialNo=vr_B.SerialNo;
  End Loop;
  
  if vs_IoHasRec='0' then--��ʾ�ӿڱ�û������
    ps_Message:='�ɹ��˻�('||ps_BillNo||')��Ϣ����ʧ��:�ɹ��˻���"'||ps_BillNo||'"�ڽӿڱ��в�����'; 
    return;
  end if;
  
/*==========���²ɹ��˻�������ʧ��==================*/  
  ps_Message:='�ɹ��˻�('||ps_BillNo||')����ʧ�ܣ����²ɹ��˻�������ĺϼ�����ʧ�ܣ�';  
    update tOrdThHead
       set (ThCount,HCost,WCost,JTaxTotal,STotal,CjTotal)=
           (select sum(ThCount),sum(HCost),sum(WCost),
                  sum(JTaxTotal),sum(STotal),sum(CjTotal)
              from tOrdThBody 
             where BillNo=ps_BillNo)
     where BillNo=ps_BillNo;
 /*==========�ɹ��˻�������==================*/ 
   if vs_IsAllZero='0' then  
    update tOrdThHead 
       set TjrID=0,TjrCode='',
           TjrName='',TjDate=null,
           DataStatus='0'
     where BillNo=ps_BillNo; 
     
    --�˻�������
    sStk_Commit_Th_ORA(ps_BillNo,vs_YwType,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
                                pd_JzDate,pi_Result,ps_Message);
    if pi_Result<>1 then     
      ps_Message:='�ɹ��˻�('||ps_BillNo||')��Ϣ���մ���ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;      
      return; 
    end if;    
  else
    update tOrdThHead 
       set JzrId=0,JzrCode='*',JzrName='*',JzDate=pd_JzDate,
           DataStatus='9'
     where BillNo=ps_BillNo; 
  end if; 
/*============ת�����ݵ���ʷ��================*/
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TVENDORRTN',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TVENDORRTNDTL',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;     
/*===============�ɹ�======================*/
  pi_Result:=1;
  ps_Message:='�ɹ��˻���Ϣ���ճɹ�';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'�ɹ��˻���Ϣ����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
    if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
    return;
  end; 
End Set_OrdTh;

--���ܣ�Shop�˻�������ռ���
procedure Set_OrdShopTh
  (ps_BillNo in tOrdJhHead.BillNo%type,    
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType, 
   pd_JzDate   IN  date, 
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  cursor CurHSC_GetIOData is
    select A.FSRCNUM as BillNo,B.LINE as SerialNo,B.FARTICLECODE as PluCode,
           '0' as PluType,B.FREALQTY as ThCount,null as Remark
      from WM_MIS_TSTORERTN A,WM_MIS_TSTORERTNDTL B
     where A.NUM=B.NUM and A.FSRCNUM=ps_BillNo
       for update;
  
  cursor CurHSC_CheckOrdTh is
    select '�ŵ��˻�('||ps_BillNo||')�����ڻ��Ѽ���!'
      from tOrdThHead
     where BillNo=ps_BillNo
       and TjDate is not null
       and JzDate is null
       for update;     
  cursor CurHSC_CheckThCount is 
    select '�ŵ��˻�('||ps_BillNo||')��Ϣ����ʧ��:��Ʒ'||A.FARTICLECODE||'��ʵ���˻�����'||
           to_char(A.FREALQTY)||'���������ԭ�����˻�����'||to_char(B.ThCount)
      from WM_MIS_TSTORERTNDTL A, tOrdThBody B,WM_MIS_TSTORERTN C
     where A.NUM=C.NUM
       and C.FSRCNUM=ps_BillNo
       and C.FSRCNUM=B.BillNo
       and A.LINE=B.SerialNo
       and A.FQTY>B.ThCount;
     
  vs_YwType   tOrdJhHead.YwType%type;
  vs_IoHasRec varchar2(1);
  vs_IsAllZero   varchar2(1);
Begin
/*==========��ʼ������==================*/  
  pi_Result:=-1;
  ps_Message:='�ŵ��˻�('||ps_BillNo||')��Ϣ����ʧ��:��ʼ������';
  vs_YwType:='0912'; 

/*==========�Ϸ����ж�==================*/  
/*  Sys_CheckData(Ps_BillNo,'WM_MIS_TSTORERTNDTL',ps_BillNo,'tOrdThBody',pi_Result,ps_Message);  
  if pi_Result<>1 then return; end if;
  pi_Result:=-1; */
  
  ps_Message:='�ŵ��˻�('||ps_BillNo||')��Ϣ����ʧ��:�ŵ굥�����ڻ��Ѽ���!';
  if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
  open CurHSC_CheckOrdTh;
  fetch CurHSC_CheckOrdTh into ps_Message;
  if CurHSC_CheckOrdTh%notfound then
    if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
    return;
  end if;
  if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
  
  ps_Message:='�ŵ��˻�('||ps_BillNo||')��Ϣ����ʧ��:��Ʒʵ���˻��������������ԭ�����˻�����';
  if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
  open CurHSC_CheckThCount;
  fetch CurHSC_CheckThCount into ps_Message;
  if CurHSC_CheckThCount%found then
    if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
    return;
  end if;
  if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
  
/*==========�����ŵ��˻�����ϸʧ��==================*/  
  ps_Message:='�ŵ��˻�('||ps_BillNo||')��Ϣ����ʧ��:�����ŵ��˻�����ϸ��������!';
  vs_IoHasRec:='0';
  vs_IsAllZero:='1';
  for vr_B in CurHSC_GetIOData 
  Loop    
    if vr_B.ThCount<>0 then
      vs_IsAllZero:='0';
    end if; 
    vs_IoHasRec:='1';       
    update tOrdThBody B
       set (PluCode,ThCount,HCost,WCost,JTaxTotal,STotal,CjTotal,CjRate,Remark,
            B.PackCount,SglCount)=
           (select vr_B.PluCode,vr_B.ThCount,
             Round(vr_B.ThCount*B.HJPrice,2),--Host
             Case When P.JTaxCalType='0' then--WHost
                    Round(Round(B.HJPrice*vr_B.ThCount,2)/(1+B.JTaxRate/100),2)
                  Else Round(Round(B.HJPrice*vr_B.ThCount,2)*(1-B.JTaxRate/100),2)
                  End,
             Round(vr_B.ThCount*B.HJPrice,2)- Case When P.JTaxCalType='0' then --JTaxTotal
                    Round(Round(B.HJPrice*vr_B.ThCount,2)/(1+B.JTaxRate/100),2)
                  Else Round(Round(B.HJPrice*vr_B.ThCount,2)*(1-B.JTaxRate/100),2)
                  End,
             Round(vr_B.ThCount*B.Price,2),--STotal
             Round(vr_B.ThCount*B.Price,2)-Round(vr_B.ThCount*B.HJPrice,2),--CjTotal
             case when (B.Price*vr_B.ThCount=0) or ((B.Price*vr_B.ThCount-B.HjPrice*vr_B.ThCount)=0) then
                       0
                  else
                    Round(((B.Price-B.HjPrice)/B.Price)*100,2)
                  end, 
                          
             vr_B.Remark,
            (case when B.PackQty<=0 or B.PackQty=1 then 0 
                  else Floor(vr_B.ThCount/B.PackQty) end) As PackCount,
            (case when B.PackQty<=0 or B.PackQty=1 then vr_B.ThCount
                  else vr_B.ThCount-Floor(vr_B.ThCount/B.PackQty)*B.PackQty 
             end) As SglCount
            from tSkuPlu P
           where P.PluId=B.PluId)
     where BillNo=vr_B.Billno and SerialNo=vr_B.SerialNo;
  End Loop;
  
  if vs_IoHasRec='0' then--��ʾ�ӿڱ�û������
    ps_Message:='�ŵ��˻�('||ps_BillNo||')��Ϣ����ʧ��:�ŵ��˻���"'||ps_BillNo||'"�ڽӿڱ��в�����'; 
    return;
  end if;
  
/*==========�����ŵ��˻�������ʧ��==================*/  
  ps_Message:='�ŵ��˻�('||ps_BillNo||')����ʧ�ܣ������ŵ��˻�������ĺϼ�����ʧ�ܣ�';  
    update tOrdThHead
       set (ThCount,HCost,WCost,JTaxTotal,STotal,CjTotal)=
           (select sum(ThCount),sum(HCost),sum(WCost),
                  sum(JTaxTotal),sum(STotal),sum(CjTotal)
              from tOrdThBody 
             where BillNo=ps_BillNo)
     where BillNo=ps_BillNo;
 /*==========�ŵ��˻�������==================*/ 
   if vs_IsAllZero='0' then  
    update tOrdThHead 
       set TjrID=0,TjrCode='',
           TjrName='',TjDate=null,
           DataStatus='0'
     where BillNo=ps_BillNo; 
     
    --�˻�������
    sStk_Commit_Th_ORA(ps_BillNo,vs_YwType,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
                                pd_JzDate,pi_Result,ps_Message);
    if pi_Result<>1 then     
      ps_Message:='�ŵ��˻�('||ps_BillNo||')��Ϣ���մ���ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;      
      return; 
    end if;    
  else
    update tOrdThHead 
       set JzrId=0,JzrCode='*',JzrName='*',JzDate=pd_JzDate,
           DataStatus='9'
     where BillNo=ps_BillNo; 
  end if; 
/*\*============ת�����ݵ���ʷ��================*\
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TSTORERTN',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  pi_Result:=-1;    */
/*===============�ɹ�======================*/
  pi_Result:=1;
  ps_Message:='�ŵ��˻���Ϣ���ճɹ�';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'�ŵ��˻���Ϣ����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
    if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
    return;
  end; 
End Set_OrdShopTh;

--���ܣ�Dst������ռ���
procedure Set_DstPs
  (ps_BillNo in tOrdJhHead.BillNo%type,    
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType, 
   pd_JzDate   IN  date, 
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  cursor CurHSC_GetIOData is
    select FSRCNUM as BillNo,LINE as SerialNo,FARTICLECODE as PluCode,
           FQTY as PsCount,'0' as PluType
      from WM_MIS_TALCNTCDTL
     where FSRCNUM='P'||ps_BillNo
       for update;
       
  cursor CurHSC_CheckPsCount is 
    select '���͵���ϸ��Ϣ����ʧ��:��Ʒ'||A.Farticlecode||'��ʵ����������'||
           to_char(A.FQty)||'���������ԭ������������'||to_char(B.PsCount)
      from WM_MIS_TALCNTCDTL A, tDstPsBody B
     where A.FSRCNUM='P'||ps_BillNo
       and A.FSRCNUM='P'||B.BillNo
       and A.LINE=B.SerialNo
       and A.FQTY>B.PsCount;
       
  cursor CurHSC_CheckDstPs is
    select PsType,'���͵�('||ps_BillNo||')�����ڻ��Ѽ���!'
      from tDstPsHead 
     where BillNo=ps_BillNo
       --and TjDate is not null
       and JzDate is null 
       for update ; 
       
  vs_YwType   tDstPsHead.YwType%type;
  vs_IoHasRec varchar2(1);
  vs_IsAllZero   varchar2(1);
  vs_PsType   tDstPsHead.Pstype%type;
Begin
  pi_Result:=-1;
  ps_Message:='���͵���ϸ��Ϣ����ʧ��';
  vs_YwType:='2003';

/*==========�Ϸ����ж�==================*/    
/*  Sys_CheckData(Ps_BillNo,'WM_MIS_TALCNTCDTL',ps_BillNo,'tDstPsBody',pi_Result,ps_Message);  
  if pi_Result<>1 then return; end if;
  pi_Result:=-1; */
  
  ps_Message:='���͵���ϸ��Ϣ����ʧ��: ���͵�'||ps_BillNo||'�����ڻ��Ѽ���!';
  if CurHSC_CheckDstPs%isopen then close CurHSC_CheckDstPs; end if;
  open CurHSC_CheckDstPs;
  fetch CurHSC_CheckDstPs into vs_PsType,ps_Message;
  if CurHSC_CheckDstPs%notfound then
    if CurHSC_CheckDstPs%isopen then close CurHSC_CheckDstPs; end if;
    return;
  end if;
  if CurHSC_CheckDstPs%isopen then close CurHSC_CheckDstPs; end if;
  
  ps_Message:='���͵���ϸ��Ϣ����ʧ��:��Ʒʵ���˻��������������ԭ������������';
  if CurHSC_CheckPsCount%isopen then close CurHSC_CheckPsCount; end if;
  open CurHSC_CheckPsCount;
  fetch CurHSC_CheckPsCount into ps_Message;
  if CurHSC_CheckPsCount%found then
    if CurHSC_CheckPsCount%isopen then close CurHSC_CheckPsCount; end if;
    return;
  end if;
  if CurHSC_CheckPsCount%isopen then close CurHSC_CheckPsCount; end if;
  
  if vs_PsType='1' then vs_YwType:='2007'; end if;
/*==========�������͵���ϸʧ��==================*/
  ps_Message:='���͵���ϸ��Ϣ����ʧ��:�������͵���ϸ��������!';
  vs_IoHasRec:='0';
  vs_IsAllZero:='1';
  
  ----���δ�ش������¼Ϊ0
  update tDstPsBody A
     set PsCount        = 0,
         PsTotal        = 0,
         WPsTotal       = 0,
         XTaxTotal      = 0,
         STotal         = 0,
         PackCount      = 0,
         SglCount       = 0,
         StlCurrPsTotal = 0
   where Not Exists (select 1
            from WM_MIS_TALCNTCDTL
           where Fsrcnum = 'P'|| A.BillNo
             and Line = A.Serialno)
     and A.BillNo=ps_BillNo;        
  ----
  
  for vr_B in CurHSC_GetIOData 
  Loop    
    if vr_B.Pscount<>0 then
      vs_IsAllZero:='0';
    end if;
    vs_IoHasRec:='1';
    update tDstpsBody B
       set (PsCount,PsTotal,WPsTotal,XTaxTotal,STotal,Remark,PackCount,SglCount,stlcurrpsprice,stlcurrpstotal)=
           (select vr_B.PsCount,--vr_B.PsTotal,vr_B.WPsTotal,vr_B.XTaxTotal,vr_B.STotal,
                   Round(vr_B.PsCount*B.PsPrice,2),--PsTotal
                   Case When P.JTaxCalType='0' then--WPsTotal
                          Round(Round(B.PsPrice*vr_B.PsCount,2)/(1+B.XTaxRate/100),2)
                        Else Round(Round(B.PsPrice*vr_B.PsCount,2)*(1-B.XTaxRate/100),2)
                        End,
                   Round(vr_B.PsCount*B.PsPrice,2)- Case When P.JTaxCalType='0' then --XTaxTotal
                          Round(Round(B.PsPrice*vr_B.PsCount,2)/(1+B.XTaxRate/100),2)
                        Else Round(Round(B.PsPrice*vr_B.PsCount,2)*(1-B.XTaxRate/100),2)
                        End,
                   Round(vr_B.PsCount*B.Price,2),--STotal                   
                   null,
                   (case when B.PackQty<=0 or B.PackQty=1 then 0 
                         else Floor(vr_B.PsCount/B.PackQty) end) As PackCount,
                   (case when B.PackQty<=0 or B.PackQty=1 then vr_B.PsCount
                         else vr_B.PsCount-Floor(vr_B.PsCount/B.PackQty)*B.PackQty end) As SglCount,
                   psprice,Round(vr_B.PsCount*B.PsPrice,2)        
              from tSkuPlu P
             where P.PluId=B.PluId)
     where BillNo=ps_BillNo and SerialNo=vr_B.SerialNo;    
  End Loop;
  if  vs_IoHasRec='0' then
    ps_Message:='���͵���ϸ��Ϣ����ʧ��:���͵�"'||ps_BillNo||'"�ڽ������ݱ��в�����'; 
    return;
  end if;
/*==========�������͵�����ʧ��==================*/  
  ps_Message:='���͵���ϸ��Ϣ����ʧ�ܣ��������͵�����ĺϼ�����ʧ�ܣ�';  
  update tDstPsHead
     set (PsTotal,PsCount,WPsTotal,XTaxTotal,STotal,stlcurrpstotal)=
         (select sum(PsTotal),sum(PsCount),sum(WPsTotal),
                 sum(XTaxTotal),sum(STotal),sum(stlcurrpstotal)
            from tDstpsBody 
           where BillNo=ps_BillNo)
   where BillNo=ps_BillNo;

/*============���͵�����================*/    
  if vs_IsAllZero='0' then      
    update tDstPsHead 
       set TjrID=0,TjrCode='',
           TjrName='',TjDate=null,
           DataStatus='0'
     where BillNo=ps_BillNo; 
     
    sStk_Commit_PsXs_ORA(ps_BillNo,vs_YwType,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
                              pd_JzDate,pi_Result,ps_Message);
    if pi_Result<>1 then 
      ps_Message:='����('||ps_BillNo||')��Ϣ���մ���ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;      
      return;
    end if;    
  else
    update tDstPsHead 
       set JzrId=0,JzrCode='*',JzrName='*',JzDate=pd_JzDate,
           DataStatus='9'
     where BillNo=ps_BillNo; 
    delete from Tstklskclock where Ywbillno=ps_BillNo and ywtype=vs_YwType; 
  end if;   
/*============ת�����ݵ���ʷ��================*/
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TALCNTC',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TALCNTCDTL',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
/*===============�ɹ�======================*/
  pi_Result:=1;
  ps_Message:='���͵���ϸ��Ϣ���ճɹ�';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'���͵���Ϣ����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_CheckPsCount%isopen then close CurHSC_CheckPsCount; end if;
    if CurHSC_CheckDstPs%isopen then close CurHSC_CheckDstPs; end if;
    return;
  end; 
End Set_DstPs;

--���ܣ�WSL������ռ���
procedure Set_WslXs
  (ps_BillNo in tOrdJhHead.BillNo%type,    
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType, 
   pd_JzDate   IN  date, 
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  cursor CurHSC_GetIOData is
    select FSRCNUM as BillNo,LINE as SerialNo,FARTICLECODE as PluCode,
           FQTY as PfCount,'0' as PluType
      from WM_MIS_TALCNTCDTL
     where FSRCNUM=ps_BillNo
       for update;
       
  cursor CurHSC_CheckPfCount is 
    select '��������ϸ��Ϣ����ʧ��:��Ʒ'||A.Farticlecode||'��ʵ����������'||
           to_char(A.FQty)||'���������ԭ������������'||to_char(B.PfCount)
      from WM_MIS_TALCNTCDTL A, tWslXsBody B
     where A.FSRCNUM=ps_BillNo
       and A.FSRCNUM=B.BillNo
       and A.LINE=B.SerialNo
       and A.FQTY>B.PfCount;
       
  cursor CurHSC_CheckDstPs is
    select '������('||ps_BillNo||')�����ڻ��Ѽ���!'
      from tWslXsHead 
     where BillNo=ps_BillNo
       and TjDate is not null
       and JzDate is null 
       for update ; 
       
  vs_YwType   tDstPsHead.YwType%type;
  vs_IoHasRec varchar2(1);
  vs_IsAllZero   varchar2(1);
Begin
  pi_Result:=-1;
  ps_Message:='��������ϸ��Ϣ����ʧ��';
  vs_YwType:='1601';

/*==========�Ϸ����ж�==================*/    
/*  Sys_CheckData(Ps_BillNo,'WM_MIS_TALCNTCDTL',ps_BillNo,'tWslXsBody',pi_Result,ps_Message);  
  if pi_Result<>1 then return; end if;
  pi_Result:=-1; */
  
  ps_Message:='��������ϸ��Ϣ����ʧ��: �����������ڻ��Ѽ���!';
  if CurHSC_CheckDstPs%isopen then close CurHSC_CheckDstPs; end if;
  open CurHSC_CheckDstPs;
  fetch CurHSC_CheckDstPs into ps_Message;
  if CurHSC_CheckDstPs%notfound then
    if CurHSC_CheckDstPs%isopen then close CurHSC_CheckDstPs; end if;
    return;
  end if;
  if CurHSC_CheckDstPs%isopen then close CurHSC_CheckDstPs; end if;
  
  ps_Message:='��������ϸ��Ϣ����ʧ��:��Ʒʵ�ʳ����������������ԭ������������';
  if CurHSC_CheckPfCount%isopen then close CurHSC_CheckPfCount; end if;
  open CurHSC_CheckPfCount;
  fetch CurHSC_CheckPfCount into ps_Message;
  if CurHSC_CheckPfCount%found then
    if CurHSC_CheckPfCount%isopen then close CurHSC_CheckPfCount; end if;
    return;
  end if;
  if CurHSC_CheckPfCount%isopen then close CurHSC_CheckPfCount; end if;
  
/*==========������������ϸʧ��==================*/
  ps_Message:='��������ϸ��Ϣ����ʧ��:������������ϸ��������!';
  vs_IoHasRec:='0';
  vs_IsAllZero:='1';
  for vr_B in CurHSC_GetIOData 
  Loop    
    if vr_B.Pfcount<>0 then
      vs_IsAllZero:='0';
    end if;
    vs_IoHasRec:='1';
    update tWslXsBody B
       set (PfCount,YsTotal,SsTotal,XTaxTotal,Remark,PackCount,SglCount)=
           (select vr_B.PfCount,--vr_B.PsTotal,vr_B.WPsTotal,vr_B.XTaxTotal,vr_B.STotal,
                   Round(vr_B.PfCount*B.PfPrice,2),--PsTotal
                   Round(vr_B.PfCount*B.PfPrice,2),--PsTotal
                  /* Case When P.JTaxCalType='0' then--WPsTotal
                          Round(Round(B.PfPrice*vr_B.PfCount,2)/(1+B.XTaxRate/100),2)
                        Else Round(Round(B.PfPrice*vr_B.PfCount,2)*(1-B.XTaxRate/100),2)
                        End,*/
                   Round(vr_B.PfCount*B.PfPrice,2)- Case When P.JTaxCalType='0' then --XTaxTotal
                          Round(Round(B.PfPrice*vr_B.PfCount,2)/(1+B.XTaxRate/100),2)
                        Else Round(Round(B.PfPrice*vr_B.PfCount,2)*(1-B.XTaxRate/100),2)
                        End,
                   --Round(vr_B.PfCount*B.Price,2),--STotal                   
                   null,
                   (case when B.PackQty<=0 or B.PackQty=1 then 0 
                         else Floor(vr_B.PfCount/B.PackQty) end) As PackCount,
                   (case when B.PackQty<=0 or B.PackQty=1 then vr_B.PfCount
                         else vr_B.PfCount-Floor(vr_B.PfCount/B.PackQty)*B.PackQty end) As SglCount
              from tSkuPlu P
             where P.PluId=B.PluId)
     where BillNo=vr_B.Billno and SerialNo=vr_B.SerialNo;    
  End Loop;
  if  vs_IoHasRec='0' then
    ps_Message:='��������ϸ��Ϣ����ʧ��:������"'||ps_BillNo||'"�ڽ������ݱ��в�����'; 
    return;
  end if;
/*==========��������������ʧ��==================*/  
  ps_Message:='��������ϸ��Ϣ����ʧ�ܣ���������������ĺϼ�����ʧ�ܣ�';  
  update tWslXsHead
     set (PfTotal,SsTotal,PfCount,XTaxTotal)=
         (select sum(PfTotal),sum(SsTotal),
                 sum(PfCount),sum(XTaxTotal)
            from tWslXsBody 
           where BillNo=ps_BillNo)
   where BillNo=ps_BillNo;

/*============����������================*/    
  if vs_IsAllZero='0' then      
    update tWslXsHead 
       set TjrID=0,TjrCode='',
           TjrName='',TjDate=null,
           DataStatus='0'
     where BillNo=ps_BillNo; 
     
    sStk_Commit_PsXs_ORA(ps_BillNo,vs_YwType,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
                              pd_JzDate,pi_Result,ps_Message);
    if pi_Result<>1 then 
      ps_Message:='����('||ps_BillNo||')��Ϣ���մ���ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;      
      return;
    end if;    
  else
    update tWslXsHead 
       set JzrId=0,JzrCode='*',JzrName='*',JzDate=pd_JzDate,
           DataStatus='9'
     where BillNo=ps_BillNo; 
    delete from Tstklskclock where Ywbillno=ps_BillNo and ywtype=vs_YwType; 
  end if;   
/*============ת�����ݵ���ʷ��================*/
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TALCNTC',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TALCNTCDTL',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
/*===============�ɹ�======================*/
  pi_Result:=1;
  ps_Message:='��������ϸ��Ϣ���ճɹ�';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'��������Ϣ����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_CheckPfCount%isopen then close CurHSC_CheckPfCount; end if;
    if CurHSC_CheckDstPs%isopen then close CurHSC_CheckDstPs; end if;
    return;
  end; 
End Set_WslXs;

--���ܣ�Rtn������ռ���
procedure Set_PstRtn
  (ps_BillNo in tOrdJhHead.BillNo%type,    
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType, 
   pd_JzDate   IN  date, 
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
    --20131227
/*  cursor CurHSC_GetIOData is
    select A.FSRCNUM as BillNo,B.LINE as SerialNo,B.FARTICLECODE as PluCode,
           '0' as PluType,B.FREALQTY as ThCount,null as Remark
      from WM_MIS_TSTORERTN A,WM_MIS_TSTORERTNDTL B
     where A.NUM=B.NUM and A.FSRCNUM=ps_BillNo
       for update;*/
  
  cursor CurHSC_CheckOrdTh is
    select '�����˻�('||ps_BillNo||')�����ڻ��Ѽ���!'
      from tDstRtnHead
     where BillNo=ps_BillNo
       and TjDate is not null
       and JzDate is null
       for update;     
    --20131227
/*  cursor CurHSC_CheckThCount is 
    select '�����˻�('||ps_BillNo||')��Ϣ����ʧ��:��Ʒ'||A.FARTICLECODE||'��ʵ���˻�����'||
           to_char(A.FREALQTY)||'���������ԭ�����˻�����'||to_char(B.ThCount)
      from WM_MIS_TSTORERTNDTL A, tDstRtnBody B,WM_MIS_TSTORERTN C
     where A.NUM=C.NUM
       and C.FSRCNUM=ps_BillNo
       and C.FSRCNUM=B.BillNo
       and A.LINE=B.SerialNo
       and A.FQTY>B.ThCount;
   
  cursor CurHSC_RtnBody is 
    select serialNo,ThCount,ThTotal,WthTotal
      from tDstRtnBody
     where BillNo = ps_BillNo;
       
  cursor CurHSC_PcYw is 
    select serialNo,RecCount,HCost,WCost
      from Tstklspcyw
     where BillNo = ps_BillNo
    order by jhdate asc;*/
      
  vs_YwType   tOrdJhHead.YwType%type;
  vs_IoHasRec varchar2(1);
  vs_IsAllZero   varchar2(1);
Begin
  --20131227
/*\*==========��ʼ������==================*\  
  pi_Result:=-1;
  ps_Message:='�����˻�('||ps_BillNo||')��Ϣ����ʧ��:��ʼ������';
  vs_YwType:='2004'; 

\*==========�Ϸ����ж�==================*\  
\*  Sys_CheckData(Ps_BillNo,'WM_MIS_TSTORERTNDTL',ps_BillNo,'tOrdThBody',pi_Result,ps_Message);  
  if pi_Result<>1 then return; end if;
  pi_Result:=-1; *\
  
  ps_Message:='�����˻�('||ps_BillNo||')��Ϣ����ʧ��:�����˻��������ڻ��Ѽ���!';
  if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
  open CurHSC_CheckOrdTh;
  fetch CurHSC_CheckOrdTh into ps_Message;
  if CurHSC_CheckOrdTh%notfound then
    if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
    return;
  end if;
  if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
  
  ps_Message:='�����˻�('||ps_BillNo||')��Ϣ����ʧ��:��Ʒʵ���˻��������������ԭ�����˻�����';
  if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
  open CurHSC_CheckThCount;
  fetch CurHSC_CheckThCount into ps_Message;
  if CurHSC_CheckThCount%found then
    if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
    return;
  end if;
  if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;
  
\*==========�����ŵ��˻�����ϸʧ��==================*\  
  ps_Message:='�����˻�('||ps_BillNo||')��Ϣ����ʧ��:���������˻�����ϸ��������!';
  vs_IoHasRec:='0';
  vs_IsAllZero:='1';
  for vr_B in CurHSC_GetIOData 
  Loop    
    if vr_B.ThCount<>0 then
      vs_IsAllZero:='0';
    end if; 
    vs_IoHasRec:='1';       
    update tDstRtnBody B
       set (B.ThCount,B.Thtotal,B.Wthtotal,B.Xtaxtotal,B.Stotal,B.Stlcurrthtotal,
            B.PackCount,B.SglCount)=
           (select vr_B.ThCount,Round(vr_B.ThCount*B.ThPrice,2),--Thtotal
             Round(Round(vr_B.ThCount*B.ThPrice,2)/(1+B.XTAXRATE/100.0),2),--wThTotal
             Round(vr_B.ThCount*B.ThPrice,2)-Round(Round(vr_B.ThCount*B.ThPrice,2)/(1+B.XTAXRATE/100.0),2),--Xtaxtotal
             Round(vr_B.ThCount*B.Price,2),--STotal
             Round(vr_B.ThCount*B.ThPrice,2),--Stlcurrthtotal
            (case when B.PackQty<=0 or B.PackQty=1 then 0 
                  else Floor(vr_B.ThCount/B.PackQty) end) As PackCount,
            (case when B.PackQty<=0 or B.PackQty=1 then vr_B.ThCount
                  else vr_B.ThCount-Floor(vr_B.ThCount/B.PackQty)*B.PackQty 
             end) As SglCount
            from tSkuPlu P
           where P.PluId=B.PluId)
     where BillNo=vr_B.Billno and SerialNo=vr_B.SerialNo;
  End Loop;
  
  for vr_B in CurHSC_RtnBody loop
    for vr_PcYw in CurHSC_PcYw loop
      if vr_B.Thcount<=vr_PcYw.Reccount then 
        update tStkLspcYw
           set Reccount = vr_B.Thcount,
               HCost   =
               (vr_B.Thcount / vr_PcYw.Reccount) * HCost,
               WCost   =
               (vr_B.Thcount / vr_PcYw.Reccount) * WCost
         where SerialNo = vr_PcYw.Serialno;
        vr_B.Thcount:=0; 
      else
        vr_B.Thcount:=vr_B.Thcount-vr_PcYw.Reccount;   
      end if;  
    end loop;  
  end loop;
  
  if vs_IoHasRec='0' then--��ʾ�ӿڱ�û������
    ps_Message:='�����˻�('||ps_BillNo||')��Ϣ����ʧ��:�����˻���"'||ps_BillNo||'"�ڽӿڱ��в�����'; 
    return;
  end if;
\*==========�����ŵ��˻�������ʧ��==================*\  
  ps_Message:='�����˻�('||ps_BillNo||')����ʧ�ܣ����������˻�������ĺϼ�����ʧ�ܣ�';  
    update tDstRtnHead
       set (ThCount,Thtotal,Wthtotal,Xtaxtotal,Stotal,Stlcurrthtotal)=
           (select sum(ThCount),sum(Thtotal),sum(Wthtotal),
                  sum(Xtaxtotal),sum(Stotal),sum(Stlcurrthtotal)
              from tDstRtnBody 
             where BillNo=ps_BillNo)
     where BillNo=ps_BillNo;
 \*==========�ŵ��˻�������==================*\ 
   if vs_IsAllZero='0' then  
    update tDstRtnHead 
       set TjrID=0,TjrCode='',
           TjrName='',TjDate=null,
           DataStatus='0'
     where BillNo=ps_BillNo; 
 
    --�˻�������
    sStk_Commit_PsTh_ORA(ps_BillNo,vs_YwType,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
                                pd_JzDate,pi_Result,ps_Message);
    if pi_Result<>1 then     
      ps_Message:='�����˻�('||ps_BillNo||')��Ϣ���մ���ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;      
      return; 
    end if;    
  else
    update tDstRtnHead 
       set JzrId=0,JzrCode='*',JzrName='*',JzDate=pd_JzDate,
           DataStatus='9'
     where BillNo=ps_BillNo; 
  end if; */
  
/*==========��ʼ������==================*/  
  pi_Result:=-1;
  ps_Message:='�����˻�('||ps_BillNo||')��Ϣ����ʧ��:��ʼ������';
  vs_YwType:='2004'; 

/*==========�Ϸ����ж�==================*/  
/*  Sys_CheckData(Ps_BillNo,'WM_MIS_TSTORERTNDTL',ps_BillNo,'tOrdThBody',pi_Result,ps_Message);  
  if pi_Result<>1 then return; end if;
  pi_Result:=-1; */
  
  ps_Message:='�����˻�('||ps_BillNo||')��Ϣ����ʧ��:�����˻��������ڻ��Ѽ���!';
  if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
  open CurHSC_CheckOrdTh;
  fetch CurHSC_CheckOrdTh into ps_Message;
  if CurHSC_CheckOrdTh%notfound then
    if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
    return;
  end if;
  if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
  --�˻�������
  update tDstRtnHead set Tjdate= null where BillNo=ps_BillNo;
  sStk_Commit_PsTh_ORA(ps_BillNo,vs_YwType,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
                              pd_JzDate,pi_Result,ps_Message);
  if pi_Result<>1 then     
    ps_Message:='�����˻�('||ps_BillNo||')��Ϣ���մ���ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;      
    return; 
  end if;    

/*============ת�����ݵ���ʷ��================*/
  IO_MovHis(ps_BillNo,'WM_MIS_TSTORERTN',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  pi_Result:=-1;

  pi_Result:=1;
  ps_Message:='�����˻���Ϣ���ճɹ�';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'�����˻���Ϣ����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    /*if CurHSC_CheckThCount%isopen then close CurHSC_CheckThCount; end if;*/
    if CurHSC_CheckOrdTh%isopen then close CurHSC_CheckOrdTh; end if;
    return;
  end; 
End Set_PstRtn;   

--���ܣ����������ռ���
procedure Set_StkBs
  (ps_BillNo in tOrdJhHead.BillNo%type,    
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType, 
   pd_JzDate   IN  date, 
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  cursor CurHSC_IOData is
    select NUM as BillNo,FPSN as CkCode
      from WM_MIS_TDECINVDTL
     where NUM=ps_BillNo
       for update;
  vs_BillNo  Tordjhhead.BillNo%type;
  vs_CkCode  Tordjhhead.CkCode%type;
  
  Cursor Cur_BsBody is
  Select NUM as BillNo,'ZB' as OrgCode,(select orgName from tOrgManage where OrgCode='ZB') as OrgName,
         (select DepId from tOrgDept where OrgCode='ZB' and IsLast='1' and IsYw='1' and IsActive='1' and rownum=1) as depid,
         (select DepCode from tOrgDept where OrgCode='ZB' and IsLast='1' and IsYw='1' and IsActive='1' and rownum=1) as depCode,
         (select DepName from tOrgDept where OrgCode='ZB' and IsLast='1' and IsYw='1' and IsActive='1' and rownum=1) as depName,
         (select Pluid from tSkuPlu where PluCode=FARTICLECODE and IsActive='1'),FARTICLECODE as Plucode,
         (select PluName from tSkuPlu where PluCode=FARTICLECODE) as Pluname,FQty as Bscount
    from WM_MIS_TDECINVDTL 
   where NUM=ps_BillNo
     and FQTY>0;
  Rec_BsBody Cur_BsBody%rowtype;
  
  --��ȡ��֯�ֿ� ��ȡ�����ڱ��������Ĳֿ�
  cursor Cur_Ck(sCkCode tStkStore.CkCode%type) is
    select CkCode,CkName 
      from tStkStore
     where OrgCode='0001'
       and CkCode=sCkCode;
  Rec_Ck  Cur_Ck%rowtype;
        
  cursor Cur_Dep is 
    select DepId,DepCode,DepName 
      from tOrgDept 
     where OrgCode='0001';
  vr_Dep       Cur_Dep%rowtype;
  
  vs_PdBillNo  Tcouykjzhead.Billno%type;
  curDyn          sys_refcursor;
  vs_PluCode   tSkuPlu.PluCode%type;
  vs_PluName   tSkuPlu.PluName%type;
  vi_Count     integer;
  
  vi_userid    tusruser.userid%type;
  vs_username  tusruser.username%type;
  iRowNum number(19):=0;
Begin
/*=================��ʼ������================*/   
  pi_Result:=-1;
  ps_Message:='����������ʧ��!'; 
/*=================�ж����ݲ�����(for update)================*/  
  ps_Message:='����������ʧ��:������'||ps_BillNo||'������';
  if CurHSC_IOData%IsOpen then Close CurHSC_IOData; end if;
  open CurHSC_IOData;
  fetch CurHSC_IOData into vs_BillNo,vs_CkCode;
  if CurHSC_IOData%notFound then
    if CurHSC_IOData%IsOpen then Close CurHSC_IOData; end if;  
    return;
  end if;  
  if CurHSC_IOData%IsOpen then Close CurHSC_IOData; end if;  
  
  if Cur_BsBody%IsOpen then Close Cur_BsBody; end if;
  open Cur_BsBody;
  fetch Cur_BsBody into Rec_BsBody;
  close Cur_BsBody;
  if Cur_BsBody%IsOpen then Close Cur_BsBody; end if;  
  
  --��ƷУ��
  open curDyn for 
    select M.PluCode
      from (select A.FARTICLECODE as PluCode,
                   nvl((select 1
                         from tSkuPlu
                        where PluCode = A.FARTICLECODE
                          and isActive = '1'),
                       0) as IsPlu
              from WM_MIS_TDECINVDTL A
             where A.NUM = ps_BillNo) M
     where IsPlu = 0;
  fetch curDyn into vs_PluCode;
  if curDyn%Found then 
    ps_Message:='��Ʒ'||vs_PluCode||'�����ڻ���ʧЧ';
  end if;
  close curDyn;  
  
  --��ȡһ�������ֿ�
  open Cur_Ck(vs_CkCode);
  fetch Cur_Ck into Rec_Ck;
  if Cur_Ck%Notfound then
    ps_Message:='�ֿ����ô���';
    return;
  end if;
  close Cur_Ck;
  
  open Cur_Dep;
  fetch Cur_Dep into vr_Dep;
  if Cur_Dep%Notfound then
    ps_Message:='�������ô���';
    return;
  end if;
  close Cur_Dep;
    
  select userid, userName
    into vi_userid, vs_username
    from tusruser
   where usercode = '0000';
  
  sSysGetBillNo('1902',vs_PdBillNo);
  if vs_PdBillNo='*' or vs_PdBillNo is null then
    ps_Message:='�����̵㵥�ĵ��ݺ�ʧ�ܣ�';
    return;
  end if;  
  --���������̵㵥����
  ps_Message:='���������̵㵥������ʧ�ܣ�';
  insert into tCouLsPdHead(BILLNO,LRDATE,USERID,USERCODE,USERNAME,ORGCODE,ORGNAME,CKCODE,
    CKNAME,PDSTARTDATE,PDTOTALDATE,YWTYPE,BILLTYPE,INORGCODE,REMARK,YKTYPE,CVSPDBILLNO)
   values (vs_PdBillNo,sysdate,vi_userid,'0000',vs_username,'ZB',
         Rec_BsBody.Orgname,Rec_Ck.CkCode,Rec_Ck.Ckname,sysdate,sysdate,'1902','3','0001',
         ps_BillNo||'�Զ�����','1','');
  --���������̵㵥��ϸ��
  ps_Message :='���������̵㵥��ϸ��ʧ��';
  insert into tCouLsPdBody(BILLNO,SERIALNO,PLUID,PLUCODE,PLUNAME,BARCODE,UNIT,SPEC,
    ZMCOUNT,YKCOUNT,SJCOUNT,YKRATE,HZDATE,YKREASON,DEPID,DEPCODE,DEPNAME,ZMHCOST,ZMWCOST,
    ZMSCOST,SJHCOST,SJWCOST,SJSCOST,YKHCOST,YKWCOST,YKSCOST,PRICE,WJPRICE,HJPRICE,Kccount)
  select vs_PdBillNo,rownum,C.PluId,C.PluCode,C.PluName,C.BarCode,C.Unit,C.Spec,
    PSTK_DB.fStk_LsXsKcFlag_ORA(B.OrgCode,vr_Dep.DepId,rec_Ck.Ckcode,B.PluId,'') as ZmCount,
    -A.FQTY as YkCount,
    PSTK_DB.fStk_LsXsKcFlag_ORA(B.OrgCode,vr_Dep.DepId,rec_Ck.Ckcode,B.PluId,'')-A.FQTY as SjCount,
    0,sysdate,'0',vr_Dep.DepId,vr_Dep.DepCode,vr_Dep.DepName,0,0,
    round(PSTK_DB.fStk_LsXsKcFlag_ORA(B.OrgCode,B.DepId,rec_Ck.Ckcode,B.PluId,'')*B.Price,2) as ZMSCOST,
    0,0,0,0,0,round(-A.FQty*B.Price,2) as YkSCost,B.Price,0,0,
    PSTK_DB.fStk_LsXsKcFlag_ORA(B.OrgCode,B.DepId,rec_Ck.Ckcode,B.PluId,'')
    from WM_MIS_TDECINVDTL A ,tSkuPluEx B,tSkuPlu C
   where A.NUM=ps_BillNo and B.OrgCode='0001' 
     and B.PluId=C.PluId and A.FARTICLECODE=C.Plucode;

   --���㺬˰���ۡ���˰����
   update tCouLsPdBody A
      set (A.HJPrice,A.WJPrice)=
      (select round(sum(HCost)/sum(KcCount),2) as HJPrice,
              round(sum(WCost)/sum(KcCount),2) as WJPrice
         from tStkLsKc B
        where B.OrgCode='0001'
          and B.CkCode=rec_ck.ckcode
          and B.DepId=A.DepId
          and B.PluId=A.PluId
          and B.Plutype='0'
          and B.KcCount>0)
     where A.BillNo=vs_PdBillNo;
    --�������� ��ӯ�� ��ʵ�̺�˰��˰���
   update tCouLsPdBody
      set ZmHCost=nvl(round(HJPrice*ZmCount,2),0),
          ZmWCost=nvl(round(WJPrice*ZmCount,2),0),
          YkHCost=nvl(round(HJPrice*YkCount,2),0),
          YkWCost=nvl(round(WJPrice*YkCount,2),0),
          SjHCost=nvl(round(HJPrice*ZmCount,2),0)+nvl(round(HJPrice*YkCount,2),0),
          SjWCost=nvl(round(WJPrice*ZmCount,2),0)+nvl(round(WJPrice*YkCount,2),0),
          SjSCost=ZmSCost+YkSCost,
          YkRate=case when ((ZmCount=0) or ((ZmCount<>0) and (abs(YkCount / ZmCount * 100) > 100 ))) then
                        (case when YkCount > 0 then 1 else -1 end)
                      else YkCount / ZmCount * 100 end
    where BillNo=vs_PdBillNo;
      
    --������ϸ������Ʒ�Ŀ�λ������Ϣ
   Update tCouLsPdBody B
      set KwCode = (select S.KwCode
                      from tStkCkKwPluSet S, tCouLsPdHead H
                     where H.BillNo = ps_BillNo
                       and S.OrgCode = Pub_Db.GetInOrgCode(H.ORGCODE)
                       and S.Ckcode = H.Ckcode
                       and S.PluID = B.PLUID
                       and Pub_Db.GetCkType(Pub_Db.GetInOrgCode(H.ORGCODE),
                                            H.Ckcode) = '1')
    where B.BillNo = vs_PdBillNo;
    --�޸ı�ͷ���
    update tCouLsPdHead A
       set (A.ZMCOUNT,A.ZMHCOST,A.ZMWCOST,A.ZMSCOST,A.SJCOUNT,A.SJHCOST,A.SJWCOST,
           A.SJSCOST,A.YKCOUNT,A.YKHCOST,A.YKWCOST,A.YKSCOST)=
      (select sum(B.ZMCOUNT) as ZMCOUNT,sum(B.ZMHCOST) as ZMHCOST,sum(B.ZMWCOST) as ZMWCOST,
              sum(B.ZMSCOST) as ZMSCOST,sum(B.SJCOUNT) as SJCOUNT,sum(B.SJHCOST) as SJHCOST,
              sum(B.SJWCOST) as SJWCOST,sum(B.SJSCOST) as SJSCOST,sum(B.YKCOUNT) as YKCOUNT,
              sum(B.YKHCOST) as YKHCOST,sum(B.YKWCOST) as YKWCOST,sum(B.YKSCOST) as YKSCOST
         from tCouLsPdBody B
        where B.BillNo=vs_PdBillNo)
     where A.BillNo=vs_PdBillNo;
    --�޸�ӯ������
    update tCouLsPdHead
       set YkRate=case when ((ZmCount=0) or ((ZmCount<>0) and (abs(YkCount / ZmCount * 100) > 100 ))) then
                     (case when YkCount > 0 then 1 else -1 end)
                  else YkCount / ZmCount * 100 end
     where BillNo=vs_PdBillNo;
    
   --ӯ��������
   PSSY_DB.sStk_LetsGo_ORA(vs_PdBillNo,'1902',vi_userid,'0000',vs_username,
                             sysdate,pi_Result,ps_Message);
   if pi_Result<>1 then
     pi_Result:=-1;
     return;
   end if;
/*=================ת�����ݵ���ʷ��================*/
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TDECINV',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TDECINVDTL',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  
/*=================�ɹ�================*/   
  pi_Result:=1;
  ps_Message:='���������ճɹ�!';
Exception when others then
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'����������ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_IOData%IsOpen then Close CurHSC_IOData; end if;
    return;
  end; 
End Set_StkBs;

--���ܣ�By������ռ���
procedure Set_StkBy
  (ps_BillNo in tOrdJhHead.BillNo%type,    
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType, 
   pd_JzDate   IN  date, 
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  cursor CurHSC_IOData is
    select NUM as BillNo,FPSN as CkCode
      from WM_MIS_TINCINVDTL
     where NUM=ps_BillNo
       for update;
  vs_BillNo  Tordjhhead.BillNo%type;
  vs_CkCode  Tordjhhead.Ckcode%type;
  
  Cursor Cur_BsBody is
  Select NUM as BillNo,'ZB' as OrgCode,(select orgName from tOrgManage where OrgCode='ZB') as OrgName,
         (select DepId from tOrgDept where OrgCode='ZB' and IsLast='1' and IsYw='1' and IsActive='1' and rownum=1) as depid,
         (select DepCode from tOrgDept where OrgCode='ZB' and IsLast='1' and IsYw='1' and IsActive='1' and rownum=1) as depCode,
         (select DepName from tOrgDept where OrgCode='ZB' and IsLast='1' and IsYw='1' and IsActive='1' and rownum=1) as depName,
         (select Pluid from tSkuPlu where PluCode=FARTICLECODE and IsActive='1'),FARTICLECODE as Plucode,
         (select PluName from tSkuPlu where PluCode=FARTICLECODE) as Pluname,FQty as Bscount
    from WM_MIS_TINCINVDTL 
   where NUM=ps_BillNo
     and FQTY>0;
  Rec_BsBody Cur_BsBody%rowtype;
  
  --��ȡ��֯�ֿ� ��ȡ�����ڱ��������Ĳֿ�
  cursor Cur_Ck(sCkCode tStkStore.CkCode%type) is
    select CkCode,CkName 
      from tStkStore
     where OrgCode='0001'
       and CkCode=sCkCode;
  Rec_Ck  Cur_Ck%rowtype;
        
  cursor Cur_Dep is 
    select DepId,DepCode,DepName 
      from tOrgDept 
     where OrgCode='0001';
  vr_Dep       Cur_Dep%rowtype;
  
  vs_PdBillNo  Tcouykjzhead.Billno%type;
  curDyn          sys_refcursor;
  vs_PluCode   tSkuPlu.PluCode%type;
  vs_PluName   tSkuPlu.PluName%type;
  vi_Count     integer;
  
  vi_userid    tusruser.userid%type;
  vs_username  tusruser.username%type;
  iRowNum number(19):=0;
Begin
/*=================��ʼ������================*/   
  pi_Result:=-1;
  ps_Message:='����������ʧ��!'; 
/*=================�ж����ݲ�����(for update)================*/  
  ps_Message:='����������ʧ��:������'||ps_BillNo||'������';
  if CurHSC_IOData%IsOpen then Close CurHSC_IOData; end if;
  open CurHSC_IOData;
  fetch CurHSC_IOData into vs_BillNo,vs_CkCode;
  if CurHSC_IOData%notFound then
    if CurHSC_IOData%IsOpen then Close CurHSC_IOData; end if;  
    return;
  end if;  
  if CurHSC_IOData%IsOpen then Close CurHSC_IOData; end if;  

  if Cur_BsBody%IsOpen then Close Cur_BsBody; end if;
  open Cur_BsBody;
  fetch Cur_BsBody into Rec_BsBody;
  close Cur_BsBody;
  if Cur_BsBody%IsOpen then Close Cur_BsBody; end if;  
  
  --��ƷУ��
  open curDyn for 
    select M.PluCode
      from (select A.FARTICLECODE as PluCode,
                   nvl((select 1
                         from tSkuPlu
                        where PluCode = A.FARTICLECODE
                          and isActive = '1'),
                       0) as IsPlu
              from WM_MIS_TINCINVDTL A
             where A.NUM = ps_BillNo) M
     where IsPlu = 0;
  fetch curDyn into vs_PluCode;
  if curDyn%Found then 
    ps_Message:='��Ʒ'||vs_PluCode||'�����ڻ���ʧЧ';
  end if;
  close curDyn;  
  
  --��ȡһ�������ֿ�
  open Cur_Ck(vs_CkCode);
  fetch Cur_Ck into Rec_Ck;
  if Cur_Ck%Notfound then
    ps_Message:='�ֿ����ô���';
    return;
  end if;
  close Cur_Ck;
  
  open Cur_Dep;
  fetch Cur_Dep into vr_Dep;
  if Cur_Dep%Notfound then
    ps_Message:='�������ô���';
    return;
  end if;
  close Cur_Dep;
    
  select userid, userName
    into vi_userid, vs_username
    from tusruser
   where usercode = '0000';
  
  sSysGetBillNo('1902',vs_PdBillNo);
  if vs_PdBillNo='*' or vs_PdBillNo is null then
    ps_Message:='�����̵㵥�ĵ��ݺ�ʧ�ܣ�';
    return;
  end if;  
  --���������̵㵥����
  ps_Message:='���������̵㵥������ʧ�ܣ�';
  insert into tCouLsPdHead(BILLNO,LRDATE,USERID,USERCODE,USERNAME,ORGCODE,ORGNAME,CKCODE,
    CKNAME,PDSTARTDATE,PDTOTALDATE,YWTYPE,BILLTYPE,INORGCODE,REMARK,YKTYPE,CVSPDBILLNO)
   values (vs_PdBillNo,sysdate,vi_userid,'0000',vs_username,'ZB',
         Rec_BsBody.Orgname,vs_CkCode,Rec_Ck.Ckname,sysdate,sysdate,'1902','3','0001',
         ps_BillNo||'�Զ�����','2','');
  --���������̵㵥��ϸ��
  ps_Message :='���������̵㵥��ϸ��ʧ��';
  insert into tCouLsPdBody(BILLNO,SERIALNO,PLUID,PLUCODE,PLUNAME,BARCODE,UNIT,SPEC,
    ZMCOUNT,YKCOUNT,SJCOUNT,YKRATE,HZDATE,YKREASON,DEPID,DEPCODE,DEPNAME,ZMHCOST,ZMWCOST,
    ZMSCOST,SJHCOST,SJWCOST,SJSCOST,YKHCOST,YKWCOST,YKSCOST,PRICE,WJPRICE,HJPRICE,Kccount)
  select vs_PdBillNo,rownum,C.PluId,C.PluCode,C.PluName,C.BarCode,C.Unit,C.Spec,
    PSTK_DB.fStk_LsXsKcFlag_ORA(B.OrgCode,vr_Dep.DepId,vs_CkCode,B.PluId,'') as ZmCount,
    A.FQTY as YkCount,
    PSTK_DB.fStk_LsXsKcFlag_ORA(B.OrgCode,vr_Dep.DepId,vs_CkCode,B.PluId,'')+A.FQTY as SjCount,
    0,sysdate,'0',B.DepId,vr_Dep.DepCode,vr_Dep.DepName,0,0,
    round(PSTK_DB.fStk_LsXsKcFlag_ORA(B.OrgCode,B.DepId,vs_CkCode,B.PluId,'')*B.Price,2) as ZMSCOST,
    0,0,0,0,0,round(A.FQty*B.Price,2) as YkSCost,B.Price,0,0,
    PSTK_DB.fStk_LsXsKcFlag_ORA(B.OrgCode,B.DepId,vs_CkCode,B.PluId,'')
    from WM_MIS_TINCINVDTL A ,tSkuPluEx B,tSkuPlu C
   where A.NUM=ps_BillNo and B.OrgCode='0001' 
     and B.PluId=C.PluId and A.FARTICLECODE=C.Plucode;

   --���㺬˰���ۡ���˰����
   update tCouLsPdBody A
      set (A.HJPrice,A.WJPrice)=
      (select round(sum(HCost)/sum(KcCount),2) as HJPrice,
              round(sum(WCost)/sum(KcCount),2) as WJPrice
         from tStkLsKc B
        where B.OrgCode='0001'
          and B.CkCode=vs_CkCode
          and B.DepId=A.DepId
          and B.PluId=A.PluId
          and B.Plutype='0'
          and B.KcCount>0)
     where A.BillNo=vs_PdBillNo;
    --�������� ��ӯ�� ��ʵ�̺�˰��˰���
   update tCouLsPdBody
      set ZmHCost=nvl(round(HJPrice*ZmCount,2),0),
          ZmWCost=nvl(round(WJPrice*ZmCount,2),0),
          YkHCost=nvl(round(HJPrice*YkCount,2),0),
          YkWCost=nvl(round(WJPrice*YkCount,2),0),
          SjHCost=nvl(round(HJPrice*ZmCount,2),0)+nvl(round(HJPrice*YkCount,2),0),
          SjWCost=nvl(round(WJPrice*ZmCount,2),0)+nvl(round(WJPrice*YkCount,2),0),
          SjSCost=ZmSCost+YkSCost,
          YkRate=case when ((ZmCount=0) or ((ZmCount<>0) and (abs(YkCount / ZmCount * 100) > 100 ))) then
                        (case when YkCount > 0 then 1 else -1 end)
                      else YkCount / ZmCount * 100 end
    where BillNo=vs_PdBillNo;
      
    --������ϸ������Ʒ�Ŀ�λ������Ϣ
   Update tCouLsPdBody B
      set KwCode = (select S.KwCode
                      from tStkCkKwPluSet S, tCouLsPdHead H
                     where H.BillNo = ps_BillNo
                       and S.OrgCode = Pub_Db.GetInOrgCode(H.ORGCODE)
                       and S.Ckcode = H.Ckcode
                       and S.PluID = B.PLUID
                       and Pub_Db.GetCkType(Pub_Db.GetInOrgCode(H.ORGCODE),
                                            H.Ckcode) = '1')
    where B.BillNo = vs_PdBillNo;
    --�޸ı�ͷ���
    update tCouLsPdHead A
       set (A.ZMCOUNT,A.ZMHCOST,A.ZMWCOST,A.ZMSCOST,A.SJCOUNT,A.SJHCOST,A.SJWCOST,
           A.SJSCOST,A.YKCOUNT,A.YKHCOST,A.YKWCOST,A.YKSCOST)=
      (select sum(B.ZMCOUNT) as ZMCOUNT,sum(B.ZMHCOST) as ZMHCOST,sum(B.ZMWCOST) as ZMWCOST,
              sum(B.ZMSCOST) as ZMSCOST,sum(B.SJCOUNT) as SJCOUNT,sum(B.SJHCOST) as SJHCOST,
              sum(B.SJWCOST) as SJWCOST,sum(B.SJSCOST) as SJSCOST,sum(B.YKCOUNT) as YKCOUNT,
              sum(B.YKHCOST) as YKHCOST,sum(B.YKWCOST) as YKWCOST,sum(B.YKSCOST) as YKSCOST
         from tCouLsPdBody B
        where B.BillNo=vs_PdBillNo)
     where A.BillNo=vs_PdBillNo;
    --�޸�ӯ������
    update tCouLsPdHead
       set YkRate=case when ((ZmCount=0) or ((ZmCount<>0) and (abs(YkCount / ZmCount * 100) > 100 ))) then
                     (case when YkCount > 0 then 1 else -1 end)
                  else YkCount / ZmCount * 100 end
     where BillNo=vs_PdBillNo;
    
   --ӯ��������
   PSSY_DB.sStk_LetsGo_ORA(vs_PdBillNo,'1902',vi_userid,'0000',vs_username,
                             sysdate,pi_Result,ps_Message);
   if pi_Result<>1 then
     pi_Result:=-1;
     return;
   end if;
/*=================ת�����ݵ���ʷ��================*/
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TINCINV',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'WM_MIS_TINCINVDTL',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;   
  
/*=================�ɹ�================*/   
  pi_Result:=1;
  ps_Message:='���������ճɹ�!';
Exception when others then
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'����������ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_IOData%IsOpen then Close CurHSC_IOData; end if;
    return;
  end; 
End Set_StkBy;

--���ܣ������ƿ������ռ���
procedure Set_StkYk
  (ps_BillNo in tStkYkHead.BillNo%type,    
   pr_User      PHSCWMS_VAR.P_UsrUser_RecType,  
   pd_JzDate   IN  date, 
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  Cursor CurHSC_GetIOData is 
    select BillNo,SerialNo,PluCode,YkCount,
           OldCkCode,NewCkCode,PluType
      from IO_tStkYk
     where BillNo=ps_BillNo
       for update;
  
  Cursor CurHSC_GetCk(ms_OrgCode tStkStore.OrgCode%type) is 
    select OldCkCode,B.CkName as OldCkname,A.NewCkCode,C.CkName as NewCkName           
      from IO_tStkYk A,tStkStore B,tStkStore C
     where BillNo=ps_BillNo
       and A.OldCkCode=B.CkCode and B.OrgCode=ms_OrgCode
       and A.NewCkCode=C.Ckcode and C.OrgCode=ms_OrgCode      
       and rownum=1;
  vr_Plu      PHSCWMS_VAR.P_OutPlu_RecType;    --�������Ʒ��Ϣ          
  vr_Ck       CurHSC_GetCk%rowtype;  
  vi_YkCount    tStkYkHead.YkCount%type;
   
  vs_OrgName    tOrgManage.OrgName%type;
  vs_InOrgCode  tOrgManage.InOrgCode%type;
  vs_OrgCode    tOrgManage.OrgCode%type;
  vs_IoHasRec   varchar2(1);
  vs_IsAllZero   varchar2(1);
Begin
/*===============��ʼ������ʧ��======================*/
  pi_Result:=-1;
  ps_Message:='�����ƿ���Ϣ����ʧ��';

/*===============ȡ���ܲ���Ϣ======================*/
  ps_Message:='�����ƿ���Ϣ����ʧ��:ȡ���ܲ���Ϣʧ��';  
  select OrgCode,OrgName,InOrgCode into vs_OrgCode,vs_OrgName,vs_InOrgCode from tOrgManage where OrgType='1001';
/*===============���ݻ��������ѯ======================*/
  if PSTO.IsExistsData('select 1 as MyData from tStkYkHead
                         where BillNo='''||ps_BillNo||''' for update') then
    ps_Message:='�����ƿ���Ϣ����ʧ��:�ƿⵥ'||ps_BillNo||'�Ѵ���';
    return;
  end if;
   
  if PSTO.IsExistsData('select 1 as MyData from IO_tStkYk
                         where BillNo='''||ps_BillNo||''''||
                         ' and OldCkCode=NewCkCode') then
    ps_Message:='�����ƿ���Ϣ����ʧ��:����ֿⲻ����ͬ��';
    return;
  end if;
  
  if PSTO.IsExistsData('select 1 as MyData from (
                         select 1 from IO_tStkYk
                         where BillNo='''||ps_BillNo||''''||
                       ' group by OldCkCode,NewCkCode)
                        having count(1)>1 ') then
    ps_Message:='�����ƿ���Ϣ����ʧ��:�ƿⵥ�д��ڶ����������ƿ⣡';
    return;
  end if;
/*===============�����ƿⵥ��ϸ����======================*/
  ps_Message:='�����ƿ���Ϣ����ʧ��:���������ƿⵥ����ϸ��������';
  vs_IoHasRec:='0';
  vs_IsAllZero:='1';
  for vr_B in CurHSC_GetIOData
  Loop
    if vr_B.Ykcount<>0 then
      vs_IsAllZero:='0';
    end if;
    vs_IoHasRec:='1';
    pi_Result:=-1;
    SysGet_PluCode_Plu(vr_B.PluCode,vr_Plu,pi_Result,ps_Message);
    if pi_Result<>1 then return; end if;
    pi_Result:=-1;    
    insert into tStkYkBody(BillNo,PluId,ExPluCode,ExPluName,PluCode,
                PluName,BarCode,Spec,Unit,PackUnit,PackQty,PackCount,
                SglCount,YkCount,PluType,Remark,SerialNo,PcGUID,PcNo,Price)
         select ps_BillNo,vr_Plu.PluID,'*',null,vr_B.PluCode,
                vr_Plu.PluName,vr_Plu.BarCode,vr_Plu.Spec,vr_Plu.Unit,'',0,0,
                vr_B.YkCount, vr_B.YkCount,'4','',vr_B.Serialno,'*','*',
                nvl((select Price from tSkuPluEx where PluId=vr_Plu.PluID and rownum=1),0)
           from dual;
  End Loop;
  if vs_IoHasRec='0' then
    ps_Message:='�����ƿ���Ϣ����ʧ��:�ƿⵥ"'||ps_BillNo||'"�ڽ������ݱ��в�����';
    return;
  end if;
  if vs_IsAllZero='1' then  
    ps_Message:='�����ƿ���Ϣ����ʧ��:�ƿⵥ"'||ps_BillNo||'"�ڽ������ݱ����ƿ�����ȫΪ0������';
    return;
  end if;
/*===============�����ƿⵥ������======================*/
  ps_Message:='�����ƿ���Ϣ����ʧ��:���������ƿⵥ������������';
  if CurHSC_GetCk%IsOpen then Close CurHSC_GetCk; end if;
  open CurHSC_GetCk(vs_InOrgCode);
  fetch CurHSC_GetCk into vr_Ck;
  if CurHSC_GetCk%notFound then
    if CurHSC_GetCk%IsOpen then Close CurHSC_GetCk; end if; 
    return;
  end if;  
  if CurHSC_GetCk%IsOpen then Close CurHSC_GetCk; end if; 
 
  select sum(YkCount) into vi_YkCount from tStkYkBody where BillNo=ps_BillNo;
   
  insert into tStkYkHead(BillNo,LrDate,UserID,UserCode,UserName,
         JzType,GenType,EmpID,EmpCode,EmpName,OrgCode,OrgName,
         OldCkCode,OldCkName,NewCkCode,NewCkName,YkCount,Remark,
         IsPcNo,InOrgCode,IsNeedTjWl,DataStatus,YwType)
  values(ps_BillNo,sysdate,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
         '1','1',pr_User.UserId,pr_User.UserCode,pr_User.UserName,vs_OrgCode,
         vs_OrgName, vr_Ck.OldCkCode,vr_Ck.OldCkName,vr_Ck.NewCkCode,
         vr_Ck.NewCkName,vi_YkCount,'�����ӿڽ����Զ����ɵ��ƿⵥ','0',
         vs_InOrgCode,'0','0','1808');
         
/*===============����ϸ������Ʒ�Ŀ�λ������Ϣ======================*/
  ps_Message:='�����ƿ���Ϣ����ʧ��:����ϸ������Ʒ�Ŀ�λ������Ϣ��������'; 
  Update tStkYkBody B
     set OutKwCode = (select S.KwCode
                        from tStkCkKwPluSet S
                       where S.OrgCode = vs_InOrgCode
                         and S.Ckcode = vr_Ck.OldCkCode
                         and S.PluID = B.PLUID
                         and Pub_Db.GetCkType(vs_InOrgCode, vr_Ck.OldCkCode) = '1'),
         InKwCode  = (select S.KwCode
                        from tStkCkKwPluSet S
                       where S.OrgCode = vs_InOrgCode
                         and S.Ckcode = vr_Ck.NewCkCode
                         and S.PluID = B.PLUID
                         and Pub_Db.GetCkType(vs_InOrgCode, vr_Ck.NewCkCode) = '1')
   where B.BillNo = ps_BillNo;
   
/*=================���������ƿⵥ=================*/
  sStk_Commit_LsYk_ORA(ps_BillNo,'1808',pr_User.UserId,pr_User.UserCode,pr_User.UserName,
         pd_JzDate,pi_Result,ps_Message);
  if pi_Result<>1 then
    ps_Message:='�����ƿ�('||ps_BillNo||')��Ϣ����ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;    
    return;
  end if;   
        
/*============ת�����ݵ���ʷ��================*/
  pi_Result:=-1;
  IO_MovHis(ps_BillNo,'IO_tStkYk',pi_Result,ps_Message);
  if pi_Result<>1 then return; end if;       
/*===============�ɹ�======================*/
  pi_Result:=1;
  ps_Message:='�����ƿ���Ϣ���ճɹ�';
Exception
  When Others then 
  begin    
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'�����ƿ���Ϣ����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if CurHSC_GetCk%IsOpen then Close CurHSC_GetCk; end if;
    return;
  end;
End Set_StkYk;

--���ܣ��̵������ռ���
/*procedure Set_StkCou
  (ps_BillNo   in tOrdCgHead.BillNo%type,   
   pr_User     PHSCWMS_VAR.P_UsrUser_RecType,  
   pd_JzDate   IN  date,   
   pi_Result   Out integer,
   ps_Message  Out varchar2)
Is
  vd_BgnDate   date:=sysdate-20;
  vd_EndDate   date:=sysdate+1;
  vs_OrgCode   tOrgManage.OrgCode%type;
  vs_InOrgCode tOrgManage.InOrgCode%type;
  vc_Data      sys_refcursor;
  cursor Cur_GetPdData_B is
    select A.BillNo,A.OrgCode,A.CkCode,A.PluCode,A.SerialNo,A.PluType,
           (select C.BillNo from IO_tStkLsKcPlu_Temp C 
             where C.OrgCode=A.OrgCode and C.CkCode=A.CkCode
               and rownum=1) As PdBillNo_Def,
           (select D.BillNo from IO_tStkLsKcPlu_Temp D 
             where D.OrgCode=A.OrgCode and D.CkCode=A.CkCode
               and D.PluCode=A.PluCode and rownum=1) As PdBillNo,
           B.PluName
      from IO_tStkKc A,tSkuPlu B
     where A.BillNo=ps_BillNo and A.PluCode=B.PluCode
       and B.IsActive='1'
       for update of A.PdBillNo;
       
\*    select A.BillNo,A.OrgCode,A.CkCode,A.PluCode,A.SerialNo,A.PluType,
           (select C.BillNo from IO_tStkLsKcPlu_Temp C 
             where C.OrgCode=A.OrgCode and C.CkCode=A.CkCode
               and rownum=1) As PdBillNo_Def,
           (select D.BillNo from IO_tStkLsKcPlu_Temp D 
             where D.OrgCode=A.OrgCode and D.CkCode=A.CkCode
               and D.PluCode=A.PluCode and rownum=1) As PdBillNo,
           B.PluName
      from IO_tStkKc A,tSkuPlu B
     where A.BillNo=ps_BillNo and A.PluCode=B.PluCode
       and B.IsActive='1'
       for update of A.PdBillNo; *\
             
  cursor Cur_GetPdData_H is
    select A.OrgCode,A.CkCode,A.PdBillNo
      from IO_tStkKc A,tSkuPlu B
     where A.BillNo=ps_BillNo and A.PluCode=B.PluCode
       and B.IsActive='1'
     group by A.OrgCode,A.CkCode,A.PdBillNo;
     
  vs_BillNo   tCouLsPdHead.BillNo%type;  
  vs_YwType   tDstPsHead.YwType%type:='1906';
Begin
  pi_Result:=-1;
  ps_Message:='�̵���Ϣ����ʧ��';
  
\*================ȡ���ܲ���֯���ܲ���֯���ڲ���֯=====================*\ 
  ps_Message:='�̵���Ϣ����ʧ��:ȡ���ܲ���֯���ܲ���֯���ڲ���֯ʧ�ܡ�';
  select OrgCode,InOrgCode
    into vs_OrgCode,vs_InOrgCode
    from tOrgManage
   where OrgType='1001';    
\*================���޸ı�IO_tStkKc���е��ֶ�Ϊ�ڲ���֯=====================*\
  ps_Message:='�̵���Ϣ����ʧ��:�޸��̵���յ����ڲ���֯ʧ�ܡ�';
  update IO_tStkKc set OrgCode=vs_InOrgCode where BillNo=ps_BillNo;

\*================ȡ��������̵�����=====================*\  
  delete from IO_tStkLsKcPlu_Temp;
  insert into IO_tStkLsKcPlu_Temp(OrgCode,CkCode,PluCode,PluId,BillNo)
  select A.InOrgCode,A.CkCode,B.PluCode,B.PluId,max(A.BillNo) As BillNo
    from tCouLsPdHead A,tCouLsPdBody B,tSkuPluEx C
   where A.BillNo=B.BillNo and A.Coustatus in ('1','2')
     and A.LrDate between vd_BgnDate and vd_EndDate
     and A.InOrgCode=vs_InOrgCode and B.DepId=C.DepId
     and A.InOrgCode=C.OrgCode and B.PluId=C.PluId
   group by A.InOrgCode,A.CkCode,B.PluCode,B.PluId;

\*================Ϊ��������Ѱ�Һ��ʵ��̵㵥��====================*\    
  for vr_B in Cur_GetPdData_B
  Loop
    if vr_B.PdBillNo_Def is null then 
     ps_Message:='�ֿ�('||vr_B.CkCode||')�е���Ʒ('||vr_B.PluCode||'-'||vr_B.PluName||
                 ')δ�ҵ��κ��������������̵㵥����Ϣ���̵㵥('||ps_BillNo||')����ʧ�ܣ�';
     return;
    end if;
    
    update IO_tStkKc 
       set PdBillNo=nvl(vr_B.PdBillNo,vr_B.PdBillNo_Def)
     where BillNo=ps_BillNo and OrgCode=vr_B.OrgCode
       and CkCode=vr_B.CkCode and PluCode=vr_B.PluCode 
       and SerialNo=vr_B.SerialNo and PluType=vr_B.PluType;
  end Loop;

\*================����ʵ�����ݵ�������====================*\   
  for vr_H in Cur_GetPdData_H
  Loop
    --��������
    sSysGetBillNo(vs_YwType,vs_BillNo);
    if nvl(vs_BillNo,'*')='*' then return; end if;
    insert into tCouLsDataHead(BillNo,LrDate,UserID,UserCode,UserName,JzDate,JzrID,JzrCode,
           JzrName,RptDate,PrnTimes,PrnDate,OrgCode,OrgName,DeptId,DepCode,DepName,
           CkCode,CkName,PdTotalDate,YwType, BillType, DataStatus,InOrgCode, 
           PdBillNo,SpDataType,PdrID,PdrCode,PdrName,LyType)
    select vs_BillNo,pd_JzDate, pr_User.UserId, pr_User.UserCode,pr_User.UserName, null, 0, null,
           null,null,0,null,OrgCode,OrgName,DeptId,DepCode,DepName,
           CkCode,CkName,null,'1906', BillType, '0',InOrgCode,
           BillNo,'0',pr_User.UserId, pr_User.UserCode,pr_User.UserName,'1'
      from tCouLsPdHead
     where BillNo=vr_H.PdBillNo;  
     
    --������ϸ�� 
    insert all 
      into IO_tStkKcHis(LogTime,BillNo,PdBillNo,OrgCode,CkCode,PluCode,
           SerialNo,KcCount,HCost,WCost,PluType,PdCount)
    values(sysdate,ps_BillNo,vs_BillNo,vr_H.OrgCode,vr_H.CkCode,PluCode,
           SerialNo,KcCount,HCost,WCost,PluType,PdCount)
      into tCouLsData(BillNo,SerialNo,PdNo,SNo,DeptId,DepCode,DepName,
           PluID,PluCode,PluName,ExPluCode,ExPluName,BarCode,Unit,Spec,
           HwCode,PackUnit,PackQty,PackCount,SglCount,SjCount, OriginType)
    values(vs_BillNo,MyNum,'*',0,DepId,DepCode,DepName,PluId,PluCode,PluName,
           '*',null,BarCode,Unit,Spec,'*',null,0,0,PdCount,PdCount,'1')
    select rownum As MyNum, C.Depid,
           (select D.DepCode from tOrgDept D where D.DepId=C.DepId) As DepCode,
           (select E.Depname from tOrgDept E where E.DepId=C.DepId) As Depname,
            B.PluID,B.PluCode,B.PluName,B.BarCode,B.Unit,B.Spec,A.Serialno,
            A.KcCount,A.HCost,A.WCost,A.PluType,A.PdCount
      From IO_tStkKc A,tSkuPlu B,tSkuPluEx C
     Where A.BillNo=ps_BillNo and A.OrgCode = vr_H.OrgCode 
       and A.CkCode = vr_H.CkCode and A.PdBillNo=vr_H.PdBillNo 
        and A.PluCode=B.PluCode and B.IsActive='1' 
        and C.OrgCode=vr_H.OrgCode and B.PluId=C.PluId; 
    --ʵ�̵�����
    sCou_LsDataHeadJz_ORA('1906',vs_BillNo,pr_User.UserId,pr_User.UserCode,pr_User.UserName,
                          pd_JzDate,pi_Result,ps_Message);  
    if pi_Result<>1 then
      ps_Message:='�̵�('||ps_BillNo||')��Ϣ����ʧ��'||':����ʧ�ܡ�ԭ��:'||ps_Message;
      return;
    end if;
    pi_Result:=-1;
  end Loop;

\*================ɾ���Ѿ���ת������====================*\   
  delete from IO_tStkKc A
   where A.BillNo=ps_BillNo 
     and exists(select 1 from IO_tStkKcHis B
                 where B.BillNo=ps_BillNo 
                   and B.OrgCode=A.OrgCode
                   and B.CkCode=A.CkCode 
                   and B.PluCode=A.PluCode 
                   and B.SerialNo=A.SerialNo 
                   and B.PluType=A.PluType); 
                   
\*================���������Ʒ�����ڽ��ձ��У���ô��ʾʧ��====================*\   
  if vc_Data%isopen then close vc_Data; end if;
  open vc_Data for 
    select '��Ʒ('||PluCode||')Ϊ��Ч��Ʒ���޷������̵�����!' As Msg
      from IO_tStkKc
     where BillNo=ps_BillNo;
  fetch vc_Data into ps_Message;
  if vc_Data%found then 
    if vc_Data%isopen then close vc_Data; end if;
    return;
  end if;
  if vc_Data%isopen then close vc_Data; end if;
                     
  \*===============�ɹ�======================*\
  pi_Result:=1;
  ps_Message:='�̵���Ϣ���ճɹ�';
Exception
  When Others then 
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'�̵���Ϣ����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
    if vc_Data%isopen then close vc_Data; end if;
    return;
  end;
End Set_StkCou;*/

--���ܣ���¼�ӿ���־
procedure WriteIOLog(ps_ErrType IN varchar2,ps_ErrMeg IN varchar2)
Is
  pragma autonomous_transaction;
Begin
  insert into IO_tTrgLog(LOGTIME,ERRTYPE,ERRMEG)
  values(sysdate,ps_ErrType,substr(ps_ErrMeg,1,400));    
  commit;
Exception
  When Others then rollback;
End WriteIOLog;

procedure ReceWlBillData
    (ps_DataKey   IN  tSkuPlu.PluName%type,
     ps_DataType  IN  tSkuPlu.PluName%type,
     pi_UserId    IN  tOrdJhHead.UserId%type,
     pd_Date      IN  tOrdJhHead.JzDate%type,
     pi_Result    OUT integer,
     ps_Message   OUT varchar2)
Is
  vr_Usr  PHSCWMS_VAR.P_UsrUser_RecType; 
Begin
/*=================��ʼ������================*/ 
  pi_Result:=-1;
  ps_Message:='���ݽ��մ���ʧ��!';
/*=================�Ϸ����ж�================*/ 
  ps_Message:='���ݽ��մ���ʧ��:����ps_DataType��ֵ'||ps_DataType||'���Ϸ�!';
  if upper(ps_DataType) not in (upper('WM_MIS_TSTKNORD'),upper('WM_MIS_TALCNTC'),
          upper('WM_MIS_TSTORERTN'),upper('WM_MIS_TVENDORRTN'),
          upper('WM_MIS_TDECINV'),upper('WM_MIS_TINCINV'),
          upper('IO_tStkYk')) then 
    return;
  end if;  

  SysGet_Usr_Info(pi_UserId,vr_Usr,pi_Result,ps_Message);
  if pi_Result<>1 then
    return;
  end if;
  pi_Result:=-1;

  vr_Usr.UserId:=pi_UserId;
  vr_Usr.UserCode:='*';
  vr_Usr.UserName:='*';
  
/*=================���ս�����մ���================*/
  if upper(ps_DataType)=upper('WM_MIS_TSTKNORD') then     
    ps_Message:='���ս�����մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_OrdCg(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then  
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'0905','�ɹ����ս������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));      
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'0905','�ɹ����ս������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
    end if;
  end if;
  
/*=================�ɹ��˻�������մ���================*/
  if upper(ps_DataType)=upper('WM_MIS_TVENDORRTN') then 
    ps_Message:='�ɹ��˻�������մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_OrdTh(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then     
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'0914','�ɹ��˻�����',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'0914','�ɹ��˻�����',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
    end if;
  end if;  
  
/*=================���ͽ�����մ���================*/
  if upper(ps_DataType)=upper('WM_MIS_TALCNTC') then 
    ps_Message:='���ͽ�����մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_DstPs(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then 
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'2003','���ͽ������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'2003','���ͽ������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));     
    end if;
  end if;
  
/*=================Shop�˻�������մ���================*/
/*  if upper(ps_DataType)=upper('WM_MIS_TSTORERTN') then 
    ps_Message:='�ŵ��˻�������մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_OrdShopTh(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then     
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'0912','�ŵ��˻�����',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'0912','�ŵ��˻�����',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
    end if;
  end if;*/
  if upper(ps_DataType)=upper('WM_MIS_TSTORERTN') then 
    ps_Message:='�����˻�������մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_PstRtn(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then     
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'2004','�����˻�����',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'2004','�����˻�����',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
    end if;
  end if;  
/*=================BS������մ���================*/
  if upper(ps_DataType)=upper('WM_MIS_TDECINV') then 
    ps_Message:='�������������մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_StkBs(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then     
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'1902','�����������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'1902','�����������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
    end if;
  end if;  
  
/*=================BS������մ���================*/
  if upper(ps_DataType)=upper('WM_MIS_TINCINV') then 
    ps_Message:='�������������մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_StkBy(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then     
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'1902','�����������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'1902','�����������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
    end if;
  end if;    
/*=================�ƿ������մ���================*/
  if upper(ps_DataType)=upper('IO_tStkYk') then 
    ps_Message:='�ƿ������մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_StkYk(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then   
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'1808','�ƿ�������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));   
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'1808','�ƿ�������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000)); 
    end if;
  end if;
  /*=================�����˻�������մ���================*/
/*  if upper(ps_DataType)=upper('IO_tDstRtn') then 
    ps_Message:='�����˻�������մ���ʧ��:���ݺ�('||ps_DataKey||')';
    Set_PstRtn(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then       
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'2004','�����˻����',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'2004','�����˻����',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
    end if;
  end if;*/
  /*=================�̵������մ���================*/
/*  if upper(ps_DataType)=upper('IO_tStkKc') then 
    ps_Message:='�̵������մ���ʧ�ܣ�';
    --Set_StkCou(ps_DataKey,vr_Usr,pd_Date,pi_Result,ps_Message);    
    if pi_Result<>1 then  
      WriteIOCmpLog('1',sysdate,vr_Usr.UserId,'1906','�̵�������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));     
      return; 
    else
      WriteIOCmpLog('0',sysdate,vr_Usr.UserId,'1906','�̵�������',ps_DataKey,substr('('||ps_DataKey||')'||ps_Message,1,1000));
    end if;
  end if;*/
/*=================�ɹ�================*/   
  pi_Result:=1;
  ps_Message:='���ݽ��մ���ɹ�!';
Exception when others then
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'���ݽ��մ���ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
  end;   
End ReceWlBillData;

procedure GetWlBillData
    (ps_DataKey   IN  tSkuPlu.PluName%type,
     ps_DataType  IN  tSkuPlu.PluName%type,
     pc_OutRefCur Out   sys_refcursor,               --�����������ݼ�
     pi_Result    OUT integer,
     ps_Message   OUT varchar2)
Is
Begin
  /*=================��ʼ������================*/ 
  pi_Result:=-1;
  ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ������ҵ������('||ps_DataType||')�Ƿ���';
  /*=================�Ϸ����ж�================*/ 
  if upper(ps_DataType) not in (upper('IO_tSkuPlu'),upper('IO_tSkuMulBar'),
          upper('IO_tEtpSupplier'),upper('IO_tEtpCustomer'),upper('IO_tOrdCg'),
          upper('IO_tDstPs'),upper('IO_tDstRtn'),upper('IO_tOrdTh')
          ) then 
    return;
  end if;
  
  /*if pc_OutRefCur%isOpen then close pc_OutRefCur; end if;
  \*=================������Ʒ��Ϣ================*\
  if upper(ps_DataType)=upper('IO_tSkuPlu') then
    open pc_OutRefCur for 
      select PluCode,PluName,BarCode,Unit,Spec,PluWeight,PluHeight,PluLong,
             PluWidth,BzDays,ClsCode,HJPrice,JTaxRate,Price,XTaxRate,PackUnit,PackQty,
             PackSpec,PackWeight,PackHeight
        from IO_tSkuPlu
       where PluCode=ps_DataKey;
  end if; 
  
  \*=================������Ʒ��������Ϣ================*\
  if upper(ps_DataType)=upper('IO_tSkuMulBar') then
    open pc_OutRefCur for
      select LogId,PluCode,BarCode,NewBarCode,LogType
        from IO_tSkuMulBar
       where Logid=to_number(ps_DataKey);
  end if;
  
  \*=================���ع�Ӧ����Ϣ================*\
  if upper(ps_DataType)=upper('IO_tEtpSupplier') then
    open pc_OutRefCur for
      select EtpCode,EtpName,Address,Linkman,Telephone,Fax
        from IO_tEtpSupplier
       where EtpCode=ps_DataKey;
  end if;
  
  \*=================���ؿͻ���Ϣ================*\
  if upper(ps_DataType)=upper('IO_tEtpCustomer') then
    open pc_OutRefCur for
      select EtpCode,EtpName,Address,Linkman,Telephone,Fax
        from IO_tEtpCustomer
       where EtpCode=ps_DataKey;
  end if;
  
  \*=================���زɹ�����Ϣ================*\
  if upper(ps_DataType)=upper('IO_tOrdCg') then
    open pc_OutRefCur for
      select BillNo,SerialNo,ZdDate,YxDate,SupCode,PluCode,HJPrice,
             WJPrice,Price,JTaxRate,CgCount,HCost,WCost,JTaxTotal,STotal,
             PluType,Remark
        from IO_tOrdCg
       where BillNo=ps_DataKey;
  end if;
  
  \*=================���زɹ��˻�����Ϣ================*\
  if upper(ps_DataType)=upper('IO_tOrdTh') then
    open pc_OutRefCur for
      select BillNo,CkCode,SerialNo,SupCode,PluCode,PluType,
             HJPrice,WJPrice,JTaxRate,Price,ThCount,HCost,WCost,
             JTaxTotal,STotal,Remark,ThReason
        from IO_tOrdTh
       where BillNo=ps_DataKey;
  end if;
  
  \*=================�������͵���Ϣ================*\
  if upper(ps_DataType)=upper('IO_tDstPs') then
    open pc_OutRefCur for
      select BillNo,SerialNo,ShopCode,OrgType,PlnshDate,Datasource,PluCode,psPrice,
             PsTotal,psCount,PluType,WpsPrice,WpsTotal,XTaxRate,XTaxTotal,Price,
             STotal,Remark
        from IO_tDstPs
       where BillNo=ps_DataKey;
  end if;
  
  \*=================���������˻�����Ϣ================*\
  if upper(ps_DataType)=upper('IO_tDstRtn') then
    open pc_OutRefCur for
      select sysdate,BillNo,SerialNo,ShopCode,PlnThDate,PluCode,ThPrice,ThCount,
             ThTotal,PluType,'' as ThReason,WThPrice,WThTotal,XTaxRate,XTaxTotal,
             Price,STotal,Remark
        from IO_tDstRtn
       where BillNo=ps_DataKey;
  end if;
*/
/*=================�ɹ�================*/   
  pi_Result:=1;
  ps_Message:='���ݼ����سɹ�!';
Exception when others then
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'���ݼ�����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
  end;    
End GetWlBillData;

--���ܣ�ͨ���˷����������ݼ�     
procedure GetWlBillDataKeys
    (ps_Tbn       IN  varchar2,
     pc_OutRefCur Out   sys_refcursor,               --�����������ݼ�
     pi_Result    OUT integer,
     ps_Message   OUT varchar2)
Is
  vs_SQL       varchar2(2000);
  vs_SQLFiledName varchar2(255);
  vs_SQLOrderBy   varchar(200);
Begin
    /*=================��ʼ������================*/ 
  pi_Result:=-1;
  ps_Message:='�Ӻ���ϵͳ��������ʧ�ܣ����������('||ps_Tbn||')�Ƿ���';
  /*=================�Ϸ����ж�================*/ 
  if upper(ps_Tbn) not in (upper('IO_tSkuPlu'),upper('IO_tSkuMulBar'),
          upper('IO_tEtpSupplier'),upper('IO_tEtpCustomer'),upper('IO_tOrdCg'),
          upper('IO_tDstPs'),upper('IO_tDstRtn'),upper('IO_tOrdTh')
          ) then 
    return;
  end if; 
  
  select decode(upper(ps_Tbn),upper('IO_tSkuPlu'),'PluCode',upper('IO_tSkuMulBar'),'LogId',
                       upper('IO_tEtpSupplier'),'EtpCode',upper('IO_tEtpCustomer'),'EtpCode',
                       'BillNo') As FLDN
    into vs_SQLFiledName
    from dual;

  vs_SQL:= 'select '||vs_SQLFiledName
        ||' as Keys,count(1) as RowsCount from '||ps_Tbn||' group by '||vs_SQLFiledName;
           
  if upper(ps_Tbn)= upper('IO_tSkuMulBar') then
    vs_SQLOrderBy:=' order by LogID ';
  end if;
  
  
  vs_SQL := vs_SQL ||vs_SQLOrderBy;  
  open pc_OutRefCur for vs_SQL;
  
/*=================�ɹ�================*/   
  pi_Result:=1;
  ps_Message:='���ݼ����سɹ�!';
Exception when others then
  begin
    pi_Result:=-1;
    ps_Message:=substr(nvl(ps_Message,'���ݼ�����ʧ�ܣ�')||'����λ�ã�'||Sqlerrm,1,2000);
  end;   
     
End GetWlBillDataKeys;

--�ɴ��޸ĵ���״̬��
procedure UpdatBillState
     (ps_BillNo      IN    IO_tBillTranState.BillNo%type,
      ps_YwType      IN    IO_tBillTranState.Ywtype%type,
      ps_ReturnCode  IN    varchar2,
      ps_ReturnMsg   IN    IO_HscmpLog.Logmeg%type,
      ps_CallTag     IN    varchar2)
     -- pi_Result      OUT   integer,
     -- ps_Message     OUT   varchar2)
Is
   pragma autonomous_transaction;
  -- Cursor CurHSC_CheckBill is 
  --  select BillNo 
  --     from IO_tBIllTranState 
  --    where BillNo=ps_BillNo;
begin
--------------------��鵥���Ƿ����--------------------------
  --pi_Result = -1;
  --ps_Message = '����ĵ��ݺ�'||ps_billno||'�ڵ���״̬���в����ڣ�';
  --if CurHSC_CheckBill%isopen then close CurHSC_CheckBill; end if;
  --open CurHSC_CheckBill;
  --if CurHSC_CheckBill%notfound then
    --if CurHSC_CheckBill%isopen then close CurHSC_CheckBill; end if;
    --return;
  --end if;
  --if CurHSC_CheckBill%isopen then close CurHSC_CheckBill; end if;
    
  --���ͳɹ�����
  if ps_CallTag='01' then 
    --���͵�
    if ps_YwType='2003' then
       update IO_tBillTranState A
          set A.BillState='1',
              A.CmpState='1',A.CmpTime=sysdate,A.CmpMessage='�������м�ƽ̨�ɹ���'
        where A.Billno=ps_BillNo and A.Ywtype=ps_YwType;
    end if;
    --�ɹ���0902���ɹ��˻�0914�������˻�2004
    if ps_YwType in('0902','0914','2004') then
      update IO_tBillTranState A
         set A.BillState='2',
             A.CmpState='1',A.CmpTime=sysdate,A.CmpMessage='�������м�ƽ̨�ɹ���',
             A.PlatState='1',A.PlatTime=sysdate,A.PlatMessage='����������ϵͳ�ɹ���'
       where A.Billno=ps_BillNo and A.Ywtype=ps_YwType;
    end if;              
  end if;
  
  --����ʧ�ܵ��� 
  if ps_CallTag='02' then  
    --���͵�
    if ps_YwType='2003' then
       update IO_tBillTranState A
          set A.CmpState='2',A.CmpTime=sysdate,A.CmpMessage='�������м�ƽ̨ʧ�ܣ�ԭ��'||ps_ReturnMsg
        where A.Billno=ps_BillNo and A.Ywtype=ps_YwType;
    end if;    
    --�ɹ���0902���ɹ��˻�0914�������˻�2004
    if ps_YwType in('0902','0914','2004') then
       update IO_tBillTranState A
          set A.CmpState='2',A.CmpTime=sysdate,A.CmpMessage='����������ϵͳʧ�ܣ�ԭ��'||ps_ReturnMsg
        where A.Billno=ps_BillNo and A.Ywtype=ps_YwType;
    end if; 
  end if;
  
  --���˵���
  if ps_CallTag='03' then
  --���˳ɹ�����
     if ps_ReturnCode='01' then
        update IO_tBillTranState A
           set A.BillState='3',
               A.WlState='1',A.WlTime=sysdate,A.WlMessage='�����Ѿ��ɹ����أ�'
         where A.BillNo=ps_BillNo and A.Ywtype=ps_YwType;
     end if;
  --����ʧ�ܵ���
     if ps_ReturnCode='02' then
        update IO_tBillTranState A
           set A.WlState='2',A.WlTime=sysdate,A.WlMessage='���ݼ���ʧ�ܣ�ԭ��'||ps_ReturnMsg
         where A.Billno=ps_BillNo and A.Ywtype=ps_YwType;
     end if;
  end if;
  
  --���͵�����������ʱ����
  if ps_CallTag='04' then
     if ps_YwType='2003' then
   --�ɹ�����
        if ps_ReturnCode='01' then
           update IO_tBillTranState A
              set A.BillState='2',
                   A.PlatState='1',A.PlatTime=sysdate,A.PlatMessage='����������ϵͳ�ɹ���'
            where A.Billno=ps_BillNo and A.Ywtype=ps_YwType;
        end if;
   --ʧ�ܵ���
        if ps_ReturnCode='02' then
           update IO_tBillTranState A
              set A.PlatState='2',A.PlatTime=sysdate,A.PlatMessage='����������ϵͳʧ�ܣ�ԭ��'||ps_ReturnMsg
            where A.Billno=ps_BillNo and A.Ywtype=ps_YwType;
        end if;
    --��0����
       if ps_ReturnCode='03' then
          update IO_tBillTranState A
             set A.Billstate='4',
                 A.PlatState='3',A.PlatTime=sysdate,A.PlatMessage='ƽ̨��������ϸȫ����0����ҵ��ϵͳ',
                 A.Wlstate='0',A.Wltime=null,A.Wlmessage=''
           where A.Billno=ps_BillNo and A.Ywtype=ps_YwType;
        end if; 
     end if;
  end if;
  commit;
Exception
  When Others then rollback;
end UpdatBillState;

end PHSCWMS_DB;
