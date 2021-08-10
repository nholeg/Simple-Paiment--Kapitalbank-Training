create or replace package api is

  -- Author  : OLEG
  -- Created : 10.05.2017 11:58:58
  -- Purpose : 
  
  -- Public type declarations

    TYPE r_RECIPIENT_TYPE IS RECORD(  recipient_id recipient.recipient_id%TYPE,
                                      recipient_name recipient.recipient_name%TYPE,
                                      recipient_number recipient.recipient_number%TYPE,
                                      paiment_type_id recipient.paiment_type_id%TYPE);
    
    TYPE r_operation_journal IS RECORD( paiment_id  operation_journal.paiment_id%TYPE, 
                                        debet operation_journal.paiment_id%TYPE,
                                        kredit operation_journal.paiment_id%TYPE, 
                                        total operation_journal.paiment_id%TYPE,
                                        currency_id operation_journal.paiment_id%TYPE);
                                        
    TYPE r_paiments IS RECORD (r_rowscn VARCHAR2 (20),
                               r_ROWID VARCHAR2 (20),
                               paiment_id paiments.paiment_id%TYPE,
                               bankomat_id paiments.bankomat_id%TYPE,
                               paiment_type_id paiments.paiment_type_id%TYPE,
                               total paiments.total%TYPE,
                               currency_id paiments.currency_id%TYPE,
                               is_finished paiments.is_finished%TYPE,
                               date_addet paiments.date_addet%TYPE,
                               recipient_id paiments.recipient_id%TYPE);
                               
    TYPE t_paiments IS TABLE OF r_paiments;
    
  
  
  -- Public constant declarations
 -- <ConstantName> constant <Datatype> := <Value>;

  -- Public variable declarations
 -- <VariableName> <Datatype>;

  -- Получить Абривиатуру валюты по коду валюты
  FUNCTION  get_currency_abbreviation(p_currency_id NUMBER ) RETURN  VARCHAR2 ;
  
  -- Получить полное название валюты по коду валюты
  FUNCTION  get_currency_full_name(p_currency_id NUMBER ) RETURN  VARCHAR2 ;
  
    -- Получить тип платежа по коду
  FUNCTION  get_paiment_type(p_paiment_type_id NUMBER ) RETURN  VARCHAR2 ;
  
  -- Получить Данные Получателя по коду получателя
  FUNCTION  get_recipient(p_recipient_id NUMBER) RETURN  r_recipient_type;
  
  -- Получить получить тариф по коду Банкомата и типу оплаты
  FUNCTION  get_comission_pst(p_bankomat_id NUMBER, p_paiment_type_id NUMBER) RETURN NUMBER;
  
  -- Получить полные данные по коду платежа из журнала 
  FUNCTION get_full_info_from_op_journal(p_paiment_id NUMBER ) RETURN r_operation_journal;
  
  -- Получить данные из таблицы paiments (NTT) (optimistic)
  FUNCTION get_paiments_ntt_op RETURN t_paiments;
  
   -- Получить данные из таблицы paiments (cursor Variable) (optimistic)
    FUNCTION get_paiments_Cur_op  RETURN  SYS_REFCURSOR;

  -- Добавить новую запись в журнал cursor (optimistic)
  PROCEDURE set_operation_journal (p_paiment_id NUMBER, 
                                 p_bankomat_id NUMBER,
                                 p_recipient_id NUMBER,
                                 p_total NUMBER,
                                 p_currency_id NUMBER);
        

  -- Изменить флажек что запись обработана (optimistic)
  PROCEDURE set_finished_op (p_rowid VARCHAR2 , p_rowscn NUMBER);
  


  -- Собрать записи первого типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_1 RETURN t_paiments;
  
  -- Собрать записи второго типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_2 RETURN t_paiments;
  
   -- Собрать записи третьего типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_3 RETURN t_paiments;
  
  -- Собрать записи четвёртого типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_4 RETURN t_paiments;
  
  -- Собрать записи пятого типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_5 RETURN t_paiments;


