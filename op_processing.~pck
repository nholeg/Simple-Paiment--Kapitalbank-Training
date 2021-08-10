create or replace package op_processing is

  -- Author  : OLEG
  -- Created : 13.05.2017 10:36:29
  -- Purpose : 


  -- Обработка записей с помошью курсора (оптимистичный) (BATCH) не работает!!!
 PROCEDURE op_processing_Cur_op ;
 
 -- Обработка записей с помошью NTT (оптимистичный)(BATCH)
  PROCEDURE op_processing_ntt_op ;


  -- Обработка записей  первого типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_1;
  
  -- Обработка записей  первого типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_2;
  
  -- Обработка записей  первого типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_3;
  
  -- Обработка записей  первого типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_4;
  
   -- Обработка записей  первого типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_5;


end op_processing;
/
create or replace package body op_processing is

PROCEDURE op_processing_Cur_op AS
l_cur SYS_REFCURSOR;
l_pst NUMBER(4,3);
C_bank CONSTANT VARCHAR2(5) := '90001';
BEGIN
 l_cur := api.get_paiments_cur_op;
  /*FOR i IN l_cur LOOP
    l_pst := api.get_comission_pst(p_bankomat_id =>l_cur(i).bankomat_id,p_paiment_type_id => l_cur(i).paiment_type_id);
    api.set_operation_journal_cur_op (l_cur(i).paiment_id, 
                           l_cur(i).bankomat_id,
                           l_cur(i).recipient_id,
                           l_cur(i).total,
                           l_cur(i).currency_id);
                           
    api.set_operation_journal_cur_op (l_cur(i).paiment_id, 
                           l_cur(i).recipient_id,
                           c_bank,
                           l_cur(i).total*l_pst,
                           l_cur(i).currency_id);
    api.set_finished_cur_op (l_cur(i).r_rowid, l_cur(i).r_rowscn);
                           
  
  END LOOP;*/


END op_processing_Cur_op;

  PROCEDURE op_processing_ntt_op AS
    l_ntt api.t_paiments;
    l_pst NUMBER(4,3);
    C_bank CONSTANT VARCHAR2(5) := '90001';
    BEGIN
      l_ntt := api.get_paiments_ntt_op;
      FOR i IN l_ntt.first..l_ntt.last LOOP
    l_pst := api.get_comission_pst(p_bankomat_id =>l_ntt(i).bankomat_id,p_paiment_type_id => l_ntt(i).paiment_type_id);
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).bankomat_id,
                           l_ntt(i).recipient_id,
                           l_ntt(i).total,
                           l_ntt(i).currency_id);
                           
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).recipient_id,
                           c_bank,
                           l_ntt(i).total*l_pst,
                           l_ntt(i).currency_id);
    api.set_finished_op (l_ntt(i).r_rowid,l_ntt(i).r_rowscn);
                           

  END LOOP;
                       
      COMMIT;
      END op_processing_ntt_op;
    

-- Обработка записей  первого типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_1 IS 
     l_ntt api.t_paiments;
     C_bank CONSTANT VARCHAR2(5) := '90001';
      BEGIN
      l_ntt := api.get_paiments_ntt_op_type_1;
      FOR i IN l_ntt.first..l_ntt.last LOOP
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).bankomat_id,
                           l_ntt(i).recipient_id,
                           l_ntt(i).total,
                           l_ntt(i).currency_id);
                           
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).recipient_id,
                           c_bank,
                           l_ntt(i).total*0.01,
                           l_ntt(i).currency_id);
    api.set_finished_op (l_ntt(i).r_rowid,l_ntt(i).r_rowscn);
    
  END LOOP;
                       
      COMMIT;
      END op_type_1;
  
-- Обработка записей  второго типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_2 IS 
     l_ntt api.t_paiments;
     C_bank CONSTANT VARCHAR2(5) := '90001';
      BEGIN
      l_ntt := api.get_paiments_ntt_op_type_2;
      FOR i IN l_ntt.first..l_ntt.last LOOP
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).bankomat_id,
                           l_ntt(i).recipient_id,
                           l_ntt(i).total,
                           l_ntt(i).currency_id);
                           
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).recipient_id,
                           c_bank,
                           l_ntt(i).total*0.012,
                           l_ntt(i).currency_id);
    api.set_finished_op (l_ntt(i).r_rowid,l_ntt(i).r_rowscn);
    
  END LOOP;
                       
      COMMIT;
      END op_type_2;
      
  -- Обработка записей  третьего типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_3 IS 
     l_ntt api.t_paiments;
     C_bank CONSTANT VARCHAR2(5) := '90001';
      BEGIN
      l_ntt := api.get_paiments_ntt_op_type_3;
      FOR i IN l_ntt.first..l_ntt.last LOOP
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).bankomat_id,
                           l_ntt(i).recipient_id,
                           l_ntt(i).total,
                           l_ntt(i).currency_id);
                           
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).recipient_id,
                           c_bank,
                           l_ntt(i).total*0.015,
                           l_ntt(i).currency_id);
    api.set_finished_op (l_ntt(i).r_rowid,l_ntt(i).r_rowscn);
    
  END LOOP;
                       
      COMMIT;
      END op_type_3;
      
  -- Обработка записей  четвёртого типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_4 IS 
     l_ntt api.t_paiments;
     C_bank CONSTANT VARCHAR2(5) := '90001';
      BEGIN
      l_ntt := api.get_paiments_ntt_op_type_4;
      FOR i IN l_ntt.first..l_ntt.last LOOP
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).bankomat_id,
                           l_ntt(i).recipient_id,
                           l_ntt(i).total,
                           l_ntt(i).currency_id);
                           
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).recipient_id,
                           c_bank,
                           l_ntt(i).total*0.018,
                           l_ntt(i).currency_id);
    api.set_finished_op (l_ntt(i).r_rowid,l_ntt(i).r_rowscn);
    
  END LOOP;
                       
      COMMIT;
      END op_type_4;
  
  -- Обработка записей  пятого типа с помошью NTT (оптимистичный)
  PROCEDURE op_type_5 IS 
     l_ntt api.t_paiments;
     C_bank CONSTANT VARCHAR2(5) := '90001';
      BEGIN
      l_ntt := api.get_paiments_ntt_op_type_5;
      FOR i IN l_ntt.first..l_ntt.last LOOP
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).bankomat_id,
                           l_ntt(i).recipient_id,
                           l_ntt(i).total,
                           l_ntt(i).currency_id);
                           
    api.set_operation_journal (l_ntt(i).paiment_id, 
                           l_ntt(i).recipient_id,
                           c_bank,
                           l_ntt(i).total*0.02,
                           l_ntt(i).currency_id);
    api.set_finished_op (l_ntt(i).r_rowid,l_ntt(i).r_rowscn);
    
  END LOOP;
                       
      COMMIT;
      END op_type_5;




end op_processing;
/
