-- puœciæ jako dba
create or replace view &&CUTTER_SCHEMA..hd_uzytkownik_view as
select
  trim(upper(o.id)) USR_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_uzytkownik l where l.id=o.nr_oper),'20181113') USR_DataAktualizacjiRekordu
  ,0 USR_Usuniety
  ,o.id USR_Nazwa
  ,SUBSTR(o.nazwa, 1, Instr(o.nazwa, ' ', -1, 1) -1) USR_Imie
  ,SUBSTR(o.nazwa, Instr(o.nazwa, ' ', -1, 1) +1) USR_Nazwisko
  ,'' USR_Email
  ,'' USR_Dzial
  ,'' USR_Stanowisko
from &&CUTTER_SCHEMA..operatorzy o
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_kontrahent_view as
select
  k.nr_kon KNT_OrgKey  
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_kontrahent l where l.id=k.nr_kon),'20181113') USR_DataAktualizacjiRekordu
  ,0 KNT_Usuniety
  ,k.naz_kon KNT_Nazwa
  ,K.skrot_k KNT_Kod
  ,k.NIP KNT_NIP
  ,k.miasto KNT_Miasto
  ,k.adres KNT_Adres
  ,trim(upper(o.id)) KNT_OpiekunUsrOrgKey
  ,decode(k.rodz_kon,'Odb','ODBIORCA','Dos','DOSTAWCA','INNE') KNT_TypKontrahenta
  ,k.nr_kon KNT_NrKontr
from &&CUTTER_SCHEMA..klient k
left join &&CUTTER_SCHEMA..ktrkredyt kk on kk.numer_komputerowy=k.nr_kon
left join &&CUTTER_SCHEMA..operatorzy o on o.NR_OPER=kk.obsl_nr
with read only;
/
create or replace view &&CUTTER_SCHEMA..hd_asortyment_view as
select
  substr(rawtohex(dbms_crypto.hash(utl_raw.cast_to_raw(to_char(k.nr_mag,'00')||k.indeks),2)),1,40) ASO_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_kartoteka l where l.id=to_char(k.nr_mag,'00')||k.zn_kart||k.indeks),'20181113') ASO_DataAktualizacjiRekordu
  ,k.akt ASO_Usuniety
  ,k.indeks ASO_Kod
  ,k.nazwa ASO_Opis
  ,k.GR_TOW ASO_GrupaAsortymentowaOrgKey
  ,k.jed_pod ASO_JM
  ,tpl.tekst_pelny ASO_NazwaHandlowaPL
  ,ten.tekst_pelny ASO_NazwaHandlowaEN
from &&CUTTER_SCHEMA..kartoteka k
left join &&CUTTER_SCHEMA..struktury s on s.kod_str=k.indeks
left join &&CUTTER_SCHEMA..tlum_napis tpl on tpl.NR_JEZYKA=1 and tpl.gr_wyrazen=1 and tpl.NR_WYRAZENIA=s.NR_KOM_STR+100000
left join &&CUTTER_SCHEMA..tlum_napis ten on ten.NR_JEZYKA=2 and ten.gr_wyrazen=1 and ten.NR_WYRAZENIA=s.NR_KOM_STR+100000
where k.zn_kart in ('Wyr','Tow','Sur','Czy') and k.nr_odz=(select nr_odz from &&CUTTER_SCHEMA..firma)
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_grupaAsortymentowa_view as
select
  g.gr_tow AGA_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_grupatowarowa l where l.id=g.gr_tow),'20181113') AGA_DataAktualizacjiRekordu
  ,0 AGA_Usuniety
  ,g.opis AGA_Nazwa
  ,g.gr_tow AGA_Kod
from &&CUTTER_SCHEMA..gruptow g
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_rodzajdokumentu_view as
select
  'SPR' RDO_OrgKey
  ,'20181113' RDO_DataAktualizacjiRekordu
  ,0 RDO_Usuniety
  ,'Dokumenty sprzeda¿y' RDO_Nazwa
  ,'SPR' RDO_Kod
