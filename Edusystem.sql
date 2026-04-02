CREATE DATABASE edusystem;
USE edusystem;

--------------------------------------------------------------------

CREATE TABLE estudiante (
id_estudiante INT,
nombres VARCHAR(100),
apellidos VARCHAR(100),
documento_identidad VARCHAR(20),
fecha_nacimiento DATE,
direccion VARCHAR(150),
telefono VARCHAR(20),
correo VARCHAR(100),
fotografia VARCHAR(255), 
nombre_tutor VARCHAR(100),
contacto_emergencia VARCHAR(100),
fecha_ingreso DATE,
nivel VARCHAR(30),
grado INT 
);

ALTER TABLE estudiante ADD grado INT;

ALTER TABLE estudiante
ADD PRIMARY KEY (id_estudiante);
     
---------------------------------------------------------------------   
   
CREATE TABLE profesor (
id_profesor INT,
nombres VARCHAR(100),
apellidos VARCHAR(100),
documento_identidad VARCHAR(20),
fecha_nacimiento DATE,
direccion VARCHAR(150),
telefono VARCHAR(20),
correo_institucional VARCHAR(100),
nivel_formacion VARCHAR(50),
especialidad VARCHAR(100),
anios_experiencia INT,
fecha_contratacion DATE,
tipo_contrato VARCHAR(30),
id_departamento INT
);

  
DESCRIBE profesor;
  
ALTER TABLE profesor
ADD PRIMARY KEY (id_profesor); 
   
ALTER TABLE profesor  
ADD FOREIGN KEY (id_departamento) REFERENCES profesor (id_departamento);
  
 ------------------------------------------------------------------------  
    
CREATE TABLE departamento (
id_departamento INT,
nombre VARCHAR(100)
);
  
ALTER TABLE departamento
ADD PRIMARY KEY (id_departamento);
 
 --------------------------------------------------------------------------
 
CREATE TABLE asignatura(
id_asignatura INT,
nombre VARCHAR(100),
area_conocimiento VARCHAR(100),
horas_tematicas INT, 
horas_practicas INT,
creditos INT
);

DESCRIBE asignatura
SELECT * FROM asignatura

ALTER TABLE asignatura
ADD PRIMARY KEY (id_asignatura)

------------------------------------------------------------------------

CREATE TABLE objetivo_asignatura(
id_objetivo INT,
id_asignatura INT,
tipo VARCHAR(20),
descripcion TEXT
);

ALTER TABLE objetivo_asignatura
ADD PRIMARY KEY (id_objetivo)

ALTER TABLE objetivo_asignatura
ADD FOREIGN KEY (id_asignatura) REFERENCES objetivo_asignatura (id_asignatura)

------------------------------------------------------------------------

CREATE TABLE bibliografia (
id_bibliografia INT,
id_asignatura INT,
descripcion TEXT
);
  
ALTER TABLE bibliografia
ADD PRIMARY KEY (id_bibliografia)
  
ALTER TABLE bibliografia 
ADD FOREIGN KEY (id_asignatura) REFERENCES bibliografia (id_asignatura)
  
  -----------------------------------------------------------------------
  
CREATE TABLE periodo_academico(
id_periodo INT,
descripcion VARCHAR(50),
fecha_inicio DATE,
fecha_fin DATE,
estado VARCHAR(30)
);

ALTER TABLE periodo_academico
ADD PRIMARY KEY (id_periodo)

