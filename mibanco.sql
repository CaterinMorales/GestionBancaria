create database mibanco;
use mibanco;

create table ejecutivo(
  rut varchar(20),
  nombre varchar(20),
  apellido varchar(20),
  clave varchar(100),
  primary key(rut)
);

create table cliente(
  rut varchar(20),
  nombre varchar(20),
  apellido varchar(20),
  clave varchar(100),
  ejecutivoFK varchar(20),
  primary key(rut),
  foreign key(ejecutivoFK) references ejecutivo(rut) on delete set null
);

create table mensaje(
  idmensaje int auto_increment,
  asunto varchar(20),
  contenido varchar(200),
  respuesta varchar(200),
  clienteFK varchar(20),
  ejecutivoFK varchar(20),
  primary key(idmensaje),
  foreign key(clienteFK) references cliente(rut) on delete set null,
  foreign key(ejecutivoFK) references ejecutivo(rut) on delete set null
);

create table cuenta(
  numerocta int,
  saldo int,
  clavetransaccion varchar(100),
  saldolineacredito int,
  saldolineacreditousado int,
  estado int,
  clienteFK varchar(20),
  primary key(numerocta),
  foreign key (clienteFK) references cliente(rut) on delete set null
);

create table movimientos(
  idmovimiento int auto_increment,
  fecha date,
  descripcion varchar(200),
  cuentaFK int,
  primary key(idmovimiento),
  foreign key (cuentaFK) references cuenta(numerocta) on delete set null
);