end api;
/
create or replace package body api is

    
-- Получить Абривиатуру валюты по коду валюты
  FUNCTION get_currency_abbreviation(p_currency_id NUMBER ) RETURN VARCHAR2 AS
      l_currency_abbreviation currency.currency_abbreviation%TYPE;
  BEGIN
   SELECT currency_abbreviation 
   INTO  l_currency_abbreviation 
   FROM currency 
   WHERE currency_id = p_currency_id;
   RETURN l_currency_abbreviation;
  END get_currency_abbreviation;


 -- Получить полное название валюты по коду валюты
  FUNCTION get_currency_full_name(p_currency_id NUMBER ) RETURN VARCHAR2 AS
           l_currency_full_name currency.currency_full_name%TYPE;
  BEGIN
   SELECT currency_full_name 
   INTO l_currency_full_name 
   FROM currency 
   WHERE currency_id = p_currency_id;
   RETURN l_currency_full_name;
  END get_currency_full_name;
  
 -- Получить тип платежа по коду
  FUNCTION get_paiment_type(p_paiment_type_id NUMBER ) RETURN  VARCHAR2 AS
           l_paiment_type paiment_type.paiment_type%TYPE;
  BEGIN
   SELECT paiment_type 
   INTO l_paiment_type 
   FROM paiment_type 
   WHERE paiment_type_id = p_paiment_type_id;
   RETURN l_paiment_type;
  END get_paiment_type;
  
  -- Получить Данные Получателя по коду получателя
  FUNCTION get_recipient(p_recipient_id NUMBER) RETURN  r_recipient_type AS
    l_recipient api.r_recipient_type;
  BEGIN
   SELECT recipient_id,
          recipient_name,
          recipient_number,
          paiment_type_id
   INTO l_recipient 
   FROM recipient 
   WHERE recipient_id = p_recipient_id;
   RETURN l_recipient;
  END get_recipient;
  
  -- Получить получить тариф по коду Банкомата и типу оплаты
  FUNCTION  get_comission_pst(p_bankomat_id NUMBER, p_paiment_type_id NUMBER) RETURN NUMBER AS
    l_comission_pst tariff.comission_pst%TYPE;
  BEGIN
   SELECT comission_pst 
   INTO l_comission_pst 
   FROM tariff 
   WHERE bankomat_id = p_bankomat_id 
   AND paiment_type_id = p_paiment_type_id;
   RETURN  l_comission_pst;
  END get_comission_pst;
  
   -- Получить полные данные по коду платежа из журнала
  FUNCTION get_full_info_from_op_journal(p_paiment_id NUMBER ) RETURN r_operation_journal AS
     l_operation_journal api.r_operation_journal;
  BEGIN
   SELECT  paiment_id,
           debet,
           kredit,
           total,
           currency_id
   INTO l_operation_journal 
   FROM operation_journal
   WHERE paiment_id = p_paiment_id;
   RETURN l_operation_journal;
  END get_full_info_from_op_journal;
  
  -- Получить данные из таблицы paiments (NTT)
  FUNCTION get_paiments_ntt_op RETURN t_paiments AS
    l_paiments api.t_paiments;
  BEGIN
   SELECT  ora_rowscn,
           ROWID,
           paiment_id,
           bankomat_id,
           paiment_type_id,
           total,
           currency_id,
           is_finished,
           date_addet,
           recipient_id           
   BULK COLLECT INTO l_paiments 
   FROM paiments
   WHERE decode(is_finished , 'N', 'N' ) = 'N';
   RETURN l_paiments;
  END get_paiments_ntt_op;
  
   -- Получить данные из таблицы paiments (cursor Variable)
  FUNCTION get_paiments_Cur_op  RETURN SYS_REFCURSOR 
