/**С����������ʧЧ*/

DELETE FROM tOrdThHead

set feedback off
set serveroutput on
set pagesize 0
set ver off
set echo off

spool d:\app\Administrator\product\11.2.0\dbhome_1\dbs\reorg3.log

-- �ű������
-- ==============================================

-- functions and procedures

CREATE OR REPLACE PROCEDURE mgmt$reorg_sendMsg (msg IN VARCHAR2) IS
    msg1 VARCHAR2(1020);
    len INTEGER := length(msg);
    i INTEGER := 1;
BEGIN
    dbms_output.enable (1000000);

    LOOP
      msg1 := SUBSTR (msg, i, 255);
      dbms_output.put_line (msg1);
      len := len - 255;
      i := i + 255;
    EXIT WHEN len <= 0;
    END LOOP;
END mgmt$reorg_sendMsg;
/

CREATE OR REPLACE PROCEDURE mgmt$reorg_errorExit (msg IN VARCHAR2) IS
BEGIN
    mgmt$reorg_sendMsg (msg);
    mgmt$reorg_sendMsg ('errorExit!');
END mgmt$reorg_errorExit;
/

CREATE OR REPLACE PROCEDURE mgmt$reorg_errorExitOraError (msg IN VARCHAR2, errMsg IN VARCHAR2) IS
BEGIN
    mgmt$reorg_sendMsg (msg);
    mgmt$reorg_sendMsg (errMsg);
    mgmt$reorg_sendMsg ('errorExitOraError!');
END mgmt$reorg_errorExitOraError;
/

CREATE OR REPLACE PROCEDURE mgmt$reorg_checkDBAPrivs 
AUTHID CURRENT_USER IS
    granted_role REAL := 0;
    user_name user_users.username%type;
BEGIN
SELECT USERNAME INTO user_name FROM USER_USERS;
    EXECUTE IMMEDIATE 'SELECT 1 FROM SYS.DBA_ROLE_PRIVS WHERE GRANTED_ROLE = ''DBA'' AND GRANTEE = :1'
      INTO granted_role       USING user_name;
EXCEPTION
    WHEN OTHERS THEN
       IF SQLCODE = -01403 OR SQLCODE = -00942  THEN
      mgmt$reorg_sendMsg ( '����: ���ڼ��Ȩ��... �û���: ' || user_name);
      mgmt$reorg_sendMsg ( '�û������� DBA Ȩ�ޡ�' );
      mgmt$reorg_sendMsg ( '�����ͼִ���û�û����ȷȨ�޵Ĳ���, �ű���ʧ�ܡ�' );
      END IF;
END mgmt$reorg_checkDBAPrivs;
/

CREATE OR REPLACE PROCEDURE mgmt$reorg_setUpJobTable (script_id IN INTEGER, job_table IN VARCHAR2, step_num OUT INTEGER)
AUTHID CURRENT_USER IS
    ctsql_text VARCHAR2(200) := 'CREATE TABLE ' || job_table || '(SCRIPT_ID NUMBER, LAST_STEP NUMBER, unique (SCRIPT_ID))';
    itsql_text VARCHAR2(200) := 'INSERT INTO ' || job_table || ' (SCRIPT_ID, LAST_STEP) values (:1, :2)';
    stsql_text VARCHAR2(200) := 'SELECT last_step FROM ' || job_table || ' WHERE script_id = :1';

    TYPE CurTyp IS REF CURSOR;  -- define weak REF CURSOR type
    stsql_cur CurTyp;  -- declare cursor variable

BEGIN
    step_num := 0;
    BEGIN
      EXECUTE IMMEDIATE ctsql_text;
    EXCEPTION
      WHEN OTHERS THEN
        NULL;
    END;

    BEGIN
      OPEN stsql_cur FOR  -- open cursor variable
        stsql_text USING  script_id;
      FETCH stsql_cur INTO step_num;
      IF stsql_cur%FOUND THEN
        NULL;
      ELSE
        EXECUTE IMMEDIATE itsql_text USING script_id, step_num;
        COMMIT;
        step_num := 1;
      END IF;
      CLOSE stsql_cur;
    EXCEPTION
      WHEN OTHERS THEN
        mgmt$reorg_errorExit ('����: �ӱ���ѡ������ʱ����: ' || job_table);
        return;
    END;

    return;

