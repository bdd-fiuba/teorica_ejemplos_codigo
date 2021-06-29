// Vaciamos la base Neo4j
MATCH (n) DETACH DELETE n;

CREATE  (edith:Persona {nombre: 'Edith', color: 'Verde', profesión: 'Músico'}),
        (gaby:Persona {nombre: 'Gabriel', color: 'Verde', profesión: 'Médico'}),
        (luis:Persona {nombre: 'Luis', color: 'Rojo', profesion: 'Pintor'}),
        (tom:Persona {nombre: 'Tomás', color: 'Azul', profesion: 'Estudiante'}),
        (juan:Persona {nombre: 'Juan', color: 'Azul', profesion: 'Médico'}),
        (lucas:Persona {nombre: 'Lucas', color: 'Rojo', profesion: 'Arquitecto'}),
        (pepito:Persona {nombre: 'Pepe', color: 'Azul'}),
        (maria:Persona {nombre: 'María', profesión: 'Estudiante'});

CREATE  (aspiradora:Producto {producto_id: 3}),
        (televisor:Producto {producto_id: 20}),
        (cafetera:Producto {producto_id: 45}),
        (tostadora:Producto {producto_id: 8});

MATCH  (juan:Persona {nombre:'Juan'}),
       (lucas:Persona {nombre:'Lucas'}),
       (edith:Persona {nombre:'Edith'}),
       (maria:Persona {nombre:'María'}),
       (tom:Persona {nombre:'Tomás'}),
       (luis:Persona {nombre:'Luis'}),
       (aspiradora:Producto {producto_id: 3}),
       (televisor:Producto {producto_id: 20}),
       (cafetera:Producto {producto_id: 45}),
       (tostadora:Producto {producto_id: 8})
CREATE (lucas)-[:COMPRO {fecha: 3}]->(aspiradora),
       (juan)-[:COMPRO {fecha: 6}]->(tostadora),
       (edith)-[:COMPRO {fecha: 7}]->(aspiradora),
       (maria)-[:COMPRO {fecha: 2}]->(cafetera),
       (luis)-[:COMPRO {fecha: 4}]->(tostadora),
       (luis)-[:COMPRO {fecha: 1}]->(aspiradora),
       (maria)-[:COMPRO {fecha: 5}]->(televisor),
       (tom)-[:COMPRO {fecha: 9}]->(cafetera),
       (tom)-[:RECOMENDO {producto_id: 45, fecha: 6}]->(maria),
       (luis)-[:RECOMENDO {producto_id: 8, fecha: 5}]->(juan),
       (luis)-[:RECOMENDO {producto_id: 8, fecha: 5}]->(lucas),
       (luis)-[:RECOMENDO {producto_id: 3, fecha: 2}]->(lucas),
       (maria)-[:RECOMENDO {producto_id: 45, fecha: 4}]->(tom),
       (edith)-[:RECOMENDO {producto_id: 20, fecha: 1}]->(lucas),
       (edith)-[:RECOMENDO {producto_id: 20, fecha: 1}]->(maria),
       (edith)-[:RECOMENDO {producto_id: 20, fecha: 1}]->(juan);

// Problema: En una base de datos Neo4J tenemos nodos con label "Producto" (que se identifican con un atributo "producto_id") y otros con label "Persona" (identificados con un atributo "nombre"). Hay a su vez definida una interrelación "COMPRÓ" entre personas y productos, con un atributo "fecha". Por último, existe una interrelación "RECOMENDÓ" entre personas, con un atributo "fecha" y un atributo" producto_id". Nos gustaría saber qué personas –luego de comprar– recomendaron un producto a otra persona que luego también lo compró, para poder recompensarlas. El formato de la salida debe ser (nombre, #recom).

MATCH (per1: Persona ),
      (per2: Persona ),
      (prod: Producto ),
      (per1)−[c1: COMPRO]−(prod),
      (per2)−[c2: COMPRO]−(prod),
      rec =(per1) − [r:RECOMENDO]−>(per2)
WHERE c1.fecha < r.fecha AND
      c2.fecha > r.fecha AND
      r.producto_id = prod.producto_id
RETURN DISTINCT per1.nombre, count(rec);

// La solución anterior tiene una desventaja: si una persona recomendó un mismo producto dos veces a la misma persona, entonces la recomendación se cuenta dos veces. Nos gustaría que cada persona sólo pueda sumar un único punto por cada par (producto, persona) al que le realiza una recomendación.

MATCH ...
