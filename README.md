# DataProject_LogicaConsultasSQL
Entrega del proyecto Lógica y consultas de SQL

Descargamos la base de datos de: https://s3.amazonaws.com/staticcontent.thepowermba/Bootcamp+Data+%26+Analytics/D%26A24/SQL/BBDD_Proyecto.sql

## Creación e importación de la base de datos a tavés de DBeaver
Sobre 'Bases de datos', botón derecho 'Crear nueva base de datos'. La llamaremos 'MovieStore'  
Sobre la nueva base de datos creada 'MovieStore', botón derecho y le damos a 'Establecer por defecto'  
Desde Archivo / Open File, seleccionamos el fichero que hemos descargado. No aseguramos de estar conectados a <postgres>, seleccionamos todo el código y ejecutamos el script.  
  
Detalle de las tablas  
  
|Tabla | Detalle| Clave primaria |
|:---| :---|
|Store          | guarda la información de las tiendas. | store_id |
|staff          | guarda la información de los trabjadores de las tiendas. | staff_id|
|address        | guarda el detalle de las direcciones de los empleados, clientes y tiendas| address_id |
|city           | información sobre las ciudades indicadas en las direcciones. | city_id |
|country        | información sobre los paises indicados en las direcciones. | country_id |
|customer       | guarda la información de todos los clientes que se han dado de alta en las tiendas | customer_id |
|rental         | guardar el detalle para saber que peliculas se han alquilado, por que cliente, fecha, empleado | rental_id |
|payment        | detalle de los pagos en cada alquiler de película | payment_id |
|inventory      | guarda la información de todas las películas que hay en cada tienda | inventory_id |
|film_actor     | guarda un registro de que actor sale en cada película | actor_id, film_id |
|actor          | guarda la información de los actores | actor_id |
|film           | guarda la información de todas las películas | film_id |
|film_category  | Asocia cada película a su categoría | film_id, category_id |
|category       | Detalle de todas las categorías a las que puede pertenecer una película | category_id |
|language       | Información sobre los idiomas disponibles en las películas | language_id | 


Como Base de datos de tiene de películas, tenemos una tabla principal que es Store. Esta tabla encontramos que está relacionada con las tablas 
staff para saber que trabajadores hay en cada tienda trabajadores.
address que tendríamos la dirección de la tienda.
inventory para saber que películas tiene/están en cada tienda.
customer para saber que cliente está asociado a cada tienda o se saber en que tienda se ha dado de alta.


