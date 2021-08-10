create or replace package Dispatchers is

  -- Author  : OLEG
  -- Created : 15.05.2017 10:19:24
  -- Purpose : 
  
  -- Диспетчер для первого типа
  PROCEDURE  dispatch_1 ;
  
  -- Диспетчер для второго типа
  PROCEDURE  dispatch_2 ;
  
    -- Диспетчер для третьего типа
  PROCEDURE  dispatch_3 ;
  
  -- Диспетчер для четвёртого типа
  PROCEDURE  dispatch_4 ;
  
   -- Диспетчер для пятого типа
  PROCEDURE  dispatch_5;

end Dispatchers;
/
create or replace package body Dispatchers is

 
 
 -- всего предусмотрел пять типов.
-- Диспетчер для первого типа
  PROCEDURE  dispatch_1 is
    l_count NUMBER;
  begin
   SELECT COUNT(*) INTO l_count FROM paiments WHERE paiment_type_id = 1 AND is_finished = 'N';
   --ограничиваю цикл сознательно )))
   FOR i IN 1..10000 LOOP
   IF l_count > 0 THEN
    op_processing.op_type_1;
       ELSE
         dbms_lock.sleep(3);
         END IF;
  END LOOP;
  
  END  dispatch_1;
    
  
  -- Диспетчер для второго типа
  PROCEDURE  dispatch_2 is
    l_count NUMBER;
  begin
   SELECT COUNT(*) INTO l_count FROM paiments  WHERE paiment_type_id = 2 AND is_finished = 'N';
   --ограничиваю цикл сознательно )))
   FOR i IN 1..10000 LOOP
   IF l_count > 0 THEN
    op_processing.op_type_2;
       ELSE
         dbms_lock.sleep(3);
         END IF;
  END LOOP;
  
  END  dispatch_2;
  
    -- Диспетчер для третьего типа
  PROCEDURE  dispatch_3 is
    l_count NUMBER;
  begin
   SELECT COUNT(*) INTO l_count FROM paiments  WHERE paiment_type_id = 3 AND is_finished = 'N';
   --ограничиваю цикл сознательно )))
   FOR i IN 1..10000 LOOP
   IF l_count > 0 THEN
     op_processing.op_type_3;
       ELSE
         dbms_lock.sleep(3);
         END IF;
  END LOOP;
  
  END  dispatch_3;
  
  -- Диспетчер для четвёртого типа
  PROCEDURE  dispatch_4 is
    l_count NUMBER;
  begin
   SELECT COUNT(*) INTO l_count FROM paiments  WHERE paiment_type_id = 4 AND is_finished = 'N';
   --ограничиваю цикл сознательно )))
   FOR i IN 1..10000 LOOP
   IF l_count > 0 THEN
     op_processing.op_type_4;
       ELSE
         dbms_lock.sleep(3);
         END IF;
  END LOOP;
  
  END  dispatch_4;
  
   -- Диспетчер для пятого типа
  PROCEDURE  dispatch_5 is
    l_count NUMBER;
  begin
   SELECT COUNT(*) INTO l_count FROM paiments  WHERE paiment_type_id = 5 AND is_finished = 'N';
   --ограничиваю цикл сознательно )))
   FOR i IN 1..10000 LOOP
   IF l_count > 0 THEN
     op_processing.op_type_5;
       ELSE
         dbms_lock.sleep(3);
         END IF;
  END LOOP;
  
  END  dispatch_5;




end Dispatchers;
/