from dual
union
select 'MAG','20181113',0,'Dokumenty magazynowe','MAG' from dual
union
select 'ZLE','20181113',0,'Zlecenia','ZLE' from dual
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_typdokumentu_view as
select
  'MAG'||typ_dok TDO_OrgKey
  ,'20181113' TDO_DataAktualizacjiRekordu
  ,0 TDO_Usuniety
  ,typ_dok TDO_Kod
  ,tytul TDO_Nazwa
  ,'MAG' RDO_OrgKey
from konfdok where gr_dok='Dok' and typ_dok<>'000'
union
select
  'SPR'||typ_dok
  ,'20181113'
  ,0 
  ,typ_dok 
  ,tytul
  ,'SPR' RDO_OrgKey
from konfdok where gr_dok='Spr' and typ_dok<>'000'
union
select
  'ZLE'||typ_dok
  ,'20181113'
  ,0 
  ,typ_dok 
  ,tytul
  ,'ZLE' RDO_OrgKey
from konfdok where gr_dok='Zle' and typ_dok<>'000'
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_faktura_view as
select
  f.nr_komp PFS_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_faktura l where l.id=f.nr_komp),'20181113') PFS_DataAktualizacjiRekordu
  ,decode(f.stan,4,1,0) PFS_Usuniety
  ,f.prefix||f.nr_doks||f.sufix PFS_Numer
  ,decode(f.storno,1,1,0) PFS_Status
  ,f.nr_plat PFS_PlatnikOrgKey
  ,' ' PFS_AutorUsrOrgKey
  ,' ' PFS_SprzedawcaOrgKey
  ,f.nr_odb PFS_NabywcaOrgKey
  ,'SPR' PFS_RdoOrgKey
  ,'SPR'||f.typ_doks PFS_TdoORgKey
  ,to_char(f.data_wyst,'YYYYMMDD') PFS_DataDokumentu
  ,to_char(f.data_sprzed,'YYYYMMDD') PFS_DataSprzedazy
  ,to_char(f.data_wyst+f.kredyt_dni,'YYYYMMDD') PFS_DataPlatnosci
  ,decode(trim(f.got_kred),'Kr','Pr','Go','Go','Inne') PFS_FormaPlatnosci
  ,f.netto_wal PFS_WartoscNetto
  ,f.vat_wal PFS_WartoscVat
  ,decode(f.NR_KOMP_POPRZE,0,0,1) PFS_Korekta
  ,decode(f.NR_KOMP_POPRZE,0,'',f.nr_komp_poprze) PFS_KorektaDoPfsOrgKey
  ,nvl(ff.netto_wal,0) PFS_KorygowanaWartoscNetto
  ,nvl(ff.vat_wal,0) PFS_KorygowanaWartoscVat
  ,f.prefix_kor PFS_WalutaWalOrgKey
  ,f.wart_netto PFS_WartoscNettoPLN
  ,f.wart_vat PFS_WartoscVATPLN
  ,nvl(ff.wart_netto,0) PFS_KorygowanaWartoscNettoPLN
  ,nvl(ff.wart_vat,0) PFS_KorygowanaWartoscVATPLN
  ,decode(trim(f.prefix_kor),'PLN',1,f.kurs) PFS_KursWaluty
  ,to_char(f.data_tabeli,'YYYYMMDD') PFS_DataKursuWaluty
