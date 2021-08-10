PL/SQL Developer Test script 3.0
8
-- Created on 18.05.2017 by OLEG 
declare 
  -- Local variables here
  i integer;
begin
  -- Test statements here
  dbms_stats.gather_schema_stats (ownname => 'EDU');
end;
0
0