----------------------------------------------------------------------{-

CREATE TABLE evento_calendario(
id_evento INT,
id_periodo INT,
descripcion VARCHAR(150),
fecha DATE
);

ALTER TABLE evento_calendario
ADD PRIMARY KEY (id_evento);

ALTER TABLE evento_calendario
ADD FOREIGN KEY (id_periodo) REFERENCES evento_calendario (id_periodo)

------------------------------------------------------------------------

CREATE TABLE aula(
id_aula INT,
edificio VARCHAR(50),
piso INT,
capacidad INT,
tipo VARCHAR(50),
equipamiento TEXT,
estado VARCHAR(30)
);

DROP TABLE aula
ALTER TABLE aula 
ADD PRIMARY KEY (id_aula)

ALTER TABLE aula 
ADD FOREIGN KEY (id_aula) REFERENCES aula (id_aula)

DESCRIBE aula

------------------------------------------------------------------------

CREATE TABLE curso (
id_curso INT,  
id_asignatura INT,
id_profesor INT,
id_periodo INT,
id_aula INT,
cupo_maximo INT,
metodologia_evaluacion TEXT
);

ALTER TABLE curso
ADD PRIMARY KEY (id_curso)

ALTER TABLE curso 
ADD FOREIGN KEY (id_asignatura) REFERENCES curso (id_aignatura);
ALTER TABLE curso 
ADD FOREIGN KEY (id_profesor) REFERENCES curso (id_profesor);
ALTER TABLE curso 
ADD FOREIGN KEY (id_periodo) REFERENCES curso (id_periodo);
ALTER TABLE curso 
ADD FOREIGN KEY (id_aula) REFERENCES curso (id_aula)
DESCRIBE curso

-------------------------------------------------------------------------

CREATE TABLE horario(
id_horario INT,
id_curso INT,
dia VARCHAR(20),
hora_inicio TIME,
hora_fin TIME
);

ALTER TABLE horario
ADD PRIMARY KEY (id_horario)

ALTER TABLE horario 
ADD FOREIGN KEY (id_curso) REFERENCES horario (id_curso);

------------------------------------------------------------------------

CREATE TABLE calificacion(
id_calificacion INT,
id_estudiante INT,
id_curso INT,
tipo_evaluacion VARCHAR(50),
fecha DATE,
valor DECIMAL(5,2),
porcentaje DECIMAL(5,2),
observaciones TEXT
);

ALTER TABLE calificacion
ADD PRIMARY KEY (id_calificacion);

ALTER TABLE calificacion
ADD FOREIGN KEY (id_estudiante) REFERENCES calificacion (id_estudiante);

ALTER TABLE calificacion
ADD FOREIGN KEY (id_curso) REFERENCES calificacion (id_curso);


----------------------------------------------------------------------

CREATE TABLE carrera(
id_carrera INT,
nombre VARCHAR(100)
);
ALTER TABLE carrera 
ADD PRIMARY KEY (id_carrera) 

----------------------------------------------------------------------

CREATE TABLE plan_estudios (
id_plan INT,
id_carrera INT,
fecha_aprobacion DATE,
creditos_totales INT,
requisitos_graduacion TEXT
);

ALTER TABLE plan_estudios
ADD PRIMARY KEY (id_plan);
ALTER TABLE plan_estudios
ADD FOREIGN KEY (id_carrera) REFERENCES plan_estudios (id_carrera);

----------------------------------------------------------------------

CREATE TABLE material_bibliografico (
id_material INT,
titulo VARCHAR(150),
autores VARCHAR(150),
editorial VARCHAR(100),
anio_publicacion INT,
edicion VARCHAR(20),
isbn VARCHAR(20),
categoria VARCHAR(100),
formato VARCHAR(20),
ubicacion VARCHAR(100),
cantidad INT
);

ALTER TABLE material_bibliografico
ADD PRIMARY KEY (id_material)

----------------------------------------------------------------------

CREATE TABLE prestamo (
id_prestamo INT,
id_material INT,
id_usuario INT,
tipo_usuario VARCHAR(20),
fecha_prestamo DATE,
fecha_devolucion DATE,
estado VARCHAR(30),
multa DECIMAL(8,2)
);


ALTER TABLE prestamo
ADD PRIMARY KEY (id_prestamo)

ALTER TABLE prestamo 
ADD FOREIGN KEY (id_material) REFERENCES prestamo (id_material);
DESCRIBE prestamo

-----------------------------------------------------------------------

CREATE TABLE actividad_extracurricural (
id_actividad INT,
nombre VARCHAR(100),
tipo VARCHAR(50),
descripcion TEXT,
id_profesor INT,
horario VARCHAR(100),
lugar VARCHAR(100),
cupo INT
);

ALTER TABLE actividad_extracurricural
ADD PRIMARY KEY (id_actividad);

ALTER TABLE actividad_extracurricural 
ADD FOREIGN KEY (id_profesor) REFERENCES actividad_extracurricural (id_profesor);


SHOW TABLES; 

SELECT * FROM actividad_extracurricural


--------------------------------------------------------------------------------

INSERT INTO estudiante (id_estudiante, nombres, apellidos, documento_identidad, fecha_nacimiento,
direccion, telefono, correo, fotografia, nombre_tutor,
contacto_emergencia, fecha_ingreso, nivel, grado
) VALUES
(1, 'Juan Sebastian', 'Estrada Muñoz', '1012345678', '2005-03-15',
'Calle 45 #23-10 Medellin', '3001234567', 'juan.estrada@gmail.com',
'foto1.jpg', 'Maria Muñoz', 'Carlos Estrada - 3114567890', '2022-01-15', 'secundaria', 11),
(2, 'Laura', 'Gomez Perez', '1023456789', '2006-07-20',
'Carrera 50 #10-22 Medellin', '3012345678', 'laura.gomez@gmail.com',
'foto2.jpg', 'Andres Gomez', 'Ana Perez - 3205678901', '2023-02-10', 'secundaria', 10),
(3, 'Carlos', 'Ramirez Lopez', '1034567890', '2004-11-02',
'Calle 30 #15-18 Envigado', '3023456789', 'carlos.ramirez@gmail.com',
'foto3.jpg', 'Luis Ramirez', 'Marta Lopez - 3106789012', '2021-08-05', 'primaria', 4),
(4, 'Sofia', 'Martinez Rios', '1045678901', '2007-01-30',
'Carrera 70 #45-12 Bello', '3034567890', 'sofia.martinez@gmail.com',
'foto4.jpg', 'Claudia Rios', 'Pedro Martinez - 3007890123', '2024-01-20', 'primaria', 1),
(5, 'Daniel', 'Torres Mejia', '1056789012', '2005-05-12',
'Calle 12 #34-56 Itagui', '3045678901', 'daniel.torres@gmail.com',
'foto5.jpg', 'Jorge Torres', 'Luisa Mejia - 3118901234', '2022-06-18', 'secundaria', 9),
(6, 'Valentina', 'Castro Diaz', '1067890123', '2006-09-25',
'Carrera 25 #67-89 Medellin', '3056789012', 'valentina.castro@gmail.com',
'foto6.jpg', 'Paola Diaz', 'Miguel Castro - 3129012345', '2023-03-12', 'primaria', 4),
(7, 'Mateo', 'Herrera Ruiz', '1078901234', '2004-12-10',
'Calle 80 #20-40 Medellin', '3067890123', 'mateo.herrera@gmail.com',
'foto7.jpg', 'Sandra Ruiz', 'Julian Herrera - 3130123456', '2021-02-01', 'secundaria', 7),
(8, 'Camila', 'Vargas Molina', '1089012345', '2007-04-18',
'Carrera 43 #12-09 Sabaneta', '3078901234', 'camila.vargas@gmail.com',
'foto8.jpg', 'Ricardo Vargas', 'Elena Molina - 3141234567', '2024-02-05', 'primaria', 4),
(9, 'Andres', 'Moreno Gil', '1090123456', '2005-08-22',
'Calle 90 #34-21 Medellin', '3089012345', 'andres.moreno@gmail.com',
'foto9.jpg', 'Fernando Moreno', 'Diana Gil - 3152345678', '2022-09-14', 'primaria', 3),
(10, 'Natalia', 'Suarez Cano', '1101234567', '2006-10-05',
'Carrera 60 #50-33 Medellin', '3090123456', 'natalia.suarez@gmail.com',
'foto10.jpg', 'Gloria Cano', 'Oscar Suarez - 3163456789', '2023-07-30', 'secundaria', 11);

 
------------------------------------------------------------------------------------------------------------

INSERT INTO profesor (id_profesor, nombres, apellidos, documento_identidad, fecha_nacimiento,
direccion, telefono, correo_institucional, nivel_formacion,
especialidad, anios_experiencia, fecha_contratacion,
tipo_contrato, id_departamento) 
VALUES
(1, 'Carlos', 'Gonzalez Ramirez', '900123456', '1980-05-12',
'Calle 10 #20-30 Medellin', '3001112233', 'cgonzalez@colegio.edu.co',
'Maestria', 'Matematicas', 12, '2015-01-15', 'Tiempo Completo', 1),
(2, 'Andrea', 'Lopez Martinez', '901234567', '1985-09-08',
'Carrera 45 #12-67 Medellin', '3012223344', 'alopez@colegio.edu.co',
'Especializacion', 'Lengua Castellana', 10, '2017-03-10', 'Tiempo Completo', 2),
(3, 'Luis', 'Herrera Castro', '902345678', '1978-11-21',
'Calle 80 #30-15 Bello', '3023334455', 'lherrera@colegio.edu.co',
'Licenciatura', 'Ciencias Naturales', 15, '2012-08-01', 'Indefinido', 3),
(4, 'Paola', 'Rios Mendoza', '903456789', '1990-02-14',
'Carrera 60 #50-10 Envigado', '3034445566', 'prios@colegio.edu.co',
'Maestria', 'Ingles', 8, '2019-01-20', 'Tiempo Completo', 4),
(5, 'Jorge', 'Torres Salazar', '904567890', '1982-07-30',
'Calle 25 #40-22 Itagui', '3045556677', 'jtorres@colegio.edu.co',
'Especializacion', 'Educacion Fisica', 11, '2016-06-18', 'Indefinido', 5),
(6, 'Diana', 'Vargas Molina', '905678901', '1987-12-05',
'Carrera 33 #18-09 Medellin', '3056667788', 'dvargas@colegio.edu.co',
'Licenciatura', 'Artistica', 9, '2018-02-12', 'Tiempo Completo', 6),
(7, 'Fernando', 'Suarez Gil', '906789012', '1975-04-17',
'Calle 90 #45-70 Medellin', '3067778899', 'fsuarez@colegio.edu.co',
'Maestria', 'Fisica', 18, '2010-09-01', 'Indefinido', 1),
(8, 'Natalia', 'Cano Perez', '907890123', '1992-10-11',
'Carrera 70 #30-55 Sabaneta', '3078889900', 'ncano@colegio.edu.co',
'Especializacion', 'Quimica', 6, '2020-07-15', 'Temporal', 3),
(9, 'Miguel', 'Restrepo Diaz', '908901234', '1983-01-28',
'Calle 15 #22-44 Medellin', '3089990011', 'mrestrepo@colegio.edu.co',
'Licenciatura', 'Historia', 13, '2014-04-03', 'Tiempo Completo', 7),
(10, 'Laura', 'Mejia Cardona', '909012345', '1989-06-19',
'Carrera 52 #14-18 Bello', '3090001122', 'lmejia@colegio.edu.co',
'Maestria', 'Tecnologia e Informatica', 7, '2021-01-25', 'Temporal', 8);

-----------------------------------------------------------------------------------------------

INSERT INTO departamento (id_departamento, nombre) 
VALUES(1, 'Matematicas'),
(2, 'Lengua Castellana'),
(3, 'Ciencias Naturales'),
(4, 'Idiomas'),
(5, 'Educacion Fisica'),
(6, 'Educacion Artistica'),
(7, 'Ciencias Sociales'),
(8, 'Tecnologia e Informatica'),
(9, 'Filosofia'),
(10, 'Orientacion Escolar');

-------------------------------------------------------------------------------------------------

INSERT INTO asignatura (id_asignatura, nombre, area_conocimiento,
horas_tematicas, horas_practicas, creditos)
VALUES
(1, 'Algebra', 'Matematicas', 4, 2, 3),
(2, 'Geometria', 'Matematicas', 3, 2, 3),
(3, 'Lengua Castellana', 'Humanidades', 4, 1, 3),
(4, 'Biologia', 'Ciencias Naturales', 3, 2, 3),
(5, 'Quimica', 'Ciencias Naturales', 3, 3, 4),
(6, 'Fisica', 'Ciencias Naturales', 4, 2, 4),
(7, 'Ingles', 'Idiomas', 3, 2, 3),
(8, 'Educacion Fisica', 'Deportes', 2, 3, 2),
(9, 'Informatica', 'Software', 2, 3, 3),
(10, 'Historia', 'Ciencias Sociales', 3, 1, 2);

------------------------------------------------------------------------------------------------

INSERT INTO objetivo_asignatura (id_objetivo, id_asignatura, tipo, descripcion)
VALUES
(1, 1, 'General', 'Desarrollar habilidades de razonamiento algebraico y solucion de ecuaciones.'),
(2, 2, 'Especifico', 'Comprender las propiedades geometricas de figuras planas y solidas.'),
(3, 3, 'General', 'Fortalecer la comprension lectora y la produccion escrita.'),
(4, 4, 'Especifico', 'Identificar las estructuras y funciones de los seres vivos.'),
(5, 5, 'General', 'Analizar las reacciones quimicas y sus aplicaciones cotidianas.'),
(6, 6, 'Especifico', 'Aplicar las leyes fisicas en la resolucion de problemas practicos.'),
(7, 7, 'General', 'Desarrollar competencias comunicativas en idioma ingles.'),
(8, 8, 'Especifico', 'Promover habitos de vida saludable mediante la actividad fisica.'),
(9, 9, 'General', 'Utilizar herramientas tecnologicas para la solucion de problemas.'),
(10, 10, 'Especifico', 'Comprender procesos historicos y su impacto en la sociedad actual.');

-------------------------------------------------------------------------------------------------

INSERT INTO bibliografia (id_bibliografia, id_asignatura, descripcion) 
VALUES
(1, 1, 'Baldor, A. Algebra. Editorial Patria.'),
(2, 2, 'Clemens, S. Geometria y sus aplicaciones. Pearson Educacion.'),
(3, 3, 'Cassany, D. La cocina de la escritura. Editorial Anagrama.'),
(4, 4, 'Campbell, N. Biologia. Pearson Educacion.'),
(5, 5, 'Chang, R. Quimica General. McGraw-Hill.'),
(6, 6, 'Serway, R. Fisica para ciencias e ingenieria. Cengage Learning.'),
(7, 7, 'Murphy, R. English Grammar in Use. Cambridge University Press.'),
(8, 8, 'Blazquez, D. Educacion Fisica. Inde Publicaciones.'),
(9, 9, 'Norton, P. Introduccion a la computacion. McGraw-Hill.'),
(10, 10, 'Hobsbawm, E. Historia del siglo XX. Editorial Critica.');

--------------------------------------------------------------------------------------------------

INSERT INTO periodo_academico (id_periodo, descripcion, fecha_inicio, fecha_fin, estado) 
VALUES
(1, 'Periodo 1 - 2022', '2022-01-17', '2022-04-15', 'Finalizado'),
(2, 'Periodo 2 - 2022', '2022-04-25', '2022-07-15', 'Finalizado'),
(3, 'Periodo 3 - 2022', '2022-07-25', '2022-10-14', 'Finalizado'),
(4, 'Periodo 4 - 2022', '2022-10-24', '2022-12-02', 'Finalizado'),
(5, 'Periodo 1 - 2023', '2023-01-16', '2023-04-14', 'Finalizado'),
(6, 'Periodo 2 - 2023', '2023-04-24', '2023-07-14', 'Finalizado'),
(7, 'Periodo 3 - 2023', '2023-07-24', '2023-10-13', 'Finalizado'),
(8, 'Periodo 4 - 2023', '2023-10-23', '2023-12-01', 'Finalizado'),
(9, 'Periodo 1 - 2024', '2024-01-15', '2024-04-12', 'Activo'),
(10, 'Periodo 2 - 2024', '2024-04-22', '2024-07-12', 'Planeado');

---------------------------------------------------------------------------------------------------

INSERT INTO evento_calendario (id_evento, id_periodo, descripcion, fecha) 
VALUES
(1, 1, 'Inicio de clases periodo 1', '2022-01-17'),
(2, 1, 'Primer examen parcial', '2022-02-20'),
(3, 2, 'Entrega de boletines academicos', '2022-05-30'),
(4, 3, 'Semana cultural institucional', '2022-08-25'),
(5, 4, 'Examenes finales', '2022-11-20'),
(6, 5, 'Inicio de clases periodo 1 2023', '2023-01-16'),
(7, 6, 'Dia deportivo institucional', '2023-06-10'),
(8, 7, 'Feria de la ciencia', '2023-09-05'),
(9, 9, 'Inicio de clases periodo 1 2024', '2024-01-15'),
(10, 9, 'Reunion de padres de familia', '2024-03-10');

----------------------------------------------------------------------------------------------------

INSERT INTO aula (id_aula, edificio, piso, capacidad, tipo,
equipamiento, estado) 
VALUES
(1, 'Bloque A', 1, 30, 'Salon Teorico',
'Tablero, VideoBeam, Sillas', 'Disponible'),
(2, 'Bloque A', 2, 25, 'Salon Teorico',
'Tablero, Computador docente', 'Disponible'),
(3, 'Bloque B', 1, 20, 'Laboratorio',
'Microscopios, Mesas de laboratorio', 'Disponible'),
(4, 'Bloque B', 2, 18, 'Laboratorio',
'Equipos de quimica, Extractor de gases', 'Mantenimiento'),
(5, 'Bloque C', 1, 35, 'Salon Teorico',
'Tablero digital, VideoBeam', 'Disponible'),
(6, 'Bloque C', 3, 40, 'Auditorio',
'Sistema de sonido, Proyector', 'Disponible'),
(7, 'Bloque D', 2, 22, 'Sala de Informatica',
'Computadores, Internet, Proyector', 'Disponible'),
(8, 'Bloque D', 1, 28, 'Salon Teorico',
'Tablero acrilico, Ventiladores', 'Ocupado'),
(9, 'Bloque E', 1, 15, 'Sala de Arte',
'Caballetes, Material artistico', 'Disponible'),
(10, 'Bloque F', 1, 50, 'Coliseo',
'Cancha multiple, Graderias', 'Disponible');

-----------------------------------------------------------------------------------------------------------

INSERT INTO curso (id_curso, id_asignatura, id_profesor,
id_periodo, id_aula, cupo_maximo,
metodologia_evaluacion) 
VALUES
(1, 1, 1, 9, 1, 30, '40% examenes, 30% talleres, 30% proyecto final'),
(2, 2, 7, 9, 2, 25, '50% examenes, 20% tareas, 30% actividades practicas'),
(3, 3, 2, 9, 5, 35, '30% lectura critica, 40% trabajos escritos, 30% examen final'),
(4, 4, 3, 9, 3, 20, '40% practicas laboratorio, 30% quizzes, 30% examen'),
(5, 5, 8, 9, 4, 18, '50% laboratorio, 20% tareas, 30% examen final'),
(6, 6, 7, 9, 3, 20, '40% evaluaciones, 30% experimentos, 30% proyecto'),
(7, 7, 4, 9, 1, 30, '35% speaking, 35% writing, 30% examenes'),
(8, 8, 5, 9, 10, 50, '60% participacion, 40% pruebas fisicas'),
(9, 9, 10, 9, 7, 22, '50% practicas computador, 20% tareas, 30% proyecto final'),
(10, 10, 9, 9, 8, 28, '40% talleres, 30% exposiciones, 30% examen final');

---------------------------------------------------------------------------------------------------------------

INSERT INTO horario (id_horario, id_curso, dia, hora_inicio, hora_fin) 
VALUES
(1, 1, 'Lunes', '07:00:00', '09:00:00'),
(2, 2, 'Martes', '09:00:00', '11:00:00'),
(3, 3, 'Miercoles', '07:00:00', '09:00:00'),
(4, 4, 'Jueves', '10:00:00', '12:00:00'),
(5, 5, 'Viernes', '08:00:00', '10:00:00'),
(6, 6, 'Lunes', '10:00:00', '12:00:00'),
(7, 7, 'Martes', '13:00:00', '15:00:00'),
(8, 8, 'Miercoles', '15:00:00', '17:00:00'),
(9, 9, 'Jueves', '07:00:00', '09:00:00'),
(10, 10, 'Viernes', '10:00:00', '12:00:00');

-------------------------------------------------------------------------------------------------------------

INSERT INTO calificacion (id_calificacion, id_estudiante, id_curso,
tipo_evaluacion, fecha, valor,
porcentaje, observaciones) 
VALUES
(1, 1, 1, 'Examen Parcial', '2024-02-15', 78.00, 30.00, 'Buen desempeño general'),
(2, 2, 2, 'Taller', '2024-02-18', 65.00, 20.00, 'Debe mejorar procedimientos'),
(3, 3, 3, 'Ensayo', '2024-02-20', 88.00, 25.00, 'Excelente redaccion'),
(4, 4, 4, 'Practica Laboratorio', '2024-02-22', 72.00, 30.00, 'Buen manejo de instrumentos'),
(5, 5, 5, 'Examen Parcial', '2024-02-25', 58.00, 30.00, 'Reforzar conceptos teoricos'),
(6, 6, 6, 'Proyecto', '2024-03-01', 92.00, 40.00, 'Trabajo sobresaliente'),
(7, 7, 7, 'Evaluacion Oral', '2024-03-03', 74.00, 20.00, 'Buena participacion'),
(8, 8, 8, 'Prueba Fisica', '2024-03-05', 81.00, 30.00, 'Muy buen rendimiento fisico'),
(9, 9, 9, 'Practica Computador', '2024-03-08', 69.00, 25.00, 'Buen uso de los conceptos aprendidos, puede mejorar'),
(10, 10, 10, 'Examen Final', '2024-03-12', 63.00, 40.00, 'Resultado aceptable');


-------------------------------------------------------------------------------------------------------

INSERT INTO carrera (id_carrera, nombre) 
VALUES
(1, 'Ingenieria de Sistemas'),
(2, 'Administracion de Empresas'),
(3, 'Contaduria Publica'),
(4, 'Derecho'),
(5, 'Psicologia'),
(6, 'Ingenieria Industrial'),
(7, 'Licenciatura en Matematicas'),
(8, 'Licenciatura en Lenguas Extranjeras'),
(9, 'Diseño Grafico'),
(10, 'Tecnologia en Desarrollo de Software');

---------------------------------------------------------------------------------------------------------

INSERT INTO plan_estudios (id_plan, id_carrera, fecha_aprobacion,
creditos_totales, requisitos_graduacion) 
VALUES
(1, 1, '2020-06-15', 160, 'Aprobar todas las asignaturas y realizar proyecto de grado'),
(2, 2, '2019-11-20', 150, 'Practica empresarial y trabajo de grado aprobado'),
(3, 3, '2021-03-10', 155, 'Aprobar examenes profesionales y pasantia'),
(4, 4, '2018-09-05', 170, 'Consultorio juridico y monografia final'),
(5, 5, '2020-02-18', 158, 'Practicas profesionales y proyecto investigativo'),
(6, 6, '2019-07-22', 162, 'Proyecto de optimizacion industrial aprobado'),
(7, 7, '2021-01-30', 150, 'Practica docente y trabajo final'),
(8, 8, '2022-05-14', 148, 'Certificacion idioma extranjero y practica pedagogica'),
(9, 9, '2020-10-09', 145, 'Portafolio profesional y proyecto creativo'),

-----------------------------------------------------------------------------------------------------------

INSERT INTO material_bibliografico (id_material, titulo, autores, editorial,
anio_publicacion, edicion, isbn,
categoria, formato, ubicacion, cantidad)
VALUES 
(1, 'Algebra de Baldor', 'Aurelio Baldor', 'Editorial Patria',
2018, '4ta', '9786074382457', 'Matematicas', 'Fisico', 'Biblioteca Central - Estante A1', 5),
(2, 'Biologia Moderna', 'Neil Campbell', 'Pearson',
2017, '10ma', '9780134093413', 'Ciencias Naturales', 'Fisico', 'Biblioteca Central - Estante B2', 4),
(3, 'Quimica General', 'Raymond Chang', 'McGraw-Hill',
2016, '12va', '9781456267616', 'Quimica', 'Fisico', 'Laboratorio Quimica', 3),
(4, 'Fisica Universitaria', 'Serway y Jewett', 'Cengage Learning',
2019, '14va', '9781305079113', 'Fisica', 'Digital', 'Repositorio Virtual', 10),
(5, 'English Grammar in Use', 'Raymond Murphy', 'Cambridge',
2015, '5ta', '9781108457651', 'Idiomas', 'Fisico', 'Biblioteca Idiomas', 6),
(6, 'Historia del Siglo XX', 'Eric Hobsbawm', 'Critica',
2014, '2da', '9788484320913', 'Historia', 'Fisico', 'Biblioteca Central - Estante C3', 4),
(7, 'Introduccion a la Programacion', 'Luis Joyanes', 'McGraw-Hill',
2020, '3ra', '9786071514202', 'Tecnologia', 'Digital', 'Repositorio Virtual', 12),
(8, 'Diseño Grafico Digital', 'Rob Williams', 'Anaya Multimedia',
2018, '1ra', '9788441532526', 'Diseño', 'Fisico', 'Sala Creativa', 2),
(9, 'Psicologia Educativa', 'Anita Woolfolk', 'Pearson',
2016, '11va', '9786073238786', 'Psicologia', 'Fisico', 'Biblioteca Ciencias Sociales', 5),
(10, 'Administracion Moderna', 'Idalberto Chiavenato', 'McGraw-Hill',
2021, '9na', '9786071515124', 'Administracion', 'Digital', 'Repositorio Virtual', 8);

---------------------------------------------------------------------------------------------------------------------

INSERT INTO prestamo (id_prestamo, id_material, id_usuario, tipo_usuario,
fecha_prestamo, fecha_devolucion, estado, multa) 
VALUES
(1, 1, 1, 'Estudiante', '2024-02-01', '2024-02-08', 'Devuelto', 0.00),
(2, 2, 2, 'Estudiante', '2024-02-03', '2024-02-10', 'Devuelto', 0.00),
(3, 3, 3, 'Profesor', '2024-02-05', '2024-02-15', 'Devuelto', 0.00),
(4, 4, 4, 'Estudiante', '2024-02-07', '2024-02-14', 'Retrasado', 50.000),
(5, 5, 5, 'Profesor', '2024-02-10', '2024-02-20', 'Devuelto', 0.00),
(6, 6, 6, 'Estudiante', '2024-02-12', '2024-02-19', 'Devuelto', 0.00),
(7, 7, 7, 'Estudiante', '2024-02-15', '2024-02-22', 'Prestado', 0.00),
(8, 8, 8, 'Profesor', '2024-02-18', '2024-02-28', 'Devuelto', 0.00),
(9, 9, 9, 'Estudiante', '2024-02-20', '2024-02-27', 'Retrasado', 30.000),
(10, 10, 10, 'Estudiante', '2024-02-22', '2024-03-01', 'Prestado', 0.00);

-------------------------------------------------------------------------------------------------------------

INSERT INTO actividad_extracurricural (id_actividad, nombre, tipo, descripcion,
id_profesor, horario, lugar, cupo) 
VALUES 
(1, 'Club de Programacion', 'Academica',
'Desarrollo de habilidades en programacion y resolucion de problemas',
1, 'Lunes 14:00-16:00', 'Sala de Informatica', 20),
(2, 'Grupo de Teatro', 'Cultural',
'Formacion en expresion corporal y actuacion teatral',
2, 'Martes 15:00-17:00', 'Auditorio', 25),
(3, 'Equipo de Futbol', 'Deportiva',
'Entrenamiento y participacion en torneos institucionales',
5, 'Miercoles 16:00-18:00', 'Cancha Principal', 30),
(4, 'Club de Ciencias', 'Academica',
'Experimentacion cientifica y proyectos investigativos',
3, 'Jueves 14:00-16:00', 'Laboratorio Ciencias', 18),
(5, 'Taller de Pintura', 'Cultural',
'Desarrollo de tecnicas artisticas y creatividad',
6, 'Viernes 13:00-15:00', 'Sala de Arte', 15),
(6, 'Club de Ingles Conversacional', 'Academica',
'Practica del idioma ingles mediante actividades dinamicas',
4, 'Lunes 16:00-18:00', 'Salon 101', 22),
(7, 'Ajedrez Escolar', 'Recreativa',
'Desarrollo del pensamiento estrategico mediante el ajedrez', NULL,
'Martes 13:00-15:00', 'Biblioteca', 16),
(8, 'Danza Folclorica', 'Cultural',
'Aprendizaje de bailes tradicionales colombianos',
8, 'Miercoles 15:00-17:00', 'Coliseo', 28),
(9, 'Robotica Educativa', 'Tecnologica',
'Construccion y programacion de robots educativos',
10, 'Jueves 16:00-18:00', 'Laboratorio Tecnologia', 20),
(10, 'Yoga y Bienestar', 'Deportiva',
'Actividades de relajacion y bienestar fisico', NULL,
'Viernes 07:00-08:30', 'Zona Verde', 18);

---------------------------------------------------------------------------------------

#CONSULTAS

#1. ¿Cuáles son todos los estudiantes de nivel Secundaria?
SELECT * FROM estudiante
WHERE nivel = 'Secundaria';

#2. ¿Qué asignaturas tienen más de 4 créditos académicos?
SELECT * FROM asignatura
WHERE creditos > 3;

#3. ¿Cuáles son los cursos de cierta asignatura en un periodo específico?
SELECT * FROM curso
WHERE id_asignatura = 1
AND id_periodo = 9;

#4. ¿Qué estudiantes son de primer o último año?
SELECT * FROM estudiante
WHERE grado = 1 OR grado= 11;

#5. ¿Cuáles son las calificaciones entre 80 y 100?
SELECT * FROM calificacion
WHERE valor BETWEEN 80 AND 100;

#6. ¿Qué profesores son de especialidad Matemáticas, Física o Química?
SELECT * FROM profesor
WHERE especialidad IN ('Matematicas', 'Fisica', 'Quimica');

#7. ¿Cuáles son las asignaturas que contienen las palabras "programación" o "software" en su nombre?
SELECT * FROM asignatura
WHERE nombre LIKE 'Software';


#8. ¿Qué actividades extracurriculares no tienen profesor asignado?
SELECT * FROM actividad_extracurricural
WHERE id_profesor IS NULL; 

#9. ¿Cuáles son los estudiantes ordenados por nivel y promedio general?
SELECT nombres,nivel,
    
      (SELECT AVG(valor)
      FROM calificacion
      WHERE calificacion.id_estudiante = estudiante.id_estudiante)
    
AS promedio_general
FROM estudiante
ORDER BY nivel, promedio_general DESC;


#10. ¿Cuál es el promedio de calificaciones por asignatura y periodo?
SELECT id_curso,

      (SELECT id_asignatura
      FROM curso
      WHERE curso.id_curso = calificacion.id_curso)
AS id_asignatura,

      (SELECT id_periodo
      FROM curso
      WHERE curso.id_curso = calificacion.id_curso)
 AS id_periodo,

    AVG(valor) AS promedio_calificaciones
    
FROM calificacion
GROUP BY id_curso
ORDER BY id_periodo, id_asignatura;