from &&CUTTER_SCHEMA..faknagl f
left join &&CUTTER_SCHEMA..faknagl ff on f.nr_komp_poprze>0 and ff.nr_komp=f.nr_komp_poprze
where f.stan>1 and f.data_wyst between to_date('01-04-2020','DD-MM-YYYY') and to_date('31-03-2021','DD-MM-YYYY')
order by f.nr_komp
with read only;
/
/*
create or replace function HD_OSP_ORGKey2(p_id_poz number) return VARCHAR2 as
  v_id number;
  v_poz number;
  v_lp_dod number;
begin
  select p.nr_komp_doks,p.nr_poz,p.lp_dod into v_id,v_poz,v_lp_dod from fakpoz p 
  left join faknagl f on f.nr_komp=p.nr_komp_doks
  where p.id_poz=p_id_poz and f.storno=0;
  return trim(to_char(v_id,'0000000000'))||trim(to_char(v_poz,'00000'))||trim(to_char(v_lp_dod,'00'));
end;*/
/
create or replace view &&CUTTER_SCHEMA..hd_faktura_poz_view as
AS
select
trim(to_char(p.nr_komp_doks,'0000000000'))||trim(to_char(p.nr_poz,'00000'))||trim(to_char(p.lp_dod,'00'))
OSP_OrgKey
   ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&CUTTER_SCHEMA..hd_log_faktura l where l.id=p.nr_komp_doks),'20181113') OSP_DataAktualizacjiRekordu
   ,0 OSP_Usuniety
   ,p.nr_komp_doks OSP_PfsOrgKey
   ,p.il_szt OSP_Ilosc
   ,p.ilosc OSP_Iloscm2
   ,0 OSP_CenaEwidencyjna
   ,0 OSP_CenaEwidencyjnam2
   ,0 OSP_CenaNetto
   ,cena_netto_b OSP_CenaNettoPoRabacie
   ,nvl(p.naz_vat,0) OSP_StawkaVat
   ,0 OSP_CenaBrutto
   ,0 OSP_CenaBruttoPoRabacie
   ,0 OSPRabatPrc
   ,' ' OSP_AutorPozycjiUsrOrgKey
   ,' ' OSP_DostawcaKntOrgKey
,trim(to_char(p.id_zlec,'0000000000'))||trim(to_char(p.id_zlec_poz,'000000'))
OSP_OzlOrgKey
   ,' ' OSP_PtpOrgKey
,substr(rawtohex(dbms_crypto.hash(utl_raw.cast_to_raw(to_char(p.nr_mag,'00')||p.indeks),2)),1,40)
OSP_AsoOrgKey
   ,p.indeks OSP_Nazwa
,decode(f.NR_KOMP_POPRZE,0,'',trim(to_char(f.nr_komp_poprze,'0000000000'))||trim(to_char(p.nr_poz,'00000'))||trim(to_char(p.lp_dod,'00')))
OSP_KorektaDoOspOrgKey
,decode(p.lp_dod,0,'',trim(to_char(p.nr_komp_doks,'0000000000'))||trim(to_char(p.nr_poz,'00000'))||trim(to_char(0,'00')))OSP_GlownaDoOspOrgKey
   ,decode(p.lp_dod,0,'',p.indeks) OSP_NazwaDod
   ,decode(p.lp_dod,0,'',p.ilosc) OSP_IloscPol
   ,decode(p.lp_dod,0,'',p.netto_wal) OSP_CenaEwidencyjnaPola
   ,0 OSP_CenaEwidencyjnaPLN
   ,0 OSP_CenaEwidencyjnam2PLN
   ,0 OSP_CenaNettoPLN
   ,0 OSP_CenaNettoPoRabaciePLN
   ,0 OSP_CenaBruttoPLN
   ,0 OSP_CenaBruttoPoRabaciePLN
   ,decode(p.lp_dod,0,'',p.cena_netto) OSP_CenaEwidencyjnaPolaPLN
   ,p.netto_b_wal OSP_WartoscPrzedRabatem
   ,p.netto_wal OSP_WartoscPoRabacie
   ,p.wart_netto_b OSP_WartoscPrzedRabatemPLN
   ,p.wart_netto OSP_WartoscPoRabaciePLN
   ,'MAG'||d.typ_dok OSP_ZrodloTDOOrgKey
   ,p.waga OSP_Waga
   ,p.cena_netto_szt OSP_CenaNettoSztuki
   ,p.nr_poz OSP_NrPoz
   ,decode(p.rodzaj_ceny,'z³/s','szt','m2') OSP_RodzajCeny
   ,pd.cena_surowcowa/pd.ilosc OSP_CenaSurowcowa
