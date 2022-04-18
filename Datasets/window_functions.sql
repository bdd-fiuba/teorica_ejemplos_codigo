CREATE TABLE Final_2009 (
  nombre_atleta VARCHAR(20) PRIMARY KEY,
  pais_origen VARCHAR(20),
  marca_seg NUMERIC (8,2)
);

INSERT INTO Final_2009 VALUES
('Daniel Bailey','Antigua y Barbuda',9.93),
('Tyson Gay','Estados Unidos',9.71),
('Marc Burns','Trinidad y Tobago',10.00),
('Usain Bolt','Jamaica',9.58),
('Darvis Patton','Estados Unidos',10.34),
('Asafa Powell','Jamaica',9.84),
('Richard Thompson','Trinidad y Tobago',9.93),
('Dwain Chambers','Reino Unido',10.00);

CREATE TABLE Exportaciones (
 pais VARCHAR(30),
 producto VARCHAR(30),
 cantidad INT
);

INSERT INTO Exportaciones VALUES
('Brasil', 'Trigo', 720),
('Argentina', 'Trigo', 440),
('USA', 'Maíz', 520),
('Australia', 'Trigo', 900),
('China', 'Sorgo', 80),
('Argentina', 'Maíz', 520),
('China', 'Trigo', 780);

CREATE TABLE Toques (
  timestamp TIME(3) PRIMARY KEY,
  jugador VARCHAR(20)
);

INSERT INTO Toques VALUES
('16:20:18.315', NULL),
('16:21:18.418', 'Lionel Messi'),
('16:21:22.637', 'Giovanni Lo Celso'),
('16:21:42.402', 'Dani Alves'),
('16:21:46.535', 'Nicolás Otamendi'),
('16:21:49.388', 'Lionel Messi'),
('16:21:50.000', NULL);
