-- Querries Universidad
-- 1 Devuelve un listado con el primer apellido, segundo apellido y el nombre de todos los alumnos/as. El listado deberá estar ordenado alfabéticamente de menor a mayor por el primer apellido, segundo apellido y nombre.
SELECT  apellido1,apellido2, nombre, tipo FROM persona WHERE tipo='alumno' ORDER BY apellido1;

-- 2 Halla el nombre y los dos apellidos de los alumnos que no han dado de alta su número de teléfono en la base de datos.
SELECT  nombre, apellido1,apellido2,tipo, telefono  FROM persona WHERE telefono IS NULL AND tipo='alumno'; 

-- 3 Devuelve el listado de los alumnos que nacieron en 1999.
SELECT  nombre, apellido1,apellido2, fecha_nacimiento, tipo  FROM persona WHERE fecha_nacimiento LIKE '1999%' AND tipo='alumno'; 

-- 4 Devuelve el listado de profesores/as que no han dado de alta su número de teléfono en la base de datos y además su NIF termina en K.
SELECT  nombre, apellido1, apellido2 ,nif , telefono ,  tipo  FROM persona WHERE nif LIKE '%K' AND tipo='profesor' AND telefono IS NULL; 

-- 5 Devuelve el listado de las asignaturas que se imparten en el primer cuatrimestre, en el tercer curso del grado que tiene el identificador 7.
SELECT nombre AS asignatura, cuatrimestre,curso, id_grado FROM asignatura WHERE cuatrimestre=1 AND curso=3 AND id_grado=7;

-- 6 Devuelve un listado de los profesores/as junto con el nombre del departamento al que están vinculados. El listado debe devolver cuatro columnas, primer apellido, segundo apellido, nombre y nombre del departamento. El resultado estará ordenado alfabéticamente de menor a mayor por apellidos y nombre.
SELECT apellido1, apellido2, persona.nombre, departamento.nombre AS nombre_departamento  FROM persona JOIN profesor ON persona.id = profesor.id_profesor JOIN departamento ON profesor.id_departamento=departamento.id WHERE persona.tipo = 'profesor' ORDER BY persona.apellido1;

-- 7 Devuelve un listado con el nombre de las asignaturas, año de inicio y año de fin del curso escolar del alumno/a con NIF 26902806M.
SELECT asignatura.nombre, curso_escolar.anyo_inicio, curso_escolar.anyo_fin , persona.nif FROM alumno_se_matricula_asignatura m inner JOIN curso_escolar ON m.id_curso_escolar =  curso_escolar.id inner JOIN asignatura ON m.id_asignatura= asignatura.id inner  JOIN persona ON id_alumno=persona.id WHERE persona.nif='26902806M';

-- 8 Devuelve un listado con el nombre de todos los departamentos que tienen profesores/as que imparten alguna asignatura en el Grado en Ingeniería Informática (Plan 2015).
SELECT DISTINCT departamento.nombre FROM departamento JOIN profesor ON departamento.id= profesor.id_departamento JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor JOIN grado ON  asignatura.id_grado = grado.id WHERE grado.nombre = 'Grado en Ingeniería Informática (Plan 2015)';

-- 9 Devuelve un listado con todos los alumnos que se han matriculado en alguna asignatura durante el curso escolar 2018/2019.
SELECT DISTINCT persona.nif, persona.nombre, persona.apellido1, persona.apellido2, persona.tipo, curso_escolar.anyo_inicio FROM persona INNER JOIN alumno_se_matricula_asignatura ON id_alumno = persona.id Inner JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar= curso_escolar.id WHERE curso_escolar.anyo_inicio=2018;


-- Resuelve las 6 siguientes consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.

