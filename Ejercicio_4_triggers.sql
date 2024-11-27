/*
4. Crear un trigger de borrado de alumnos de tipo before. Si se intenta borrar 
fuera del horario laboral debe rechazar el borrado con un signal de error 45000.
 a. El horario laboral será de 8 a 18
 b. Además debemos guardar en la tabla auditorías el borrado si es 
satisfactorio.
 c. Modificar el trigger para que sea de tipo after. ¿impedimos el borrado? 
*/
DROP TRIGGER IF EXISTS borrado_de_alumnos;
DELIMITER //
CREATE TRIGGER borrado_de_alumnos BEFORE DELETE ON alumnos FOR EACH ROW
BEGIN
	-- a. Horario laboral de 8 a 18
    IF ADDTIME(CURTIME(),'06:00:00') < '08:00:00' OR ADDTIME(CURTIME(),'06:00:00') > '18:00:00' THEN
    -- Se podría poner como condicion tambien: IF ADDTIME(CURTIME(),'06:00:00') NOT BETWEEN '08:00:00' AND '18:00:00' THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error de borrado. Se encuentra fuera del horario laboral.';
    END IF;
    -- b.
    INSERT INTO auditoria (tabla,operacion,usuario) VALUES ('profesores', 'DELETE', CURRENT_USER());
END//
DELIMITER ;
/*No se ejecuta el borrado y me envía un mensaje de error indicando que se encuentra fuera del horario laboral.
Actualmente son las 13:44 pero como adelanté 6 horas la hora actual dentro del trigger con la función addtime(),
se crea la condición para probar que está por fuera del horario laboral. Al ejecutar el trigger, envía el error
esperado, comprobando que funciona correctamente el trigger*/
DELETE FROM alumnos WHERE cod_alumno = 105;


/* El trigger sin el addttime() es el siguiente, y no permitiría borrar filas entre las 8 y 18 horas.*/
DROP TRIGGER IF EXISTS borrado_de_alumnos;
DELIMITER //
CREATE TRIGGER borrado_de_alumnos BEFORE DELETE ON alumnos FOR EACH ROW
BEGIN
	-- a. Horario laboral de 8 a 18
    IF CURTIME() NOT BETWEEN '08:00:00' AND '18:00:00' THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error de borrado. Se encuentra fuera del horario laboral.';
    END IF;
    -- b.
    INSERT INTO auditoria (tabla,operacion,usuario) VALUES ('profesores', 'DELETE', CURRENT_USER());
END//
DELIMITER ;
DELETE FROM alumnos WHERE cod_alumno = 105;