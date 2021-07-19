CREATE DATABASE seguridad;

----------------------------------------
-- Definimos los roles
----------------------------------------

CREATE ROLE resp_ventas;
CREATE ROLE resp_compras;
CREATE ROLE resp_produccion;
CREATE ROLE sperez LOGIN PASSWORD='susanita' IN ROLE resp_ventas;
CREATE ROLE rfranco LOGIN PASSWORD='roger' IN ROLE resp_compras;
CREATE ROLE bgarcia LOGIN PASSWORD='1234' IN ROLE resp_produccion;

DROP SCHEMA public;
CREATE SCHEMA empresa;
GRANT USAGE ON SCHEMA empresa TO ALL;
SET search_path to empresa;

----------------------------------------
-- Creamos las tablas
----------------------------------------

CREATE TABLE Clientes(nombre VARCHAR(20) PRIMARY KEY, domicilio VARCHAR(30));
CREATE TABLE Pedidos(cod_pedido INT PRIMARY KEY,
                     nombre_cliente VARCHAR(20) REFERENCES
                     Clientes(nombre), fecha_entrega DATE);
CREATE TABLE Productos(codigo INT PRIMARY KEY, nombre VARCHAR(20),
                       descripcion VARCHAR(50), stock INT);
CREATE TABLE Insumos(codigo INT PRIMARY KEY, nombre VARCHAR(40),
                     descripcion VARCHAR(50), stock INT);
CREATE TABLE ComposicionPedido(cod_pedido INT REFERENCES Pedidos
             (cod_pedido), cod_producto INT REFERENCES Productos
	     (codigo), cantidad INT, PRIMARY KEY (cod_pedido, cod_producto));

----------------------------------------
-- Insertamos algunos datos
----------------------------------------

INSERT INTO Clientes VALUES ('La Sierra S.A.', 'Los Andes 280'),
			    ('Turdera S.R.L.', 'Juarez 1539');

INSERT INTO Pedidos VALUES (58, 'La Sierra S.A.', '26-10-2017'),
			   (60, 'Turdera S.R.L.', '28-10-2017');

INSERT INTO Productos VALUES (381, 'Hamaca paraguaya', 'Ideal para descansar', 5),
			     (408, 'Sombrilla veneciana', 'Con filtro solar interno', 3);

INSERT INTO Insumos VALUES (33, 'Rollo de Soga 200m, 4mm', 'Soga delgada de alta resistencia', 15),
	                   (38, 'Rollo de lona azul 100m', 'Lona para sombrillas', 3);

INSERT INTO ComposicionPedido VALUES (58, 381, 1),
				     (58, 408, 1),
				     (60, 381, 2),
				     (60, 408, 3);

----------------------------------------
-- Asignamos permisos
----------------------------------------

GRANT ALL PRIVILEGES ON Clientes, Pedidos, ComposicionPedido TO resp_ventas;
GRANT SELECT, UPDATE (stock) ON Insumos, Productos TO resp_produccion;
GRANT SELECT ON Pedidos, ComposicionPedido TO resp_produccion;
GRANT SELECT, UPDATE (stock) ON Insumos TO resp_compras;

----------------------------------------
-- Probar consultas!!
----------------------------------------

-- ...

