
/*CREAR BASE DE DATOS*/
CREATE DATABASE cabanias_db;

/*USAR BASE DE DATOS*/
USE cabanias_db;

/*CREAR TABLAS*/
CREATE TABLE IF NOT EXISTS `cabanias_db` . `provincia` (
provincia_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nombre varchar(50) NOT NULL
);

CREATE TABLE IF NOT EXISTS `cabanias_db` . `perfil` (
perfil_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
tipo_perfil VARCHAR(30)
);

CREATE TABLE IF NOT EXISTS `cabanias_db` . `cliente` (
cliente_id INT  PRIMARY KEY NOT NULL AUTO_INCREMENT,
nombre varchar(50) NOT NULL,
apellido varchar(50) NOT NULL,
email varchar(50) NOT NULL,
provincia_id INT,
perfil_id INT,
CONSTRAINT `provincia_id`
	FOREIGN KEY (`provincia_id`)
    REFERENCES `cabanias_db` . `provincia` (`provincia_id`),
CONSTRAINT `perfil_id`
	FOREIGN KEY (`perfil_id`)
    REFERENCES `cabanias_db` . `perfil` (`perfil_id`)
);

CREATE TABLE IF NOT EXISTS `cabanias_db`.`cabanias` (
cabania_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
capacidad INT NOT NULL,
precio FLOAT NOT NULL);


CREATE TABLE IF NOT EXISTS `cabanias_db`. `estado` (
estado_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
nombre VARCHAR(20) NOT NULL);

CREATE TABLE IF NOT EXISTS `cabanias_db`. `metodos_pago` (
metodo_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
tipo_metodo VARCHAR(20) NOT NULL);

CREATE TABLE IF NOT EXISTS `cabanias_db`. `reservas` (
reserva_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
ingreso DATE NOT NULL,
salidad DATE NOT NULL,
cant_noches INT NOT NULL,
cant_personas INT NOT NULL,
senia INT,
estado_id INT,
cliente_id INT NOT NULL,
cabania_id INT NOT NULL,
CONSTRAINT `estado_id`
	FOREIGN KEY (`estado_id`)
    REFERENCES `cabanias_db`. `estado` (`estado_id`),
CONSTRAINT `cliente_id`
	FOREIGN KEY (`cliente_id`)
    REFERENCES `cabanias_db`. `cliente` (`cliente_id`),    
CONSTRAINT `cabania_id`
	FOREIGN KEY (`cabania_id`)
    REFERENCES `cabanias_db`.`cabanias` (`cabania_id`)
    
);

CREATE TABLE IF NOT EXISTS `cabanias_db`.`pago` (
pago_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
total FLOAT NOT NULL,
reserva_id INT NOT NULL,
metodo_id INT NOT NULL,
CONSTRAINT `reserva_id`
	FOREIGN KEY (`reserva_id`)
    REFERENCES `cabanias_db`. `reservas` (`reserva_id`),    
CONSTRAINT `metodo_id`
	FOREIGN KEY (`metodo_id`)
    REFERENCES `cabanias_db`. `metodos_pago` (`metodo_id`)

);
/*MODIFICAR TABLAS YA CREADAS*/
ALTER TABLE cliente
ADD password varchar(8);

/* MODIFICAR CAMPOS DE TABLAS YA CREADAS*/
ALTER TABLE cliente
MODIFY COLUMN password varchar(8) NOT NULL;