EXCEPTION
      WHEN OTHERS THEN
        mgmt$reorg_errorExit ('����: ���ʱ�ʱ����: ' || job_table);
        return;
END mgmt$reorg_setUpJobTable;
/

CREATE OR REPLACE PROCEDURE mgmt$reorg_deleteJobTableEntry(script_id IN INTEGER, job_table IN VARCHAR2, step_num IN INTEGER, highest_step IN INTEGER)
AUTHID CURRENT_USER IS
    delete_text VARCHAR2(200) := 'DELETE FROM ' || job_table || ' WHERE SCRIPT_ID = :1';
BEGIN

    IF step_num <= highest_step THEN
      return;
    END IF;

    BEGIN
      EXECUTE IMMEDIATE delete_text USING script_id;
      IF SQL%NOTFOUND THEN
        mgmt$reorg_errorExit ('����: �ӱ���ɾ����Ŀʱ����: ' || job_table);
        return;
      END IF;
    EXCEPTION
        WHEN OTHERS THEN
          mgmt$reorg_errorExit ('����: �ӱ���ɾ����Ŀʱ����: ' || job_table);
          return;
    END;

    COMMIT;
END mgmt$reorg_deleteJobTableEntry;
/

CREATE OR REPLACE PROCEDURE mgmt$reorg_setStep (script_id IN INTEGER, job_table IN VARCHAR2, step_num IN INTEGER)
AUTHID CURRENT_USER IS
    update_text VARCHAR2(200) := 'UPDATE ' || job_table || ' SET last_step = :1 WHERE script_id = :2';
BEGIN
    -- update job table
    EXECUTE IMMEDIATE update_text USING step_num, script_id;
    IF SQL%NOTFOUND THEN
      mgmt$reorg_sendMsg ('sql_text ��δ�ҵ��쳣����: ' || update_text);
      mgmt$reorg_errorExit ('����: ���ʱ�ʱ����: ' || job_table);
      return;
    END IF;
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
      mgmt$reorg_errorExit ('����: ���ʱ�ʱ����: ' || job_table);
      return;
END mgmt$reorg_setStep;
/

CREATE OR REPLACE PROCEDURE mgmt$step_1_3(script_id IN INTEGER, job_table IN VARCHAR2, step_num IN OUT INTEGER)
AUTHID CURRENT_USER IS
    sqlerr_msg VARCHAR2(100);
BEGIN
    IF step_num <> 1 THEN
      return;
    END IF;

    mgmt$reorg_setStep (3, 'MGMT$REORG_CHECKPOINT', step_num);
    step_num := step_num + 1;
    BEGIN
      mgmt$reorg_sendMsg ('ALTER INDEX "HSCMP"."IDX_TORDJHHEAD" REBUILD   NOLOGGING ONLINE');
      EXECUTE IMMEDIATE 'ALTER INDEX "HSCMP"."IDX_TORDJHHEAD" REBUILD   NOLOGGING ONLINE';
    EXCEPTION
      WHEN OTHERS THEN
        sqlerr_msg := SUBSTR(SQLERRM, 1, 100);
        mgmt$reorg_errorExitOraError('����: ִ�в���',  sqlerr_msg);
        step_num := -1;
        return;
    END;
END mgmt$step_1_3;
/

CREATE OR REPLACE PROCEDURE mgmt$step_2_3(script_id IN INTEGER, job_table IN VARCHAR2, step_num IN OUT INTEGER)
AUTHID CURRENT_USER IS
    sqlerr_msg VARCHAR2(100);
BEGIN
    IF step_num <> 2 THEN
      return;
    END IF;

    mgmt$reorg_setStep (3, 'MGMT$REORG_CHECKPOINT', step_num);
    step_num := step_num + 1;
    BEGIN
      mgmt$reorg_sendMsg ('ALTER INDEX "HSCMP"."IDX_TORDJHHEAD" LOGGING');
      EXECUTE IMMEDIATE 'ALTER INDEX "HSCMP"."IDX_TORDJHHEAD" LOGGING';
    EXCEPTION
      WHEN OTHERS THEN
        sqlerr_msg := SUBSTR(SQLERRM, 1, 100);
        mgmt$reorg_errorExitOraError('����: ִ�в���',  sqlerr_msg);
        step_num := -1;
        return;
    END;
