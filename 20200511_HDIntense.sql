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
   --,decode(p.lp_dod,0,'',p.netto_wal) OSP_CenaEwidencyjnaPolaPLN
   ,0 OSP_CenaEwidencyjnaPolaPLN
   ,0 OSP_CenaEwidencyjnaPLN
   ,0 OSP_CenaEwidencyjnam2PLN
   ,0 OSP_CenaNettoPLN
   ,0 OSP_CenaNettoPoRabaciePLN
   ,0 OSP_CenaBruttoPLN
   ,0 OSP_CenaBruttoPoRabaciePLN
   ,decode(p.lp_dod,0,'',p.cena_netto) OSP_CenaEwidencyjnaPola
   ,p.netto_b_wal OSP_WartoscPrzedRabatem
   ,p.netto_wal OSP_WartoscPoRabacie
   ,p.wart_netto_b OSP_WartoscPrzedRabatemPLN
   ,p.wart_netto OSP_WartoscPoRabaciePLN
   ,'MAG'||d.typ_dok OSP_ZrodloTDOOrgKey
   ,p.waga OSP_Waga
   ,p.cena_netto_szt OSP_CenaNettoSztuki
   ,p.nr_poz OSP_NrPoz
   ,decode(p.rodzaj_ceny,'z³/s','szt','m2') OSP_RodzajCeny
   ,decode(p2.ilosc,0,pd.cena_surowcowa,pd.cena_surowcowa/p2.ilosc) OSP_CenaSurowcowaM2
   ,decode(p2.il_szt,0,pd.cena_surowcowa,pd.cena_surowcowa/p2.il_szt) OSP_CenaSurowcowaSzt
from &&CUTTER_SCHEMA..fakpoz p
left join &&CUTTER_SCHEMA..faknagl f on f.nr_komp=p.nr_komp_doks 
left join pozdok dp on dp.nr_komp_dok=p.id_wz and dp.nr_poz=p.id_wz_poz left join dok d on d.NR_KOMP_DOK=dp.nr_dok_zrod 
left join (
    select d.nr_kom_fakt,pd.nr_komp_baz,pd.nr_poz_zlec,sum(pd.ilosc_jp*pd.cen_wyd) cena_surowcowa, sum(pd.ilosc_jr) ilosc from pozdok pd
    left join dok d on d.nr_komp_dok=pd.nr_komp_dok
    where pd.typ_dok='WZ' group by d.nr_kom_fakt,pd.nr_komp_baz,pd.nr_poz_zlec
) pd on pd.nr_kom_fakt=p.nr_komp_doks and pd.nr_komp_baz=p.id_zlec and pd.nr_poz_zlec=p.id_zlec_poz
left join (
    select fp.nr_komp_doks,fp.id_zlec,fp.id_zlec_poz,sum(ilosc) ilosc,sum(il_szt) il_szt from fakpoz fp where czy_dod<>'T' group by fp.nr_komp_doks,fp.id_zlec,fp.id_zlec_poz
) p2 on p2.nr_komp_doks=p.nr_komp_doks and p2.id_zlec=p.id_zlec and p2.id_zlec_poz=p.id_zlec_poz;
where f.data_wyst between to_date('01-04-2020','DD-MM-YYYY') and to_date('31-03-2021','DD-MM-YYYY')
WITH READ ONLY;
/
