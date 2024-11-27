/*
4. Crear un trigger de borrado de alumnos de tipo before. Si se intenta borrar 
fuera del horario laboral debe rechazar el borrado con un signal de error 45000.
 a. El horario laboral será de 8 a 18
 b. Además debemos guardar en la tabla auditorías el borrado si es 
satisfactorio.
 c. Modificar el trigger para que sea de tipo after. ¿impedimos el borrado? 
*/
DROP TRIGGER IF EXISTS borrado_de_alumnos;
select addtime(curtime(),'06:00:00');

DELIMITER //
CREATE TRIGGER borrado_de_alumnos BEFORE DELETE ON alumnos FOR EACH ROW
BEGIN
	-- a. Horario laboral de 8 a 18
    IF ADDTIME(CURTIME(),'06:00:00') < '08:00:00' OR ADDTIME(CURTIME(),'06:00:00') > '18:00:00' THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'Error de borrado. Se encuentra fuera del horario laboral.';
    END IF;
    INSERT INTO auditoria (tabla,operacion,usuario) VALUES ('profesores', 'DELETE', CURRENT_USER());
END//