from &&CUTTER_SCHEMA..fakpoz p
left join &&CUTTER_SCHEMA..faknagl f on f.nr_komp=p.nr_komp_doks 
left join pozdok dp on dp.nr_komp_dok=p.id_wz and dp.nr_poz=p.id_wz_poz left join dok d on d.NR_KOMP_DOK=dp.nr_dok_zrod 
left join (
    select d.nr_kom_fakt,pd.nr_komp_baz,pd.nr_poz_zlec,sum(pd.ilosc_jp*pd.cen_wyd) cena_surowcowa, sum(pd.ilosc_jr) ilosc from pozdok pd
    left join dok d on d.nr_komp_dok=pd.nr_komp_dok
    where pd.typ_dok='WZ' group by d.nr_kom_fakt,pd.nr_komp_baz,pd.nr_poz_zlec
) pd on pd.nr_kom_fakt=p.nr_komp_doks and pd.nr_komp_baz=p.id_zlec and pd.nr_poz_zlec=p.id_zlec_poz
where f.data_wyst between to_date('01-04-2020','DD-MM-YYYY') and to_date('31-03-2021','DD-MM-YYYY')
WITH READ ONLY;
/

create or replace view &&CUTTER_SCHEMA..hd_typmagazynu_view as
select
  'SUR' TMG_OrgKey
  ,'20181113' TMG_DataAktualizacjiRekordu
  ,0 TMG_Usuniety
  ,'Magayn surowców' TMG_Nazwa
  ,'Sur' TMG_Kod
from dual
union
select 'TOW','20181113',0,'Magazyn towarów','Tow' from dual
union
select 'WYR','20181113',0,'Magazyn wyrobów','Wyr' from dual
union
select 'CZY','20181113',0,'Magazyn czynnoœci','Czy' from dual
union
select 'POL','20181113',0,'Magazyn pó³produktów','Pó³' from dual
union
select 'OTHER','20181113',0,'Magazyn inny - niepoprawny',' ' from dual
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_magazyn_view as
select
  m.NR_MAG MAG_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_magazyn l where l.id=m.nr_mag),'20181113') MAG_DataAktualizacjiRekordu
  ,0 MAG_Usuniety
  ,m.NAZ_MAG MAG_Nazwa
  ,m.nr_mag MAG_Kod
  ,decode(m.znacznik,'Pó³','POL','Sur','SUR','Tow','TOW','Czy','CZY','Wyr','WYR','OTHER') MAG_TmgOrgKey
  ,m.miasto MAG_Lokalizacja
from &&CUTTER_SCHEMA..magazyn m
with read only;
/
create or replace view &&CUTTER_SCHEMA..hd_zamowienie_view as
select
  z.nr_kom_zlec PZL_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_zamowienie l where l.id=z.nr_kom_zlec),'20181113') PZL_DataAktualizacjiRekordu
  ,decode(z.status,'A',1,0) PZL_Usuniety
  ,z.nr_zlec PZL_Numer
  ,0 PZL_Status
  ,z.nr_kon PZL_KontrahentKntOrgKey
  ,trim(upper(z.nr_op_wpr)) PZL_AutoOrgKey
  ,z.nr_zlec_kli PZL_NumerZamKlienta
  ,'ZLE' PZL_RdoOrgKey
  ,'ZLE'||z.typ_zlec PZL_TdoOrgKey
  ,to_char(z.data_zl,'YYYYMMDD') PZL_DataDokumentu
  ,'' PZL_DataSprzedazy
  ,'' PZL_DataPlatnosci
  ,'' PZL_FormaPlatnosci
  ,0 PZL_WartoscNetto
  ,waluta PZL_WalutaWalOrgKey
  ,kurs PZL_KursWaluty
  ,'' PZL_DataKursuWaluty
  ,z.wart_zlec PZL_WartoscNettoPLN
  ,z.nr_kontraktu PZL_NumerKontraktu
