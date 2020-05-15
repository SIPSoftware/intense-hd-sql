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
