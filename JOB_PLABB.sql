BEGIN
sys.dbms_scheduler.create_job(
job_name => '"HSCMP"."TCNTCONTRACT_UPDATE"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
   insert into tCntContract
select * from tCntContract@zbcmp
where etpcode in (''00003'',''00008'',''00009'',''00010'',''00013'',''00015'',''00016'',''00021'',''00023'',''00025''
,''00025'',''00027'',''00030'',''00031'',''00036'',''00037'',''00040'',''00041'',''00043'',''00045'',''00047'',''00049''
,''00050'',''00055'',''00056'',''00057'',''00062'',''00066'',''00073'',''00074'',''00077'',''00078'',''00082'',''00085''
,''00086'',''00088'',''00090'',''00091'',''00093'',''00094'',''00096'',''00097'',''00098'',''00104'',''00105'',''00107''
,''00110'',''00113'',''00115'',''00116'',''00120'',''00121'',''00122'',''00124'',''00129'',''00133'',''00134'',''00135''
,''00137'',''00139'',''00140'',''00149'',''00150'',''00151'',''00154'',''00157'',''00160'',''00161'',''00166'',''00167''
,''00168'',''00169'',''00171'',''00172'',''00176'',''00179'',''00191'',''00193'',''00199'',''00200'',''00203'',''00205''
,''00213'',''00224'',''00241'',''00246'',''00258'',''00284'',''00294'',''00325'',''00351'',''00362'',''00367'',''00369''
,''00370'',''00371'',''00374'',''00401'',''00406'',''00434'',''00451'',''00463'',''00499'',''00501'',''00504'',''00507''
,''00508'',''00519'',''00520'',''00526'',''00529'',''00533'',''00545'',''00546'',''00058'',''00145'',''00244'',''00296''
,''00335'',''00502'',''00521'')
and startdate=to_char(sysdate,''yyyy-mm-dd'')
;
end;',
repeat_interval => 'FREQ=DAILY;BYHOUR=3;BYMINUTE=0;BYSECOND=0',
start_date => to_timestamp_tz('2012-01-28 Asia/Shanghai', 'YYYY-MM-DD TZR'),
job_class => '"DEFAULT_JOB_CLASS"',
comments => '插入供应商表',
auto_drop => TRUE,
enabled => TRUE);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."TCNTCONTRACT_UPDATE"', attribute => 'raise_events', value => dbms_scheduler.job_failed + dbms_scheduler.job_stopped);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."TCNTCONTRACT_UPDATE"', attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_FAILED_RUNS);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."TCNTCONTRACT_UPDATE"', attribute => 'job_weight', value => 1);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."TCNTCONTRACT_UPDATE"', attribute => 'instance_stickiness', value => FALSE);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."TCNTCONTRACT_UPDATE"', attribute => 'restartable', value => TRUE);
sys.dbms_scheduler.enable( '"HSCMP"."TCNTCONTRACT_UPDATE"' );
END;


/*****/
begin
insert into tCntContract
select * from tCntContract@zbcmp
where etpcode in ('00003','00008','00009','00010','00013','00015','00016','00021','00023','00025'
,'00025','00027','00030','00031','00036','00037','00040','00041','00043','00045','00047','00049'
,'00050','00055','00056','00057','00062','00066','00073','00074','00077','00078','00082','00085'
,'00086','00088','00090','00091','00093','00094','00096','00097','00098','00104','00105','00107'
,'00110','00113','00115','00116','00120','00121','00122','00124','00129','00133','00134','00135'
,'00137','00139','00140','00149','00150','00151','00154','00157','00160','00161','00166','00167'
,'00168','00169','00171','00172','00176','00179','00191','00193','00199','00200','00203','00205'
,'00213','00224','00241','00246','00258','00284','00294','00325','00351','00362','00367','00369'
,'00370','00371','00374','00401','00406','00434','00451','00463','00499','00501','00504','00507'
,'00508','00519','00520','00526','00529','00533','00545','00546','00058','00145','00244','00296'
,'00335','00502','00521')
and startdate = to_char(sysdate,'yyyy-mm-dd')
;
end;