from &&CUTTER_SCHEMA..zamow z
where z.FORMA_WPROW in ('C','P') and z.wyroznik in ('Z','R') and z.status in ('P','Z','K')
with read only;
/
create or replace view &&CUTTER_SCHEMA..hd_zamowienie_poz_view as
select
  trim(to_char(p.nr_kom_zlec,'0000000000'))||trim(to_char(p.nr_poz,'000000')) OZL_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_zamowienie l where l.id=p.nr_kom_zlec),'20181113') OZL_DataAktualizacjiRekordu
  ,0 OZL_Usuniety
  ,p.nr_kom_zlec OZL_PzlOrgKey
  ,p.nr_poz OZL_NrPoz
  ,p.kod_str OZL_Nazwa
  ,p.ilosc OZL_Ilosc
  ,p.cena OZL_CenaEwidencyjna
  ,p.nr_mag OZD_MagOrgKey
  ,substr(rawtohex(dbms_crypto.hash(utl_raw.cast_to_raw(to_char(p.nr_mag,'00')||p.kod_Str),2)),1,40) OZD_AsoOrgKey
  ,0 OZL_CenaEwidencyjnaPLN
  ,p.szer OZL_Szerokosc
  ,p.wys OZL_Wysokosc
  ,p.pow_jed_fak OZL_PowierzchniaDoFakturowania
  ,decode(p.nrkatk,0,0,1) OZL_CzyKsztalt
from &&CUTTER_SCHEMA..spisz p
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_zamowienie_poz_dod_view as
select
  trim(to_char(p.nr_kom_zlec,'0000000000'))||trim(to_char(p.nr_poz,'000000'))||trim(to_char(p.kol_dod,'000000')) OZD_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_zamowienie l where l.id=p.nr_kom_zlec),'20181113') OZD_DataAktualizacjiRekordu
  ,0 OZD_Usuniety
  ,p.nr_kom_zlec OZD_PzlOrgKey
  ,trim(to_char(p.nr_kom_zlec,'0000000000'))||trim(to_char(p.nr_poz,'000000')) OZD_OzlOrgKey
  ,p.kod_dod OZD_Nazwa
  ,p.il_pol_szp OZD_IloscPol
  ,p.cena OZD_CenaEwidencyjna
  ,p.nr_mag OZD_MagOrgKey
  ,substr(rawtohex(dbms_crypto.hash(utl_raw.cast_to_raw(to_char(p.nr_mag,'00')||p.kod_dod),2)),1,40) OZD_AsoOrgKey
  ,0 OZD_CenaEwidencyjnaPLN
from &&CUTTER_SCHEMA..spisd p
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_dokumentymag_view as
select
  d.nr_komp_dok PMG_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..HD_LOG_DOKUMENTYMAG l where l.id=d.nr_komp_dok),'20181113') PMG_DataAktualizacjiRekordu
  ,0 PMG_Usuniety 
  ,d.nr_dok PMG_Numer
  ,'' PMG_DostawcaOrgKey
  ,d.nr_mag PMG_MagOrgKey
  ,d.storno PMG_Status
  ,'MAG' PMG_RdoOrgKey
  ,'MAG'||d.typ_dok PMG_TdoOrgKey
  ,trim(upper(d.nr_op_wpr)) PMG_AutorUsrOrgKey
  ,to_char(d.data_d,'YYYYMMDD') PMG_DataDokumentu
  ,decode(d.typ_dok,'OO+',d.nr_mag_doc,0) PMG_SrcOddzialCutter
  ,decode(d.typ_dok,'OO+',
    decode(d.nr_mag_doc,
-- tlumaczenie nr_oddzialu na numery w Intense
--      Kraków
        3,1,
--      Bia³ystok
        4,2,        
--      Bydgoszcz
        5,3,
--      Ostro³êka
        7,4,
--      Skierniewice                         
        2,5,
--      Szczecin
        8,6,
--      Wroc³aw                         
        6,7,
--      Metal        
        4,8,
--      else
        0),
    0) PMG_SrcKeyOO
  ,decode(d.typ_dok,'OO+',d.nr_kom_fakt,0) PMG_OrgKeyOO
