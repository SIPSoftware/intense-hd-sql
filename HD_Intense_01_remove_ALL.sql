drop TABLE &&CUTTER_SCHEMA.."HD_LOG_UZYTKOWNIK";
drop TABLE &&CUTTER_SCHEMA.."HD_LOG_KONTRAHENT";
drop TABLE &&CUTTER_SCHEMA.."HD_LOG_KARTOTEKA";
drop TABLE &&CUTTER_SCHEMA.."HD_LOG_GRUPATOWAROWA";
drop TABLE &&CUTTER_SCHEMA.."HD_LOG_FAKTURA";
drop TABLE &&CUTTER_SCHEMA.."HD_LOG_MAGAZYN";
drop TABLE &&CUTTER_SCHEMA.."HD_LOG_ZAMOWIENIE";
drop TABLE &&CUTTER_SCHEMA.."HD_LOG_DOKUMENTYMAG";

drop TRIGGER &&CUTTER_SCHEMA..hd_klient_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_operatorzy_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_kartoteka_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_gruptow_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_faknagl_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_fakpoz_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_magazyn_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_zamow_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_spisz_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_spisd_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_zlectyp_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_dok_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_pozdok_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_kontrakt_CHANGE_TRIGGER;
drop TRIGGER &&CUTTER_SCHEMA..hd_pozkontr_CHANGE_TRIGGER;

drop SYNONYM &&HD_SCHEMA..D_UZYTKOWNIK;
drop SYNONYM &&HD_SCHEMA..D_KONTRAHENT;
drop SYNONYM &&HD_SCHEMA..D_ASORTYMENT;
drop SYNONYM &&HD_SCHEMA..D_GRUPAASORTYMENTOWA;
drop SYNONYM &&HD_SCHEMA..D_RODZAJDOKUMENTU;
drop SYNONYM &&HD_SCHEMA..D_TYPDOKUMENTU;
drop SYNONYM &&HD_SCHEMA..D_FAKTURASPRZEDAZY;
drop SYNONYM &&HD_SCHEMA..F_FSPOZYCJE;
drop SYNONYM &&HD_SCHEMA..D_TYPMAGAZYNU;
drop SYNONYM &&HD_SCHEMA..D_MAGAZYNOWE;
drop SYNONYM &&HD_SCHEMA..D_ZLECENIE;
drop SYNONYM &&HD_SCHEMA..F_ZLECENIE_POZYCJE;
drop SYNONYM &&HD_SCHEMA..F_ZLECENIE_POZYCJE_DODATKOWE;
drop SYNONYM &&HD_SCHEMA..D_MAGAZYNOWY;
drop SYNONYM &&HD_SCHEMA..F_MAGAZYN_POZYCJE;

drop view &&CUTTER_SCHEMA..hd_uzytkownik_view;
drop view &&CUTTER_SCHEMA..hd_kontrahent_view;
drop view &&CUTTER_SCHEMA..hd_asortyment_view;
drop view &&CUTTER_SCHEMA..hd_grupaAsortymentowa_view;
drop view &&CUTTER_SCHEMA..hd_rodzajdokumentu_view;
drop view &&CUTTER_SCHEMA..hd_typdokumentu_view;
drop view &&CUTTER_SCHEMA..hd_faktura_view;
drop view &&CUTTER_SCHEMA..hd_faktura_poz_view;
drop view &&CUTTER_SCHEMA..hd_typmagazynu_view;
drop view &&CUTTER_SCHEMA..hd_magazyn_view;
drop view &&CUTTER_SCHEMA..hd_zamowienie_view;
drop view &&CUTTER_SCHEMA..hd_zamowienie_poz_view;
drop view &&CUTTER_SCHEMA..hd_zamowienie_poz_dod_view;
drop view &&CUTTER_SCHEMA..hd_dokumentymag_view;
drop view &&CUTTER_SCHEMA..hd_dokumentymag_poz_view;
drop view &&CUTTER_SCHEMA..hd_kontrakt_view;
drop view &&CUTTER_SCHEMA..hd_kontrakt_poz_view;

