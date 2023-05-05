prompt PL/SQL Developer Export Tables for user FARMACIA_ALTO_COSTO@PRUEBA
prompt Created by User on viernes, 5 de mayo de 2023
set feedback off
set define off

prompt Creating ESTATUS...
create table ESTATUS
(
  pk_estatus INTEGER not null,
  estatus    VARCHAR2(30)
)
;
alter table ESTATUS
  add primary key (PK_ESTATUS);

prompt Creating ALMACEN...
create table ALMACEN
(
  pk_almacen     INTEGER not null,
  fk_estatus     INTEGER,
  tipo_almacen   VARCHAR2(100),
  piso           NUMBER(2),
  pasillo        VARCHAR2(60),
  observacion    VARCHAR2(150),
  fk_created_by  INTEGER,
  create_date    DATE,
  fk_modified_by INTEGER,
  modified_date  DATE
)
;
alter table ALMACEN
  add primary key (PK_ALMACEN);
alter table ALMACEN
  add constraint FK_ESTATUS_AL foreign key (FK_ESTATUS)
  references ESTATUS (PK_ESTATUS) on delete cascade;

prompt Creating AREA_TRABAJO...
create table AREA_TRABAJO
(
  pk_area_trabajo INTEGER not null,
  area_trabajo    VARCHAR2(30),
  fk_created_by   INTEGER,
  create_date     DATE,
  fk_modified_by  INTEGER,
  modified_date   DATE
)
;
alter table AREA_TRABAJO
  add primary key (PK_AREA_TRABAJO);

prompt Creating ESTADO...
create table ESTADO
(
  pk_estado INTEGER not null,
  estado    VARCHAR2(30)
)
;
alter table ESTADO
  add primary key (PK_ESTADO);

prompt Creating MUNICIPIO...
create table MUNICIPIO
(
  pk_municipio INTEGER not null,
  fk_estado    INTEGER,
  municipio    VARCHAR2(30)
)
;
alter table MUNICIPIO
  add primary key (PK_MUNICIPIO);
alter table MUNICIPIO
  add constraint FK_ESTADO foreign key (FK_ESTADO)
  references ESTADO (PK_ESTADO) on delete cascade;

prompt Creating PARROQUIA...
create table PARROQUIA
(
  pk_parroquia INTEGER not null,
  fk_municipio INTEGER,
  parroquia    VARCHAR2(40)
)
;
alter table PARROQUIA
  add primary key (PK_PARROQUIA);
alter table PARROQUIA
  add constraint FK_MUNICIPIO foreign key (FK_MUNICIPIO)
  references MUNICIPIO (PK_MUNICIPIO) on delete cascade;

prompt Creating TIPO_CENT_FARM...
create table TIPO_CENT_FARM
(
  pk_tipo_centro INTEGER not null,
  tipo_de_centro VARCHAR2(30),
  fk_created_by  INTEGER,
  create_date    DATE,
  fk_modified_by INTEGER,
  modified_date  DATE
)
;
alter table TIPO_CENT_FARM
  add primary key (PK_TIPO_CENTRO);

prompt Creating CENTRO_FARMACEUTICO...
create table CENTRO_FARMACEUTICO
(
  pk_centro_farm   INTEGER not null,
  fk_estado        INTEGER,
  fk_municipio     INTEGER,
  fk_parroquia     INTEGER,
  fk_tipo_centro   INTEGER,
  fk_area_trabajo  INTEGER,
  fk_estatus       INTEGER,
  cod_centro_farm  VARCHAR2(30),
  centro_farmacia  VARCHAR2(100),
  correo           VARCHAR2(50),
  correo_alterno   VARCHAR2(50),
  telefono         NUMBER(11),
  tlf_alterno      NUMBER(11),
  observacion      VARCHAR2(30),
  ubicacion_exacta VARCHAR2(100),
  fk_created_by    INTEGER,
  create_date      DATE,
  fk_modified_by   INTEGER,
  modified_date    DATE
)
;
alter table CENTRO_FARMACEUTICO
  add primary key (PK_CENTRO_FARM);
alter table CENTRO_FARMACEUTICO
  add constraint FK_AREA_TRABJ_CH foreign key (FK_AREA_TRABAJO)
  references AREA_TRABAJO (PK_AREA_TRABAJO) on delete cascade;
alter table CENTRO_FARMACEUTICO
  add constraint FK_ESTADO_CH foreign key (FK_ESTADO)
  references ESTADO (PK_ESTADO) on delete cascade;
alter table CENTRO_FARMACEUTICO
  add constraint FK_ESTATUS_CH foreign key (FK_ESTATUS)
  references ESTATUS (PK_ESTATUS) on delete cascade;
alter table CENTRO_FARMACEUTICO
  add constraint FK_MUNICIPIO_CH foreign key (FK_MUNICIPIO)
  references MUNICIPIO (PK_MUNICIPIO) on delete cascade;
alter table CENTRO_FARMACEUTICO
  add constraint FK_PARROQUIA_CH foreign key (FK_PARROQUIA)
  references PARROQUIA (PK_PARROQUIA) on delete cascade;
alter table CENTRO_FARMACEUTICO
  add constraint FK_TIP_CENTRO_CH foreign key (FK_TIPO_CENTRO)
  references TIPO_CENT_FARM (PK_TIPO_CENTRO) on delete cascade;

prompt Creating PRESENTACION_MEDICAMENTO...
create table PRESENTACION_MEDICAMENTO
(
  pk_pres_medicamento INTEGER not null,
  present_medicamento VARCHAR2(50),
  fk_created_by       INTEGER,
  create_date         DATE,
  fk_modified_by      INTEGER,
  modified_date       DATE
)
;
alter table PRESENTACION_MEDICAMENTO
  add primary key (PK_PRES_MEDICAMENTO);

prompt Creating CICLO_PACIENTE_TRATAMIENTO...
create table CICLO_PACIENTE_TRATAMIENTO
(
  pk_ciclo                INTEGER not null,
  fk_paciente             INTEGER,
  fk_medicamento          INTEGER,
  fk_pres_medicamento     INTEGER,
  cantidad_medi_asignado  NUMBER(2),
  cantidad_ciclos         VARCHAR2(20),
  dias_ciclos             VARCHAR2(30),
  fecha_inicio_ciclo      DATE,
  fecha_ult_primer_ciclo  DATE,
  fecha_segundo_ciclo     DATE,
  fecha_ult_segundo_ciclo DATE,
  fecha_ciclo_culminado   DATE,
  fk_created_by           INTEGER,
  create_date             DATE,
  fk_modified_by          INTEGER,
  modified_date           DATE
)
;
alter table CICLO_PACIENTE_TRATAMIENTO
  add primary key (PK_CICLO);
alter table CICLO_PACIENTE_TRATAMIENTO
  add constraint FK_PRES_MEDICAMENTO_CI foreign key (FK_PRES_MEDICAMENTO)
  references PRESENTACION_MEDICAMENTO (PK_PRES_MEDICAMENTO) on delete cascade;

prompt Creating CIUDADANO...
create table CIUDADANO
(
  pk_ciudadano     INTEGER not null,
  fk_estatus       INTEGER,
  fk_estado        INTEGER,
  fk_municipio     INTEGER,
  fk_parroquia     INTEGER,
  cedula           VARCHAR2(10),
  nombre           VARCHAR2(30),
  apellido         VARCHAR2(30),
  sexo             VARCHAR2(1),
  fecha_nacimiento DATE
)
;
alter table CIUDADANO
  add primary key (PK_CIUDADANO);
alter table CIUDADANO
  add constraint FK_ESTATUS foreign key (FK_ESTATUS)
  references ESTATUS (PK_ESTATUS) on delete cascade;
alter table CIUDADANO
  add constraint FK_MUNICIPIO_C foreign key (FK_MUNICIPIO)
  references MUNICIPIO (PK_MUNICIPIO) on delete cascade;
alter table CIUDADANO
  add constraint FK_PARROQUIA_C foreign key (FK_PARROQUIA)
  references PARROQUIA (PK_PARROQUIA) on delete cascade;
alter table CIUDADANO
  add constraint FK_STADO_C foreign key (FK_ESTADO)
  references ESTADO (PK_ESTADO) on delete cascade;

prompt Creating TIPO_MEDICAMENTOS...
create table TIPO_MEDICAMENTOS
(
  pk_tipo_medicamento INTEGER not null,
  tipo_medicamento    VARCHAR2(40),
  fk_created_by       INTEGER,
  create_date         DATE,
  fk_modified_by      INTEGER,
  modified_date       DATE
)
;
alter table TIPO_MEDICAMENTOS
  add primary key (PK_TIPO_MEDICAMENTO);

prompt Creating MEDICAMENTOS...
create table MEDICAMENTOS
(
  pk_medicamento      INTEGER not null,
  nombre_medicamento  VARCHAR2(50),
  componente_princ    VARCHAR2(600),
  fk_tipo_medicamento INTEGER,
  fk_created_by       INTEGER,
  create_date         DATE,
  fk_modified_by      INTEGER,
  modified_date       DATE
)
;
alter table MEDICAMENTOS
  add primary key (PK_MEDICAMENTO);
alter table MEDICAMENTOS
  add constraint FK_TIPO_MEDICAMENTO_M foreign key (FK_TIPO_MEDICAMENTO)
  references TIPO_MEDICAMENTOS (PK_TIPO_MEDICAMENTO) on delete cascade;

prompt Creating DETALLES_MEDICAMENTOS...
create table DETALLES_MEDICAMENTOS
(
  pk_detalle_medic    INTEGER not null,
  fk_medicamento      INTEGER,
  fk_pres_medicamento INTEGER,
  unidad_medida       VARCHAR2(50)
)
;
alter table DETALLES_MEDICAMENTOS
  add primary key (PK_DETALLE_MEDIC);
alter table DETALLES_MEDICAMENTOS
  add constraint FK_MEDICAMENTO_DM foreign key (FK_MEDICAMENTO)
  references MEDICAMENTOS (PK_MEDICAMENTO) on delete cascade;
alter table DETALLES_MEDICAMENTOS
  add constraint FK_PRES_MEDICAMENTO_DM foreign key (FK_PRES_MEDICAMENTO)
  references PRESENTACION_MEDICAMENTO (PK_PRES_MEDICAMENTO) on delete cascade;

prompt Creating ESPECIALIDAD...
create table ESPECIALIDAD
(
  pk_especialidad INTEGER not null,
  especialidad    VARCHAR2(250),
  fk_created_by   INTEGER,
  create_date     DATE,
  fk_modified_by  INTEGER,
  modified_date   DATE
)
;
alter table ESPECIALIDAD
  add primary key (PK_ESPECIALIDAD);

prompt Creating INVENTARIO_MEDICAMENTOS...
create table INVENTARIO_MEDICAMENTOS
(
  pk_inventario_medic INTEGER not null,
  fk_detalle_medic    INTEGER,
  fk_almacen          INTEGER,
  fk_estatus          INTEGER,
  cantidad            NUMBER(7),
  lote                NUMBER(7),
  fecha_vencimiento   DATE,
  observacion         VARCHAR2(30) default 'NINGUNA POR AHORA',
  fk_created_by       INTEGER,
  create_date         DATE,
  fk_modified_by      INTEGER,
  modified_date       DATE
)
;
alter table INVENTARIO_MEDICAMENTOS
  add primary key (PK_INVENTARIO_MEDIC);
alter table INVENTARIO_MEDICAMENTOS
  add constraint FK_ALMACEN_IM foreign key (FK_ALMACEN)
  references ALMACEN (PK_ALMACEN) on delete cascade;
alter table INVENTARIO_MEDICAMENTOS
  add constraint FK_DETALLE_ESTATUS_IM foreign key (FK_ESTATUS)
  references ESTATUS (PK_ESTATUS) on delete cascade;
alter table INVENTARIO_MEDICAMENTOS
  add constraint FK_DETALLE_MEDIC_IM foreign key (FK_DETALLE_MEDIC)
  references DETALLES_MEDICAMENTOS (PK_DETALLE_MEDIC) on delete cascade;

prompt Creating MEDICOS...
create table MEDICOS
(
  pk_medicos          INTEGER not null,
  fk_ciudadano        INTEGER,
  fk_especialidad     INTEGER,
  fk_centro_farm      INTEGER,
  fk_estatus          INTEGER,
  mpps                VARCHAR2(10),
  fecha_incorporacion DATE,
  fecha_inactividad   DATE,
  observacion         VARCHAR2(30) default 'NINGUNA POR AHORA',
  fk_created_by       INTEGER,
  create_date         DATE,
  fk_modified_by      INTEGER,
  modified_date       DATE
)
;
alter table MEDICOS
  add primary key (PK_MEDICOS);
alter table MEDICOS
  add constraint FK_CENT_FARM_ME foreign key (FK_CENTRO_FARM)
  references CENTRO_FARMACEUTICO (PK_CENTRO_FARM) on delete cascade;
alter table MEDICOS
  add constraint FK_CIUDADANO_ME foreign key (FK_CIUDADANO)
  references CIUDADANO (PK_CIUDADANO) on delete cascade;
alter table MEDICOS
  add constraint FK_ESPECIALIDAD_ME foreign key (FK_ESPECIALIDAD)
  references ESPECIALIDAD (PK_ESPECIALIDAD) on delete cascade;
alter table MEDICOS
  add constraint FK_ESTATUS_ME foreign key (FK_ESTATUS)
  references ESTATUS (PK_ESTATUS) on delete cascade;

