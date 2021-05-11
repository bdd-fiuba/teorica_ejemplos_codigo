CREATE TABLE Jugadores (
jugador VARCHAR(30) NOT NULL PRIMARY KEY,
precio INT,
tecnica NUMERIC(4,2),
fecha_nac DATE
);

INSERT INTO Jugadores
VALUES
('Lionel Messi',80,9.80,'1987-06-24'),
('Cristiano Ronaldo',75,9.70,'1985-02-05'),
('Luis Suárez',45,8.70,'1987-01-24'),
('Ciro Immobile',30,5.00,'1990-02-20'),
('Karim Benzema',36,7.20,'1987-12-19'),
('Paul Pogba',40,8.30,'1993-03-15');
