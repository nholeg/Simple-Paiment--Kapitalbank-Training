BEGIN
FOR I IN 1..5 LOOP
    SYS.DBMS_SCHEDULER.DROP_JOB(job_name => 'EDU.JOB_UPD_' || i,
                                defer => false,
                                FORCE => TRUE);
                                
 end loop;
 
END;