from &&CUTTER_SCHEMA..dok d
with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_dokumentymag_poz_view as
select
  trim(to_char(p.nr_komp_dok,'0000000000'))||trim(to_char(p.nr_poz,'000000'))||trim(to_char(p.kol_dod,'000000')) OMG_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_dokumentymag l where l.id=p.nr_komp_dok),'20181113') OMG_DataAktualizacjiRekordu
  ,0 OMG_Usuniety
  ,p.nr_komp_dok OMG_PmgOrgKey
  ,p.indeks OMG_Nazwa
  ,p.ilosc_jp OMG_Ilosc
  ,0 OMG_CenaEwidencyjna
  ,p.cena_przyj OMG_CenaPrzyjecie
  ,p.cen_wyd OMG_CenaWydanie
  ,p.nr_mag OMG_MagOrgKey
  ,substr(rawtohex(dbms_crypto.hash(utl_raw.cast_to_raw(to_char(p.nr_mag,'00')||p.indeks),2)),1,40) OMG_AsoOrgKey
  ,trim(to_char(fp.nr_komp_doks,'0000000000'))||trim(to_char(fp.nr_poz,'00000'))||trim(to_char(fp.lp_dod,'00')) OMG_OspOrgKey
  ,trim(to_char(p.nr_komp_baz,'0000000000'))||trim(to_char(p.nr_poz_zlec,'000000')) OMG_OzlOrgKey
  ,0 OMG_OdsOrgKey
  ,decode(p.kol_dod,0,'',trim(to_char(p.nr_komp_dok,'0000000000'))||trim(to_char(p.nr_poz,'000000'))||trim(to_char(0,'000000'))) OMG_GlownaDoOmgOrgKey
  ,decode(p.kol_dod,0,'',p.indeks) OMG_NazwaDod
  ,decode(p.kol_dod,0,'',p.ilosc_jp) OMG_IloscPol
  ,decode(p.kol_dod,0,'',0) OMG_CenaEwidencyjnaPola
  ,decode(p.kol_dod,0,'',p.cena_przyj) OMG_CenaPolaPrzyjecie
  ,decode(p.kol_dod,0,'',p.cen_wyd) OMG_CenaPolaWydanie
from &&CUTTER_SCHEMA..pozdok p
left join fakpoz fp on fp.id_poz=p.id_poz_fak
left join faknagl f on f.nr_komp=fp.nr_komp_doks and f.storno=0

with read only;
/

create or replace view &&CUTTER_SCHEMA..hd_kontrakt_view as
select
  trim(to_char(kon.nr_komp_kontr,'0000000000')) PKN_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_kontrakt l where l.id=kon.nr_komp_kontr),'20181113') PKN_DataAktualizacjiRekordu
  ,decode(kon.status,1,0,1) PKN_Usuniety
  ,' ' PKN_Region
  ,' ' PKN_UsrOrgKey
  ,kon.nr_kontr PKN_Numer
  ,kon.nr_kontr PKN_Nazwa
  ,kon.nr_kon PKN_KntOrgKey
  ,0 PKN_Ilosc
  ,kon.wart_plan PKN_Wartosc
  ,0 PKN_Prowizja
  ,0 PKN_Odlegosc
  ,0 PKN_KRAJ
  ,0 PKN_PzlOrgKey
  ,kon.waluta PKN_WalutaWalOrgKey
  ,kon.kurs PKN_KursWaluty
  ,kon.data_kursu PKN_DataKursuWaluty
  ,0 PKN_WartoscPLN
  ,0 PKN_ProwizjaPLN
  ,kon.os_odpow PKN_OsobaOdpowiedzialna
from &&CUTTER_SCHEMA..kontrakt kon
with read only;
/
create or replace view &&CUTTER_SCHEMA..hd_kontrakt_poz_view as
select
  trim(to_char(p.nr_komp_kontr,'0000000000')) OKN_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_kontrakt l where l.id=p.nr_komp_kontr),'20181113') OKN_DataAktualizacjiRekordu
  ,0 OKN_Usuniety
  ,p.poz_kontr OKN_PozycjaKontraktu
  ,' ' OKN_PzlOrgKey
  ,0 OKN_Ilosc
  ,p.cena_um OKN_CenaEwidencyjna
  ,substr(rawtohex(dbms_crypto.hash(utl_raw.cast_to_raw('03'||p.indeks),2)),1,40) OZL_AsoOrgKey
  ,0 OKN_CenaEwidencyjnaPLN
