-- ****************************
--
-- Skrypt zaklada obiekty potrzebne do uruchomienia widoków dla Hurtowni Danych
--
-- ***************************


-- pusciæ jako DBA: SYS,SYSTEM,CUTTER
define path='.\';
define cutter_schema='test1';
define hd_schema='intense';
define hd_role='hd_role';


--  CREATE TABLESPACE "INTENSE" DATAFILE 
--  'E:\ORACLE\ORADATA\ARCHIVE\INTENSE.DBF' SIZE 104857600
--  AUTOEXTEND ON NEXT 33554432 MAXSIZE 32767M
--  LOGGING ONLINE PERMANENT BLOCKSIZE 8192
--  EXTENT MANAGEMENT LOCAL AUTOALLOCATE DEFAULT NOCOMPRESS  SEGMENT SPACE MANAGEMENT AUTO;

-- pusciæ tylko raz
--CREATE USER &&hd_schema IDENTIFIED BY "intense123"  DEFAULT TABLESPACE "INTENSE" TEMPORARY TABLESPACE "TEMP" default profile CUTTER
;
--ALTER USER &&hd_schema QUOTA UNLIMITED ON INTENSE;
--create role &&hd_role;
--grant &&hd_role to &&intense;
--grant connect to &&intense;
--alter user &&intense default role connect,&&hd_role;
--grant execute on sys.dbms_crypto to &&cutter_schema;

@'&path\HD_Intense_01_remove_ALL.sql';
@'&path\HD_Intense_02_logs.sql';
@'&path\HD_Intense_03_triggers.sql';
@'&path\HD_Intense_04_views.sql';
@'&path\HD_Intense_05_grants.sql';
@'&path\HD_Intense_08_enable_triggers.sql';
