/*
 3. Crear un trigger llamado “insert_profesores” sobre profesores que al insertar 
un registro realice lo siguiente:
 a. Ponga el nombre y apellidos en mayúsculas o Si la edad está en blanco, 
ponemos de forma automática 24
 b. Debemos comprobar que el correo está OK. De lo contrario disparamos 
un error 45000. Para que esté bien debe tener una ‘@’ y luego un punto 
en algún lugar o Insertar el insert en la tabla de auditoría.
 c. Modificar el trigger para que sea de tipo after
*/
DROP TABLE IF EXISTS auditoria;
CREATE TABLE auditoria(
tabla VARCHAR(50),
operacion VARCHAR(50),
usuario VARCHAR(50)
);

DROP TRIGGER IF EXISTS insert_profesores;
DELIMITER // 
CREATE TRIGGER insert_profesores BEFORE INSERT ON profesores FOR EACH ROW
BEGIN
	-- a.
	SET NEW.nombre = UPPER(NEW.nombre);
    SET NEW.apellidos = UPPER(NEW.apellidos);
    IF NEW.edad IS NULL THEN
		SET NEW.edad = 24;
	END IF;
    
    -- b.
	IF NEW.email NOT LIKE '%@%.%' THEN
		SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'El email no tiene un formato válido';
	END IF;
    INSERT INTO auditoria (tabla,operacion,usuario) VALUES ('profesores', 'INSERT', CURRENT_USER());
END//

-- Con error. Proporciona un mensaje de texto indicando que el email no tiene un formato correcto
INSERT INTO profesores(cod_profesor, nombre, apellidos,email,edad) VALUES (60, 'Fernando', 'Rozas','fernandorozasgmail.com',NULL) //

-- Sin error, inserta la fila y se inserta la operación en la tabla auditoria.
INSERT INTO profesores(cod_profesor, nombre, apellidos,email,edad) VALUES (60, 'Fernando', 'Rozas','fernandorozas@gmail.com',NULL) //
DELETE FROM profesores WHERE cod_profesor = 60 //
SELECT * FROM auditoria//
SELECT * FROM PROFESORES//
