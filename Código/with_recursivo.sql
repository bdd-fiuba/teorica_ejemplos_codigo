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


-- Window functions
SELECT
       RANK() OVER (ORDER BY marca_seg ) AS posición,
        nombre_atleta , pais_origen , marca_seg,
        AVG(marca_seg) OVER (ORDER BY marca_seg)
FROM Final_2009
ORDER BY posición;

SELECT *
FROM Exportaciones;

SELECT producto,
       RANK() OVER (PARTITION BY producto ORDER BY cantidad DESC) AS ranking,
       pais, cantidad
FROM Exportaciones
ORDER BY producto DESC, ranking, pais;


SELECT fecha, cliente, SUM(monto) OVER (PARTITION BY cliente ORDER BY fecha) AS saldo
FROM Operaciones;