# DataProject_LogicaConsultasSQL
Entrega del proyecto Lógica y consultas de SQL.  
Encontramos tres carpetas en el proyecto:
- BBDD_Data: Script SQL para la creación de tablas y registros.
- Diagrama: Imagen del esquema relacional de la base de datos. También se puede visualizar desde el fichero readme.md.
- Script: Script SQL con las consultas SQL del enunciado.

Descargamos la base de datos de: https://s3.amazonaws.com/staticcontent.thepowermba/Bootcamp+Data+%26+Analytics/D%26A24/SQL/BBDD_Proyecto.sql

## Creación e importación de la base de datos a tavés de DBeaver
Sobre 'Bases de datos', botón derecho 'Crear nueva base de datos'. La llamaremos 'MovieStore'.  
Sobre la nueva base de datos creada 'MovieStore', botón derecho y le damos a 'Establecer por defecto'.  
Desde Archivo / Open File, seleccionamos el fichero que hemos descargado. No aseguramos de estar conectados a postgres, seleccionamos todo el código y ejecutamos el script.   
  
## Esquema relacional de la base de datos
![Esquema ER](/Diagrama/DiagramaER.png)

## Detalle de las tablas   
  
| Tabla | Detalle | Clave primaria |
|:--- |:---|:---- | 
|store          | Guarda la información de las tiendas e películas. | store_id |
|staff          | Guarda la información de los trabjadores de las tiendas. | staff_id|
|address        | Guarda el detalle de las direcciones de los empleados, clientes y tiendas| address_id |
|city           | Guarda el nombre y el id de las ciudades indicadas en las direcciones. | city_id |
|country        | Guarda el nombre y el id de los paises indicados en las direcciones. | country_id |
|customer       | Guarda la información de todos los clientes que se han dado de alta en las tiendas | customer_id |
|rental         | Guarda el detalle para saber que peliculas se han alquilado, por que cliente, fecha, empleado | rental_id |
|payment        | Guarda el detalle de los pagos de cada alquiler de película | payment_id |
|inventory      | Guarda la información de todas las películas que hay en cada tienda | inventory_id |
|film_actor     | Guarda una relación sobre que actor sale en cada película | actor_id, film_id |
|actor          | Guarda la información de los actores | actor_id |
|film           | Guarda la información de todas las películas | film_id |
|film_category  | Guarda una relación para saber a que categoría pertenece cada película | film_id, category_id |
|category       | Guarda el nombre y el id de todas las categorías a las que puede pertenecer una película | category_id |
|language       | Información sobre los idiomas disponibles en las películas | language_id | 

