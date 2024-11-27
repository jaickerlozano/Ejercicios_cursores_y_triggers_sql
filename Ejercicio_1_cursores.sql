/*
Cursores y Triggers
Entra en la base de datos academia y carga el fichero TARJETAS.sql.
1. Crear un procedimiento llamado “listar_profesores” que tengan un cursor. 
Debemos ir pintando el nombre completo del profesor en mayúsculas y la 
edad. Hacerlo con un bucle LOOP 
*/
USE academia;
CREATE TABLE lista_profesores (
nombre_completo VARCHAR(100),
edad INT);

DROP PROCEDURE IF EXISTS listar_profesores;
DELIMITER //

CREATE PROCEDURE listar_profesores()
BEGIN
	-- declaración de variables
    DECLARE fin BOOL;
    DECLARE nombre_completo VARCHAR(100);
    DECLARE edad_profesor INT;
    
    -- cursor y handler
    DECLARE profesores_cursor CURSOR FOR SELECT UPPER(CONCAT(nombre, ' ', apellidos)), edad FROM profesores;
    DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET fin = TRUE;
	
    -- Instrucciones
    TRUNCATE TABLE lista_profesores;
    OPEN profesores_cursor;
    
    bucle: LOOP 
		FETCH profesores_cursor INTO nombre_completo, edad_profesor;
        
        IF fin THEN
			LEAVE bucle;
		END IF;
		
        INSERT INTO lista_profesores VALUES(nombre_completo, edad_profesor);
	END LOOP;
    COMMIT;    
END//

SELECT * FROM lista_profesores//
CALL listar_profesores//


-- Otra forma de resolverlo pero solo realizando una lista en una única salida sin crear una tabla

delimiter //
DROP PROCEDURE IF EXISTS listar_profesores//
CREATE PROCEDURE listar_profesores()
BEGIN
	DECLARE fin BOOLEAN;
	DECLARE nombre_completo VARCHAR(50);
	DECLARE v_edad INT;
	DECLARE salida TEXT;
	DECLARE cursor_profesores CURSOR FOR SELECT upper(concat(nombre, ' ', apellidos)), edad FROM profesores;
	DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET fin=TRUE;
	SET salida = ' ';
    
	OPEN cursor_profesores;
		eti1: LOOP
		FETCH cursor_profesores INTO nombre_completo, v_edad;
		IF fin THEN
			LEAVE eti1;
		END IF;
    
		SET salida=concat(salida,'\n', nombre_completo,' ',v_edad);
	END LOOP;
	CLOSE cursor_profesores;
	SELECT salida;
END//
-- Probar el procedimiento
CALL listar_profesores()//
DELIMITER ;






