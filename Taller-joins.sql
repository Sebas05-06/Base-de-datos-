


#1
SELECT 
    e.nombres, 
	 e.apellidos, 
	 e.nivel,
    a.nombre AS asignatura, a.creditos,
    d.nombre AS departamento
FROM calificacion c
INNER JOIN estudiante e ON c.id_estudiante = e.id_estudiante
INNER JOIN curso cu ON c.id_curso = cu.id_curso
INNER JOIN asignatura a ON cu.id_asignatura = a.id_asignatura
INNER JOIN profesor p ON cu.id_profesor = p.id_profesor
INNER JOIN departamento d ON p.id_departamento = d.id_departamento
WHERE a.creditos >= 4;



  
#2 
  SELECT 
    p.nombres, 
	 p.apellidos, 
	 p.anios_experiencia,
    d.nombre AS departamento,
    a.nombre AS asignatura,
    pa.descripcion AS periodo
FROM profesor p
LEFT JOIN departamento d ON p.id_departamento = d.id_departamento
LEFT JOIN curso cu ON p.id_profesor = cu.id_profesor
LEFT JOIN asignatura a ON cu.id_asignatura = a.id_asignatura
LEFT JOIN periodo_academico pa ON cu.id_periodo = pa.id_periodo
ORDER BY d.nombre ASC, p.anios_experiencia DESC;


#3
SELECT 
    a.nombre AS asignatura,
    COUNT(c.id_calificacion) AS total_evaluaciones,
    AVG(c.valor) AS promedio_calificaciones
FROM asignatura a
LEFT JOIN curso cu ON a.id_asignatura = cu.id_asignatura
LEFT JOIN calificacion c ON cu.id_curso = c.id_curso
GROUP BY a.id_asignatura, a.nombre
HAVING COUNT(c.id_calificacion) > 0
ORDER BY promedio_calificaciones DESC;



#4
SELECT 
    e.nombres AS estudiante, e.apellidos,
    a.nombre AS asignatura,
    p.nombres AS profesor, p.apellidos AS apellido_profesor,
    c.tipo_evaluacion, c.valor, c.fecha, c.observaciones
FROM calificacion c
INNER JOIN estudiante e ON c.id_estudiante = e.id_estudiante
INNER JOIN curso cu ON c.id_curso = cu.id_curso
INNER JOIN asignatura a ON cu.id_asignatura = a.id_asignatura
INNER JOIN profesor p ON cu.id_profesor = p.id_profesor
WHERE c.fecha BETWEEN '2024-02-01' AND '2024-03-15';


#5
SELECT 
    au.id_aula, 
	 au.edificio, 
	 au.piso,
    au.tipo, 
	 au.capacidad, 
	 au.estado
FROM aula au
LEFT JOIN curso cu ON au.id_aula = cu.id_aula
    AND cu.id_periodo = 9
WHERE cu.id_curso IS NULL;


#6
SELECT 
    e.nombres, 
	 e.apellidos,
    mb.titulo, 
	 mb.autores,
    pr.fecha_prestamo, 
	 pr.fecha_devolucion, 
	 pr.estado, 
	 pr.multa
FROM prestamo pr
INNER JOIN estudiante e ON pr.id_usuario = e.id_estudiante
INNER JOIN material_bibliografico mb ON pr.id_material = mb.id_material
WHERE pr.tipo_usuario = 'Estudiante'
  AND e.nivel IN ('secundaria', 'primaria')
  AND e.grado IN (10, 11);
  
  
#7
  SELECT 
    a.nombre AS asignatura,
    pa.descripcion AS periodo,
    COUNT(c.id_calificacion) AS total_evaluaciones,
    AVG(c.valor) AS promedio_calificacion,
    MIN(c.valor) AS minima,
    MAX(c.valor) AS maxima
FROM calificacion c
INNER JOIN curso cu ON c.id_curso = cu.id_curso
INNER JOIN asignatura a ON cu.id_asignatura = a.id_asignatura
INNER JOIN periodo_academico pa ON cu.id_periodo = pa.id_periodo
GROUP BY a.id_asignatura, a.nombre, pa.id_periodo, pa.descripcion
ORDER BY pa.id_periodo, promedio_calificacion DESC;


#8
SELECT 
    e.nombres, 
	 e.apellidos, 
	 e.nivel, 
	 e.grado,
    ae.nombre AS actividad, ae.tipo,
    ae.horario, ae.lugar
FROM estudiante e
INNER JOIN actividad_extracurricural ae 
    ON ae.tipo LIKE '%Academica%'
WHERE e.nivel = 'secundaria'
  AND (ae.nombre LIKE '%Programacion%' 
    OR ae.nombre LIKE '%Ciencias%' 
    OR ae.nombre LIKE '%Ingles%')
ORDER BY e.grado DESC;


#9
SELECT 
    p.nombres, 
	 p.apellidos, 
	 p.especialidad,
    a.nombre AS asignatura,
    AVG(c.valor) AS promedio_asignatura,
    (SELECT AVG(valor) FROM calificacion) AS promedio_general
FROM profesor p
INNER JOIN curso cu ON p.id_profesor = cu.id_profesor
INNER JOIN asignatura a ON cu.id_asignatura = a.id_asignatura
INNER JOIN calificacion c ON cu.id_curso = c.id_curso
GROUP BY p.id_profesor, p.nombres, p.apellidos, p.especialidad, a.id_asignatura, a.nombre
HAVING AVG(c.valor) > (SELECT AVG(valor) FROM calificacion)
ORDER BY promedio_asignatura DESC;


#10
SELECT 
    e.nombres, 
	 e.apellidos, 
	 e.telefono, 
	 e.correo,
    mb.titulo AS material,
    pr.fecha_prestamo,
    pr.fecha_devolucion AS fecha_limite,
    DATEDIFF(CURDATE(), pr.fecha_devolucion) AS dias_vencido,
    pr.estado,
    pr.multa
FROM estudiante e
LEFT JOIN prestamo pr ON e.id_estudiante = pr.id_usuario
    AND pr.tipo_usuario = 'Estudiante'
LEFT JOIN material_bibliografico mb ON pr.id_material = mb.id_material
WHERE pr.id_prestamo IS NULL          -- sin préstamos
   OR (pr.estado IN ('Retrasado', 'Prestado') 
       AND pr.fecha_devolucion < CURDATE())
ORDER BY dias_vencido DESC;