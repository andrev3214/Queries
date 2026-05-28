/* Crear una base de datos llamada universidadDB la cual maneja dos modulos:
academico y seguridad 

Modulo Academico: Carrera y Estudiante.

Modulo Seguridad: Cargo y Usuario.


*/
use master;
go

if(exists(select * from sys.databases where name = 'universidadDB'))
begin
	drop database universidadDB


end
go

create database universidadDB
go 

use universidadDB
go
-- //schema: Es un contenedor lógico dentro de una base de datos que sirve para organizar objetos dentro de una base de datos.
create schema academico
go

create schema seguridad
go

create table Academico.Carrera(
	id int primary key identity(1,1)
	, nombre nvarchar(100) not null
	, precio decimal(10,2)
	,create_at datetime default getdate()
	, update_at datetime default null
	, delete_at datetime
)
go

create table Seguridad.Cargo(
	id int identity(1,1)
	,constraint PK_Cargo primary key(id)
	,nombre nvarchar(100) not null
	,constraint UQ_Cargo_Nombre unique(nombre)
	,descripcion nvarchar(255)
	,create_at datetime default getdate()
	,update_at datetime default null
	,delete_at datetime null
)
go

create table Seguridad.Usuario(
	id int primary key identity(1,1)
	,constraint UQ_Usuario_Cif unique(cif)
	, cif varchar(16) not null unique
	, nombre nvarchar(100) not null
	, email nvarchar(100) not null unique
	, password nvarchar(255) not null
	,constraint UQ_Usuario_Email unique(email)
	,check(email like '%@%.%')
	,idCargo int not null
	, create_at datetime default getdate()
	, update_at datetime default null
	, delete_at datetime
	,constraint CHK_Usuario_Password
	check(len(password) >= 8)
	,constraint FK_Usuario_Cargo
	foreign key(idCargo)
	references Seguridad.Cargo(id)
)
go

