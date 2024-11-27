- Este repositorio contiene clases y resolución de ejercicios donde se practica los cursores y triggers.
  
- Se realizó 4 ejercicios, 2 de cursores y 2 de triggers.
  
- El ejercicio 1 de cursores lo realicé de dos formas. La primera forma fue creando una tabla vacía,
donde se guardará el listado de profesores en mayúsculas con sus edades que se obtendrá por medio del
procedimiento creado.
La segunda forma lo realicé creando un procedimiento que tomara los nombres y apellidos en mayúsculas
y las edades de los profesores, y se guardara en una variable, y al llamarse el procedimiento se imprimiera
 esa lista.

- En el ejercicio 4 de triggers, tengo dos triggers que emiten un mensaje de error si se desea eliminar una
fila en una tabla cuando se está fuera del horario laboral, esto se activaría sería entre las 8 y 18 horas.
La idea de haber realizado dos triggers que hicieran lo mismo, fue porque con el primero lo condicioné para
que la hora actual estuviera fuera del horario laboral, ya que al momento que hice el script, eran las 13:44,
por lo tanto, no iba a tener forma de saber si enviaría el mensaje de error intentando eliminar una fila en una
tabla al encontrarme dentro del horario laboral. El segundo trigger sería el disparador definitivo con la hora
real, ya que sé que funciona correctamente.
