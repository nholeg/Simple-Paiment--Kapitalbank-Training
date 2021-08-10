PL/SQL Developer Test script 3.0
28
-- Created on 15.05.2017 by OLEG 
declare 
  -- Local variables here
  i integer;
  
procedure P_CREATE_JOB as
begin
for i in 1 .. 5 loop
sys.dbms_scheduler.create_job(job_name => 'JOB_UPD_' || i,
job_type => 'STORED_PROCEDURE',
job_action => 'dispatchers.dispatch_' || i);
end loop;
end;

procedure P_RUN_JOB as
begin
for i in 1 .. 5 loop
dbms_scheduler.run_job('JOB_UPD_' || i, FALSE);
end loop;
end;


begin
P_CREATE_JOB;
P_RUN_JOB;

  
end;
0
0
