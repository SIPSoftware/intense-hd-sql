-- puœciæ jako dba
CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_klient_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..klient
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_kontrahent.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_kontrahent (log_date, id, action)
    VALUES (SYSDATE, :new.nr_kon, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_klient_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_operatorzy_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..operatorzy
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_uzytkownik.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_uzytkownik (log_date, id, action)
    VALUES (SYSDATE, :new.id, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_operatorzy_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_kartoteka_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..kartoteka
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_kartoteka.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;
  if (:new.nazwa<>:old.nazwa) or (:new.akt<>:old.akt) or (:new.indeks<>:old.indeks) or 
  (:new.gr_tow<>:old.gr_tow) or (:new.jed_pod<>:old.jed_pod) then
    INSERT INTO &&CUTTER_SCHEMA..hd_log_kartoteka (log_date, id, action)
        VALUES (SYSDATE, to_char(:new.nr_mag,'00')||:new.zn_kart||:new.indeks, log_action);
  end if;
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_kartoteka_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_gruptow_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..gruptow
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_grupatowarowa.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_grupatowarowa (log_date, id, action)
    VALUES (SYSDATE, :new.gr_tow, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_gruptow_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_faknagl_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..faknagl
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_faktura.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_faktura (log_date, id, action)
    VALUES (SYSDATE, :new.nr_komp, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_faknagl_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_fakpoz_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..fakpoz
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_faktura.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_faktura (log_date, id, action)
    VALUES (SYSDATE, :new.nr_komp_doks, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_fakpoz_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_magazyn_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..magazyn
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_magazyn.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_magazyn (log_date, id, action)
    VALUES (SYSDATE, :new.nr_mag, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_magazyn_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_zamow_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..zamow
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_zamowienie.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_zamowienie (log_date, id, action)
    VALUES (SYSDATE, :new.nr_kom_zlec, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/

alter TRIGGER &&CUTTER_SCHEMA..hd_zamow_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_spisz_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..spisz
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_zamowienie.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_zamowienie (log_date, id, action)
    VALUES (SYSDATE, :new.nr_kom_zlec, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/

alter TRIGGER &&CUTTER_SCHEMA..hd_spisz_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_spisd_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..spisd
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_zamowienie.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_zamowienie (log_date, id, action)
    VALUES (SYSDATE, :new.nr_kom_zlec, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/

alter TRIGGER &&CUTTER_SCHEMA..hd_spisd_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_zlectyp_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..zlec_typ
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_zamowienie.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_zamowienie (log_date, id, action)
    VALUES (SYSDATE, :new.nr_komp_zlec, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_zlectyp_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_dok_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..dok
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_dokumentymag.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_dokumentymag (log_date, id, action)
    VALUES (SYSDATE, :new.nr_komp_dok, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/

alter TRIGGER &&CUTTER_SCHEMA..hd_dok_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_pozdok_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..pozdok
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_dokumentymag.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_dokumentymag (log_date, id, action)
    VALUES (SYSDATE, :new.nr_komp_dok, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/

alter TRIGGER &&CUTTER_SCHEMA..hd_pozdok_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_kontrakt_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..kontrakt
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_kontrakt.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_kontrakt (log_date, id, action)
    VALUES (SYSDATE, :new.nr_komp_kontr, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_kontrakt_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_pozkontr_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..pozkontr
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_kontrakt.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_kontrakt (log_date, id, action)
    VALUES (SYSDATE, :new.NR_KOMP_KONTR, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_pozkontr_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_spise_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..spise
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_produkt.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_produkt (log_date, id, action)
    VALUES (SYSDATE, :new.nr_kom_szyby, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_spise_CHANGE_TRIGGER disable;
/

/*CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_zamowienie_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..zamow
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_zamowienie.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_zamowienie (log_date, id, action)
    VALUES (SYSDATE, :new.nr_kom_zlec, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_zamowienie_CHANGE_TRIGGER disable;
/

CREATE OR REPLACE TRIGGER &&CUTTER_SCHEMA..hd_zlectyp_CHANGE_TRIGGER
  AFTER INSERT OR UPDATE OR DELETE
  ON &&CUTTER_SCHEMA..zlec_typ
  for each row
DECLARE
  log_action &&CUTTER_SCHEMA..hd_log_zamowienie.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'I';
  ELSIF UPDATING THEN
    log_action := 'U';
  ELSIF DELETING THEN
    log_action := 'D';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is not reachable.');
  END IF;

  INSERT INTO &&CUTTER_SCHEMA..hd_log_zamowienie (log_date, id, action)
    VALUES (SYSDATE, :new.nr_komp_zlec, log_action);
  EXCEPTION
    WHEN OTHERS THEN null;
END;
/
alter TRIGGER &&CUTTER_SCHEMA..hd_zlectyp_CHANGE_TRIGGER disable;
/


*/