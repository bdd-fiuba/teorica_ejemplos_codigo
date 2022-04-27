-- Este ejemplo utiliza la base de 'worldcup2010' para ilustrar
-- el uso de triggers a efectos de controlar restricciones más complejas
-- sobre el modelo de datos.

-- Ej. 1)---------------Trigger de inserción--------------------
-- Haremos que cada vez que se inserta un score, se verifique que el jugador
-- esté en uno de los equipos que jugó el partido.
CREATE TRIGGER JugadorEnPartido
    AFTER INSERT ON Score  --después de hacer una inserción en score, ejecutar evaluar_insercion_score()
    FOR EACH ROW
    EXECUTE PROCEDURE evaluar_insercion_score();

CREATE OR REPLACE FUNCTION evaluar_insercion_score()
    RETURNS TRIGGER AS $evaluar_insercion_score$
BEGIN
    IF NOT EXISTS (SELECT *
                FROM Match m
                         INNER JOIN NationalTeam nt ON ((m.home = nt.id) OR (m.away = nt.id))
                         INNER JOIN Player p ON (nt.id = p.national_team)
                WHERE p.id = new.player_id
                  AND m.id = new.match_id) THEN
    --Cuando esta función devuelve una excepción, la inserción no se lleva adelante
    RAISE EXCEPTION 'No es posible insertar un gol de un jugador que no pertenece a las selecciones que se enfrentaron';
    END IF;
    RETURN new; --En cambio, cuando la función devuelve la tupla 'new' tal como estaba, la inserción se realiza
END;
$evaluar_insercion_score$ LANGUAGE plpgsql;

-- (Nota: Luego faltaría controlar que si se cambia al jugador de equipo, o si se
-- cambian los equipos que jugaron determinado partido, se siga cumpliendo esta restricción).


-- Ej. 2)---------------Trigger de inserción--------------------
-- Ahora haremos que cada vez que se inserta un score, se registre en la tabla
-- de auditoria creada para tal fin el nombre del usuario de la base que hizo
-- la inserción, y la fecha de hoy.

-- Creamos la tabla a este efecto. Luego habría que configurar la seguridad de la misma
-- para que un usuario común no pueda verla ni modificarla.
CREATE TABLE auditoria_players (
    usuario VARCHAR(30),
    fecha DATE
);

CREATE TRIGGER AuditoriaScores
    AFTER INSERT ON Score  --después de hacer una inserción en score, ejecutar insertar_auditoria_scores()
    FOR EACH ROW EXECUTE FUNCTION insertar_auditoria_scores();

CREATE OR REPLACE FUNCTION insertar_auditoria_scores()
RETURNS TRIGGER AS $insertar_auditoria_scores$
BEGIN
    INSERT INTO auditoria_players VALUES (CURRENT_USER, CURRENT_DATE); --Se carga el usuario y fecha actual
    RETURN NEW;
END;
$insertar_auditoria_scores$ LANGUAGE plpgsql;

-----------------Tests--------------------
INSERT INTO Score(id, match_id, player_id) VALUES(35135,17,57); --Esta debería ser insertada y auditada,
-- porque corresponde a un partido y jugador válidos (el jugador pertenecía a uno de los equipos que
-- jugó el partido).
INSERT INTO Score(id, match_id, player_id) VALUES(99836,18,60); --Esta NO debería ser insertada.

SELECT * FROM auditoria_players;
