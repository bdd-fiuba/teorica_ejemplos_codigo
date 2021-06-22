DROP KEYSPACE biblioteca

CREATE KEYSPACE biblioteca
    WITH replication = {
        'class': 'SimpleStrategy',
        'replication_factor': 1
    };

USE biblioteca;

CREATE COLUMNFAMILY socios (
    nro_socio int,
    nombre text,
    domicilio text,
    telefono set<int>,
    mail set<text>,
    primary key (nro_socio)
);

CREATE COLUMNFAMILY prestamos_por_socio (
    nro_socio int,
    ISBN bigint,
    nro_orden int,
    nombre text,
    vencimiento date,
    primary key ((nro_socio), ISBN, nro_orden)
);

CREATE COLUMNFAMILY libros_por_genero (
    genero text,
    ISBN bigint,
    nombre text,
    primary key ((genero), isbn)
);

CREATE COLUMNFAMILY libros (
    ISBN bigint,
    nombre text,
    autor list<text>,
    genero set<text>,
    anio int,
    idioma text,
    primary key (ISBN)
);

CREATE COLUMNFAMILY libros_por_nombre (
    nombre text,
    ISBN bigint,
    primary key ((nombre), ISBN)
);


CREATE COLUMNFAMILY ejemplares_dispon (
    ISBN bigint,
    nro_orden int,
    primary key ((ISBN), nro_orden)
);

CREATE COLUMNFAMILY prestamos_por_fecha (
    vencimiento date,
    nro_socio int,
    ISBN bigint,
    nro_orden int,
    primary key ((vencimiento), nro_socio, ISBN, nro_orden)
);


INSERT INTO socios (nro_socio, nombre, domicilio, telefono, mail) VALUES
                        (751, 'Eleonora Minga', 'Carlos Casares 378', {1138294829, 43775921}, {'sjfl@mimail.com'});
INSERT INTO socios (nro_socio, nombre, domicilio, telefono, mail) VALUES
                        (830, 'Mariana Frasse', 'Av. Antártida Argentina 51', {}, {'mfrasse@mimail.com'});
INSERT INTO socios (nro_socio, nombre, domicilio, telefono, mail) VALUES
                        (838, 'Teodoro French', 'Las Amapolas 218', {1548827015}, {'teodorof@gmail.com'});

INSERT INTO libros (ISBN, nombre, autor, genero, anio, idioma) VALUES
                        (14292859338291, 'Choque de reyes', ['George R. R. Martin'], {'ficción', 'épico'}, 1998, 'español');
INSERT INTO libros (ISBN, nombre, autor, genero, anio, idioma) VALUES
                        (40382739185329, 'El cazador de sueños', ['Stephen King'], {'ciencia ficción', 'terror'}, 2001, 'español');
INSERT INTO libros (ISBN, nombre, autor, genero, anio, idioma) VALUES
                        (55102184963921, 'Rayuela', ['J. Cortázar'], {'drama', 'surrealista'}, 1963, 'español');
INSERT INTO libros (ISBN, nombre, autor, genero, anio, idioma) VALUES
                        (21080318277352, 'Memorias Impuras', ['L. Bodoc'], {'ficción', 'drama'}, 2013, 'español');
INSERT INTO libros (ISBN, nombre, autor, genero, anio, idioma) VALUES
                        (60287391608910, 'La carta esférica', ['A. Pérez-Reverte'], {'ficción', 'aventura'}, 2000, 'español');

INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('ficción', 14292859338291, 'Choque de reyes');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('épico', 14292859338291, 'Choque de reyes');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('ciencia ficción', 40382739185329, 'El cazador de sueños');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('terror', 40382739185329, 'El cazador de sueños');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('drama', 55102184963921, 'Rayuela');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('surrealista', 55102184963921, 'Rayuela');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('ficción', 21080318277352, 'Memorias impuras');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('drama', 21080318277352, 'Memorias impuras');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('ficción', 60287391608910, 'La carta esférica');
INSERT INTO libros_por_genero (genero, ISBN, nombre) VALUES
                        ('aventura', 60287391608910, 'La carta esférica');

