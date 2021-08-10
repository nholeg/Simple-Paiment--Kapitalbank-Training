create or replace procedure OP_THREADS is

nJOBS number := 10;
sJOB_ACTION varchar2(200);

procedure P_JOB_SESSION(sACTION in varchar2) as
nCNT number;
begin
begin
--select 1 into nCNT from v$session v where v.ACTION = sACTION;
SELECT 1 into nCNT FROM USER_SCHEDULER_JOBS WHERE job_name = sACTION AND STATE='RUNNING';
exception
when others then
nCNT := 0;
end;
if (nCNT > 0) then
SYS.DBMS_LOCK.SLEEP(5);
--рекурсия
P_JOB_SESSION(sACTION);
end if;
end P_JOB_SESSION;

procedure P_CREATE_JOB as
begin
sJOB_ACTION:='begin
op_processing.op_processing_ntt_op;
end;';
for i in 1 .. nJOBS loop
sys.dbms_scheduler.create_job(job_name => 'JOB_UPD_' || i,
job_type => 'PLSQL_BLOCK',
job_action => sJOB_ACTION;
end loop;
end;

procedure P_RUN_JOB as
begin
for i in 1 .. nJOBS loop
dbms_scheduler.run_job('JOB_UPD_' || i, false);
end loop;
end;

procedure P_DROP_JOB as
begin
for i in 1 .. nJOBS loop
dbms_scheduler.drop_job('JOB_UPD_' || i, TRUE);
end loop;
end;

begin
P_CREATE_JOB;
P_RUN_JOB;
SYS.DBMS_LOCK.SLEEP(5);
for i in 1 .. nJOBS loop
P_JOB_SESSION('JOB_UPD_' || i);
end loop;
P_DROP_JOB;

end P_THREAD_TEST;
/