prompt Creating PARIENTE...
create table PARIENTE
(
  pk_pariente    INTEGER not null,
  fk_ciudadano   INTEGER,
  fk_paciente    INTEGER,
  fk_created_by  INTEGER,
  create_date    DATE,
  fk_modified_by INTEGER,
  modified_date  DATE
)
;
alter table PARIENTE
  add primary key (PK_PARIENTE);
alter table PARIENTE
  add constraint FK_CIUDADANO_PE foreign key (FK_CIUDADANO)
  references CIUDADANO (PK_CIUDADANO) on delete cascade;

prompt Creating PACIENTE...
create table PACIENTE
(
  pk_paciente         INTEGER not null,
  fk_ciudadano        INTEGER,
  fk_pariente         INTEGER default 0,
  peso                VARCHAR2(6),
  altura              VARCHAR2(6),
  superficie_corporal VARCHAR2(6),
  correo              VARCHAR2(30),
  telefonno           NUMBER(11),
  tlf_alterno         NUMBER(11),
  fk_created_by       INTEGER,
  create_date         DATE,
  fk_modified_by      INTEGER,
  modified_date       DATE,
  observacion         VARCHAR2(40) default 'NINGUNA'
)
;
alter table PACIENTE
  add primary key (PK_PACIENTE);
alter table PACIENTE
  add constraint FK_CIUDADANO_P foreign key (FK_CIUDADANO)
  references CIUDADANO (PK_CIUDADANO) on delete cascade;
alter table PACIENTE
  add constraint FK_PARIENTE_P foreign key (FK_PARIENTE)
  references PARIENTE (PK_PARIENTE) on delete cascade;

prompt Creating PACIENTE_RETIRADO...
create table PACIENTE_RETIRADO
(
  pk_paci_retirado INTEGER not null,
  fk_ciudadano     INTEGER,
  observacion      VARCHAR2(50) default 'RETIRADO SIN UN MOTIVO'
)
;
alter table PACIENTE_RETIRADO
  add primary key (PK_PACI_RETIRADO);
alter table PACIENTE_RETIRADO
  add constraint FK_CIUDADANO_PR foreign key (FK_CIUDADANO)
  references CIUDADANO (PK_CIUDADANO) on delete cascade;

prompt Creating PATOLOGIA...
create table PATOLOGIA
(
  pk_patologia     INTEGER not null,
  nombre_patologia VARCHAR2(50)
)
;
alter table PATOLOGIA
  add primary key (PK_PATOLOGIA);

prompt Creating PATOLOGIA_PACIENTE...
create table PATOLOGIA_PACIENTE
(
  pk_patologia_pac INTEGER not null,
  fk_paciente      INTEGER,
  fk_patologia     INTEGER,
  fk_medico        INTEGER,
  fk_estatus       INTEGER,
  fk_created_by    INTEGER,
  create_date      DATE
)
;
alter table PATOLOGIA_PACIENTE
  add primary key (PK_PATOLOGIA_PAC);
alter table PATOLOGIA_PACIENTE
  add constraint FK_ESTATUS_PP foreign key (FK_ESTATUS)
  references ESTATUS (PK_ESTATUS) on delete cascade;
alter table PATOLOGIA_PACIENTE
  add constraint FK_MEDICO_PP foreign key (FK_MEDICO)
  references MEDICOS (PK_MEDICOS) on delete cascade;
alter table PATOLOGIA_PACIENTE
  add constraint FK_PATOLOGIA_PP foreign key (FK_PATOLOGIA)
  references PATOLOGIA (PK_PATOLOGIA) on delete cascade;

prompt Creating TIPO_INSUMOS...
create table TIPO_INSUMOS
(
  pk_tipo_insumos INTEGER not null,
  tipo_insumos    VARCHAR2(30),
  fk_created_by   INTEGER,
  create_date     DATE,
  fk_modified_by  INTEGER,
  modified_date   DATE
)
;
alter table TIPO_INSUMOS
  add primary key (PK_TIPO_INSUMOS);

prompt Creating SOLICITUD_INSUMOS...
create table SOLICITUD_INSUMOS
(
  pk_solicitud_insumos INTEGER not null,
  fk_tipo_insumo       INTEGER,
  fk_estatus           INTEGER,
  cantidad_insumo      VARCHAR2(50),
  fecha_solicitud      DATE,
  fecha_recibido       DATE,
  observacion          VARCHAR2(40),
  fk_created_by        INTEGER,
  create_date          DATE,
  fk_modified_by       INTEGER,
  modified_date        DATE
)
;
alter table SOLICITUD_INSUMOS
  add primary key (PK_SOLICITUD_INSUMOS);
alter table SOLICITUD_INSUMOS
  add constraint FK_ESTATUS_SI foreign key (FK_ESTATUS)
  references ESTATUS (PK_ESTATUS) on delete cascade;
alter table SOLICITUD_INSUMOS
  add constraint FK_TIP_INSUMO_SI foreign key (FK_TIPO_INSUMO)
  references TIPO_INSUMOS (PK_TIPO_INSUMOS) on delete cascade;

prompt Creating TIPO_TICKET...
create table TIPO_TICKET
(
  pk_tipo_ticket INTEGER not null,
  nombre_ticket  VARCHAR2(25),
  nro_min        VARCHAR2(25),
  nro_max        VARCHAR2(25),
  letra          VARCHAR2(5)
)
;
alter table TIPO_TICKET
  add primary key (PK_TIPO_TICKET);

prompt Creating TICKET...
create table TICKET
(
  pk_ticket        INTEGER not null,
  fk_tipo_ticket   INTEGER,
  fk_estatus       INTEGER,
  cedula_ciudadano VARCHAR2(10),
  nro_ticket       VARCHAR2(10),
  fk_created_by    INTEGER,
  create_date      DATE
)
;
alter table TICKET
  add primary key (PK_TICKET);
alter table TICKET
  add constraint FK_TIP_ESTATUS_T foreign key (FK_ESTATUS)
  references ESTATUS (PK_ESTATUS) on delete cascade;
alter table TICKET
  add constraint FK_TIP_TICKET_T foreign key (FK_TIPO_TICKET)
  references TIPO_TICKET (PK_TIPO_TICKET) on delete cascade;