INSERT INTO libros_por_nombre (nombre, ISBN) VALUES
                        ('Choque de reyes', 14292859338291);
INSERT INTO libros_por_nombre (nombre, ISBN) VALUES
                        ('El cazador de sueños', 40382739185329);
INSERT INTO libros_por_nombre (nombre, ISBN) VALUES
                        ('Rayuela', 55102184963921);
INSERT INTO libros_por_nombre (nombre, ISBN) VALUES
                        ('Memorias impuras', 21080318277352);
INSERT INTO libros_por_nombre (nombre, ISBN) VALUES
                        ('La carta esférica', 60287391608910);

INSERT INTO prestamos_por_socio (nro_socio, ISBN, nro_orden, nombre, vencimiento) VALUES
                        (751, 55102184963921, 2, 'Rayuela', '2017-06-23');
INSERT INTO prestamos_por_socio (nro_socio, ISBN, nro_orden, nombre, vencimiento) VALUES
                        (751, 21080318277352, 1, 'Memorias impuras', '2017-07-05');
INSERT INTO prestamos_por_socio (nro_socio, ISBN, nro_orden, nombre, vencimiento) VALUES
                        (830, 14292859338291, 2, 'Choque de reyes', '2017-10-06');
INSERT INTO prestamos_por_socio (nro_socio, ISBN, nro_orden, nombre, vencimiento) VALUES
                        (838, 60287391608910, 1, 'La carta esférica', '2017-10-08');

INSERT INTO ejemplares_dispon (ISBN, nro_orden) VALUES
                        (55102184963921, 1);
INSERT INTO ejemplares_dispon (ISBN, nro_orden) VALUES
                        (55102184963921, 3);
INSERT INTO ejemplares_dispon (ISBN, nro_orden) VALUES
                        (14292859338291, 1);
INSERT INTO ejemplares_dispon (ISBN, nro_orden) VALUES
                        (60287391608910, 2);
INSERT INTO ejemplares_dispon (ISBN, nro_orden) VALUES
                        (60287391608910, 3);
INSERT INTO ejemplares_dispon (ISBN, nro_orden) VALUES
                        (40382739185329, 1);

INSERT INTO prestamos_por_fecha (vencimiento, nro_socio, ISBN, nro_orden) VALUES
                        ('2017-06-23', 751, 55102184963921, 2);
INSERT INTO prestamos_por_fecha (vencimiento, nro_socio, ISBN, nro_orden) VALUES
                        ('2017-07-05', 751, 21080318277352, 1);
INSERT INTO prestamos_por_fecha (vencimiento, nro_socio, ISBN, nro_orden) VALUES
                        ('2017-10-06', 830, 14292859338291, 2);
INSERT INTO prestamos_por_fecha (vencimiento, nro_socio, ISBN, nro_orden) VALUES
                        ('2017-10-08', 838, 60287391608910, 1);

##########################################
# Ejemplares que posee el socio 751
##########################################

SELECT nombre, nro_orden, vencimiento
FROM prestamos_por_socio
WHERE nro_socio = 751;

##########################################
# Autores del libro con ISBN 14292859338291
##########################################

SELECT autor
FROM libros
WHERE ISBN = 14292859338291

##########################################
# LLega Eleonora Minga (nro_socio = 751) y devuelve el libro 'Rayuela' que tenía
##########################################

# 1) Obtenemos el ISBN y el nro_orden
SELECT nombre, ISBN, nro_orden
FROM prestamos_por_socio
WHERE nro_socio = 751;

# 2) Lo damos de baja en préstamos_por_socio
DELETE FROM prestamos_por_socio
WHERE nro_socio = 751 AND ISBN = 55102184963921 AND nro_orden = 2;

# 3) Lo damos de alta en ejemplares disponibles
INSERT INTO ejemplares_dispon (ISBN, nro_orden) VALUES(55102184963921, 2);
