drop procedure if exists leer_cursos;
DELIMITER //

CREATE PROCEDURE leer_cursos()
BEGIN
-- Variables
	DECLARE fin BOOL;
    DECLARE resultado text;
    DECLARE cod_curso int;
    DECLARE nombre_curso VARCHAR(50);
    DECLARE precio_curso DECIMAL;
    
    -- CURSOR Y HANDLER
    DECLARE CURSOR_CURSOS CURSOR FOR SELECT * FROM CURSOS;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		set fin = true;
	
    set resultado = " ";
    
    OPEN CURSOR_CURSOS;
    
    bucle: LOOP
		FETCH CURSOR_CURSOS INTO  cod_curso, nombre_curso, precio_curso;
        IF fin THEN
			leave bucle;
        END IF;
        
        SET RESULTADO = concat(resultado, "\n", nombre_curso);
	END LOOP;
    
    SELECT RESULTADO;
    
END//

CALL LEER_CURSOS()//