/*INGRESAR DATOS*/
INSERT INTO provincia VALUES (NULL,'cordoba');
INSERT INTO provincia VALUES (NULL,'buenos aires');
INSERT INTO provincia VALUES (NULL, 'ciudad autonomoma');
INSERT INTO provincia VALUES (NULL, 'catamarca');
INSERT INTO provincia VALUES (NULL, 'chaco');
INSERT INTO provincia VALUES (NULL, 'chubut');
INSERT INTO provincia VALUES (NULL, 'corrientes');
INSERT INTO provincia VALUES (NULL, 'entre rios');
INSERT INTO provincia VALUES (NULL, 'formosa');
INSERT INTO provincia VALUES (NULL, 'jujuy');
INSERT INTO provincia VALUES (NULL, 'la pampa');
INSERT INTO provincia VALUES (NULL, 'la rioja');
INSERT INTO provincia VALUES (NULL, 'mendoza');
INSERT INTO provincia VALUES (NULL, 'misiones');
INSERT INTO provincia VALUES (NULL, 'neuquen');
INSERT INTO provincia VALUES (NULL, 'rio negro');
INSERT INTO provincia VALUES (NULL, 'salta');
INSERT INTO provincia VALUES (NULL, 'san juan');
INSERT INTO provincia VALUES (NULL, 'san luis');
INSERT INTO provincia VALUES (NULL, 'santa cruz');
INSERT INTO provincia VALUES (NULL, 'santa fe');
INSERT INTO provincia VALUES (NULL, 'santiago del estero');
INSERT INTO provincia VALUES (NULL, 'tierra del fuego');
INSERT INTO provincia VALUES (NULL, 'tucuman');

INSERT INTO perfil VALUES(NULL, 'cliente');
INSERT INTO perfil VALUES(NULL, 'nuevo');
INSERT INTO perfil VALUES(NULL, 'recomendado');


/* SELECCIONAR TODOS LOS DATOS DE UNA TABLA*/
SELECT * FROM perfil;

/*SELECCIONAR CAMPOS ESPECIFICOS DE UNA TABLA*/
SELECT nombre from provincia;

/*ACTUALIZAR VALORES DEL CAMPO DE UNA TABALA*/
UPDATE perfil
SET tipo_perfil = 'primerizo'
WHERE perfil_id= '2';

DELETE FROM perfil
WHERE perfil_id = 2;

SELECT tipo_perfil, nombre, apellido
FROM perfil INNER JOIN cliente ON cliente.perfil_id = perfil.perfil_id;

SELECT reserva_id, nombre, apellido
FROM reservas INNER JOIN cliente ON reservas.cliente_id_pk= cliente.cliente_id;



INSERT INTO cliente VALUES (
NULL, 'Marcelo', 'Carrizo', 'marcecarrizo@gmil.com', 1, 1, 'mar1234'),
(NULL, 'Camila', 'Caceres', 'camicaceres@gmil.com', 1, 1, 'cami1234');

INSERT INTO cabanias VALUES
(NULL, 7, 60000 ),
(NULL, 5, 30000 ),
(NULL, 6, 36000 ),
(NULL, 4, 24000 );

INSERT INTO estado VALUES
(NULL,  'en progreso');

SELECT * FROM reservas;

INSERT INTO reservas VALUES
(NULL, '2024-01-01', '2024-01-10', salidad-ingreso , 5, 30000, 1, 4, 2 );

UPDATE reservas
SET cliente_id_pk = 2
WHERE reserva_id = 2;



select * from reservas;

/*funciona*/
SELECT COUNT(*) AS total_reservaciones
FROM reservas
WHERE cabania_id = 3
/* determina si las fechas deseadas estan dentro de un rango registrado*/
AND (ingreso < '2024-01-31' /*fecha salida deseada*/ AND  salidad > '2024-01-09' /*fecha inicio deseada*/);

SELECT capacidad, ingreso, salidad
FROM cabanias inner join reservas on reservas.cabania_id = cabanias.cabania_id;



SELECT COUNT(*) AS total_reservaciones
FROM reservas
WHERE cabania_id = 3
AND ('2024-01-10' /*fecha ingreso deseada*/  BETWEEN ingreso AND salidad
OR  '2024-01-15' /*fecha final deseada*/ BETWEEN ingreso AND salidad) ;


SELECT cliente_id, ingreso, salidad
FROM cliente inner join reservas on reservas.cliente_id_pk = cliente.cliente_id;

select * from reservas;
DELETE FROM cliente WHERE cliente_id= 1;