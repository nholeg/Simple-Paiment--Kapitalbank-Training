CREATE OR replace function test RETURN SYS_REFCURSOR 

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
END ;
/