/************/
BEGIN
sys.dbms_scheduler.disable( '"HSCMP"."TCNTCONTRACT_UPDATE"' );
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."TCNTCONTRACT_UPDATE"', attribute => 'start_date', value => systimestamp at time zone 'Asia/Shanghai');
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."TCNTCONTRACT_UPDATE"', attribute => 'raise_events', value => dbms_scheduler.job_failed + dbms_scheduler.job_stopped);
sys.dbms_scheduler.enable( '"HSCMP"."TCNTCONTRACT_UPDATE"' );
END;
/***************************以下************************************/
BEGIN
sys.dbms_scheduler.create_job(
job_name => '"HSCMP"."PLANB_TCNTCONTRACT_UPDATE"',
job_type => 'PLSQL_BLOCK',
job_action => 'begin
   insert into tCntContract
select * from tCntContract@zbcmp
where etpcode in (''00003'',''00008'',''00009'',''00010'',''00013'',''00015'',''00016'',''00021'',''00023'',''00025''
,''00025'',''00027'',''00030'',''00031'',''00036'',''00037'',''00040'',''00041'',''00043'',''00045'',''00047'',''00049''
,''00050'',''00055'',''00056'',''00057'',''00062'',''00066'',''00073'',''00074'',''00077'',''00078'',''00082'',''00085''
,''00086'',''00088'',''00090'',''00091'',''00093'',''00094'',''00096'',''00097'',''00098'',''00104'',''00105'',''00107''
,''00110'',''00113'',''00115'',''00116'',''00120'',''00121'',''00122'',''00124'',''00129'',''00133'',''00134'',''00135''
,''00137'',''00139'',''00140'',''00149'',''00150'',''00151'',''00154'',''00157'',''00160'',''00161'',''00166'',''00167''
,''00168'',''00169'',''00171'',''00172'',''00176'',''00179'',''00191'',''00193'',''00199'',''00200'',''00203'',''00205''
,''00213'',''00224'',''00241'',''00246'',''00258'',''00284'',''00294'',''00325'',''00351'',''00362'',''00367'',''00369''
,''00370'',''00371'',''00374'',''00401'',''00406'',''00434'',''00451'',''00463'',''00499'',''00501'',''00504'',''00507''
,''00508'',''00519'',''00520'',''00526'',''00529'',''00533'',''00545'',''00546'',''00058'',''00145'',''00244'',''00296''
,''00335'',''00502'',''00521'')
and startdate=to_char(sysdate,''yyyy-mm-dd'')
;
end;',
repeat_interval => 'FREQ=DAILY;BYHOUR=3;BYMINUTE=0;BYSECOND=0',
start_date => systimestamp at time zone '+8:00',
job_class => '"DEFAULT_JOB_CLASS"',
comments => '插入供应商表',
auto_drop => TRUE,
enabled => FALSE);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."PLANB_TCNTCONTRACT_UPDATE"', attribute => 'raise_events', value => dbms_scheduler.job_failed + dbms_scheduler.job_completed);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."PLANB_TCNTCONTRACT_UPDATE"', attribute => 'logging_level', value => DBMS_SCHEDULER.LOGGING_FAILED_RUNS);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."PLANB_TCNTCONTRACT_UPDATE"', attribute => 'job_weight', value => 1);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."PLANB_TCNTCONTRACT_UPDATE"', attribute => 'instance_stickiness', value => FALSE);
sys.dbms_scheduler.set_attribute( name => '"HSCMP"."PLANB_TCNTCONTRACT_UPDATE"', attribute => 'restartable', value => TRUE);
sys.dbms_scheduler.enable( '"HSCMP"."PLANB_TCNTCONTRACT_UPDATE"' );
END;

TRUNCATE TABLE tstkpc
SELECT * FROM tStkPc