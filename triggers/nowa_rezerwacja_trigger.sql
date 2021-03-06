CREATE OR REPLACE TRIGGER nowa_rezerwacja_trigger
  AFTER INSERT
  ON REZERWACJE
  FOR EACH ROW
  BEGIN
    INSERT INTO REZERWACJE_LOG (ID_REZERWACJI, DATA, STATUS)
    VALUES (:NEW.NR_REZERWACJI, CURRENT_DATE, :NEW.STATUS);

    UPDATE WYCIECZKI w
    SET LICZBA_WOLNYCH_MIEJSC = LICZBA_WOLNYCH_MIEJSC - 1
    WHERE w.ID_WYCIECZKI = :NEW.ID_WYCIECZKI;
  end nowa_rezerwacja_trigger;