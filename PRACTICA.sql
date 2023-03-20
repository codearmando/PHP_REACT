prompt PL/SQL Developer Export Tables for user GABRIEL@PRUEBA
prompt Created by User on martes, 14 de marzo de 2023
set feedback off
set define off

prompt Creating PRACTICA...
create table PRACTICA
(
  pk_practica      INTEGER not null,
  nombre_usuario   VARCHAR2(30),
  apellido_usuario VARCHAR2(30),
  fecha_nacimiento DATE,
  create_date      DATE,
  fk_estado        VARCHAR2(2),
  fk_municipio     VARCHAR2(3),
  fk_parroquia     VARCHAR2(4),
  modified_date    DATE
)
;
alter table PRACTICA
  add constraint PK_PRACTICA primary key (PK_PRACTICA);

prompt Loading PRACTICA...
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (2, 'Manuel', 'Rincon', to_date('24-01-2001', 'dd-mm-yyyy'), to_date('14-03-2023 11:08:09', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (5, 'eliany', 'guillen', to_date('13-06-2000', 'dd-mm-yyyy'), to_date('14-03-2023 11:09:19', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (6, 'ronny', 'montañes', to_date('13-06-2000', 'dd-mm-yyyy'), to_date('14-03-2023 11:23:10', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (7, 'jose', 'castillo', to_date('13-06-1989', 'dd-mm-yyyy'), to_date('14-03-2023 14:50:10', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (8, 'simon', 'Bolivar', to_date('13-06-1881', 'dd-mm-yyyy'), to_date('14-03-2023 14:50:56', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (1, 'Gabriel', 'Rincon', to_date('24-01-2001', 'dd-mm-yyyy'), to_date('14-03-2023 11:07:59', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (3, 'caroll', 'pacheco', to_date('22-05-1987', 'dd-mm-yyyy'), to_date('14-03-2023 11:08:36', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (4, 'apolinar', 'pacheco', to_date('13-04-1941', 'dd-mm-yyyy'), to_date('14-03-2023 11:09:02', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
insert into PRACTICA (pk_practica, nombre_usuario, apellido_usuario, fecha_nacimiento, create_date, fk_estado, fk_municipio, fk_parroquia, modified_date)
values (9, 'emili', 'cabaño', to_date('28-11-1589', 'dd-mm-yyyy'), to_date('14-03-2023 17:15:15', 'dd-mm-yyyy hh24:mi:ss'), '4', '4', '4', null);
commit;
prompt 9 records loaded

set feedback on
set define on
prompt Done
