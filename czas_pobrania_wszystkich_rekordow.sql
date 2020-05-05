set colsep ','
set headsep off
set pagesize 0
set trimspool on

spool d:\temp\HD_ASORTYMENT_VIEW.csv;
select * from HD_ASORTYMENT_VIEW where aso_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_DOKUMENTYMAG_POZ_VIEW.csv;
select * from HD_DOKUMENTYMAG_POZ_VIEW where omg_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_DOKUMENTYMAG_VIEW.csv;
select * from HD_DOKUMENTYMAG_VIEW where pmg_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_FAKTURA_POZ_VIEW.csv;
select * from HD_FAKTURA_POZ_VIEW where osp_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_FAKTURA_VIEW.csv;
select * from HD_FAKTURA_VIEW where pfs_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_GRUPAASORTYMENTOWA_VIEW.csv;
select * from HD_GRUPAASORTYMENTOWA_VIEW where aga_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_KONTRAHENT_VIEW.csv;
select * from HD_KONTRAHENT_VIEW where usr_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_KONTRAKT_POZ_VIEW.csv;
select * from HD_KONTRAKT_POZ_VIEW where okn_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_KONTRAKT_VIEW.csv;
select * from HD_KONTRAKT_VIEW where pkn_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_MAGAZYN_VIEW.csv;
select * from HD_MAGAZYN_VIEW where mag_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_MAG_VIEW.csv;
select * from HD_MAG_VIEW where pmg_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_RODZAJDOKUMENTU_VIEW.csv;
select * from HD_RODZAJDOKUMENTU_VIEW where rdo_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_TYPDOKUMENTU_VIEW.csv;
select * from HD_TYPDOKUMENTU_VIEW where tdo_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_TYPMAGAZYNU_VIEW.csv;
select * from HD_TYPMAGAZYNU_VIEW where tmg_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_UZYTKOWNIK_VIEW.csv;
select * from HD_UZYTKOWNIK_VIEW where usr_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_ZAMOWIENIE_POZ_DOD_VIEW.csv;
select * from HD_ZAMOWIENIE_POZ_DOD_VIEW where ozd_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_ZAMOWIENIE_POZ_VIEW.csv;
select * from HD_ZAMOWIENIE_POZ_VIEW where ozl_dataaktualizacjirekordu>'20190715' order by 1 desc;
spool d:\temp\HD_ZAMOWIENIE_VIEW.csv;
select * from HD_ZAMOWIENIE_VIEW where pzl_dataaktualizacjirekordu>'20190715' order by 1 desc;