END mgmt$step_2_3;
/

CREATE OR REPLACE PROCEDURE mgmt$step_3_3(script_id IN INTEGER, job_table IN VARCHAR2, step_num IN OUT INTEGER)
AUTHID CURRENT_USER IS
    sqlerr_msg VARCHAR2(100);
BEGIN
    IF step_num <> 3 THEN
      return;
    END IF;

    mgmt$reorg_setStep (3, 'MGMT$REORG_CHECKPOINT', step_num);
    step_num := step_num + 1;
    BEGIN
      mgmt$reorg_sendMsg ('BEGIN DBMS_STATS.GATHER_INDEX_STATS(''"HSCMP"'', ''"IDX_TORDJHHEAD"'', estimate_percent=>NULL); END;');
      EXECUTE IMMEDIATE 'BEGIN DBMS_STATS.GATHER_INDEX_STATS(''"HSCMP"'', ''"IDX_TORDJHHEAD"'', estimate_percent=>NULL); END;';
    EXCEPTION
      WHEN OTHERS THEN
        sqlerr_msg := SUBSTR(SQLERRM, 1, 100);
        mgmt$reorg_errorExitOraError('����: ִ�в���',  sqlerr_msg);
        step_num := -1;
        return;
    END;
END mgmt$step_3_3;
/

CREATE OR REPLACE PROCEDURE mgmt$reorg_cleanup_3 (script_id IN INTEGER, job_table IN VARCHAR2, step_num IN INTEGER, highest_step IN INTEGER)
AUTHID CURRENT_USER IS
BEGIN
    IF step_num <= highest_step THEN
      return;
    END IF;

    mgmt$reorg_sendMsg ('��ʼ����ָ���');

    mgmt$reorg_deleteJobTableEntry(script_id, job_table, step_num, highest_step);

    mgmt$reorg_sendMsg ('�������ָ���');
END mgmt$reorg_cleanup_3;
/

CREATE OR REPLACE PROCEDURE mgmt$reorg_commentheader_3 IS
BEGIN
     mgmt$reorg_sendMsg ('--   Ŀ�����ݿ�:	hscmb');
     mgmt$reorg_sendMsg ('--   �ű�����ʱ��:	20-1�� -2012   22:49');
END mgmt$reorg_commentheader_3;
/

-- �ű�ִ�п�����
-- ==============================================

variable step_num number;
exec mgmt$reorg_commentheader_3;
exec mgmt$reorg_sendMsg ('��ʼ����');
show user;
exec mgmt$reorg_checkDBAPrivs;
exec mgmt$reorg_setupJobTable (3, 'MGMT$REORG_CHECKPOINT', :step_num);

exec mgmt$step_1_3(3, 'MGMT$REORG_CHECKPOINT', :step_num);
exec mgmt$step_2_3(3, 'MGMT$REORG_CHECKPOINT', :step_num);
exec mgmt$step_3_3(3, 'MGMT$REORG_CHECKPOINT', :step_num);

exec mgmt$reorg_sendMsg ('������ɡ���������׶Ρ�');

exec mgmt$reorg_cleanup_3 (3, 'MGMT$REORG_CHECKPOINT', :step_num, 3);

exec mgmt$reorg_sendMsg ('��ʼ������ɵĹ���');

DROP PROCEDURE mgmt$step_1_3;
DROP PROCEDURE mgmt$step_2_3;
DROP PROCEDURE mgmt$step_3_3;

DROP PROCEDURE mgmt$reorg_cleanup_3;
DROP PROCEDURE mgmt$reorg_commentheader_3;

exec mgmt$reorg_sendMsg ('���������ɵĹ���');

exec mgmt$reorg_sendMsg ('��ɽű�ִ��');

spool off
set pagesize 24
set serveroutput off
set feedback on
set echo on
set ver on


