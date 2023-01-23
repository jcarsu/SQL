#Ver qué es lo que tiene el servidor
#sentencias de SQL/comandos de SQL 
#Por costumbre los comandos se ejecutan en mayúsculas
#Con ctrl+enter, se ejecuta una instancia

SHOW DATABASES;
#Para separar un conjunto de instrucciones en SQL, le pongo un ; al final 
#El ; es similar a las celdas de Jupyter
USE bank;
#Para seleccionar info en SQL, el * indica que me traiga todas las columnas de (FROM) una tabla (nombre_de_tabla)
#Lo que sí tiene que ir con su ortografía es lo relacionado a la DB, en este caso la tabla "trans# va en minúsculas y así debe de ingresarse
SELECT * FROM trans;
#Ver las tablas
SHOW TABLES;

#En vez de usar el *, podemos llamar a las columnas que nos interesen, ejemplo
SELECT trans_id, account_id, date, type
FROM trans;

#Poner limites de las columnas/filas a llamar
SELECT trans_id, account_id, date, type
#SQL no lee enters
FROM trans
LIMIT 4; 

#Conocer cuántos registros tengo
SELECT count(*) FROM bank.trans;

#Aprox 60MB de info, ya tiende al millón de registros
#Este tema, evoluciona a lo que se llama BigQuery