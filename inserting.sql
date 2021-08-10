INSERT INTO PAIMENT_TYPE (PAIMENT_TYPE_ID,PAIMENT_TYPE) VALUES (PAIMENT_TYPE_SEQ.NEXTVAL,99450);
INSERT INTO TARIFF (ID,BANKOMAT_ID,PAIMENT_TYPE_ID,COMISSION_PST) VALUES (TARIF_SEQ.NEXTVAL,10001,PAIMENT_TYPE_SEQ.CURRVAL,0.01);
INSERT INTO PAIMENT_TYPE (PAIMENT_TYPE_ID,PAIMENT_TYPE) VALUES (PAIMENT_TYPE_SEQ.NEXTVAL,99451);
INSERT INTO TARIFF (ID,BANKOMAT_ID,PAIMENT_TYPE_ID,COMISSION_PST) VALUES (TARIF_SEQ.NEXTVAL,10001,PAIMENT_TYPE_SEQ.CURRVAL,0.012);
INSERT INTO PAIMENT_TYPE (PAIMENT_TYPE_ID,PAIMENT_TYPE) VALUES (PAIMENT_TYPE_SEQ.NEXTVAL,99455);
INSERT INTO TARIFF (ID,BANKOMAT_ID,PAIMENT_TYPE_ID,COMISSION_PST) VALUES (TARIF_SEQ.NEXTVAL,10001,PAIMENT_TYPE_SEQ.CURRVAL,0.015);
INSERT INTO PAIMENT_TYPE (PAIMENT_TYPE_ID,PAIMENT_TYPE) VALUES (PAIMENT_TYPE_SEQ.NEXTVAL,99470);
INSERT INTO TARIFF (ID,BANKOMAT_ID,PAIMENT_TYPE_ID,COMISSION_PST) VALUES (TARIF_SEQ.NEXTVAL,10001,PAIMENT_TYPE_SEQ.CURRVAL,0.018);
INSERT INTO PAIMENT_TYPE (PAIMENT_TYPE_ID,PAIMENT_TYPE) VALUES (PAIMENT_TYPE_SEQ.NEXTVAL,99477);
INSERT INTO TARIFF (ID,BANKOMAT_ID,PAIMENT_TYPE_ID,COMISSION_PST) VALUES (TARIF_SEQ.NEXTVAL,10001,PAIMENT_TYPE_SEQ.CURRVAL,0.02);

UPDATE TEMP SET TYPE = 1 WHERE TYPE = 99450;
UPDATE TEMP SET TYPE = 2 WHERE TYPE = 99451;
UPDATE TEMP SET TYPE = 3 WHERE TYPE = 99455;
UPDATE TEMP SET TYPE = 4 WHERE TYPE = 99470;
UPDATE TEMP SET TYPE = 5 WHERE TYPE = 99477;

INSERT INTO CURRENCY (CURRENCY_ID,CURRENCY_ABBREVIATION,CURRENCY_FULL_NAME) VALUES (CURRENCY_SEQ.NEXTVAL, 'AZN', 'Azerbaijan Manat');
INSERT INTO CURRENCY (CURRENCY_ID,CURRENCY_ABBREVIATION,CURRENCY_FULL_NAME) VALUES (CURRENCY_SEQ.NEXTVAL, 'USD', 'United States Dollar');
INSERT INTO CURRENCY (CURRENCY_ID,CURRENCY_ABBREVIATION,CURRENCY_FULL_NAME) VALUES (CURRENCY_SEQ.NEXTVAL, 'EUR', 'Euro');

INSERT INTO RECIPIENT (RECIPIENT_ID,RECIPIENT_NUMBER, RECIPIENT_NAME,PAIMENT_TYPE_ID ) SELECT RECIPIENT_SEQ.NEXTVAL, NOMER, NAME,TYPE FROM TEMP;

/
INSERT INTO RECIPIENT (RECIPIENT_ID,RECIPIENT_NUMBER, RECIPIENT_NAME,PAIMENT_TYPE_ID ) 
SELECT RECIPIENT_SEQ.NEXTVAL,  RECIPIENT_NUMBER+1, recipient_name,paiment_type_id FROM RECIPIENT;
/
DECLARE

l_res NUMBER;

BEGIN

FOR I  IN (SELECT RECIPIENT_ID,PAIMENT_TYPE_ID FROM RECIPIENT)
LOOP

L_res := round(DBMS_RANDOM.VALUE( 1, 500),2);

INSERT INTO PAIMENTS (PAIMENT_ID,
                      BANKOMAT_ID, 
                      PAIMENT_TYPE_ID,   
                      TOTAL, 
                      CURRENCY_ID, 
                      IS_FINISHED,
                      DATE_ADDET, 
                      RECIPIENT_ID) 
              VALUES (PAIMENTS_SEQ.NEXTVAL,
                      '10001',
                      I.PAIMENT_TYPE_ID, 
                      L_RES,
                     '1',
                      'N',
                      sysTIMESTAMP,
                      I.RECIPIENT_ID);


END LOOP;

end;