from &&CUTTER_SCHEMA..pozkontr p
with read only;
--/
--create or replace view &&CUTTER_SCHEMA..hd_produkty_view as
--select
--  trim(to_char(e.nr_kom_szyby,'0000000000')) PPR_OrgKey
--  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..HD_LOG_PRODUKT l where l.id=e.nr_kom_szyby),'20181113') PPR_DataAktualizacjiRekordu
--  ,0 PPR_Usuniety
--  ,e.nr_komp_zlec PPR_PzlOrgKey
--  ,e.nr_poz PPR_NrPozycji
--  ,e.nr_szt PPR_NrSztuki
--  ,pd.ilosc_jp*pd.cen_wyd/(select count(*) from spise where spise.nr_k_wz=e.nr_k_wz and spise.nr_poz_wz=e.nr_poz_wz) PPR_CenaSurowcowa
--  ,e.nr_kom_szyby PPR_NrSeryjnySzyby
--from &&CUTTER_SCHEMA..spise e
--left join &&CUTTER_SCHEMA..pozdok pd on pd.nr_komp_dok=e.nr_k_wz and pd.nr_poz_zlec=e.nr_poz and pd.kol_dod=0
--with read only;
/
CREATE VIEW &&CUTTER_SCHEMA..HD_PRODUKTY_VIEW AS select
  trim(to_char(e.nr_kom_szyby,'0000000000')) PPR_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&CUTTER_SCHEMA..HD_LOG_PRODUKT l where l.id=e.nr_kom_szyby),'20181113') PPR_DataAktualizacjiRekordu
  ,0 PPR_Usuniety
  ,e.nr_komp_zlec PPR_PzlOrgKey
  ,e.nr_poz PPR_NrPozycji
  ,e.nr_szt PPR_NrSztuki
  ,pd.ilosc_jp*pd.cen_wyd/i.ile PPR_CenaSurowcowa
  ,e.nr_kom_szyby PPR_NrSeryjnySzyby
from &&CUTTER_SCHEMA..spise e
          left join &&CUTTER_SCHEMA..pozdok pd on pd.nr_komp_dok=e.nr_k_wz and pd.nr_poz_zlec=e.nr_poz and pd.kol_dod=0
    ,( select count(*) as ile, i.nr_k_wz, i.nr_poz_wz from spise i group by i.nr_k_wz, i.nr_poz_wz ) i  -- dodane
where i.nr_k_wz=e.nr_k_wz and i.nr_poz_wz=e.nr_poz_wz     -- dodane
WITH READ ONLY;
/

create or replace view &&CUTTER_SCHEMA..hd_pozycje_obrobki_view as
select 
  trim(to_char(p.nr_kom_zlec,'0000000000'))||trim(to_char(p.nr_poz,'000000'))||trim(to_char(s.nr_k_p_obr,'0000')) OBR_OrgKey
  ,nvl((select to_char(max(l.LOG_DATE),'YYYYMMDD') from &&cutter_schema..hd_log_zamowienie l where l.id=p.nr_kom_zlec),'20181113') OBR_DataAktualizacjiRekordu
  ,p.nr_kom_zlec OBR_PzlOrgKey
  ,p.nr_poz OBR_NrPoz
  ,s.symb_p_obr OBR_SymbolObrobki
  ,s.nazwa_p_obr OBR_NazwaObrobki
  ,nvl(a.il_obr*p.ilosc,0) OBR_IloscObrobki
from &&CUTTER_SCHEMA..spisz p 
left join &&CUTTER_SCHEMA..slparob s on 1=1
left join 
(
  select v.nr_kom_zlec, v.nr_poz, v.nk_obr, sum(V.il_obr) il_obr
  from &&CUTTER_SCHEMA..v_spiss v where v.inst_std=v.nk_inst
  group by v.nr_kom_zlec,v.nr_poz,v.nk_obr
)a on a.nr_kom_zlec=p.nr_kom_zlec and a.nr_poz=p.nr_poz and a.nk_obr=s.nr_k_p_obr
with read only;