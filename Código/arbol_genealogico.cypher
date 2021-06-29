// Vaciamos la base Neo4j
MATCH (n) DETACH DELETE n;

//#################################
// Creamos los nodos
//#################################

CREATE  (carlo:Persona {nombre: 'Carlo'}),
        (teresa:Persona {nombre: 'Teresa'}),
        (adolfo:Persona {nombre: 'Adolfo'}),
        (gina:Persona {nombre: 'Gina'}),
        (francisco:Persona {nombre: 'Francisco'}),
        (leopoldo:Persona {nombre: 'Leopoldo'}),
        (esther:Persona {nombre: 'Esther'}),
        (virgilio:Persona {nombre: 'Virgilio'}),
        (roberta:Persona {nombre: 'Roberta'}),
        (marisol:Persona {nombre: 'Marisol'}),
        (leila:Persona {nombre: 'Leila'}),
        (kevin:Persona {nombre: 'Kevin'}),
        (victor:Persona {nombre: 'Victor'})");

//#################################
// Creamos los vínculos
//#################################

MATCH (carlo:Persona {nombre: 'Carlo'}),
      (teresa:Persona {nombre: 'Teresa'}),
      (adolfo:Persona {nombre: 'Adolfo'}),
      (gina:Persona {nombre: 'Gina'}),
      (francisco:Persona {nombre: 'Francisco'}),
      (leopoldo:Persona {nombre: 'Leopoldo'}),
      (esther:Persona {nombre: 'Esther'}),
      (virgilio:Persona {nombre: 'Virgilio'}),
      (roberta:Persona {nombre: 'Roberta'}),
      (marisol:Persona {nombre: 'Marisol'}),
      (leila:Persona {nombre: 'Leila'}),
      (kevin:Persona {nombre: 'Kevin'}),
      (victor:Persona {nombre: 'Victor'})
CREATE  (carlo)-[:ESPOSO]->(teresa),
        (adolfo)-[:ESPOSO]->(gina),
        (leopoldo)-[:ESPOSO]->(esther),
        (virgilio)-[:ESPOSO]->(roberta),
        (francisco)-[:HIJO_DE]->(carlo),
        (francisco)-[:HIJO_DE]->(carlo),
        (leopoldo)-[:HIJO_DE]->(teresa),
        (leopoldo)-[:HIJO_DE]->(teresa),
        (esther)-[:HIJO_DE]->(adolfo),
        (esther)-[:HIJO_DE]->(gina),
        (virgilio)-[:HIJO_DE]->(adolfo),
        (virgilio)-[:HIJO_DE]->(gina),
        (marisol)-[:HIJO_DE]->(leopoldo),
        (marisol)-[:HIJO_DE]->(esther),
        (leila)-[:HIJO_DE]->(leopoldo),
        (leila)-[:HIJO_DE]->(esther),
        (kevin)-[:HIJO_DE]->(leopoldo),
        (kevin)-[:HIJO_DE]->(esther),
        (victor)-[:HIJO_DE]->(virgilio),
        (victor)-[:HIJO_DE]->(roberta);

// Consulta 1: ¿Quiénes son los primos de Victor?

MATCH (victor:Persona {nombre:'Victor'}),
      (n:Persona),
      (a:Persona),
      (n2:Persona),
      (p:Persona),
      (victor)-[:HIJO_DE]->(n)-[:HIJO_DE]->(a)<-[:HIJO_DE]-(n2)<-[:HIJO_DE]-(p)
WHERE n<>n2
RETURN DISTINCT p.nombre;

// Consulta 2: ¿Quiénes son ancestros de Victor?

MATCH  (victor:Persona {nombre:'Victor'}),
       (p:Persona)<-[:HIJO_DE*]-(victor:Persona)
RETURN DISTINCT p.nombre);