-- 1 Devuelve un listado con los nombres de todos los profesores/as y los departamentos que tienen vinculados. El listado también debe mostrar a aquellos profesores/as que no tienen ningún departamento asociado. El listado debe devolver cuatro columnas, nombre del departamento, primer apellido, segundo apellido y nombre del profesor/a. El resultado estará ordenado alfabéticamente de menor a mayor por el nombre del departamento, apellidos y nombre.
SELECT departamento.nombre AS DEPARTAMENTO,  persona.apellido1, persona.apellido2, persona.nombre FROM departamento RIGHT JOIN profesor  ON departamento.id=profesor.id_departamento LEFT JOIN persona ON persona.id=profesor.id_profesor ORDER BY  departamento.nombre;
-- 2 Devuelve un listado con los profesores/as que no están asociados a un departamento.
SELECT departamento.nombre AS DEPARTAMENTO,  persona.apellido1, persona.apellido2, persona.nombre FROM departamento RIGHT JOIN profesor  ON departamento.id=profesor.id_departamento LEFT JOIN persona ON persona.id=profesor.id_profesor WHERE profesor.id_departamento IS NULL   ORDER BY  departamento.nombre;
-- 3 Devuelve un listado con los departamentos que no tienen profesores asociados.
SELECT departamento.nombre AS DEPARTAMENTO,  persona.apellido1, persona.apellido2, persona.nombre FROM departamento LEFT JOIN profesor  ON departamento.id=profesor.id_departamento LEFT JOIN persona ON persona.id=profesor.id_profesor WHERE profesor.id_departamento IS NULL ORDER BY  departamento.nombre;
-- 4 Devuelve un listado con los profesores/as que no imparten ninguna asignatura.
SELECT asignatura.nombre AS Asignatura,  persona.nif, persona.nombre, persona.apellido1, persona.apellido2, persona.tipo FROM asignatura  right JOIN persona ON asignatura.id_profesor= persona.id WHERE persona.tipo='profesor' AND asignatura.id_profesor is null;-- 5 Devuelve un listado con las asignaturas que no tienen un profesor/a asignado.
-- 5 Devuelve un listado con las asignaturas que no tienen un profesor/a asignado.
SELECT asignatura.nombre AS Asignatura,  persona.nif, persona.nombre, persona.apellido1, persona.apellido2, persona.tipo FROM asignatura  left JOIN persona ON asignatura.id_profesor= persona.id WHERE asignatura.id_profesor IS NULL;
-- 6 Devuelve un listado con todos los departamentos que no han impartido asignaturas en ningún curso escolar.
SELECT * FROM departamento  left JOIN profesor ON profesor.id_departamento = departamento.id WHERE profesor.id_departamento IS NULL;
-- Consultas resumen:
-- 1 Devuelve el número total de alumnos existentes.
Select count(tipo) as Total_alumnos from persona where tipo='alumno';
-- 2 Calcula cuántos alumnos nacieron en 1999.
Select COUNT( fecha_nacimiento ) AS Total_alumnos_nacidos_1999 from persona where fecha_nacimiento LIKE '1999%' AND tipo='alumno' ;
-- 3 Calcula cuántos profesores/as hay en cada departamento. El resultado sólo debe mostrar dos columnas, una con el nombre del departamento y otra con el número de profesores/as que hay en ese departamento. El resultado sólo debe incluir los departamentos que tienen profesores/as asociados y tendrá que estar ordenado de mayor a menor por el número de profesores/as.
SELECT departamento.nombre AS Departamento, COUNT(profesor.id_profesor) AS Numero_de_Profesores FROM departamento  JOIN profesor  ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre HAVING COUNT(profesor.id_profesor) > 0 ORDER BY Numero_de_Profesores DESC;
-- 4 Devuelve un listado con todos los departamentos y el número de profesores/as que hay en cada uno de ellos. Tenga en cuenta que pueden existir departamentos que no tienen profesores asociados. Estos departamentos también deben aparecer en el listado.
SELECT departamento.nombre AS Departamento, COUNT(profesor.id_profesor) AS Numero_de_Profesores FROM departamento  left JOIN profesor  ON departamento.id = profesor.id_departamento GROUP BY departamento.nombre  ORDER BY Numero_de_Profesores DESC;
-- 5 Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno. Ten en cuenta que pueden existir grados que carecen de asignaturas asociadas. Estos grados también deben aparecer en el listado. El resultado deberá estar ordenado de mayor a menor por el número de asignaturas.
Select grado.nombre AS GRADOS, COUNT(asignatura.id_grado) AS Numero_Asignaturas FROM grado left JOIN asignatura ON asignatura.id_grado=grado.id GROUP BY grado.nombre ORDER BY Numero_Asignaturas DESC;
-- 6 Devuelve un listado con el nombre de todos los grados existentes en la base de datos y el número de asignaturas que tiene cada uno, de los grados que tengan más de 40 asignaturas asociadas.
Select grado.nombre AS GRADOS, COUNT(asignatura.id_grado) AS Numero_Asignaturas FROM grado left JOIN asignatura ON asignatura.id_grado=grado.id GROUP BY grado.nombre HAVING COUNT(asignatura.id_grado) > 40 ORDER BY Numero_Asignaturas DESC;
-- 7 Devuelve un listado que muestre el nombre de los grados y la suma del número total de créditos existentes para cada tipo de asignatura. El resultado debe tener tres columnas: nombre del grado, tipo de asignatura y la suma de los créditos de todas las asignaturas que existen de este tipo.
SELECT grado.nombre AS Nombre_Grado,  asignatura.tipo AS Tipo_Asignatura, SUM(asignatura.creditos) AS Suma_Creditos FROM asignatura LEFT JOIN grado ON asignatura.id_grado = grado.id GROUP BY  grado.nombre, asignatura.tipo;
-- 8 Devuelve un listado que muestre cuántos alumnos se han matriculado de alguna asignatura en cada uno de los cursos escolares. El resultado tendrá que mostrar dos columnas, una columna con el año de inicio del curso escolar y otra con el número de alumnos matriculados.
SELECT curso_escolar.anyo_inicio, count( alumno_se_matricula_asignatura.id_alumno) AS alumnos_inscritos from curso_escolar join alumno_se_matricula_asignatura ON alumno_se_matricula_asignatura.id_curso_escolar= curso_escolar.id group by curso_escolar.anyo_inicio;
-- 9 Devuelve un listado con el número de asignaturas que imparte cada profesor/a. El listado debe tener en cuenta a aquellos profesores/as que no imparten ninguna asignatura. El resultado mostrará cinco columnas: id, nombre, primer apellido, segundo apellido y número de asignaturas. El resultado estará ordenado de mayor a menor por el número de asignaturas.
SELECT persona.id, persona.nombre, persona.apellido1, persona.apellido2, count(asignatura.id_profesor)AS Numero_asignaturas from persona left join asignatura on asignatura.id_profesor= persona.id where persona.tipo='profesor' group by persona.id ORDER BY Numero_asignaturas DESC;
-- 10 Devuelve todos los datos del alumno/a más joven.
SELECT * FROM persona WHERE tipo='alumno' AND fecha_nacimiento=(SELECT MAX(fecha_nacimiento) FROM persona);
-- 11 Devuelve un listado con los profesores/as que tienen un departamento asociado y que no imparten ninguna asignatura.
SELECT persona.id, persona.nif, persona.nombre, persona.apellido1, persona.apellido2, persona.tipo, departamento.nombre AS Departamento, asignatura.id as id_asignatura FROM persona JOIN profesor ON persona.id=profesor.id_profesor LEFT JOIN asignatura ON asignatura.id_profesor=profesor.id_profesor LEFT JOIN departamento ON departamento.id=profesor.id_departamento WHERE asignatura.id IS NULL
