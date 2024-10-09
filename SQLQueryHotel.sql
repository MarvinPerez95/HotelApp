--Creacion de Base de Datos
create database Hotel;

Use Hotel;
go

--Creacion del Esquema Hotel
create schema dbHotel;
go

--Formato de ingreso para fecha
SELECT FORMAT (getdate(), 'dd-MM-yyyy') as date
GO

/*		Creacion de Tablas			*/
--Tabla Clientes
create table dbHotel.Clientes(
ClienteID int identity(1,1) Primary Key,
Nombre varchar(50),
Email varchar(50)
)

--Tabla Habitaciones
create table dbHotel.Habitaciones(
HabitacionID int identity(1,1) primary key,
TipoHabitacion varchar(25),
PrecioPorNoche decimal(5,2)
)

--Tabla Reservas 
create table dbHotel.Reservas(
ReservaID int identity(1,1) Primary Key,
ClienteID int Foreign Key references dbHotel.Clientes(ClienteID),
HabitacionID int Foreign Key references dbHotel.Habitaciones (HabitacionID),
FechaEntrada datetime,
FechaSalida datetime, 
Total decimal(5,2)
)


/*		Ingreso de Datos		*/
--Tabla Clientes
INSERT INTO dbHotel.Clientes (Nombre, Email)
VALUES 
('Juan Pérez', 'juan.perez@gmail.com'),
('Ana González', 'ana.gonzalez@hotmail.com'),
('Carlos Martínez', 'carlos.martinez@yahoo.com'),
('Laura Rodríguez', 'laura.rodriguez@outlook.com'),
('Pedro Sánchez', 'pedro.sanchez@gmail.com');

select * from dbHotel.Clientes;

--Tabla Habitaciones
INSERT INTO dbHotel.Habitaciones (TipoHabitacion, PrecioPorNoche)
VALUES 
('Individual', 50.00),
('Doble', 80.00),
('Suite', 150.00),
('Familiar', 120.00),
('Deluxe', 200.00);

select * from dbHotel.Habitaciones;

--Tabla Reservas
INSERT INTO dbHotel.Reservas (ClienteID, HabitacionID, FechaEntrada, FechaSalida, Total)
VALUES 
(1, 2, '15-01-2024', '20-01-2024', 400.00),  -- Juan reservó una habitación doble por 5 noches
(2, 3, '01-11-2024', '05-11-2024', 600.00),  -- Ana reservó una suite por 4 noches
(3, 1, '09-10-2024', '12-10-2024', 100.00),  -- Carlos reservó una habitación individual por 2 noches
(4, 4, '01-12-2024', '07-12-2024', 720.00),  -- Laura reservó una habitación familiar por 6 noches
(5, 5, '25-10-2024', '28-10-2024', 600.00);	 -- Pedro reservó una habitación Deluxe por 3 noches
(1, 1, '20-10-2024', '22-10-2024', 150.00);  -- Juan reservó una habitación individual por 3 noches

select * from dbHotel.Reservas;
--Drop table dbHotel.Reservas;


/*		Consultas		*/
--Ingresos por cliente
select ClienteID, sum(total) as IngresosClientes from dbHotel.Reservas
where total>0
group by ClienteID 
order by ClienteID;

-- Reservas activas
select * from dbHotel.Reservas
where FechaSalida > getDate()
order by FechaSalida asc;

/*		Procedimiento Almacenado*/
-- Procedimiento Reserva 
Create procedure spReserva
--Parametros
	@ClienteID int,
	@HabitacionID int,
	@FechIngreso DateTime,
	@FechaEgreso DateTime
as 
Begin
--Variables
	declare @PrecioNoche decimal (5,2);
	declare @Total decimal(5,2);
	declare @TotalNoches int;

--Precio de habitacion 
	select  @PrecioNoche = @PrecioNoche from dbHotel.Habitaciones 
	where HabitacionID = @HabitacionID;

--Cantidad de Noches
	Set @TotalNoches = DATEDIFF(day,@FechIngreso,@FechaEgreso);

--Calculo del Total
	Set @Total = @PrecioNoche * @TotalNoches;

--Incercion en tabla
	INSERT INTO dbHotel.Reservas (ClienteID, HabitacionID, FechaEntrada, FechaSalida, Total)
VALUES
(@clienteID, @HabitacionID, @FechIngreso, @fechaEgreso, @Total);
End
go

--Invocacion de SP
execute spReserva 
	@ClienteID = 1,
    @HabitacionID = 2,
    @FechIngreso = '01-11-2024',
    @FechaEgreso = '05-11-2024';
go

--Validacion
select * from dbHotel.Reservas;