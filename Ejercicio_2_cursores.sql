/*
Cursores y Triggers
Entra en la base de datos academia y carga el fichero TARJETAS.sql.
2. Crear un procedimiento denominado “notas_max_mix” que tenga un curso 
que extraiga las notas máximas y mínimas de cada curso. Hacerlo con un 
bucle WHILE
*/
DROP PROCEDURE IF EXISTS notas_max_min;

DELIMITER //
CREATE PROCEDURE notas_max_min()
BEGIN
	-- variables
    DECLARE fin BOOL;
    DECLARE curso VARCHAR(10);
    DECLARE nota_max INT;
    DECLARE nota_min INT;
    DECLARE resultado TEXT;
    
    -- cursor y handler
    DECLARE cursor_notas CURSOR FOR SELECT c.nombre, max(n.nota), min(n.nota) 
		FROM cursos AS c INNER JOIN notas_alumnos AS n 
		ON c.cod_curso=n.cod_curso 
		GROUP BY c.nombre ORDER BY c.nombre;
	DECLARE CONTINUE HANDLER FOR NOT FOUND 
		SET fin = TRUE;
	SET resultado = ' ';
    
    /*Es este caso, es necesario declarar explícitamente la variable fin como FALSE, para que el bucle while no interprete la variable
    fin como un null, de lo contrario, no entrará en el bucle y el resultado será vacío*/
	SET fin = FALSE;
    
   -- Instrucciones
	OPEN cursor_notas;
    bucle: WHILE fin <> TRUE DO
		FETCH cursor_notas INTO curso, nota_max, nota_min;
        SET resultado = CONCAT(resultado, '\n', curso, ' ', nota_max, ' ', nota_min);
	END WHILE;
    CLOSE cursor_notas;
    SELECT resultado;
END//

CALL notas_max_min()//