AS c_paiments SYS_REFCURSOR; 
     BEGIN
        OPEN c_paiments FOR
        SELECT ora_rowscn,
               ROWID,
               paiment_id,
               bankomat_id,
               paiment_type_id,
               total,
               currency_id,
               is_finished,
               date_addet,
               recipient_id        
   FROM paiments
   WHERE decode(is_finished , 'N', 'N' ) = 'N';
   RETURN c_paiments;
    END get_paiments_Cur_op;
  -- Добавить новую запись в журнал 
  PROCEDURE set_operation_journal (p_paiment_id NUMBER, 
                                 p_bankomat_id NUMBER,
                                 p_recipient_id NUMBER,
                                 p_total NUMBER,
                                 p_currency_id NUMBER) AS
   BEGIN
    INSERT INTO operation_journal (id,
                                   paiment_id,
                                   debet,
                                   kredit,
                                   total,
                                   currency_id)
     VALUES (operation_journal_seq.nextval,
             p_paiment_id,
             p_bankomat_id,
             p_recipient_id,
             p_total,
             p_currency_id);
    END set_operation_journal;                                
        
  
                    
   -- Изменить флажек что запись обработана (optimistic)                         
  PROCEDURE set_finished_op (p_rowid VARCHAR2, p_rowscn NUMBER) AS
    l_scn NUMBER;
     BEGIN
       
     SELECT ora_rowscn INTO l_scn
     FROM paiments WHERE ROWID = p_rowid; 
     
     IF l_scn = p_rowscn THEN
       
     UPDATE paiments SET is_finished ='Y'
     WHERE ROWID = p_rowid;
       
     END IF;
     
     END set_finished_op; 
    
  -- Собрать записи первого типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_1 RETURN t_paiments AS
    l_paiments api.t_paiments;
  BEGIN
   SELECT  ora_rowscn,
           ROWID,
           paiment_id,
           bankomat_id,
           paiment_type_id,
           total,
           currency_id,
           is_finished,
           date_addet,
           recipient_id           
   BULK COLLECT INTO l_paiments 
   FROM paiments
   WHERE decode(is_finished , 'N', 'N' ) = 'N' AND paiment_type_id = 1;
   RETURN l_paiments;
  END get_paiments_ntt_op_type_1;                           
    
   -- Собрать записи вторго типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_2 RETURN t_paiments AS
    l_paiments api.t_paiments;
  BEGIN
   SELECT  ora_rowscn,
           ROWID,
           paiment_id,
           bankomat_id,
           paiment_type_id,
           total,
           currency_id,
           is_finished,
           date_addet,
           recipient_id           
   BULK COLLECT INTO l_paiments 
   FROM paiments
   WHERE decode(is_finished , 'N', 'N' ) = 'N' AND paiment_type_id = 2;
   RETURN l_paiments;
  END get_paiments_ntt_op_type_2; 
      
  -- Собрать записи третьего типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_3 RETURN t_paiments AS
    l_paiments api.t_paiments;
  BEGIN
   SELECT  ora_rowscn,
           ROWID,
           paiment_id,
           bankomat_id,
           paiment_type_id,
           total,
           currency_id,
           is_finished,
           date_addet,
           recipient_id           
   BULK COLLECT INTO l_paiments 
   FROM paiments
   WHERE decode(is_finished , 'N', 'N' ) = 'N' AND paiment_type_id = 3;
   RETURN l_paiments;
  END get_paiments_ntt_op_type_3; 
   
  -- Собрать записи четвёртого типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_4 RETURN t_paiments AS
    l_paiments api.t_paiments;
  BEGIN
   SELECT  ora_rowscn,
           ROWID,
           paiment_id,
           bankomat_id,
           paiment_type_id,
           total,
           currency_id,
           is_finished,
           date_addet,
           recipient_id           
   BULK COLLECT INTO l_paiments 
   FROM paiments
   WHERE decode(is_finished , 'N', 'N' ) = 'N' AND paiment_type_id = 4;
   RETURN l_paiments;
  END get_paiments_ntt_op_type_4; 
  
  -- Собрать записи пятого типа в колекцию (NTT) из таблицы paiments (optimistic)
  FUNCTION get_paiments_ntt_op_type_5 RETURN t_paiments AS
    l_paiments api.t_paiments;
  BEGIN
   SELECT  ora_rowscn,
           ROWID,
           paiment_id,
           bankomat_id,
           paiment_type_id,
           total,
           currency_id,
           is_finished,
           date_addet,
           recipient_id           
   BULK COLLECT INTO l_paiments 
   FROM paiments
   WHERE decode(is_finished , 'N', 'N' ) = 'N' AND paiment_type_id = 5;
   RETURN l_paiments;
  END get_paiments_ntt_op_type_5; 
  
  
  
  
/*begin
  -- Initialization
  <Statement>;*/
end api;
/
