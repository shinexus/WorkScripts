USE [HSCSCM]
GO
/****** Object:  StoredProcedure [dbo].[sSCMGetCgData]    Script Date: 09/04/2013 15:31:59 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Batch submitted through debugger: SQLQuery12.sql|7|0|C:\Documents and Settings\Administrator\Local Settings\Temp\~vs120.sql
-- Batch submitted through debugger: SQLQuery4.sql|7|0|C:\Documents and Settings\Administrator\Local Settings\Temp\~vsF4.sql
-- Batch submitted through debugger: SQLQuery60.sql|0|0|C:\Documents and Settings\Administrator\Local Settings\Temp\~vs10E.sql
--USE [HSCSCM]
--GO
/****** Object:  StoredProcedure [dbo].[sSCMGetCgData]    Script Date: 09/16/2011 17:53:27 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER OFF
--GO


ALTER    PROCEDURE  [dbo].[sSCMGetCgData]
(
@ps_MisSysType varchar(10),--0表示海信纵横单店系统，1表示海信商定天下系统,2表示海信纵横配送系统,3表示海信商定天下百货版  
@ps_MisDbType varchar(10), --0表示SqlServer数据库；1表示Oracle数据库
@ps_MisDbName varchar(200), --数据库名称
@pi_Result   smallint output,        
@ps_Message  varchar(2000) output 
) as
  declare
    @i integer,
    @j integer,
    @k integer,
    @n integer,
    @vs_BillNo  varchar(20),
    @vs_CgHeadTable varchar(50),
    @vs_Sql     varchar(8000),
    @vs_Message varchar(1000)
begin
  set @pi_Result=-1
  create table #Tmp_sSCMGetCgData_BillNo(BillNo varchar(20) null)
  
  if (@ps_MisSysType='1')or(@ps_MisSysType='3')
  begin    
    if  @ps_MisDbType='0'
      set @vs_CgHeadTable='[TORDCGHEAD]'  
    else 
      set @vs_CgHeadTable='[VSCMORDCGHEAD]'   
    set @vs_Sql='
insert into #Tmp_sSCMGetCgData_BillNo(BillNo)
select s.BillNo
from '+@ps_MisDbName+@vs_CgHeadTable+' s
where not exists(select 1 from tScmCgHead t where s.BillNo=t.BillNo) and s.JzDate is not null and s.YwStatus=' + '0' 
    
    exec(@vs_Sql)
    print @vs_Sql
    if @@ERROR<>0
    begin
      set @vs_Message='--取出在Scm中不存在的采购单单据号失败'
      goto Procedure_Error
    end 
    --表体
    set @vs_Sql='delete from tScmCgBody where BillNo in (select billNo from #Tmp_sSCMGetCgData_BillNo)
    insert into tScmCgBody(BillNo,SerialNo,PluCode,BarCode,PluName,CargoNo,Spec,Unit,WJPrice,HJPrice,JTaxRate,CgCount,HCost,WCost,JTaxTotal,Remark)
    select s.BillNo,SerialNo,PluCode,BarCode,PluName,CargoNo,Spec,Unit,WJPrice,HJPrice,JTaxRate,CgCount,CgHCost,CgWCost,CgJTaxTotal,Remark
    from  '+@ps_MisDbName+'TORDCGBODY s,#Tmp_sSCMGetCgData_BillNo a
    where s.BillNo = a.BillNo
    '
    exec(@vs_Sql)
    if @@ERROR<>0
    begin
      set @vs_Message='--向tScmCgBody中插入数据失败'
      goto Procedure_Error
    end 
    --表头
    set @vs_Sql='
    insert into tScmCgHead(BillNo,LrDate,RzDate,OrgCode,OrgName,DepCode,DepName,ShOrgCode,ShOrgName,SupCode,SupName,CntID,HtCode,HtName,
    JyMode,JsName,CgCount,
    Hcost,Wcost,JTaxTotal,ZdDate,YxDate,DhDate,CgyCode,CgyName,Remark)
    select s.BillNo,LrDate,JzDate,OrgCode,OrgName,DepCode,DepName ,YsOrgCode,YsOrgName,SupCode,SupName,CntID,HtCode,HtName,JyMode,
    (select EnumValueName from  '+@ps_MisDbName+'TSYSENUMVALUE where EnumValueId=JsCode and enumtypeid=''7002'') as JsName,CgCount,
    CgHCost,CgWCost,CgJTaxTotal,ZdDate,YxDate,DhDate,CgyCode,CgyName,Remark
    from  '+@ps_MisDbName+@vs_CgHeadTable+' s,#Tmp_sSCMGetCgData_BillNo a
    where  s.BillNo = a.BillNo
    '
    exec(@vs_Sql)
    if @@ERROR<>0
    begin
      set @vs_Message='--向tScmCgHead中插入数据失败'
      goto Procedure_Error
    end  
  end
  else if @ps_MisSysType='0'
  begin
    set @vs_Sql='
insert into #Tmp_sSCMGetCgData_BillNo(BillNo)
select s.BillNo
from '+@ps_MisDbName+'TJHCGHEAD s
where not exists(select 1 from tScmCgHead t where s.BillNo=t.BillNo) and s.RzDate is not null and s.ZxFlag =2
    '
  --ZxFlag=0的
    exec(@vs_Sql)
    print @vs_Sql
    if @@ERROR<>0
    begin
      set @vs_Message='--取出在Scm中不存在的TJHCGHEAD单据号失败'
      goto Procedure_Error
    end 
    create index Ix_#Tmp_sSCMGetCgData_BillNo on #Tmp_sSCMGetCgData_BillNo(BillNo)

    --表体
    set @vs_Sql='
insert into tScmCgBody(BillNo, SerialNo, PluCode, BarCode, PluName, CargoNo, Spec, Unit, WJPrice, HJPrice, JTaxRate, CgCount, HCost, WCost, JTaxTotal, Remark)
select s.BillNo, SerialNo, PluCode, BarCode, PluName, CargoNo,Spec, Unit, WJPrice, HJPrice, JTaxRate, CgCount, CgHCost, CgWCost, CgJTaxTotal, Remark
from '+@ps_MisDbName+'TJHCGBODY s, #Tmp_sSCMGetCgData_BillNo a
where s.BillNo = a.BillNo
    '
    exec(@vs_Sql)
    if @@ERROR<>0
    begin
      set @vs_Message='--向tScmCgBody中插入数据失败'
      goto Procedure_Error
    end 

    --表头
    set @vs_Sql='
insert into tScmCgHead(BillNo,LrDate,RzDate,OrgCode,OrgName,DepCode,DepName,ShOrgCode,ShOrgName,SupCode,SupName,CntID,HtCode,HtName, JyMode,JsName,CgCount, Hcost,Wcost,JTaxTotal,ZdDate,YxDate,DhDate,CgyCode,CgyName,Remark) 
select s.BillNo,LrDate,RzDate,''*'' as OrgCode,''*'' as OrgName,DepCode,DepName ,''*'' as YsOrgCode,''*'' as YsOrgName,SupCode,SupName,0 as CntID,HtCode,HtName,JyMode, (case JsCode when ''00'' then ''先款后货'' when ''01'' then ''货到付款'' when ''02'' then ''延期付款'' when ''04'' then ''滚动付款'' when ''06'' then ''以销定付'' when ''20'' then ''保底'' when ''21'' then ''提成''    when ''22'' then ''保底提成'' end) as JsName,CgCount, CgHCost,CgWCost,CgJTaxTotal,ZdDate,YxDate,DhDate, CgyCode, CgyName,Remark
from  '+@ps_MisDbName+'TJHCGHEAD s,#Tmp_sSCMGetCgData_BillNo a where  s.BillNo = a.BillNo
    '
    exec(@vs_Sql)
    if @@ERROR<>0
    begin
      set @vs_Message='--向tScmCgHead中插入数据失败'
      goto Procedure_Error
    end  
  end
/*=================成功退出=================*/ 
  set @ps_Message='更新采购单数据成功！'
  set @pi_Result=1
/*=================失败退出=================*/ 
Procedure_Error:
  set @pi_Result=-1
  set @ps_Message='更新采购单数据失败！发生位置：'+@vs_Message+'！'
end