prompt Loading ESTATUS...
insert into ESTATUS (pk_estatus, estatus)
values (21, 'VIVO');
insert into ESTATUS (pk_estatus, estatus)
values (2, 'DISPONIBLE');
insert into ESTATUS (pk_estatus, estatus)
values (3, 'OPERATIVO');
insert into ESTATUS (pk_estatus, estatus)
values (4, 'INOPERATIVO');
insert into ESTATUS (pk_estatus, estatus)
values (5, 'FUEERA DE SERVICIO');
insert into ESTATUS (pk_estatus, estatus)
values (6, 'EN TRATAMIENTO');
insert into ESTATUS (pk_estatus, estatus)
values (7, 'TRATAMIENTO CULMINADO');
insert into ESTATUS (pk_estatus, estatus)
values (8, 'FALLECIDO');
insert into ESTATUS (pk_estatus, estatus)
values (9, 'NO ATENDIDO');
insert into ESTATUS (pk_estatus, estatus)
values (10, 'PENDIENTE');
insert into ESTATUS (pk_estatus, estatus)
values (11, 'PAUSADO');
insert into ESTATUS (pk_estatus, estatus)
values (12, 'CULMINADO');
insert into ESTATUS (pk_estatus, estatus)
values (14, 'LLENO');
insert into ESTATUS (pk_estatus, estatus)
values (15, 'POR AGOTARSE');
insert into ESTATUS (pk_estatus, estatus)
values (16, 'AGOTADO');
insert into ESTATUS (pk_estatus, estatus)
values (17, 'POR ATENDER');
insert into ESTATUS (pk_estatus, estatus)
values (18, 'ATENDIDO');
insert into ESTATUS (pk_estatus, estatus)
values (19, 'EN ESPERA');
insert into ESTATUS (pk_estatus, estatus)
values (20, 'RECIBIDO');
commit;
prompt 19 records loaded
prompt Loading ALMACEN...
insert into ALMACEN (pk_almacen, fk_estatus, tipo_almacen, piso, pasillo, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 2, 'Estanterías', 2, 'PASILLO Estanteria', 'NINGUNA POR AHORA', null, null, null, null);
insert into ALMACEN (pk_almacen, fk_estatus, tipo_almacen, piso, pasillo, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 2, 'Refrigeradores', 3, 'PASILLO Refrigeradores', 'NINGUNA POR AHORA', null, null, null, null);
insert into ALMACEN (pk_almacen, fk_estatus, tipo_almacen, piso, pasillo, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (4, 14, 'Congeladores', 0, 'PASILLO Congeladores', 'NINGUNA POR AHORA', null, null, null, null);
insert into ALMACEN (pk_almacen, fk_estatus, tipo_almacen, piso, pasillo, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (5, 5, 'Armarios', 1, 'PASILLO Armarios', 'Dañado por bajones de luz', null, null, null, null);
insert into ALMACEN (pk_almacen, fk_estatus, tipo_almacen, piso, pasillo, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (6, 2, 'Cajones y Contenedores', 2, 'PASILLO Cajones y Contenedores', 'NINGUNA POR AHORA', null, null, null, null);
insert into ALMACEN (pk_almacen, fk_estatus, tipo_almacen, piso, pasillo, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (7, 5, 'Salas Limpias', 1, 'PASILLO Salas Limpias', 'Dañado por bajones de luz', null, null, null, null);
commit;
prompt 6 records loaded
prompt Loading AREA_TRABAJO...
insert into AREA_TRABAJO (pk_area_trabajo, area_trabajo, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 'Público', null, null, null, null);
insert into AREA_TRABAJO (pk_area_trabajo, area_trabajo, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 'Privado', null, null, null, null);
commit;
prompt 2 records loaded
prompt Loading ESTADO...
insert into ESTADO (pk_estado, estado)
values (2, 'Amazonas');
insert into ESTADO (pk_estado, estado)
values (3, 'Anzoátegui');
insert into ESTADO (pk_estado, estado)
values (4, 'Apure');
insert into ESTADO (pk_estado, estado)
values (5, 'Aragua');
insert into ESTADO (pk_estado, estado)
values (6, 'Barinas');
insert into ESTADO (pk_estado, estado)
values (7, 'Bolívar');
insert into ESTADO (pk_estado, estado)
values (8, 'Carabobo');
insert into ESTADO (pk_estado, estado)
values (9, 'Cojedes');
insert into ESTADO (pk_estado, estado)
values (10, 'Delta Amacuro');
insert into ESTADO (pk_estado, estado)
values (11, 'Falcón');
insert into ESTADO (pk_estado, estado)
values (12, 'Guárico');
insert into ESTADO (pk_estado, estado)
values (13, 'Lara');
insert into ESTADO (pk_estado, estado)
values (14, 'Mérida');
insert into ESTADO (pk_estado, estado)
values (15, 'Miranda');
insert into ESTADO (pk_estado, estado)
values (16, 'Monagas');
insert into ESTADO (pk_estado, estado)
values (17, 'Nueva Esparta');
insert into ESTADO (pk_estado, estado)
values (18, 'Portuguesa');
insert into ESTADO (pk_estado, estado)
values (19, 'Sucre');
insert into ESTADO (pk_estado, estado)
values (20, 'Táchira');
insert into ESTADO (pk_estado, estado)
values (21, 'Trujillo');
insert into ESTADO (pk_estado, estado)
values (22, 'La Guaira');
insert into ESTADO (pk_estado, estado)
values (23, 'Yaracuy');
insert into ESTADO (pk_estado, estado)
values (24, 'Zulia');
insert into ESTADO (pk_estado, estado)
values (25, 'Distrito Capital');
insert into ESTADO (pk_estado, estado)
values (26, 'Dependencias Federales');
commit;
prompt 25 records loaded
prompt Loading MUNICIPIO...
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (2, 2, 'Alto Orinoco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (3, 2, 'Atabapo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (4, 2, 'Atures');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (5, 2, 'Autana');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (6, 2, 'Manapiare');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (7, 2, 'Maroa');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (8, 2, 'Río Negro');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (9, 3, 'Anaco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (10, 3, 'Aragua');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (11, 3, 'Manuel Ezequiel Bruzual');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (12, 3, 'Diego Bautista Urbaneja');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (13, 3, 'Fernando Peñalver');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (14, 3, 'Francisco Del Carmen Carvajal');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (15, 3, 'General Sir Arthur McGregor');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (16, 3, 'Guanta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (17, 3, 'Independencia');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (18, 3, 'José Gregorio Monagas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (19, 3, 'Juan Antonio Sotillo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (20, 3, 'Juan Manuel Cajigal');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (21, 3, 'Libertad');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (22, 3, 'Francisco de Miranda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (23, 3, 'Pedro María Freites');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (24, 3, 'Píritu');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (25, 3, 'San José de Guanipa');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (26, 3, 'San Juan de Capistrano');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (27, 3, 'Santa Ana');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (28, 3, 'Simón Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (29, 3, 'Simón Rodríguez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (30, 4, 'Achaguas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (31, 4, 'Biruaca');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (32, 4, 'Muñóz');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (33, 4, 'Páez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (34, 4, 'Pedro Camejo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (35, 4, 'Rómulo Gallegos');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (36, 4, 'San Fernando');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (37, 5, 'Atanasio Girardot');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (38, 5, 'Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (39, 5, 'Camatagua');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (40, 5, 'Francisco Linares Alcántara');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (41, 5, 'José Ángel Lamas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (42, 5, 'José Félix Ribas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (43, 5, 'José Rafael Revenga');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (44, 5, 'Libertador');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (45, 5, 'Mario Briceño Iragorry');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (46, 5, 'Ocumare de la Costa de Oro');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (47, 5, 'San Casimiro');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (48, 5, 'San Sebastián');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (49, 5, 'Santiago Mariño');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (50, 5, 'Santos Michelena');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (51, 5, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (52, 5, 'Tovar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (53, 5, 'Urdaneta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (54, 5, 'Zamora');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (55, 6, 'Alberto Arvelo Torrealba');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (56, 6, 'Andrés Eloy Blanco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (57, 6, 'Antonio José de Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (58, 6, 'Arismendi');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (59, 6, 'Barinas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (60, 6, 'Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (61, 6, 'Cruz Paredes');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (62, 6, 'Ezequiel Zamora');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (63, 6, 'Obispos');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (64, 6, 'Pedraza');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (65, 6, 'Rojas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (66, 6, 'Sosa');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (67, 7, 'Caroní');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (68, 7, 'Cedeño');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (69, 7, 'El Callao');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (70, 7, 'Gran Sabana');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (71, 7, 'Heres');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (72, 7, 'Piar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (73, 7, 'Angostura (Raúl Leoni)');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (74, 7, 'Roscio');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (75, 7, 'Sifontes');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (76, 7, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (77, 7, 'Padre Pedro Chien');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (78, 8, 'Bejuma');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (79, 8, 'Carlos Arvelo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (80, 8, 'Diego Ibarra');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (81, 8, 'Guacara');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (82, 8, 'Juan José Mora');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (83, 8, 'Libertador');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (84, 8, 'Los Guayos');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (85, 8, 'Miranda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (86, 8, 'Montalbán');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (87, 8, 'Naguanagua');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (88, 8, 'Puerto Cabello');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (89, 8, 'San Diego');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (90, 8, 'San Joaquín');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (91, 8, 'Valencia');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (92, 9, 'Anzoátegui');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (93, 9, 'Tinaquillo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (94, 9, 'Girardot');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (95, 9, 'Lima Blanco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (96, 9, 'Pao de San Juan Bautista');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (97, 9, 'Ricaurte');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (98, 9, 'Rómulo Gallegos');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (99, 9, 'San Carlos');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (100, 9, 'Tinaco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (101, 10, 'Antonio Díaz');
commit;
prompt 100 records committed...
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (102, 10, 'Casacoima');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (103, 10, 'Pedernales');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (104, 10, 'Tucupita');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (105, 11, 'Acosta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (106, 11, 'Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (107, 11, 'Buchivacoa');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (108, 11, 'Cacique Manaure');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (109, 11, 'Carirubana');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (110, 11, 'Colina');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (111, 11, 'Dabajuro');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (112, 11, 'Democracia');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (113, 11, 'Falcón');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (114, 11, 'Federación');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (115, 11, 'Jacura');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (116, 11, 'José Laurencio Silva');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (117, 11, 'Los Taques');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (118, 11, 'Mauroa');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (119, 11, 'Miranda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (120, 11, 'Monseñor Iturriza');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (121, 11, 'Palmasola');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (122, 11, 'Petit');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (123, 11, 'Píritu');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (124, 11, 'San Francisco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (125, 11, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (126, 11, 'Tocópero');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (127, 11, 'Unión');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (128, 11, 'Urumaco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (129, 11, 'Zamora');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (130, 12, 'Camaguán');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (131, 12, 'Chaguaramas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (132, 12, 'El Socorro');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (133, 12, 'José Félix Ribas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (134, 12, 'José Tadeo Monagas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (135, 12, 'Juan Germán Roscio');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (136, 12, 'Julián Mellado');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (137, 12, 'Las Mercedes');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (138, 12, 'Leonardo Infante');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (139, 12, 'Pedro Zaraza');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (140, 12, 'Ortíz');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (141, 12, 'San Gerónimo de Guayabal');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (142, 12, 'San José de Guaribe');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (143, 12, 'Santa María de Ipire');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (144, 12, 'Sebastián Francisco de Miranda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (145, 13, 'Andrés Eloy Blanco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (146, 13, 'Crespo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (147, 13, 'Iribarren');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (148, 13, 'Jiménez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (149, 13, 'Morán');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (150, 13, 'Palavecino');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (151, 13, 'Simón Planas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (152, 13, 'Torres');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (153, 13, 'Urdaneta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (154, 14, 'Alberto Adriani');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (155, 14, 'Andrés Bello');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (156, 14, 'Antonio Pinto Salinas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (157, 14, 'Aricagua');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (158, 14, 'Arzobispo Chacón');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (159, 14, 'Campo Elías');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (160, 14, 'Caracciolo Parra Olmedo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (161, 14, 'Cardenal Quintero');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (162, 14, 'Guaraque');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (163, 14, 'Julio César Salas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (164, 14, 'Justo Briceño');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (165, 14, 'Libertador');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (166, 14, 'Miranda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (167, 14, 'Obispo Ramos de Lora');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (168, 14, 'Padre Noguera');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (169, 14, 'Pueblo Llano');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (170, 14, 'Rangel');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (171, 14, 'Rivas Dávila');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (172, 14, 'Santos Marquina');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (173, 14, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (174, 14, 'Tovar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (175, 14, 'Tulio Febres Cordero');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (176, 14, 'Zea');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (177, 15, 'Acevedo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (178, 15, 'Andrés Bello');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (179, 15, 'Baruta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (180, 15, 'Brión');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (181, 15, 'Buroz');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (182, 15, 'Carrizal');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (183, 15, 'Chacao');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (184, 15, 'Cristóbal Rojas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (185, 15, 'El Hatillo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (186, 15, 'Guaicaipuro');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (187, 15, 'Independencia');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (188, 15, 'Lander');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (189, 15, 'Los Salias');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (190, 15, 'Páez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (191, 15, 'Paz Castillo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (192, 15, 'Pedro Gual');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (193, 15, 'Plaza');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (194, 15, 'Simón Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (195, 15, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (196, 15, 'Urdaneta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (197, 15, 'Zamora');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (198, 16, 'Acosta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (199, 16, 'Aguasay');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (200, 16, 'Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (201, 16, 'Caripe');
commit;
prompt 200 records committed...
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (202, 16, 'Cedeño');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (203, 16, 'Ezequiel Zamora');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (204, 16, 'Libertador');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (205, 16, 'Maturín');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (206, 16, 'Piar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (207, 16, 'Punceres');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (208, 16, 'Santa Bárbara');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (209, 16, 'Sotillo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (210, 16, 'Uracoa');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (211, 17, 'Antolín del Campo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (212, 17, 'Arismendi');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (213, 17, 'García');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (214, 17, 'Gómez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (215, 17, 'Maneiro');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (216, 17, 'Marcano');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (217, 17, 'Mariño');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (218, 17, 'Península de Macanao');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (219, 17, 'Tubores');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (220, 17, 'Villalba');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (221, 17, 'Díaz');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (222, 18, 'Agua Blanca');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (223, 18, 'Araure');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (224, 18, 'Esteller');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (225, 18, 'Guanare');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (226, 18, 'Guanarito');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (227, 18, 'Monseñor José Vicente de Unda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (228, 18, 'Ospino');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (229, 18, 'Páez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (230, 18, 'Papelón');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (231, 18, 'San Genaro de Boconoíto');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (232, 18, 'San Rafael de Onoto');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (233, 18, 'Santa Rosalía');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (234, 18, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (235, 18, 'Turén');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (236, 19, 'Andrés Eloy Blanco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (237, 19, 'Andrés Mata');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (238, 19, 'Arismendi');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (239, 19, 'Benítez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (240, 19, 'Bermúdez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (241, 19, 'Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (242, 19, 'Cajigal');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (243, 19, 'Cruz Salmerón Acosta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (244, 19, 'Libertador');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (245, 19, 'Mariño');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (246, 19, 'Mejía');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (247, 19, 'Montes');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (248, 19, 'Ribero');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (249, 19, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (250, 19, 'Valdéz');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (251, 20, 'Andrés Bello');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (252, 20, 'Antonio Rómulo Costa');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (253, 20, 'Ayacucho');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (254, 20, 'Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (255, 20, 'Cárdenas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (256, 20, 'Córdoba');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (257, 20, 'Fernández Feo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (258, 20, 'Francisco de Miranda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (259, 20, 'García de Hevia');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (260, 20, 'Guásimos');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (261, 20, 'Independencia');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (262, 20, 'Jáuregui');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (263, 20, 'José María Vargas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (264, 20, 'Junín');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (265, 20, 'Libertad');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (266, 20, 'Libertador');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (267, 20, 'Lobatera');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (268, 20, 'Michelena');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (269, 20, 'Panamericano');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (270, 20, 'Pedro María Ureña');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (271, 20, 'Rafael Urdaneta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (272, 20, 'Samuel Darío Maldonado');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (273, 20, 'San Cristóbal');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (274, 20, 'Seboruco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (275, 20, 'Simón Rodríguez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (276, 20, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (277, 20, 'Torbes');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (278, 20, 'Uribante');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (279, 20, 'San Judas Tadeo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (280, 21, 'Andrés Bello');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (281, 21, 'Boconó');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (282, 21, 'Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (283, 21, 'Candelaria');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (284, 21, 'Carache');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (285, 21, 'Escuque');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (286, 21, 'José Felipe Márquez Cañizalez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (287, 21, 'Juan Vicente Campos Elías');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (288, 21, 'La Ceiba');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (289, 21, 'Miranda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (290, 21, 'Monte Carmelo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (291, 21, 'Motatán');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (292, 21, 'Pampán');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (293, 21, 'Pampanito');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (294, 21, 'Rafael Rangel');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (295, 21, 'San Rafael de Carvajal');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (296, 21, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (297, 21, 'Trujillo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (298, 21, 'Urdaneta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (299, 21, 'Valera');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (300, 22, 'Vargas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (301, 23, 'Arístides Bastidas');
commit;
prompt 300 records committed...
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (302, 23, 'Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (303, 23, 'Bruzual');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (304, 23, 'Cocorote');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (305, 23, 'Independencia');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (306, 23, 'José Antonio Páez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (307, 23, 'La Trinidad');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (308, 23, 'Manuel Monge');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (309, 23, 'Nirgua');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (310, 23, 'Peña');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (311, 23, 'San Felipe');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (312, 23, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (313, 23, 'Urachiche');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (314, 23, 'José Joaquín Veroes');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (315, 24, 'Almirante Padilla');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (316, 24, 'Baralt');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (317, 24, 'Cabimas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (318, 24, 'Catatumbo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (319, 24, 'Colón');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (320, 24, 'Francisco Javier Pulgar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (321, 24, 'Páez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (322, 24, 'Jesús Enrique Losada');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (323, 24, 'Jesús María Semprún');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (324, 24, 'La Cañada de Urdaneta');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (325, 24, 'Lagunillas');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (326, 24, 'Machiques de Perijá');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (327, 24, 'Mara');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (328, 24, 'Maracaibo');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (329, 24, 'Miranda');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (330, 24, 'Rosario de Perijá');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (331, 24, 'San Francisco');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (332, 24, 'Santa Rita');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (333, 24, 'Simón Bolívar');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (334, 24, 'Sucre');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (335, 24, 'Valmore Rodríguez');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (336, 25, 'Libertador');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (337, 26, 'Archipielago de los Roques');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (338, 26, 'Archipielago de las Aves');
insert into MUNICIPIO (pk_municipio, fk_estado, municipio)
values (339, 26, 'Archipielago de la Orchila');
commit;
prompt 338 records loaded
prompt Loading PARROQUIA...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1143, 336, '23 de enero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1144, 337, 'Archipielago de los Roques');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1145, 338, 'Archipielago de las Aves');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1146, 339, 'Archipielago de la Orchila');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (2, 2, 'Alto Orinoco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (3, 2, 'Huachamacare Acanaña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (4, 2, 'Marawaka Toky Shaman;Zaña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (5, 2, 'Mavaka Mavaka');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (6, 2, 'Sierra Parima Parimabé');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (7, 3, 'Ucata Laja Lisa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (8, 3, 'Yapacana Macuruco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (9, 3, 'Caname Guarinuma');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (10, 4, 'Fernando Girón Tovar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (11, 4, 'Luis Alberto Gómez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (12, 4, 'Pahueña Limón de Parhueña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (13, 4, 'Platanillal Platanillal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (14, 5, 'Samariapo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (15, 5, 'Sipapo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (16, 5, 'Munduapo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (17, 5, 'Guayapo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (18, 6, 'Alto Ventuari');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (19, 6, 'Medio Ventuari');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (20, 6, 'Bajo Ventuari');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (21, 7, 'Victorino');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (22, 7, 'Comunidad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (23, 8, 'Casiquiare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (24, 8, 'Cocuy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (25, 8, 'San Carlos de Río Negro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (26, 8, 'Solano');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (27, 9, 'Anaco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (28, 9, 'San Joaquín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (29, 10, 'Cachipo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (30, 10, 'Aragua de Barcelona');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (31, 11, 'Clarines');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (32, 11, 'Guanape');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (33, 11, 'Sabana de Uchire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (34, 12, 'Lechería');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (35, 12, 'El Morro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (36, 13, 'Puerto Píritu');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (37, 13, 'San Miguel');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (38, 13, 'Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (39, 14, 'Valle de Guanape');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (40, 14, 'Santa Bárbara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (41, 15, 'El Chaparro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (42, 15, 'Tomás Alfaro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (43, 15, 'Calatrava');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (44, 16, 'Guanta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (45, 16, 'Chorrerón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (46, 17, 'Mamo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (47, 17, 'Soledad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (48, 18, 'Mapire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (49, 18, 'Piar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (50, 18, 'Santa Clara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (51, 18, 'San Diego de Cabrutica');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (52, 18, 'Uverito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (53, 18, 'Zuata');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (54, 19, 'Puerto La Cruz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (55, 19, 'Pozuelos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (56, 20, 'Onoto');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (57, 20, 'San Pablo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (58, 21, 'San Mateo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (59, 21, 'El Carito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (60, 21, 'Santa Inés');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (61, 21, 'La Romereña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (62, 22, 'Atapirire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (63, 22, 'Boca del Pao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (64, 22, 'El Pao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (65, 22, 'Pariaguán');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (66, 23, 'Cantaura');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (67, 23, 'Libertador');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (68, 23, 'Santa Rosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (69, 23, 'Urica');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (70, 24, 'Píritu');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (71, 24, 'San Francisco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (72, 25, 'San José de Guanipa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (73, 26, 'Boca de Uchire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (74, 26, 'Boca de Chávez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (75, 27, 'Pueblo Nuevo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (76, 27, 'Santa Ana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (77, 28, 'Bergantín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (78, 28, 'Caigua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (79, 28, 'El Carmen');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (80, 28, 'El Pilar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (81, 28, 'Naricual');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (82, 28, 'San Crsitóbal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (83, 29, 'Edmundo Barrios');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (84, 29, 'Miguel Otero Silva');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (85, 30, 'Achaguas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (86, 30, 'Apurito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (87, 30, 'El Yagual');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (88, 30, 'Guachara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (89, 30, 'Mucuritas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (90, 30, 'Queseras del medio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (91, 31, 'Biruaca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (92, 32, 'Bruzual');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (93, 32, 'Mantecal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (94, 32, 'Quintero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (95, 32, 'Rincón Hondo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (96, 32, 'San Vicente');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (97, 33, 'Guasdualito');
commit;
prompt 100 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (98, 33, 'Aramendi');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (99, 33, 'El Amparo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (100, 33, 'San Camilo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (101, 33, 'Urdaneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (102, 34, 'San Juan de Payara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (103, 34, 'Codazzi');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (104, 34, 'Cunaviche');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (105, 35, 'Elorza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (106, 35, 'La Trinidad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (107, 36, 'San Fernando');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (108, 36, 'El Recreo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (109, 36, 'Peñalver');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (110, 36, 'San Rafael de Atamaica');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (111, 37, 'Pedro José Ovalles');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (112, 37, 'Joaquín Crespo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (113, 37, 'José Casanova Godoy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (114, 37, 'Madre María de San José');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (115, 37, 'Andrés Eloy Blanco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (116, 37, 'Los Tacarigua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (117, 37, 'Las Delicias');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (118, 37, 'Choroní');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (119, 38, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (120, 39, 'Camatagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (121, 39, 'Carmen de Cura');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (122, 40, 'Santa Rita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (123, 40, 'Francisco de Miranda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (124, 40, 'Moseñor Feliciano González');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (125, 41, 'Santa Cruz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (126, 42, 'José Félix Ribas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (127, 42, 'Castor Nieves Ríos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (128, 42, 'Las Guacamayas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (129, 42, 'Pao de Zárate');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (130, 42, 'Zuata');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (131, 43, 'José Rafael Revenga');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (132, 44, 'Palo Negro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (133, 44, 'San Martín de Porres');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (134, 45, 'El Limón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (135, 45, 'Caña de Azúcar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (136, 46, 'Ocumare de la Costa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (137, 47, 'San Casimiro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (138, 47, 'Güiripa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (139, 47, 'Ollas de Caramacate');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (140, 47, 'Valle Morín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (141, 48, 'San Sebastían');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (142, 49, 'Turmero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (143, 49, 'Arevalo Aponte');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (144, 49, 'Chuao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (145, 49, 'Samán de Güere');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (146, 49, 'Alfredo Pacheco Miranda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (147, 50, 'Santos Michelena');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (148, 50, 'Tiara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (149, 51, 'Cagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (150, 51, 'Bella Vista');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (151, 52, 'Tovar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (152, 53, 'Urdaneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (153, 53, 'Las Peñitas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (154, 53, 'San Francisco de Cara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (155, 53, 'Taguay');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (156, 54, 'Zamora');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (157, 54, 'Magdaleno');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (158, 54, 'San Francisco de Asís');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (159, 54, 'Valles de Tucutunemo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (160, 54, 'Augusto Mijares');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (163, 55, 'Sabaneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (164, 55, 'Juan Antonio Rodríguez Domínguez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (165, 56, 'El Cantón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (166, 56, 'Santa Cruz de Guacas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (167, 56, 'Puerto Vivas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (168, 57, 'Ticoporo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (169, 57, 'Nicolás Pulido');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (170, 57, 'Andrés Bello');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (171, 58, 'Arismendi');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (172, 58, 'Guadarrama');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (173, 58, 'La Unión');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (174, 58, 'San Antonio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (175, 59, 'Barinas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (176, 59, 'Alberto Arvelo Larriva');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (177, 59, 'San Silvestre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (178, 59, 'Santa Inés');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (179, 59, 'Santa Lucía');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (180, 59, 'Torumos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (181, 59, 'El Carmen');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (182, 59, 'Rómulo Betancourt');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (183, 59, 'Corazón de Jesús');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (184, 59, 'Ramón Ignacio Méndez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (185, 59, 'Alto Barinas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (186, 59, 'Manuel Palacio Fajardo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (187, 59, 'Juan Antonio Rodríguez Domínguez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (188, 59, 'Dominga Ortiz de Páez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (189, 60, 'Barinitas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (190, 60, 'Altamira de Cáceres');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (191, 60, 'Calderas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (192, 61, 'Barrancas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (193, 61, 'El Socorro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (194, 61, 'Mazparrito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (195, 62, 'santa Bárbara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (196, 62, 'Pedro Briceño Méndez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (197, 62, 'Ramón Ignacio Méndez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (198, 62, 'José Ignacio del Pumar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (199, 63, 'Obispos');
commit;
prompt 200 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (200, 63, 'Guasimitos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (201, 63, 'El Real');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (202, 63, 'La Luz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (203, 64, 'Ciudad Bolívia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (204, 64, 'José Ignacio Briceño');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (205, 64, 'José Félix Ribas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (206, 64, 'Páez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (207, 65, 'Libertad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (208, 65, 'Dolores');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (209, 65, 'Santa Rosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (210, 65, 'Palacio Fajardo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (211, 66, 'Ciudad de Nutrias');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (212, 66, 'El Regalo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (213, 66, 'Puerto Nutrias');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (214, 66, 'Santa Catalina');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (215, 67, 'Cachamay');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (216, 67, 'Chirica');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (217, 67, 'Dalla Costa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (218, 67, 'Once de Abril');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (219, 67, 'Simón Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (220, 67, 'Unare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (221, 67, 'Universidad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (222, 67, 'Vista al Sol');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (223, 67, 'Pozo Verde');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (224, 67, 'Yocoima');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (225, 67, '5 de Julio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (226, 68, 'Cedeño');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (227, 68, 'Altagracia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (228, 68, 'Ascensión Farreras');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (229, 68, 'Guaniamo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (230, 68, 'La Urbana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (231, 68, 'Pijiguaos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (232, 69, 'El Callao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (233, 70, 'Gran Sabana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (234, 70, 'Ikabarú');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (235, 71, 'Catedral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (236, 71, 'Zea');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (237, 71, 'Orinoco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (238, 71, 'José Antonio Páez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (239, 71, 'Marhuanta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (240, 71, 'Agua Salada');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (241, 71, 'Vista Hermosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (242, 71, 'La Sabanita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (243, 71, 'Panapana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (244, 72, 'Andrés Eloy Blanco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (245, 72, 'Pedro Cova');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (246, 73, 'Raúl Leoni');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (247, 73, 'Barceloneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (248, 73, 'Santa Bárbara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (249, 73, 'San Francisco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (250, 74, 'Roscio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (251, 74, 'Salóm');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (252, 75, 'Sifontes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (253, 75, 'Dalla Costa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (254, 75, 'San Isidro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (255, 76, 'Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (256, 76, 'Aripao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (257, 76, 'Guarataro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (258, 76, 'Las Majadas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (259, 76, 'Moitaco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (260, 77, 'Padre Pedro Chien');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (261, 77, 'Río Grande');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (262, 78, 'Bejuma');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (263, 78, 'Canoabo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (264, 78, 'Simón Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (265, 79, 'Güigüe');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (266, 79, 'Carabobo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (267, 79, 'Tacarigua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (268, 80, 'Mariara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (269, 80, 'Mariara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (270, 81, 'Ciudad Alianza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (271, 81, 'Guacara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (272, 81, 'Yagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (273, 82, 'Morón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (274, 82, 'Yagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (275, 83, 'Tocuyito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (276, 83, 'Independencia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (277, 84, 'Los Guayos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (278, 85, 'Miranda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (279, 86, 'Montalbán');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (280, 87, 'Naguanagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (281, 88, 'Bartolomé Salóm');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (282, 88, 'Democracia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (283, 88, 'Fraternidad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (284, 88, 'Goaigoaza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (285, 88, 'Juan José Flores');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (286, 88, 'Unión');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (287, 88, 'Borburata');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (288, 88, 'Patanemo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (289, 89, 'San Diego');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (290, 90, 'San Joaquín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (291, 91, 'Candelaria');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (292, 91, 'Catedral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (293, 91, 'El Socorro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (294, 91, 'Miguel Peña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (295, 91, 'Rafael Urdaneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (296, 91, 'San Blas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (297, 91, 'San José');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (298, 91, 'Santa Rosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (299, 91, 'Negro Primero');
commit;
prompt 300 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (300, 92, 'Cojedes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (301, 92, 'Juan de Mata Suárez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (302, 93, 'Tinaquillo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (303, 94, 'El Baúl');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (304, 94, 'Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (305, 95, 'La Aguadita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (306, 95, 'Macapo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (307, 96, 'El Pao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (308, 97, 'El Amparo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (309, 97, 'Libertad de Cojedes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (310, 98, 'Rómulo Gallegos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (311, 99, 'San Carlos de Austria');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (312, 99, 'Juan Ángel Bravo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (313, 99, 'Manuel Manrique');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (314, 100, 'General en Jefe José Laurencio Silva');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (315, 101, 'Curiapo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (316, 101, 'Almirante Luis Brión');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (317, 101, 'Francisco Aniceto Lugo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (318, 101, 'Manuel Renaud');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (319, 101, 'Padre Barral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (320, 101, 'Santos de Abelgas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (321, 102, 'Imataca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (322, 102, 'Cinco de Julio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (323, 102, 'Juan Bautista Arismendi');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (324, 102, 'Manuel Piar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (325, 102, 'Rómulo Gallegos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (326, 103, 'Pedernales');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (327, 103, 'Luis Beltrán Prieto Figueroa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (328, 104, 'San José (Delta Amacuro)');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (329, 104, 'José Vidal Marcano');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (330, 104, 'Juan Millán');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (331, 104, 'Leonardo Ruíz Pineda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (332, 104, 'Mariscal Antonio José de Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (333, 104, 'Monseñor Argimiro García');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (334, 104, 'San Rafael (Delta Amacuro)');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (335, 104, 'Virgen del Valle');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (336, 105, 'Capadare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (337, 105, 'La Pastora');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (338, 105, 'Libertador');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (339, 105, 'San Juan de los Cayos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (340, 106, 'Aracua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (341, 106, 'La Peña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (342, 106, 'San Luis');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (343, 107, 'Bariro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (344, 107, 'Borojó');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (345, 107, 'Capatárida');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (346, 107, 'Guajiro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (347, 107, 'Seque');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (348, 107, 'Zazárida');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (349, 107, 'Valle de Eroa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (350, 108, 'Cacique Manaure');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (351, 109, 'Norte');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (352, 109, 'Carirubana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (353, 109, 'Santa Ana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (354, 109, 'Urbana Punta Cardón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (355, 110, 'La Vela de Coro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (356, 110, 'Acurigua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (357, 110, 'Guaibacoa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (358, 110, 'Las Calderas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (359, 110, 'Macoruca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (360, 111, 'Dabajuro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (361, 112, 'Agua Clara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (362, 112, 'Avaria');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (363, 112, 'Pedregal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (364, 112, 'Piedra Grande');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (365, 112, 'Purureche');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (366, 113, 'Adaure');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (367, 113, 'Adícora');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (368, 113, 'Baraived');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (369, 113, 'Buena Vista');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (370, 113, 'Churuguara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (371, 113, 'Jadacaquiva');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (372, 113, 'El Vínculo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (373, 113, 'El Hato');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (374, 113, 'Moruy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (375, 113, 'Pueblo Nuevo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (376, 114, 'Agua Larga');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (377, 114, 'El Paují');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (378, 114, 'Independencia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (379, 114, 'Mapararí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (380, 115, 'Agua Linda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (381, 115, 'Araurima');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (382, 115, 'Jacura');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (383, 116, 'Tucacas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (384, 116, 'Boca de Aroa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (385, 117, 'Los Taques');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (386, 117, 'Judibana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (387, 118, 'Mene de Mauroa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (388, 118, 'San Félix');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (389, 118, 'Casigua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (390, 119, 'Guzmán Guillermo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (391, 119, 'Mitare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (392, 119, 'Río Seco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (393, 119, 'Sabaneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (394, 119, 'San Antonio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (395, 119, 'San Gabriel');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (396, 119, 'Santa Ana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (397, 120, 'Boca del Tocuyo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (398, 120, 'Chichiriviche');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (399, 120, 'Tocuyo de la Costa');
commit;
prompt 400 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (400, 121, 'Palmasola');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (401, 122, 'Cabure');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (402, 122, 'Colina');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (403, 122, 'Curimagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (404, 123, 'San José de la Costa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (405, 123, 'Píritu');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (406, 124, 'San Francisco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (407, 125, 'Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (408, 125, 'Pecaya');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (409, 126, 'Tocópero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (410, 127, 'El Charal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (411, 127, 'Las Vegas del Tuy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (412, 127, 'Santa Cruz de Bucaral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (413, 128, 'Bruzual');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (414, 128, 'Urumaco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (415, 129, 'Puerto Cumarebo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (416, 129, 'La Ciénaga');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (417, 129, 'La Soledad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (418, 129, 'Pueblo Cumarebo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (419, 129, 'Zazárida');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (420, 130, 'Camaguán');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (421, 130, 'Puerto Miranda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (422, 130, 'Uverito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (423, 131, 'Chaguaramas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (424, 132, 'El Socorro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (425, 133, 'Tucupido');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (426, 133, 'San Rafael de Laya');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (427, 134, 'Altagracia de Orituco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (428, 134, 'San Rafael de Orituco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (429, 134, 'San Francisco Javier de Lezama');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (430, 134, 'Paso Real de Macaira');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (431, 134, 'Carlos Soublette');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (432, 134, 'San Francisco de Macaira');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (433, 134, 'Libertad de Orituco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (434, 135, 'Cantaclaro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (435, 135, 'San Juan de los Morros');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (436, 135, 'Parapara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (437, 136, 'El Sombrero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (438, 136, 'Sosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (439, 137, 'Las Mercedes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (440, 137, 'Cabruta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (441, 137, 'Santa Rita de Manapire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (442, 138, 'Valle de la Pascua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (443, 138, 'Espino');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (444, 139, 'San José de Unare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (445, 139, 'Zaraza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (446, 140, 'San José de Tiznados');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (447, 140, 'San Francisco de Tiznados');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (448, 140, 'San Lorenzo de Tiznados');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (449, 140, 'Ortiz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (450, 141, 'Guayabal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (451, 141, 'Cazorla');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (452, 142, 'San José de Guaribe');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (453, 142, 'Uveral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (454, 143, 'Santa María de Ipire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (455, 143, 'Altamira');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (456, 144, 'El Calvario');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (457, 144, 'El Rastro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (458, 144, 'Guardatinajas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (459, 144, 'Capital Urbana Calabozo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (460, 145, 'Quebrada Honda de Guache');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (461, 145, 'Pío Tamayo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (462, 145, 'Yacambú');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (463, 146, 'Fréitez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (464, 146, 'José María Blanco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (465, 147, 'Catedral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (466, 147, 'Concepción');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (467, 147, 'El Cují');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (468, 147, 'Juan de Villega');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (469, 147, 'Santa Rosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (470, 147, 'Tamaca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (471, 147, 'Unión');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (472, 147, 'Aguedo Felipe Alvarado');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (473, 147, 'Buena Vista');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (474, 147, 'Juárez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (475, 148, 'Juan Bautista Rodríguez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (476, 148, 'Cuara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (477, 148, 'Diego de Lozada');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (478, 148, 'Paraíso de San José');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (479, 148, 'San Miguel');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (480, 148, 'Tintorero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (481, 148, 'José Bernardo Dorante');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (482, 148, 'Coronel Mariano Peraza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (483, 149, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (484, 149, 'Anzoátegui');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (485, 149, 'Guarico');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (486, 149, 'Hilario Luna y Luna');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (487, 149, 'Humocaro Alto');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (488, 149, 'Humocaro Bajo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (489, 149, 'La Candelaria');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (490, 149, 'Morán');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (491, 150, 'Cabudare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (492, 150, 'José Gregorio Bastidas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (493, 150, 'Agua Viva');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (494, 151, 'Sarare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (495, 151, 'Buría');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (496, 151, 'Gustavo Vegas León');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (497, 152, 'Trinidad Samuel');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (498, 152, 'Antonio Díaz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (499, 152, 'Camacaro');
commit;
prompt 500 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (500, 152, 'Castañeda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (501, 152, 'Cecilio Zubillaga');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (502, 152, 'Chiquinquirá');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (503, 152, 'El Blanco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (504, 152, 'Espinoza de los Monteros');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (505, 152, 'Lara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (506, 152, 'Las Mercedes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (507, 152, 'Manuel Morillo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (508, 152, 'Montaña Verde');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (509, 152, 'Montes de Oca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (510, 152, 'Torres');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (511, 152, 'Heriberto Arroyo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (512, 152, 'Reyes Vargas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (513, 152, 'Altagracia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (514, 153, 'Siquisique');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (515, 153, 'Moroturo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (516, 153, 'San Miguel');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (517, 153, 'Xaguas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (518, 154, 'Presidente Betancourt');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (519, 154, 'Presidente Páez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (520, 154, 'Presidente Rómulo Gallegos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (521, 154, 'Gabriel Picón González');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (522, 154, 'Héctor Amable Mora');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (523, 154, 'José Nucete Sardi');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (524, 154, 'Pulido Méndez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (525, 155, 'La Azulita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (526, 156, 'Santa Cruz de Mora');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (527, 156, 'Mesa Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (528, 156, 'Mesa de Las Palmas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (529, 157, 'Aricagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (530, 157, 'San Antonio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (531, 158, 'Canagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (532, 158, 'Capurí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (533, 158, 'Chacantá');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (534, 158, 'El Molino');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (535, 158, 'Guaimaral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (536, 158, 'Mucutuy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (537, 158, 'Mucuchachí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (538, 159, 'Fernández Peña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (539, 159, 'Matriz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (540, 159, 'Montalbán');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (541, 159, 'Acequias');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (542, 159, 'Jají');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (543, 159, 'La Mesa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (544, 159, 'San José del Sur');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (545, 160, 'Tucaní');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (546, 160, 'Florencio Ramírez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (547, 161, 'Santo Domingo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (548, 161, 'Las Piedras');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (549, 162, 'Guaraque');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (550, 162, 'Mesa de Quintero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (551, 162, 'Río Negro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (552, 163, 'Arapuey');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (553, 163, 'Palmira');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (554, 164, 'San Cristóbal de Torondoy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (555, 164, 'Torondoy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (556, 165, 'Antonio Spinetti Dini');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (557, 165, 'Arias');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (558, 165, 'Caracciolo Parra Pérez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (559, 165, 'Domingo Peña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (560, 165, 'El Llano');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (561, 165, 'Gonzalo Picón Febres');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (562, 165, 'acinto Plaza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (563, 165, 'Juan Rodríguez Suárez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (564, 165, 'Lasso de la Vega');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (565, 165, 'Mariano Picón Salas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (566, 165, 'Milla');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (567, 165, 'Osuna Rodríguez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (568, 165, 'Sagrario');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (569, 165, 'El Morro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (570, 165, 'Los Nevados');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (571, 166, 'Andrés Eloy Blanco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (572, 166, 'La Venta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (573, 166, 'Piñango');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (574, 166, 'Timotes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (575, 167, 'Eloy Paredes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (576, 167, 'San Rafael de Alcázar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (577, 167, 'Santa Elena de Arenales');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (578, 168, 'Santa María de Caparo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (579, 169, 'Pueblo Llano');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (580, 170, 'Cacute');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (581, 170, 'La Toma');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (582, 170, 'Mucuchíes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (583, 170, 'Mucurubá');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (584, 170, 'San Rafael');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (585, 171, 'Gerónimo Maldonado');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (586, 171, 'Bailadores');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (587, 172, 'Tabay');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (588, 173, 'Chiguará');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (589, 173, 'Estánquez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (590, 173, 'Lagunillas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (591, 173, 'La Trampa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (592, 173, 'Pueblo Nuevo del Sur');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (593, 173, 'San Juan');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (594, 174, 'El Amparo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (595, 174, 'El Llano');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (596, 174, 'San Francisco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (597, 174, 'Tovar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (598, 175, 'Independencia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (599, 175, 'María de la Concepción Palacios Blanco');
commit;
prompt 600 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (600, 175, 'Nueva Bolivia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (601, 175, 'Santa Apolonia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (602, 176, 'Caño El Tigre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (603, 176, 'Zea');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (604, 177, 'Aragüita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (605, 177, 'Arévalo González');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (606, 177, 'Capaya');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (607, 177, 'Caucagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (608, 177, 'Panaquire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (609, 177, 'Ribas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (610, 177, 'El Café');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (611, 177, 'Marizapa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (612, 178, 'Cumbo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (613, 178, 'San José de Barlovento');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (614, 179, 'El Cafetal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (615, 179, 'Las Minas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (616, 179, 'Nuestra Señora del Rosario');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (617, 180, 'Higuerote');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (618, 180, 'Curiepe');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (619, 180, 'Tacarigua de Brió');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (620, 181, 'Mamporal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (621, 182, 'Carrizal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (622, 183, 'Chacao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (623, 184, 'Charallave');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (624, 184, 'Las Brisas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (625, 185, 'El Hatillo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (626, 186, 'Altagracia de la Montaña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (627, 186, 'Cecilio Acosta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (628, 186, 'Los Teques');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (629, 186, 'El Jarillo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (630, 186, 'San Pedro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (631, 186, 'Tácata');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (632, 186, 'Paracotos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (633, 187, 'Cartanal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (634, 187, 'Santa Teresa del Tuy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (635, 188, 'La Democracia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (636, 188, 'Ocumare del Tuy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (637, 188, 'Santa Bárbara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (638, 189, 'San Antonio de los Altos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (639, 190, 'Río Chico');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (640, 190, 'El Guapo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (641, 190, 'Tacarigua de la Laguna');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (642, 190, 'Paparo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (643, 190, 'San Fernando del Guapo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (644, 191, 'Santa Lucía del Tuy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (645, 192, 'Cúpira');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (646, 192, 'Machurucuto');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (647, 193, 'Guarenas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (648, 194, 'San Antonio de Yare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (649, 194, 'San Francisco de Yare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (650, 195, 'Leoncio Martínez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (651, 195, 'Petare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (652, 195, 'Caucagüita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (653, 195, 'Filas de Mariche');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (654, 195, 'La Dolorita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (655, 196, 'Cúa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (656, 196, 'Nueva Cúa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (657, 197, 'Guatire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (658, 197, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (659, 198, 'San Antonio de Maturín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (660, 198, 'San Francisco de Maturín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (661, 199, 'Aguasay');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (662, 200, 'Caripito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (663, 201, 'El Guácharo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (664, 201, 'La Guanota');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (665, 201, 'Sabana de Piedra');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (666, 201, 'San Agustín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (667, 201, 'Teresen');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (668, 201, 'Caripe');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (669, 202, 'Areo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (670, 202, 'Capital Cedeño');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (671, 202, 'San Félix de Cantalicio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (672, 202, 'Viento Fresco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (673, 203, 'El Tejero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (674, 203, 'Punta de Mata');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (675, 204, 'Chaguaramas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (676, 204, 'Las Alhuacas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (677, 204, 'Tabasca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (678, 204, 'Temblador');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (679, 205, 'Alto de los Godos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (680, 205, 'Boquerón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (681, 205, 'Las Cocuizas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (682, 205, 'La Cruz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (683, 205, 'San Simón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (684, 205, 'El Corozo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (685, 205, 'El Furrial');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (686, 205, 'Jusepín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (687, 205, 'La Pica');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (688, 205, 'San Vicente');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (689, 206, 'Aparicio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (690, 206, 'Aragua de Maturín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (691, 206, 'Chaguamal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (692, 206, 'El Pinto');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (693, 206, 'Guanaguana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (694, 206, 'La Toscana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (695, 206, 'Taguaya');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (696, 207, 'Cachipo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (697, 207, 'Quiriquire');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (698, 208, 'Santa Bárbara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (699, 209, 'Barrancas');
commit;
prompt 700 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (700, 209, 'Los Barrancos de Fajardo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (701, 210, 'Uracoa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (702, 211, 'Antolín del Campo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (703, 212, 'Arismendi');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (704, 213, 'García');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (705, 213, 'Francisco Fajardo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (706, 214, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (707, 214, 'Guevara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (708, 214, 'Matasiete');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (709, 214, 'Santa Ana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (710, 214, 'Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (711, 215, 'Aguirre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (712, 215, 'Maneiro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (713, 216, 'Adrián');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (714, 216, 'Juan Griego');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (715, 216, 'Yaguaraparo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (716, 217, 'Porlamar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (717, 218, 'San Francisco de Macanao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (718, 218, 'Boca de Río');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (719, 219, 'Tubores');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (720, 219, 'Los Baleales');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (721, 220, 'Vicente Fuentes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (722, 220, 'Villalba');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (723, 221, 'San Juan Bautista');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (724, 221, 'Zabala');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (725, 222, 'BOCA DEL RIO');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (726, 223, 'Capital Araure');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (727, 223, 'Río Acarigua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (728, 224, 'Capital Esteller');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (729, 224, 'Uveral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (730, 225, 'Guanare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (731, 225, 'Córdoba');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (732, 225, 'San José de la Montaña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (733, 225, 'San Juan de Guanaguanare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (734, 225, 'Virgen de la Coromoto');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (735, 226, 'Guanarito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (736, 226, 'Trinidad de la Capilla');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (737, 226, 'Divina Pastora');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (738, 227, 'Monseñor José Vicente de Unda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (739, 227, 'Peña Blanca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (740, 228, 'Capital Ospino');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (741, 228, 'Aparición');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (742, 228, 'La Estación');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (743, 229, 'Páez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (744, 229, 'Payara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (745, 229, 'Pimpinela');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (746, 229, 'Ramón Peraza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (747, 230, 'Papelón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (748, 230, 'Caño Delgadito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (749, 231, 'San Genaro de Boconoito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (750, 231, 'Antolín Tovar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (751, 232, 'San Rafael de Onoto');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (752, 232, 'Santa Fe');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (753, 232, 'Thermo Morles');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (754, 233, 'Santa Rosalía');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (755, 233, 'Florida');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (756, 234, 'Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (757, 234, 'Concepción');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (758, 234, 'San Rafael de Palo Alzado');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (759, 234, 'Uvencio Antonio Velásquez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (760, 234, 'San José de Saguaz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (761, 234, 'Villa Rosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (762, 235, 'Turén');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (763, 235, 'Canelones');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (764, 235, 'Santa Cruz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (765, 235, 'San Isidro Labrador');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (766, 236, 'Mariño');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (767, 236, 'Rómulo Gallegos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (768, 237, 'San José de Aerocuar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (769, 237, 'Tavera Acosta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (770, 238, 'Río Caribe');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (771, 238, 'Antonio José de Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (772, 238, 'El Morro de Puerto Santo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (773, 238, 'Puerto Santo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (774, 238, 'San Juan de las Galdonas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (775, 239, 'El Pilar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (776, 239, 'El Rincón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (777, 239, 'General Francisco Antonio Váquez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (778, 239, 'Guaraúnos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (779, 239, 'Tunapuicito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (780, 239, 'Unión');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (781, 240, 'Santa Catalina');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (782, 240, 'Santa Rosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (783, 240, 'Santa Teresa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (784, 240, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (785, 240, 'Maracapana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (786, 241, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (787, 242, 'Libertad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (788, 242, 'El Paujil');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (789, 242, 'Yaguaraparo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (790, 243, 'Cruz Salmerón Acosta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (791, 243, 'Chacopata');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (792, 243, 'Manicuare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (793, 244, 'Tunapuy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (794, 244, 'Campo Elías');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (795, 245, 'Irapa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (796, 245, 'Campo Claro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (797, 245, 'Maraval');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (798, 245, 'San Antonio de Irapa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (799, 245, 'Soro');
commit;
prompt 800 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (800, 246, 'Mejía');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (801, 247, 'Cumanacoa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (802, 247, 'Arenas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (803, 247, 'Aricagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (804, 247, 'Cogollar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (805, 247, 'San Fernando');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (806, 247, 'San Lorenzo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (807, 248, 'Villa Frontado (Muelle de Cariaco)');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (808, 248, 'Catuaro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (809, 248, 'Rendón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (810, 248, 'San Cruz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (811, 248, 'Santa María');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (812, 249, 'Altagracia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (813, 249, 'Santa Inés');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (814, 249, 'Valentín Valiente');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (815, 249, 'Ayacucho');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (816, 249, 'San Juan');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (817, 249, 'Raúl Leoni');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (818, 249, 'Gran Mariscal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (819, 250, 'Cristóbal Colón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (820, 250, 'Bideau');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (821, 250, 'Punta de Piedras');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (822, 250, 'Güiria');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (823, 251, 'Andrés Bello');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (824, 252, 'Antonio Rómulo Costa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (825, 253, 'Ayacucho');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (826, 253, 'Rivas Berti');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (827, 253, 'San Pedro del Río');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (828, 254, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (829, 254, 'Palotal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (830, 254, 'General Juan Vicente Gómez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (831, 254, 'Isaías Medina Angarita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (832, 255, 'Cárdenas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (833, 255, 'Amenodoro Ángel Lamus');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (834, 255, 'La Florida');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (835, 256, 'Córdoba');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (836, 257, 'Fernández Feo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (837, 257, 'Alberto Adriani');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (838, 257, 'Santo Domingo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (839, 258, 'Francisco de Miranda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (840, 259, 'García de Hevia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (841, 259, 'Boca de Grita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (842, 259, 'José Antonio Páez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (843, 260, 'Guásimos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (844, 261, 'Independencia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (845, 261, 'Juan Germán Roscio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (846, 261, 'Román Cárdenas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (847, 262, 'Jáuregui');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (848, 262, 'Emilio Constantino Guerrero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (849, 262, 'Monseñor Miguel Antonio Salas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (850, 263, 'José María Vargas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (851, 264, 'Junín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (852, 264, 'La Petrólea');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (853, 264, 'Quinimarí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (854, 264, 'Bramón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (855, 265, 'Libertad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (856, 265, 'Cipriano Castro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (857, 265, 'Manuel Felipe Rugeles');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (858, 266, 'Libertador');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (859, 266, 'Doradas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (860, 266, 'Emeterio Ochoa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (861, 266, 'San Joaquín de Navay');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (862, 267, 'Lobatera');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (863, 267, 'Constitución');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (864, 268, 'Michelena');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (865, 269, 'Panamericano');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (866, 269, 'La Palmita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (867, 270, 'Pedro María Ureña');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (868, 270, 'Nueva Arcadia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (869, 271, 'Delicias');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (870, 271, 'Pecaya');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (871, 272, 'Samuel Darío Maldonado');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (872, 272, 'Boconó');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (873, 272, 'Hernández');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (874, 273, 'La Concordia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (875, 273, 'San Juan Bautista');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (876, 273, 'Pedro María Morantes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (877, 273, 'San Sebastián');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (878, 273, 'Dr. Francisco Romero Lobo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (879, 274, 'Seboruco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (880, 275, 'Simón Rodríguez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (881, 276, 'Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (882, 276, 'Eleazar López Contreras');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (883, 276, 'San Pablo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (884, 277, 'Torbes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (885, 278, 'Uribante');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (886, 278, 'Cárdenas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (887, 278, 'Juan Pablo Peñalosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (888, 278, 'Potosí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (889, 279, 'San Judas Tadeo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (890, 280, 'Araguaney');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (891, 280, 'El Jaguito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (892, 280, 'La Esperanza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (893, 280, 'Santa Isabel');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (894, 281, 'Boconó');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (895, 281, 'El Carmen');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (896, 281, 'Mosquey');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (897, 281, 'Ayacucho');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (898, 281, 'Burbusay');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (899, 281, 'General Ribas');
commit;
prompt 900 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (900, 281, 'Guaramacal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (901, 281, 'Vega de Guaramacal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (902, 281, 'Monseñor Jáuregui');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (903, 281, 'Rafael Rangel');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (904, 281, 'San Miguel');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (905, 281, 'San José');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (906, 282, 'Sabana Grande');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (907, 282, 'Cheregüé');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (908, 282, 'Granados');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (909, 283, 'Arnoldo Gabaldón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (910, 283, 'Bolivia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (911, 283, 'Carrillo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (912, 283, 'Cegarra');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (913, 283, 'Chejendé');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (914, 283, 'Manuel Salvador Ullo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (915, 283, 'San José');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (916, 284, 'Carache');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (917, 284, 'La Concepción');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (918, 284, 'Cuicas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (919, 284, 'Panamericana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (920, 284, 'Santa Cruz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (921, 285, 'Escuque');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (922, 285, 'La Unión');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (923, 285, 'Santa Rita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (924, 285, 'Sabana Libre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (925, 286, 'El Socorro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (926, 286, 'Los Caprichos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (927, 286, 'Antonio José de Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (928, 287, 'Campo Elías');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (929, 287, 'Arnoldo Gabaldón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (930, 288, 'Santa Apolonia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (931, 288, 'El Progreso');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (932, 288, 'La Ceiba');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (933, 288, 'Tres de Febrero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (934, 289, 'El Dividive');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (935, 289, 'Agua Santa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (936, 289, 'Agua Caliente');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (937, 289, 'El Cenizo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (938, 289, 'Valerita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (939, 290, 'Monte Carmelo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (940, 290, 'Buena Vista');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (941, 290, 'Santa María del Horcón');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (942, 291, 'Motatán');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (943, 291, 'El Baño');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (944, 291, 'Jalisco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (945, 292, 'Pampán');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (946, 292, 'Flor de Patria');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (947, 292, 'La Paz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (948, 292, 'Santa Ana');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (949, 293, 'Pampanito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (950, 293, 'La Concepción');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (951, 293, 'Pampanito II');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (952, 294, 'Betijoque');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (953, 294, 'José Gregorio Hernández');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (954, 294, 'La Pueblita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (955, 294, 'Los Cedros');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (956, 295, 'Carvajal');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (957, 295, 'Campo Alegre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (958, 295, 'Antonio Nicolás Briceño');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (959, 295, 'José Leonardo Suárez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (960, 296, 'Sabana de Mendoza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (961, 296, 'Junín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (962, 296, 'Valmore Rodríguez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (963, 296, 'El Paraíso');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (964, 297, 'Andrés Linares');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (965, 297, 'Chiquinquirá');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (966, 297, 'Cristóbal Mendoza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (967, 297, 'Cruz Carrillo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (968, 297, 'Matriz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (969, 297, 'Monseñor Carrillo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (970, 297, 'Tres Esquinas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (971, 298, 'Cabimbú');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (972, 298, 'Jajó');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (973, 298, 'La Mesa de Esnujaque');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (974, 298, 'Santiago');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (975, 298, 'Tuñame');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (976, 298, 'La Quebrada');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (977, 299, 'Juan Ignacio Montilla');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (978, 299, 'La Beatriz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (979, 299, 'La Puerta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (980, 299, 'Mendoza del Valle de Momboy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (981, 299, 'Mercedes Díaz');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (982, 299, 'San Luis');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (983, 300, 'Caraballeda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (984, 300, 'Carayaca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (985, 300, 'Carlos Soublette');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (986, 300, 'Caruao Chuspa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (987, 300, 'Catia La Mar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (988, 300, 'El Junko');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (989, 300, 'La Guaira');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (990, 300, 'Macuto');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (991, 300, 'Maiquetía');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (992, 300, 'Naiguatá');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (993, 300, 'Urimare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (994, 301, 'Arístides Bastidas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (995, 302, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (996, 303, 'Chivacoa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (997, 303, 'Campo Elías');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (998, 304, 'Cocorote');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (999, 305, 'Independencia');
commit;
prompt 1000 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1000, 306, 'José Antonio Páez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1001, 307, 'La Trinidad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1002, 308, 'Manuel Monge');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1003, 309, 'Salóm');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1004, 309, 'Temerla');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1005, 309, 'Nirgua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1006, 310, 'San Andrés');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1007, 310, 'Yaritagua');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1008, 311, 'San Javier');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1009, 311, 'Albarico');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1010, 311, 'San Felipe');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1011, 312, 'Sucre');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1012, 313, 'Urachiche');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1013, 314, 'El Guayabo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1014, 314, 'Farriar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1015, 315, 'Isla de Toas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1016, 315, 'Monagas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1017, 316, 'San Timoteo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1018, 316, 'General Urdaneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1019, 316, 'Libertador');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1020, 316, 'Marcelino Briceño');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1021, 316, 'Pueblo Nuevo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1022, 316, 'Manuel Guanipa Matos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1023, 317, 'Ambrosio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1024, 317, 'Carmen Herrera');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1025, 317, 'La Rosa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1026, 317, 'Germán Ríos Linares');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1027, 317, 'San Benito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1028, 317, 'Rómulo Betancourt');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1029, 317, 'Jorge Hernández');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1030, 317, 'Punta Gorda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1031, 317, 'Arístides Calvani');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1032, 318, 'Encontrados');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1033, 318, 'Udón Pérez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1034, 319, 'Moralito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1035, 319, 'San Carlos del Zulia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1036, 319, 'Santa Cruz del Zulia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1037, 319, 'Santa Bárbara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1038, 319, 'Urribarrí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1039, 320, 'Carlos Quevedo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1040, 320, 'Francisco Javier Pulgar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1041, 320, 'Simón Rodríguez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1042, 320, 'Guamo-Gavilanes');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1043, 321, 'La Concepción');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1044, 321, 'San José');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1045, 321, 'Mariano Parra León');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1046, 321, 'José Ramón Yépez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1047, 322, 'Jesús María Semprún');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1048, 322, 'Barí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1049, 323, 'Concepción');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1050, 323, 'Andrés Bello');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1051, 323, 'Chiquinquirá');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1052, 323, 'El Carmelo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1053, 323, 'Potreritos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1054, 324, 'Libertad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1055, 324, 'Alonso de Ojeda');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1056, 324, 'Venezuela');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1057, 324, 'Eleazar López Contreras');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1058, 324, 'Campo Lara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1059, 325, 'Bartolomé de las Casas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1060, 325, 'Libertad');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1061, 325, 'Río Negro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1062, 325, 'San José de Perijá');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1063, 326, 'San Rafael');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1064, 326, 'La Sierrita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1065, 326, 'Las Parcelas');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1066, 326, 'Luis de Vicente');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1067, 326, 'Monseñor Marcos Sergio Godoy');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1068, 326, 'Ricaurte');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1069, 326, 'Tamare');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1070, 327, 'Antonio Borjas Romero');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1071, 327, 'Bolívar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1072, 327, 'Cacique Mara');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1073, 327, 'Carracciolo Parra Pérez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1074, 327, 'Cecilio Acosta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1075, 327, 'Cristo de Aranza');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1076, 327, 'Coquivacoa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1077, 327, 'Chiquinquirá');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1078, 327, 'Francisco Eugenio Bustamante');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1079, 327, 'Idelfonzo Vásquez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1080, 327, 'Juana de Ávila');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1081, 327, 'Luis Hurtado Higuera');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1082, 327, 'Manuel Dagnino');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1083, 327, 'Olegario Villalobos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1084, 327, 'Raúl Leoni');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1085, 327, 'Santa Lucía');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1086, 327, 'Venancio Pulgar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1087, 327, 'San Isidro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1088, 328, 'Altagracia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1089, 328, 'Faría');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1090, 328, 'Ana María Campos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1091, 328, 'San Antonio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1092, 328, 'San José');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1093, 329, 'Donaldo García');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1094, 329, 'El Rosario');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1095, 329, 'Sixto Zambrano');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1096, 330, 'San Francisco');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1097, 330, 'El Bajo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1098, 330, 'Domitila Flores');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1099, 330, 'Francisco Ochoa');
commit;
prompt 1100 records committed...
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1100, 330, 'Los Cortijos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1101, 330, 'Marcial Hernández');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1102, 331, 'Santa Rita');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1103, 331, 'El Mene');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1104, 331, 'Pedro Lucas Urribarrí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1105, 331, 'José Cenobio Urribarrí');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1106, 332, 'Rafael Maria Baralt');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1107, 332, 'Manuel Manrique');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1108, 332, 'Rafael Urdaneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1109, 333, 'Bobures');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1110, 333, 'Gibraltar');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1111, 333, 'Heras');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1112, 333, 'Monseñor Arturo Álvarez');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1113, 333, 'Rómulo Gallegos');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1114, 333, 'El Batey');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1115, 334, 'Rafael Urdaneta');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1116, 334, 'La Victoria');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1117, 334, 'Raúl Cuenca');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1118, 335, 'Sinamaica');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1119, 335, 'Alta Guajira');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1120, 335, 'Elías Sánchez Rubio');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1121, 335, 'Guajira');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1122, 336, 'Altagracia');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1123, 336, 'Antímano');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1124, 336, 'Caricuao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1125, 336, 'Catedral');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1126, 336, 'Coche');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1127, 336, 'El Junquito');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1128, 336, 'El Paraíso');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1129, 336, 'El Recreo');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1130, 336, 'El Valle');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1131, 336, 'La Candelaria');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1132, 336, 'La Pastora');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1133, 336, 'La Vega');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1134, 336, 'Macarao');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1135, 336, 'San Agustín');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1136, 336, 'San Bernardino');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1137, 336, 'San José');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1138, 336, 'San Juan');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1139, 336, 'San Pedro');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1140, 336, 'Santa Rosalía');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1141, 336, 'Santa Teresa');
insert into PARROQUIA (pk_parroquia, fk_municipio, parroquia)
values (1142, 336, 'Sucre (Catia)');
commit;
prompt 1143 records loaded
prompt Loading TIPO_CENT_FARM...
insert into TIPO_CENT_FARM (pk_tipo_centro, tipo_de_centro, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 'Farmacia comunitarias', null, null, null, null);
insert into TIPO_CENT_FARM (pk_tipo_centro, tipo_de_centro, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 'Farmacia hospitalarias', null, null, null, null);
insert into TIPO_CENT_FARM (pk_tipo_centro, tipo_de_centro, fk_created_by, create_date, fk_modified_by, modified_date)
values (4, 'Farmacia populares', null, null, null, null);
commit;
prompt 3 records loaded
prompt Loading CENTRO_FARMACEUTICO...
insert into CENTRO_FARMACEUTICO (pk_centro_farm, fk_estado, fk_municipio, fk_parroquia, fk_tipo_centro, fk_area_trabajo, fk_estatus, cod_centro_farm, centro_farmacia, correo, correo_alterno, telefono, tlf_alterno, observacion, ubicacion_exacta, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 2, 2, 2, 2, 2, 3, '12345', 'OPENAI', 'AI@GMAIL.COM', 'OPENAI2@GMAIL.COM', 4126987515, 0, null, 'FLORES DE CHACAO', null, null, null, null);
commit;
prompt 1 records loaded
prompt Loading PRESENTACION_MEDICAMENTO...
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 'Jarabe', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 'Capsula', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (4, 'Tableta', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (5, 'Suspensión (Jarabe espeso)', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (6, 'Polvo', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (7, 'Granulados', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (8, 'Comprimidos', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (9, 'Emulsiones', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (10, 'Parenteral o Inyectable', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (11, 'Supositorio', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (12, 'Parches transdérmicos', null, null, null, null);
insert into PRESENTACION_MEDICAMENTO (pk_pres_medicamento, present_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (13, 'Inhaladores', null, null, null, null);
commit;
prompt 12 records loaded
prompt Loading CICLO_PACIENTE_TRATAMIENTO...
prompt Table is empty
prompt Loading CIUDADANO...
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (8, 21, 2, 2, 2, 'E099887744', 'RICARDO OSCAR', 'GOMÉZ PÉRES', 'M', to_date('15-02-1899', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (3, 21, 2, 2, 2, 'V027588805', 'GABRIEL ARMANDO', 'RINCON PACHECO', 'M', to_date('24-01-2001', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (4, 21, 2, 2, 2, 'V027340602', 'ELIANY MARIA', 'GUILLEN HERNÁDEZ', 'F', to_date('28-11-2000', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (5, 21, 2, 2, 2, 'V006662436', 'CAROLL YAMILETH', 'PACHECO PALACIOS', 'F', to_date('22-05-1987', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (6, 21, 3, 9, 27, 'V001234567', 'WINDOWS PRIVATE', 'MICROSOFT SERVER', 'M', to_date('02-11-1985', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (9, 21, 3, 9, 27, 'E000012345', 'CAMILA FERNANDA', 'PUERTAS', 'F', to_date('22-11-1985', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (10, 21, 2, 2, 2, 'E027309277', 'MANUEL DAVID', 'RINCÓN PACHECO', 'M', to_date('25-06-1999', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (11, 21, 2, 2, 2, 'E003698752', 'ROMAN CARLOS', 'CASTILLO RINCÓN', 'M', to_date('18-06-1996', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (12, 21, 2, 2, 2, 'V007896541', 'MARIA KARLA', 'GOMÉZ ROJAS', 'F', to_date('13-12-2001', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (13, 21, 2, 2, 2, 'V003250656', 'RONNY FERNANDO', 'MONTAÑES', 'M', to_date('08-08-2015', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (24, 21, 2, 2, 2, 'V058594035', 'CIUDADANO1', 'ROJAS', 'F', to_date('03-06-1899', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (25, 21, 2, 2, 2, 'V025196694', 'CIUDADANO2', 'CARRUSEL', 'M', to_date('11-04-1888', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (7, 21, 3, 9, 27, 'E069874526', 'LINNUX', 'OPEN SOFTWARE', 'M', to_date('25-05-1999', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (20, 21, 2, 2, 2, 'E003250656', 'JOHANA FERNANDÉZ', 'CAMACHO CASTILLO', 'F', to_date('18-08-1999', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (21, 21, 2, 2, 2, 'V008450676', 'ROSA GABRIELA', 'ROSALES MARTÍNEZ', 'F', to_date('14-05-2001', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (22, 21, 3, 9, 27, 'V000302661', 'PARIENTE1', 'RÍOS', 'M', to_date('20-05-2001', 'dd-mm-yyyy'));
insert into CIUDADANO (pk_ciudadano, fk_estatus, fk_estado, fk_municipio, fk_parroquia, cedula, nombre, apellido, sexo, fecha_nacimiento)
values (23, 21, 3, 9, 27, 'V005885246', 'PARIENTE2', 'MURALLAS', 'F', to_date('25-05-2005', 'dd-mm-yyyy'));
commit;
prompt 17 records loaded
prompt Loading TIPO_MEDICAMENTOS...
insert into TIPO_MEDICAMENTOS (pk_tipo_medicamento, tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 'ANALGÉSICO', null, null, null, null);
insert into TIPO_MEDICAMENTOS (pk_tipo_medicamento, tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 'ANTIHISTAMÍNICO/ANTIALÉRGICOS', null, null, null, null);
insert into TIPO_MEDICAMENTOS (pk_tipo_medicamento, tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (4, 'ANTIÁCIDOS', null, null, null, null);
insert into TIPO_MEDICAMENTOS (pk_tipo_medicamento, tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (6, 'ANTIBIÓTICOS', null, null, null, null);
insert into TIPO_MEDICAMENTOS (pk_tipo_medicamento, tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (7, 'ANTIMICÓTICOS', null, null, null, null);
insert into TIPO_MEDICAMENTOS (pk_tipo_medicamento, tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (8, 'ANTITUSIVOS', null, null, null, null);
insert into TIPO_MEDICAMENTOS (pk_tipo_medicamento, tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (9, 'DIURÉTICOS', null, null, null, null);
insert into TIPO_MEDICAMENTOS (pk_tipo_medicamento, tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (10, 'ANTICONCEPTIVOS', null, null, null, null);
commit;
prompt 8 records loaded
prompt Loading MEDICAMENTOS...
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (1, 'paracetamol', 'COMPONENTE PRINC PARACETAMOL', 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 'ibuprofeno', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 'aspirina', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (4, 'ketorolaco', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (5, 'tramadol', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (6, 'codeína', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (7, 'morfina', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (8, 'oxicodona', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (9, 'fentanilo', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (10, 'diclofenaco', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (11, 'naproxeno', null, 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (12, 'loratadina', null, 3, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (13, 'cetirizina', null, 3, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (14, 'fexofenadina', null, 3, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (15, 'desloratadina', null, 3, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (16, 'clorfeniramina', null, 3, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (17, 'diphenhydramina', null, 3, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (18, 'bromfeniramina', null, 3, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (19, 'amoxicilina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (20, 'ampicilina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (21, 'ciprofloxacino', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (22, 'levofloxacino', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (23, 'moxifloxacino', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (24, 'eritromicina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (25, 'doxiciclina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (26, 'sulfametoxazol', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (27, 'trimetoprim', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (28, 'gentamicina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (29, 'tobramicina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (30, 'azitromicina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (31, 'claritromicina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (32, 'cefaclor', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (33, 'cefalexina', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (34, 'cefuroxima', null, 6, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (35, 'clotrimazol', null, 7, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (36, 'econazol', null, 7, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (45, 'FROZEN', 'COMP FROZEN', 2, null, null, null, null);
insert into MEDICAMENTOS (pk_medicamento, nombre_medicamento, componente_princ, fk_tipo_medicamento, fk_created_by, create_date, fk_modified_by, modified_date)
values (37, 'miconazol', null, 7, null, null, null, null);
commit;
prompt 38 records loaded
prompt Loading DETALLES_MEDICAMENTOS...
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (2, 2, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (3, 3, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (4, 4, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (5, 5, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (6, 6, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (7, 7, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (8, 8, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (9, 9, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (10, 10, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (11, 11, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (12, 12, 5, '5-mililitros(ml)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (13, 13, 5, '5-mililitros(ml)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (15, 15, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (16, 16, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (17, 17, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (18, 18, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (19, 19, 5, '5-mililitros(ml)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (20, 20, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (21, 21, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (22, 22, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (23, 23, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (24, 24, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (25, 25, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (26, 26, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (27, 27, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (28, 28, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (29, 29, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (30, 30, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (31, 31, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (32, 32, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (33, 33, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (34, 34, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (36, 35, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (37, 36, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (47, 1, 4, '20-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (14, 14, 5, '5-mililitros(ml)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (1, 1, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (45, 45, 4, '5-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (46, 45, 4, '20-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (52, 3, 4, '10-miligramos(mg)');
insert into DETALLES_MEDICAMENTOS (pk_detalle_medic, fk_medicamento, fk_pres_medicamento, unidad_medida)
values (38, 37, 4, '5-miligramos(mg)');
commit;
prompt 41 records loaded
prompt Loading ESPECIALIDAD...
insert into ESPECIALIDAD (pk_especialidad, especialidad, fk_created_by, create_date, fk_modified_by, modified_date)
values (1, 'Farmacéutico clínico', null, null, null, null);
insert into ESPECIALIDAD (pk_especialidad, especialidad, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 'Farmacéutico especializado en enfermedades crónicas', null, null, null, null);
insert into ESPECIALIDAD (pk_especialidad, especialidad, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 'Farmacéutico de oncología', null, null, null, null);
commit;
prompt 3 records loaded
prompt Loading INVENTARIO_MEDICAMENTOS...
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 2, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 3, 2, 15, 75, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (4, 4, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (5, 5, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (6, 6, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (7, 7, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (8, 8, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (9, 9, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (10, 10, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (11, 11, 2, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (12, 12, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (13, 13, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (15, 15, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (16, 16, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (17, 17, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (18, 18, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (19, 19, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (20, 20, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (21, 21, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (22, 22, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (23, 23, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (24, 24, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (25, 25, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (26, 26, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (27, 27, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (28, 28, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (29, 29, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (30, 30, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (31, 31, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (32, 32, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (33, 33, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (34, 34, 2, 16, 0, 0, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (36, 36, 3, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), 'NINGUNA POR AHORA', null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (37, 37, 6, 15, 50, 1, to_date('01-01-2021', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (43, 45, 2, 15, 50, 1, to_date('12-12-2022', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (45, 47, 6, 16, 100, 2, to_date('03-05-2023', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (44, 46, 6, 15, 50, 1, to_date('12-12-2022', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (50, 52, 2, 15, 400, 10, to_date('03-05-2023', 'dd-mm-yyyy'), null, null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (38, 38, 6, 16, 0, 0, to_date('22-04-2023', 'dd-mm-yyyy'), 'NINGUNA POR AHORA', null, null, null, null);
insert into INVENTARIO_MEDICAMENTOS (pk_inventario_medic, fk_detalle_medic, fk_almacen, fk_estatus, cantidad, lote, fecha_vencimiento, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (1, 1, 2, 15, 70, 1, to_date('01-01-2021', 'dd-mm-yyyy'), 'NINGUNA POR AHORA', null, null, null, null);
commit;
prompt 40 records loaded
prompt Loading MEDICOS...
insert into MEDICOS (pk_medicos, fk_ciudadano, fk_especialidad, fk_centro_farm, fk_estatus, mpps, fecha_incorporacion, fecha_inactividad, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 6, 3, 2, 2, '14053', to_date('09-04-2023 12:51:32', 'dd-mm-yyyy hh24:mi:ss'), null, 'NINGUNA POR AHORA', null, null, null, null);
insert into MEDICOS (pk_medicos, fk_ciudadano, fk_especialidad, fk_centro_farm, fk_estatus, mpps, fecha_incorporacion, fecha_inactividad, observacion, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 7, 3, 2, 2, '14053', to_date('09-04-2023 18:44:19', 'dd-mm-yyyy hh24:mi:ss'), null, 'NINGUNA POR AHORA', null, null, null, null);
commit;
prompt 2 records loaded
prompt Loading PARIENTE...
insert into PARIENTE (pk_pariente, fk_ciudadano, fk_paciente, fk_created_by, create_date, fk_modified_by, modified_date)
values (1, 22, 22, null, null, null, null);
insert into PARIENTE (pk_pariente, fk_ciudadano, fk_paciente, fk_created_by, create_date, fk_modified_by, modified_date)
values (4, 3, 25, null, null, null, null);
insert into PARIENTE (pk_pariente, fk_ciudadano, fk_paciente, fk_created_by, create_date, fk_modified_by, modified_date)
values (2, 22, 23, null, null, null, null);
insert into PARIENTE (pk_pariente, fk_ciudadano, fk_paciente, fk_created_by, create_date, fk_modified_by, modified_date)
values (3, 25, 24, null, null, null, null);
insert into PARIENTE (pk_pariente, fk_ciudadano, fk_paciente, fk_created_by, create_date, fk_modified_by, modified_date)
values (22, 25, 41, null, null, null, null);
insert into PARIENTE (pk_pariente, fk_ciudadano, fk_paciente, fk_created_by, create_date, fk_modified_by, modified_date)
values (21, 5, 40, null, null, null, null);
commit;
prompt 6 records loaded
prompt Loading PACIENTE...
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (22, 21, 1, '58kl', '152', '12', 'ROSAGABRIELA@GMAIL.COM', 12365489654, 15874693210, null, null, null, null, 'NINGUNA');
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (25, 7, 4, '185kl', '1.25', '12', 'correopruebaivss@gmail.com', 14782369857, 2145879630, null, null, null, null, 'NINGUNA');
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (23, 20, 2, '52KL', '152', '12', 'johana@gmail.com', 12365478965, 0, null, null, null, null, 'NINGUNA');
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (24, 24, 3, '15KL', '1.85', '12', 'CIUDADANO1@GMAIL.COM', 15478203521, 22665489231, null, null, null, null, 'NINGUNA');
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (41, 8, 22, '186kl', '1.56', '10', 'RICARDO@GMAIL.COM', 15987430214, 0, null, null, null, null, 'NINGUNA');
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (40, 11, 21, '56KL', '1.85', '15', 'ROMAN@GMAIL.COM', 1234698741, 12036512478, null, null, null, null, 'NINGUNA');
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (1, 3, null, '150', '1.58', '123', 'CIUDADANO@GMAIL.COM', 12365478963, 0, null, null, null, null, null);
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (2, 4, null, '12KL', '1.65', '120.3', 'CIUDADANA@GMAIL.COM', 2569874156, 12598743602, null, null, null, null, null);
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (3, 5, null, '182KL', '1.85', '23.3', 'CIUDADANA@GMAIL.COM', 23654781023, 23518947058, null, null, null, null, null);
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (20, 13, null, '50kl', '1.85', '12', 'RONNYFERNANDO@GMAIL.COM', 12345698017, 12345678200, null, null, null, null, 'NINGUNA');
insert into PACIENTE (pk_paciente, fk_ciudadano, fk_pariente, peso, altura, superficie_corporal, correo, telefonno, tlf_alterno, fk_created_by, create_date, fk_modified_by, modified_date, observacion)
values (21, 12, null, '100kl', '1.25', '45', 'MARIA@GMAIL.COM', 78965412365, 0, null, null, null, null, 'NINGUNA');
commit;
prompt 11 records loaded
prompt Loading PACIENTE_RETIRADO...
insert into PACIENTE_RETIRADO (pk_paci_retirado, fk_ciudadano, observacion)
values (40, 4, 'RETIRADO SIN UN MOTIVO');
insert into PACIENTE_RETIRADO (pk_paci_retirado, fk_ciudadano, observacion)
values (22, 9, 'RETIRADO SIN UN MOTIVO');
insert into PACIENTE_RETIRADO (pk_paci_retirado, fk_ciudadano, observacion)
values (21, 11, 'RETIRADO SIN UN MOTIVO');
insert into PACIENTE_RETIRADO (pk_paci_retirado, fk_ciudadano, observacion)
values (1, 8, 'RETIRADO SIN UN MOTIVO');
commit;
prompt 4 records loaded
prompt Loading PATOLOGIA...
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (2, 'Asma');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (3, 'Rabia');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (4, 'Cáncer de colon y recto');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (5, 'Cáncer de endometrio');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (6, 'Cáncer de Hígado');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (7, 'Leucemia');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (8, 'Linfoma no Hodgkin');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (9, 'Melanoma');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (10, 'Cáncer de páncreas');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (11, 'Cáncer de próstata');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (12, 'Cáncer de pulmón');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (13, 'Cáncer de riñón');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (14, 'Cáncer de seno (mama)');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (15, 'Cáncer de tiroides');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (16, 'Cáncer de vejiga');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (17, 'Culebrilla (herpes zóster)');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (18, 'Diabetes');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (19, 'Meningitis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (20, 'Silicosis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (21, 'Tricomoniasis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (22, 'Zika');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (23, 'VIH/Sida');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (24, 'Herpes genital');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (25, 'Hemofilia');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (26, 'Neumonía');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (27, 'Ébola');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (28, 'Listeria (Listeriosis)');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (29, 'Ántrax');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (30, 'Artritis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (31, 'Clamidia');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (32, 'Tuberculosis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (33, 'Coronavirus(Covid-19)');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (34, 'Paperas');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (35, 'Poliomielitis/Polio');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (36, 'Rotavirus');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (37, 'Shigelosis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (38, 'Sífilis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (39, 'Síndrome alcohólico fetal');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (40, 'Síndrome de fatiga crónica (SFC)');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (41, 'Tosferina');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (42, 'Vaginosis bacteriana');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (43, 'Pulmonar');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (44, 'Próstata');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (45, 'Pulmonar');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (46, 'Riñon');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (47, 'Colon');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (48, 'Cuello de Utero');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (49, 'Piel');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (50, 'Pene');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (51, 'Páncreas');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (52, 'Ovario');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (53, 'Cirrosis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (54, 'Hígado Graso');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (55, 'enfermedad de Wilson');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (56, 'hemocromatosis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (57, 'Laringe');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (58, 'hepatitis A');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (59, 'hepatitis B');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (60, 'hepatitis C');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (61, 'Tiroides');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (62, 'Testiculos');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (63, 'Catarro');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (64, 'Celiaquía');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (65, 'Chikungunya');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (66, 'Ciática');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (67, 'Cistitis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (68, 'Colon irritable');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (69, 'Colitis ulcerosa');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (70, 'Cólico nefrítico');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (71, 'Colesteatoma');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (72, 'Cólera');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (73, 'Congestión nasal');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (74, 'Conjuntivitis');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (75, 'Contusiones');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (76, 'Corte de digestión');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (77, 'Crisis de pánico');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (78, 'Cuerpos extraños');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (79, 'Déficit de la hormona del crecimiento');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (80, 'Degeneración macular');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (81, 'Dermatitis atópica');
insert into PATOLOGIA (pk_patologia, nombre_patologia)
values (82, 'Derrame ocular');
commit;
prompt 81 records loaded
prompt Loading PATOLOGIA_PACIENTE...
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (22, 22, 5, 2, 18, null, to_date('17-04-2023 14:55:04', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (25, 25, 5, 2, 18, null, to_date('18-04-2023 14:04:50', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (1, 3, 2, 2, 18, null, to_date('09-04-2023 14:51:20', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (2, 2, 3, 2, 18, null, to_date('09-04-2023 16:50:56', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (3, 1, 3, 2, 18, null, to_date('09-04-2023 17:15:44', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (4, 1, 2, 3, 18, null, to_date('11-04-2023 11:37:23', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (20, 20, 4, 3, 18, null, to_date('16-04-2023 10:05:34', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (21, 21, 4, 3, 18, null, to_date('16-04-2023 10:35:07', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (23, 23, 5, 2, 18, null, to_date('17-04-2023 15:06:41', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (24, 24, 5, 3, 18, null, to_date('17-04-2023 17:36:11', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (41, 41, 6, 2, 18, null, to_date('23-04-2023 12:15:49', 'dd-mm-yyyy hh24:mi:ss'));
insert into PATOLOGIA_PACIENTE (pk_patologia_pac, fk_paciente, fk_patologia, fk_medico, fk_estatus, fk_created_by, create_date)
values (40, 40, 5, 3, 18, null, to_date('23-04-2023 12:07:06', 'dd-mm-yyyy hh24:mi:ss'));
commit;
prompt 12 records loaded
prompt Loading TIPO_INSUMOS...
prompt Table is empty
prompt Loading SOLICITUD_INSUMOS...
prompt Table is empty
prompt Loading TIPO_TICKET...
insert into TIPO_TICKET (pk_tipo_ticket, nombre_ticket, nro_min, nro_max, letra)
values (1, 'PRIMERA VEZ', '1', '300', 'P');
insert into TIPO_TICKET (pk_tipo_ticket, nombre_ticket, nro_min, nro_max, letra)
values (2, 'MONOTERAPIA', '400', '700', 'M');
insert into TIPO_TICKET (pk_tipo_ticket, nombre_ticket, nro_min, nro_max, letra)
values (3, 'MULTITERAPIA', '800', '1100', 'U');
insert into TIPO_TICKET (pk_tipo_ticket, nombre_ticket, nro_min, nro_max, letra)
values (4, 'QUIMIOTERAPIA', '1200', '1500', 'Q');
insert into TIPO_TICKET (pk_tipo_ticket, nombre_ticket, nro_min, nro_max, letra)
values (5, 'TRANSPLANTE', '1600', '2000', 'T');
commit;
prompt 5 records loaded
prompt Loading TICKET...
insert into TICKET (pk_ticket, fk_tipo_ticket, fk_estatus, cedula_ciudadano, nro_ticket, fk_created_by, create_date)
values (2, 2, 18, '3698752', '400', null, null);
insert into TICKET (pk_ticket, fk_tipo_ticket, fk_estatus, cedula_ciudadano, nro_ticket, fk_created_by, create_date)
values (3, 1, 18, '99887744', '2', null, null);
insert into TICKET (pk_ticket, fk_tipo_ticket, fk_estatus, cedula_ciudadano, nro_ticket, fk_created_by, create_date)
values (5, 1, 19, '123', '4', null, null);
insert into TICKET (pk_ticket, fk_tipo_ticket, fk_estatus, cedula_ciudadano, nro_ticket, fk_created_by, create_date)
values (6, 1, 19, '1', '5', null, null);
insert into TICKET (pk_ticket, fk_tipo_ticket, fk_estatus, cedula_ciudadano, nro_ticket, fk_created_by, create_date)
values (4, 1, 19, '147', '3', null, null);
insert into TICKET (pk_ticket, fk_tipo_ticket, fk_estatus, cedula_ciudadano, nro_ticket, fk_created_by, create_date)
values (1, 1, 9, '27340602', '1', null, null);
insert into TICKET (pk_ticket, fk_tipo_ticket, fk_estatus, cedula_ciudadano, nro_ticket, fk_created_by, create_date)
values (7, 1, 19, '27588805', '6', null, null);
commit;
prompt 7 records loaded

set feedback on
set define on
prompt Done
