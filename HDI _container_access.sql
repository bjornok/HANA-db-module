/*
**  In SAP Web IDE, go to DB Explorer, select your HDI-container, and rigth-click --> Open SQL Console as Administrator
**  Reference: https://blogs.sap.com/2018/01/24/the-easy-way-to-make-your-hdi-container-accessible-to-a-classic-database-user/
*/

/* Go to to <container>#DI schema, in the example, container is BKTEST_1 */
set schema "BKTEST_1#DI";
/* Create a temporary table to add privileges */
create local temporary column table "#PRIVILEGES" like "_SYS_DI"."TT_SCHEMA_PRIVILEGES"; 

insert into "#PRIVILEGES" ("PRIVILEGE_NAME", "PRINCIPAL_SCHEMA_NAME", "PRINCIPAL_NAME") values ('SELECT', '', '<myuser>');
insert into "#PRIVILEGES" ("PRIVILEGE_NAME", "PRINCIPAL_SCHEMA_NAME", "PRINCIPAL_NAME") values ('INSERT', '', '<myuser>');
insert into "#PRIVILEGES" ("PRIVILEGE_NAME", "PRINCIPAL_SCHEMA_NAME", "PRINCIPAL_NAME") values ('UPDATE', '', '<myuser>');
insert into "#PRIVILEGES" ("PRIVILEGE_NAME", "PRINCIPAL_SCHEMA_NAME", "PRINCIPAL_NAME") values ('DELETE', '', '<myuser>');
/* Not sure if this works - according to BLOG, only the four above privileges works */
insert into "#PRIVILEGES" ("PRIVILEGE_NAME", "PRINCIPAL_SCHEMA_NAME", "PRINCIPAL_NAME") values ('CREATE ANY', '', 'BKUSER');

call "BKTEST_1#DI"."GRANT_CONTAINER_SCHEMA_PRIVILEGES"("#PRIVILEGES", "_SYS_DI"."T_NO_PARAMETERS", ?, ?, ?);
-- call "BKTEST_1#DI"."REVOKE_CONTAINER_SCHEMA_PRIVILEGES"("#PRIVILEGES", "_SYS_DI"."T_NO_PARAMETERS", ?, ?, ?);

drop table "#PRIVILEGES";

