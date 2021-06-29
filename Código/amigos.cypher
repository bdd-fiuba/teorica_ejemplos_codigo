// Vaciamos la base Neo4j
MATCH (n) DETACH DELETE n;

//#################################
// Definiendo nodos
//#################################

CREATE
  (edith:Persona {nombre: 'Edith', color: 'Verde', profesion: 'Músico'}),
  (gaby:Persona {nombre: 'Gabriel', color: 'Verde', profesion: 'Médico'}),
  (luis:Persona {nombre: 'Luis', color: 'Rojo', profesion: 'Pintor'}),
  (tom:Persona {nombre: 'Tomás', color: 'Azul', profesion: 'Estudiante'}),
  (juan:Persona {nombre: 'Juan', color: 'Azul', profesion: 'Médico'}),
  (lucas:Persona {nombre: 'Lucas', color: 'Rojo', profesion: 'Arquitecto'}),
  (pepito:Persona {nombre: 'Pepe', color: 'Azul'}),
  (maria:Persona {nombre: 'María', profesion: 'Estudiante'});

//#################################
// Ejemplos de consultas básicas
//#################################

MATCH (p:Persona {nombre: 'María'})
RETURN p.profesion;

MATCH (m:Persona)
WHERE m.color='Verde'
RETURN m.nombre, m.profesion;

//#################################
// Definiendo interrelaciones
//#################################

MATCH (juan:Persona {nombre:'Juan'}),
 (lucas:Persona {nombre:'Lucas'}),
 (edith:Persona {nombre:'Edith'}),
 (maria:Persona {nombre:'María'}),
 (tom:Persona {nombre:'Tomás'}),
 (luis:Persona {nombre:'Luis'})
CREATE (juan)-[:AMIGO_DE]->(lucas),
  (edith)-[:AMIGO_DE]->(maria),
  (maria)-[:AMIGO_DE]->(lucas),
  (lucas)-[:AMIGO_DE]->(tom),
  (luis)-[:AMIGO_DE]->(edith),
  (lucas)-[:ENEMIGO_DE]->(edith),
  (tom)-[:ENEMIGO_DE]->(edith),
  (tom)-[:ENEMIGO_DE]->(luis);

//#################################
// Consultas
//#################################

// Consulta 1: ¿Existen enemigos que tengan amigos en común?

MATCH  (n:Persona)-[:AMIGO_DE]-(m:Persona),
       (m:Persona)-[:AMIGO_DE]-(o:Persona),
       (n:Persona)-[:ENEMIGO_DE]-(o:Persona)
RETURN n.nombre, o.nombre;

// Consulta 2: ¿A cuántos amigos de distancia están Juan y Luis?

MATCH  (juan:Persona {nombre:'Juan'}),
       (luis:Persona {nombre:'Luis'}),
       p=shortestPath((juan:Persona)-[:AMIGO_DE*]-(luis:Persona))
RETURN p;

// Consulta 3: ¿Quién es la persona que más amigos tiene en común con Tomás?

MATCH (edith:Persona {nombre:'Edith'}),
      c=(p:Persona)-[:AMIGO_DE]-(q:Persona)-[:AMIGO_DE]-(edith)
WHERE NOT (p)-[:AMIGO_DE]-(edith)
RETURN DISTINCT p, count(c)
ORDER BY count(c) DESC
LIMIT 1

