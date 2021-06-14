-- Este ejemplo utiliza la tabla Jugadores incluída
-- en el script mochila_jugadores.sql,
-- y la tabla de Vuelos en el script vuelos.sql

-- OBJETIVO: Armar un equipo de jugadores
-- con la mayor técnica posible sin gastar más de 140

WITH RECURSIVE Mochila(tecnica_total, monto, equipo) AS
       (VALUES (0.00, 0, ARRAY[]::VARCHAR[])
        UNION
        SELECT m.tecnica_total + j.tecnica,
               m.monto + j.precio,
               ARRAY_APPEND(m.equipo, j.jugador)
        FROM Mochila m,
             Jugadores j
        WHERE m.monto + j.precio <=140
        AND j.jugador > ALL(m.equipo))

SELECT *
FROM Mochila
WHERE tecnica_total >=
    ALL (SELECT m2.tecnica_total
         FROM Mochila m2);

-- OBJETIVO: Hallar todas las ciudades
-- alcanzables desde París.
WITH RECURSIVE DestAlcanzables(destino_alc) AS
    (VALUES ('París')
    UNION
    (SELECT DISTINCT v.destino
     FROM DestAlcanzables d, Vuelos v
     WHERE d.destino_alc = v.origen)
    )
SELECT *
FROM DestAlcanzables;
