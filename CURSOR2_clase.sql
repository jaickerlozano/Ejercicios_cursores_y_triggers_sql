DROP procedure IF EXISTS backup_cursos;

CREATE TABLE CURSOS_BACKUP (
	codigo int, 
	nombre varchar(50), 
	precio decimal
    );

DELIMITER //
CREATE PROCEDURE backup_cursos()
BEGIN
	-- VARIABLES
	DECLARE fin bool;
	DECLARE cod_curso int;
	DECLARE nombre_curso varchar(50);
	DECLARE precio_curso decimal;
    
    -- CURSOR Y HANDLER
    DECLARE cursor_cursos CURSOR FOR SELECT * FROM CURSOS;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET fin = true;
        
	-- INSTRUCCIONES
    truncate table CURSOS_BACKUP;
    OPEN cursor_cursos;
    
    bucle: LOOP
		FETCH cursor_cursos into cod_curso, nombre_curso, precio_curso;
		
		IF fin THEN
			leave bucle;
		END IF;
        
        INSERT INTO CURSOS_BACKUP VALUES(cod_curso, nombre_curso, precio_curso);
	END LOOP;
    COMMIT;
END//

SELECT * FROM CURSOS_BACKUP//
call backup_cursos()//








